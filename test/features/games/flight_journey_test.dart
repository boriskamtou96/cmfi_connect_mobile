import 'dart:convert';
import 'dart:io';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/games/application/flight_journey.dart';
import 'package:cmfi_connect/src/features/games/domain/flight_journey.dart';
import 'package:cmfi_connect/src/features/games/domain/game.dart';
import 'package:cmfi_connect/src/features/games/domain/verse_flight.dart';
import 'package:cmfi_connect/src/features/games/presentation/flight_journey_screen.dart';
import 'package:cmfi_connect/src/features/games/presentation/verse_flight_screen.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

/// A course with one lesson, for the games tab to show its tiles.
const _path = GamePath(
  courses: [GameCourse(code: 'bible', title: 'La Bible')],
  course: 'bible',
  player: GamePlayer(
    totalPoints: 40,
    level: 1,
    levelFloor: 0,
    nextLevelAt: 200,
    streakDays: 1,
    playedToday: true,
    pointsToday: 40,
  ),
  levels: [
    GameLevel(
      id: 1,
      position: 1,
      title: 'Les commencements',
      lessons: [
        GameLessonSummary(
          id: 10,
          position: 1,
          title: 'La création',
          state: LessonState.open,
        ),
      ],
    ),
  ],
);

/// The game of Flame never settles: its frames are pumped one by one.
Future<void> _frames(WidgetTester tester, [int count = 20]) async {
  for (var i = 0; i < count; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('the progress of the journey', () {
    const start = JourneyProgress();

    test('a journey starts at its first stage, the others closed', () {
      expect(start.started, isFalse);
      expect(start.current, 0);
      expect(start.isOpen(0), isTrue);
      expect(start.isOpen(1), isFalse);
      expect(start.heartsOf(0), isNull);
    });

    test('a stage won keeps its hearts and opens the next one', () {
      final after = start.won(0, 2);
      expect(after.reached, 1);
      expect(after.heartsOf(0), 2);
      expect(after.current, 1);
      expect(after.isOpen(1), isTrue);
      expect(after.isOpen(2), isFalse);
    });

    test('played again, a stage keeps its best hearts', () {
      final once = start.won(0, 2);
      expect(once.won(0, 1).heartsOf(0), 2);
      expect(once.won(0, 3).heartsOf(0), 3);
      // nothing opens by playing an old stage again
      expect(once.won(0, 3).reached, 1);
    });

    test('a stage still closed cannot be won', () {
      expect(start.won(3, 3).reached, 0);
    });

    test('the last stage won, the journey is finished', () {
      var progress = start;
      for (var stage = 0; stage < canaanStages.length; stage++) {
        progress = progress.won(stage, 3);
      }
      expect(progress.finished, isTrue);
      expect(progress.current, canaanStages.length - 1);
      expect(progress.total, canaanStages.length * 3);
    });

    test('it is read back from what the phone keeps', () {
      final saved = start.won(0, 3).won(1, 1).saved;
      expect(saved, '3,1');
      final read = JourneyProgress.parse(saved, length: 12);
      expect((read.reached, read.heartsOf(1)), (2, 1));
      // unreadable: a journey not started
      expect(JourneyProgress.parse('3,x', length: 12).started, isFalse);
      expect(JourneyProgress.parse('7', length: 12).started, isFalse);
      expect(JourneyProgress.parse(null, length: 12).started, isFalse);
    });
  });

  test('every language has the twelve verses, short enough to fly', () {
    final json =
        jsonDecode(File('assets/games/journey_canaan.json').readAsStringSync())
            as Map<String, dynamic>;
    expect(json.keys, containsAll(['fr', 'en', 'de', 'es', 'ar', 'zh', 'hi']));
    for (final MapEntry(key: language, value: book) in json.entries) {
      final verses = (book as Map<String, dynamic>)['verses'] as List<dynamic>;
      expect(
        [for (final verse in verses) (verse as Map<String, dynamic>)['osis']],
        [for (final stage in canaanStages) stage.osis],
        reason: language,
      );
      expect(book['source'], isNotEmpty, reason: language);
      for (final verse in verses) {
        final text = (verse as Map<String, dynamic>)['text'] as String;
        final pieces = flightWords(text, language: language).length;
        expect(
          pieces,
          inInclusiveRange(4, 28),
          reason: '$language ${verse['osis']}',
        );
      }
    }
  });

  test('every language names the twelve places and tells their story', () {
    for (final locale in AppLocale.values) {
      final texts = locale.buildSync().games.journey;
      expect(texts.places, hasLength(canaanStages.length), reason: '$locale');
      expect(texts.stories, hasLength(canaanStages.length), reason: '$locale');
    }
  });

  testWidgets('the map opens on the first stage, the others closed', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    // ignore: unawaited_futures
    app.container.read(appRouterProvider).push(const FlightJourneyRoute());
    await tester.pumpAndSettle();

    expect(find.byType(FlightJourneyScreen), findsOneWidget);
    expect(find.text('La conquête de Canaan'), findsOneWidget);
    expect(find.text('Étape 1 sur 12'), findsOneWidget);
    expect(find.bySemanticsLabel('L’Égypte, étape à jouer'), findsOneWidget);
    expect(
      find.bySemanticsLabel('La sortie d’Égypte, étape fermée'),
      findsOneWidget,
    );
    // the stage to play tells its story
    expect(
      find.text('Esclave en Égypte, Israël crie, et Dieu l’entend.'),
      findsOneWidget,
    );
    expect(find.text('JOUER · L’ÉGYPTE'), findsOneWidget);
  });

  testWidgets('the stage reached is kept: the map opens where the player is', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    await app.preferences.setString('flight_journey', '3,2');
    // ignore: unawaited_futures
    app.container.read(appRouterProvider).push(const FlightJourneyRoute());
    await tester.pumpAndSettle();

    expect(find.text('Étape 3 sur 12'), findsOneWidget);
    expect(find.text('5 sur 36'), findsOneWidget);
    expect(find.bySemanticsLabel('L’Égypte, étape franchie'), findsOneWidget);
    expect(
      find.bySemanticsLabel('La mer Rouge, étape à jouer'),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel('Élim, étape fermée'), findsOneWidget);
    expect(find.text('JOUER · LA MER ROUGE'), findsOneWidget);
  });

  testWidgets('playing a stage flies its verse, under the name of its place', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    await app.preferences.setString('flight_journey', '3,2');
    // ignore: unawaited_futures
    app.container.read(appRouterProvider).push(const FlightJourneyRoute());
    await tester.pumpAndSettle();

    await tester.tap(find.text('JOUER · LA MER ROUGE'));
    await _frames(tester);

    expect(find.byType(VerseFlightScreen), findsOneWidget);
    expect(find.text('La mer Rouge'), findsOneWidget);
    expect(find.text('Étape 3 sur 12'), findsOneWidget);
    expect(find.text('Exode 14.14'), findsOneWidget);
    expect(find.bySemanticsLabel('3 cœurs'), findsOneWidget);

    await tester.tap(find.byTooltip('Terminer'));
    await _frames(tester, 30);
    expect(find.byType(VerseFlightScreen), findsNothing);
    expect(find.byType(FlightJourneyScreen), findsOneWidget);
  });

  testWidgets('a stage not open yet is flown as a free flight', (tester) async {
    final app = await pumpApp(tester, token: 't');
    // ignore: unawaited_futures
    app.container.read(appRouterProvider).push(VerseFlightRoute(stage: 7));
    await _frames(tester);

    expect(find.byType(VerseFlightScreen), findsOneWidget);
    expect(find.text('Verset en vol'), findsOneWidget);
    expect(find.text('Kadès'), findsNothing);

    await tester.tap(find.byTooltip('Terminer'));
    await _frames(tester, 30);
  });

  testWidgets('a stage won is kept on the phone and opens the next one', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    final journey = app.container.read(flightJourneyProvider.notifier);

    await journey.won(0, 2);
    expect(app.container.read(flightJourneyProvider).current, 1);
    expect(app.preferences.getString('flight_journey'), '2');

    // a worse score changes nothing, a better one is kept
    await journey.won(0, 1);
    expect(app.preferences.getString('flight_journey'), '2');
    await journey.won(0, 3);
    expect(app.preferences.getString('flight_journey'), '3');
  });

  testWidgets('the tile of the games tab tells the stage reached', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      gamesApi: FakeGamesApi(gamePath: _path),
    );
    await app.container.read(flightJourneyProvider.notifier).won(0, 3);
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Jeux'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Verset en vol'), findsOneWidget);
    expect(find.text('Étape 2 sur 12'), findsOneWidget);

    // the tile opens the map of the journey
    await tester.tap(find.text('Verset en vol'));
    await tester.pumpAndSettle();
    expect(find.byType(FlightJourneyScreen), findsOneWidget);
  });
}
