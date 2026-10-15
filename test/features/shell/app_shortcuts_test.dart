import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/app_shortcuts.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/hymns/presentation/hymns_screen.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/prayer/presentation/prayer_screen.dart';
import 'package:cmfi_connect/src/features/prayer/presentation/retreat_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('signed in: three shortcuts in the app language, gone at '
      'sign-out', (tester) async {
    final app = await pumpApp(tester, token: 't');

    expect(app.shortcuts.shown, {
      AppShortcut.today: 'Remplir mon compte rendu',
      AppShortcut.hymns: 'Cantiques',
      AppShortcut.retreat: 'Retraite du moment',
    });

    await LocaleSettings.setLocale(AppLocale.en);
    await tester.pumpAndSettle();
    expect(app.shortcuts.shown[AppShortcut.today], 'Fill in my report');
    await LocaleSettings.setLocale(AppLocale.fr);
    await tester.pumpAndSettle();

    await openMore(tester);
    await tester.pumpAndSettle();
    await scrollToEnd(tester);
    await tester.tap(find.text('Se déconnecter'));
    await tester.pumpAndSettle();

    expect(app.shortcuts.cleared, isTrue);
    expect(app.shortcuts.shown, isEmpty);
  });

  testWidgets('signed out: no shortcut', (tester) async {
    final app = await pumpApp(tester);

    expect(app.shortcuts.shown, isEmpty);
  });

  testWidgets('a shortcut touched while the app runs opens what it says', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');

    app.shortcuts.tapsController.add(AppShortcut.hymns);
    await tester.pumpAndSettle();
    expect(find.byType(HymnsScreen), findsOneWidget);

    app.shortcuts.tapsController.add(AppShortcut.today);
    await tester.pumpAndSettle();
    expect(find.text('Enregistrer la journée'), findsOneWidget);

    // no retreat made today: the one of the moment
    app.shortcuts.tapsController.add(AppShortcut.retreat);
    await tester.pumpAndSettle();
    expect(find.byType(RetreatScreen), findsOneWidget);
  });

  testWidgets('the app opened by a shortcut goes there', (tester) async {
    await pumpApp(
      tester,
      token: 't',
      shortcuts: FakeAppShortcuts()..launchedWith = AppShortcut.hymns,
    );

    expect(find.byType(HymnsScreen), findsOneWidget);
  });

  testWidgets('the four retreats made: the Prière tab', (tester) async {
    final api = FakePrayerApi();
    api.retreatList.addAll([
      for (final moment in RetreatMoment.values)
        RetreatRecord(day: today(), moment: moment),
    ]);
    final app = await pumpApp(tester, token: 't', prayerApi: api);

    app.shortcuts.tapsController.add(AppShortcut.retreat);
    await tester.pumpAndSettle();

    expect(find.byType(RetreatScreen), findsNothing);
    expect(find.byType(PrayerScreen), findsOneWidget);
  });
}
