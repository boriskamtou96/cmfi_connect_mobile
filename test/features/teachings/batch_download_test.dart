import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/teachings/domain/teaching.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

const _crusade = TeachingEditionBrief(
  id: 7,
  title: 'Croisades de prière et de jeûne 2026',
  year: 2026,
);

Teaching _message(int id, String title, int day) => Teaching(
  id: id,
  title: title,
  speaker: 'Théodore Andoseh',
  category: 'Croisades de prière et de jeûne',
  categorySlug: 'croisades',
  year: 2026,
  dayNumber: day,
  edition: _crusade,
  durationSeconds: 600,
  audio: TeachingAudio(
    id: 100 + id,
    url: '/v1/media/$id.mp3',
    sizeBytes: 30 * 1024 * 1024,
  ),
);

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<TestApp> openCrusade(
    WidgetTester tester, {
    required FakeTeachingFiles files,
    bool premium = true,
  }) async {
    final app = await pumpApp(
      tester,
      token: 't',
      premium: FakePremiumStore(active: premium),
      teachingsApi: FakeTeachingsApi(
        teachings: [
          _message(1, 'La sainteté', 1),
          _message(2, 'Le pardon', 1),
          _message(3, 'La mission', 2),
        ],
      ),
      teachingFiles: files,
    );
    await openMenu(tester);
    await scrollTo(tester, inMenu('Enseignements'));
    await tester.tap(inMenu('Enseignements'));
    await tester.pumpAndSettle();
    // the category opens its edition
    await tester.tap(find.text('Croisades de prière et de jeûne'));
    await tester.pumpAndSettle();
    return app;
  }

  testWidgets('an edition is kept on the phone in one go, after saying how '
      'many and how heavy; then it is removed', (tester) async {
    final files = FakeTeachingFiles();
    await openCrusade(tester, files: files);

    await tester.tap(find.text('Télécharger les 3 messages'));
    await tester.pumpAndSettle();
    expect(find.text('Garder sur ton téléphone ?'), findsOneWidget);
    expect(find.textContaining('3 messages, 90 Mo'), findsOneWidget);

    await tester.tap(find.text('Télécharger'));
    await tester.pumpAndSettle();
    expect(files.kept, {1, 2, 3});
    expect(find.text('Les 3 messages sont sur ton téléphone'), findsOneWidget);

    await tester.tap(find.text('Retirer'));
    await tester.pumpAndSettle();
    expect(find.text('Retirer ces messages du téléphone ?'), findsOneWidget);
    await tester.tap(find.text('Retirer').last);
    await tester.pumpAndSettle();
    expect(files.kept, isEmpty);
    expect(find.text('Télécharger les 3 messages'), findsOneWidget);
  });

  testWidgets('a day alone; then the edition asks only for what is missing', (
    tester,
  ) async {
    final files = FakeTeachingFiles();
    await openCrusade(tester, files: files);

    await tester.tap(find.text('Jour 2'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Télécharger ce message'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Télécharger'));
    await tester.pumpAndSettle();
    expect(files.kept, {3});
    expect(find.text('Ce message est sur ton téléphone'), findsOneWidget);

    await tester.tap(find.text('Tous').last);
    await tester.pumpAndSettle();
    expect(
      find.text('Télécharger les 2 messages qui manquent'),
      findsOneWidget,
    );
  });

  testWidgets('without Premium, it opens the Premium page', (tester) async {
    final files = FakeTeachingFiles();
    await openCrusade(tester, files: files, premium: false);

    await tester.tap(find.text('Télécharger les 3 messages'));
    await tester.pumpAndSettle();
    expect(find.text('Garder sur ton téléphone ?'), findsNothing);
    expect(files.kept, isEmpty);
  });
}
