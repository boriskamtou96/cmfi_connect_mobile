import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/teachings/domain/teaching.dart';
import 'package:cmfi_connect/src/features/teachings/presentation/teaching_player_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

Teaching _message(
  int id,
  String title, {
  TeachingEditionBrief? edition,
  String category = 'Prédications',
}) => Teaching(
  id: id,
  title: title,
  speaker: 'Théodore Andoseh',
  category: category,
  edition: edition,
  audio: TeachingAudio(id: 100 + id, url: '/v1/media/$id.mp3'),
  durationSeconds: 600,
);

final _three = [
  _message(1, 'Premier message'),
  _message(2, 'Deuxième message'),
  _message(3, 'Troisième message'),
];

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<TestApp> pumpHome(
    WidgetTester tester, {
    List<Teaching>? teachings,
    Map<String, Object> preferences = const {},
  }) async {
    final app = await pumpApp(
      tester,
      token: 't',
      teachingsApi: FakeTeachingsApi(teachings: teachings ?? _three),
      initialPreferences: preferences,
    );
    await scrollTo(tester, find.text('Enseignements'));
    return app;
  }

  testWidgets('a message played from the home screen is followed by the next '
      'one of its row', (tester) async {
    final app = await pumpHome(tester);
    await scrollTo(tester, find.text('Premier\u00a0message'));

    await tester.tap(find.text('Premier\u00a0message'));
    await tester.pumpAndSettle();
    expect(find.byType(TeachingPlayerScreen), findsOneWidget);
    expect(app.player.snapshot.teaching?.id, 1);

    // the end of the message, as the real player says it
    final now = app.player.snapshot;
    app.player.emit(
      now.copyWith(playing: false, completed: true, position: now.duration),
    );
    await tester.pumpAndSettle();
    expect([for (final one in app.player.opened) one.teaching.id], [1, 2]);
  });

  testWidgets('a file name reads as its day and message, with its edition '
      'and its day on the cover', (tester) async {
    await pumpHome(
      tester,
      teachings: [
        _message(
          1,
          'Jour 3_2 croisade de prière et de jeûne 2026',
          edition: const TeachingEditionBrief(
            id: 7,
            title: 'Croisade 2026',
            year: 2026,
          ),
        ),
      ],
    );
    await scrollTo(tester, find.text('Jour 3, message\u00a02'));

    expect(find.text('Jour 3, message\u00a02'), findsOneWidget);
    expect(find.textContaining('Jour 3_2'), findsNothing);
    expect(find.text('Croisade 2026'), findsOneWidget);
    // the cover without a picture: the day and the year
    expect(find.text('Jour 3'), findsOneWidget);
    expect(find.text('2026'), findsOneWidget);
    expect(find.text('10 min'), findsOneWidget);
  });

  testWidgets('a message begun comes first, with what is left of it', (
    tester,
  ) async {
    await pumpHome(
      tester,
      // the third heard for 4 minutes of 10
      preferences: {'teaching_progress': '{"3":[240,600]}'},
    );
    await scrollTo(tester, find.text('Troisième\u00a0message'));

    expect(find.text('Reste 6 min'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Troisième\u00a0message')).dx,
      lessThan(tester.getTopLeft(find.text('Premier\u00a0message')).dx),
    );
  });

  testWidgets('a large text grows the row instead of cutting it', (
    tester,
  ) async {
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    // other cards of the home screen may overflow; not this row
    final errors = <String>[];
    final previous = FlutterError.onError;
    FlutterError.onError = (details) => errors.add(details.toString());
    await pumpHome(tester);
    await scrollTo(tester, find.text('Premier\u00a0message'));
    FlutterError.onError = previous;

    expect(errors.where((error) => error.contains('_ListenCard')), isEmpty);
    expect(find.text('10 min'), findsWidgets);
  });
}
