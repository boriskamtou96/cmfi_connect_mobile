import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/games/domain/game.dart';
import 'package:cmfi_connect/src/features/games/presentation/leaderboard_screen.dart';
import 'package:cmfi_connect/src/features/games/presentation/lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

GamePath _path({bool? inLeaderboard, int? weekRank, bool dailyDone = false}) =>
    GamePath(
      courses: const [GameCourse(code: 'ministry', title: 'Notre ministère')],
      course: 'ministry',
      player: GamePlayer(
        totalPoints: 240,
        level: 2,
        streakDays: 6,
        playedToday: true,
        pointsToday: 30,
        inLeaderboard: inLeaderboard,
        weekRank: weekRank,
        dailyDone: dailyDone,
      ),
      levels: const [
        GameLevel(
          id: 1,
          position: 1,
          title: 'Notre fondateur',
          lessons: [
            GameLessonSummary(
              id: 10,
              title: 'Ses premières années',
              state: LessonState.done,
              stars: 3,
            ),
            GameLessonSummary(
              id: 11,
              title: 'Livré au Seigneur',
              state: LessonState.open,
            ),
          ],
        ),
      ],
    );

const _board = GameLeaderboard(
  entries: [
    GameLeaderboardEntry(rank: 1, username: 'marie.ngo', points: 420),
    GameLeaderboardEntry(rank: 2, username: 'paul.m', points: 380),
    GameLeaderboardEntry(
      rank: 3,
      username: 'boris.kamtou',
      points: 240,
      me: true,
    ),
    GameLeaderboardEntry(rank: 4, username: 'esther.b', points: 90),
  ],
  me: GameStanding(rank: 3, points: 240),
);

const _daily = GameDaily(
  questions: [
    GameQuestion(
      id: 1,
      prompt: 'Question du défi 1 ?',
      choices: [
        GameChoice(id: 'a', text: 'La bonne'),
        GameChoice(id: 'b', text: 'Une autre'),
      ],
      answer: 'a',
    ),
    GameQuestion(
      id: 2,
      prompt: 'Question du défi 2 ?',
      choices: [
        GameChoice(id: 'a', text: 'La bonne'),
        GameChoice(id: 'b', text: 'Une autre'),
      ],
      answer: 'a',
    ),
  ],
);

Future<void> _openGames(WidgetTester tester) async {
  await tester.tap(
    find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text('Jeux'),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _openBoard(WidgetTester tester) async {
  await _openGames(tester);
  await tester.tap(find.text('Classement'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('the first time, the leaderboard asks whether to appear, and '
      'keeps the answer', (tester) async {
    final api = FakeGamesApi(gamePath: _path())..board = _board;
    await pumpApp(tester, token: 't', gamesApi: api);
    await _openBoard(tester);

    expect(find.byType(LeaderboardScreen), findsOneWidget);
    expect(find.text('Apparaître dans le classement ?'), findsOneWidget);
    expect(find.textContaining('ton pseudo, ta photo'), findsOneWidget);
    await tester.tap(find.text("Oui, j'y entre"));
    await tester.pumpAndSettle();

    expect(api.settings, [(inLeaderboard: true, dailyGoal: null)]);
    expect(find.text('Apparaître dans le classement ?'), findsNothing);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
  });

  testWidgets('saying no keeps the member out, and the others in sight; the '
      'switch brings them in later', (tester) async {
    final api = FakeGamesApi(gamePath: _path())
      ..board = const GameLeaderboard(
        entries: [
          GameLeaderboardEntry(rank: 1, username: 'marie.ngo', points: 420),
        ],
      );
    await pumpApp(tester, token: 't', gamesApi: api);
    await _openBoard(tester);
    await tester.tap(find.text('Non merci'));
    await tester.pumpAndSettle();

    expect(api.settings, [(inLeaderboard: false, dailyGoal: null)]);
    expect(find.text('@marie.ngo'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);

    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    expect(api.settings.last, (inLeaderboard: true, dailyGoal: null));
    expect(find.text('Apparaître dans le classement ?'), findsNothing);
  });

  testWidgets('the leaderboard: pseudos and points, my line, this week or '
      'since ever, all or my circle', (tester) async {
    final api = FakeGamesApi(gamePath: _path(inLeaderboard: true, weekRank: 3))
      ..board = _board;
    await pumpApp(tester, token: 't', gamesApi: api);
    await _openGames(tester);
    // my rank of the week, on the tab
    expect(find.text('Rang 3'), findsOneWidget);
    await tester.tap(find.text('Classement'));
    await tester.pumpAndSettle();

    // already chosen: nothing is asked
    expect(find.text('Apparaître dans le classement ?'), findsNothing);
    expect(api.boardsAsked, [(period: 'week', scope: 'all')]);
    expect(find.text('@marie.ngo'), findsOneWidget);
    expect(find.text('420'), findsOneWidget);
    expect(find.text('@boris.kamtou · Toi'), findsOneWidget);
    expect(find.text('@esther.b'), findsOneWidget);

    await tester.tap(find.text('Depuis toujours'));
    await tester.pumpAndSettle();
    expect(api.boardsAsked.last, (period: 'all', scope: 'all'));
    await tester.tap(find.text('Mon cercle'));
    await tester.pumpAndSettle();
    expect(api.boardsAsked.last, (period: 'all', scope: 'circle'));
  });

  testWidgets('beyond the first fifty, my line is pinned under the list; an '
      'empty week says so', (tester) async {
    final api = FakeGamesApi(gamePath: _path(inLeaderboard: true))
      ..board = const GameLeaderboard(
        entries: [
          GameLeaderboardEntry(rank: 1, username: 'marie.ngo', points: 420),
        ],
        me: GameStanding(rank: 127, points: 34),
      );
    await pumpApp(tester, token: 't', gamesApi: api);
    await _openBoard(tester);

    expect(find.text('127'), findsOneWidget);
    expect(find.text('Toi'), findsOneWidget);
    expect(find.text('34 points'), findsOneWidget);

    api.board = const GameLeaderboard();
    await tester.tap(find.text('Depuis toujours'));
    await tester.pumpAndSettle();
    expect(find.textContaining("Personne n'a encore joué"), findsOneWidget);
    expect(find.text('Toi'), findsNothing);
  });

  testWidgets('the challenge of the day is played like a lesson and gives '
      '15 points', (tester) async {
    final api = FakeGamesApi(gamePath: _path())..dailyChallenge = _daily;
    await pumpApp(tester, token: 't', gamesApi: api);
    await _openGames(tester);

    expect(find.text('5 questions · +15 points'), findsOneWidget);
    await tester.tap(find.text('Défi du jour'));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsOneWidget);
    expect(find.text('DÉFI DU JOUR'), findsOneWidget);

    for (var i = 0; i < 2; i++) {
      await tester.tap(find.text('La bonne'));
      await tester.pump();
      await tester.tap(find.text('VÉRIFIER'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('CONTINUER'));
      await tester.pumpAndSettle();
    }

    expect(api.dailySubmitted.single.answers, hasLength(2));
    expect(api.submitted, isEmpty);
    expect(find.text('Défi relevé !'), findsOneWidget);
    expect(find.text('+15'), findsOneWidget);
    expect(find.text('2 / 2'), findsOneWidget);
  });

  testWidgets('done today, the challenge does not open again', (tester) async {
    final api = FakeGamesApi(gamePath: _path(dailyDone: true))
      ..dailyChallenge = _daily;
    final app = await pumpApp(tester, token: 't', gamesApi: api);
    await _openGames(tester);

    expect(find.text('Défi du jour relevé. À demain !'), findsOneWidget);
    await tester.tap(find.text('Défi du jour'));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsNothing);
    expect(app.toasts.messages, contains('Défi du jour relevé. À demain !'));
  });

  testWidgets('before the first lesson done, no challenge of the day', (
    tester,
  ) async {
    final fresh = _path().copyWith(player: const GamePlayer());
    await pumpApp(
      tester,
      token: 't',
      gamesApi: FakeGamesApi(gamePath: fresh),
    );
    await _openGames(tester);

    expect(find.text('Défi du jour'), findsNothing);
    expect(find.text('Classement'), findsOneWidget);
  });
}
