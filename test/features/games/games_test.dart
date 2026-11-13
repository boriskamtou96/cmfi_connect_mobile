import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/games/domain/game.dart';
import 'package:cmfi_connect/src/features/games/presentation/games_screen.dart';
import 'package:cmfi_connect/src/features/games/presentation/lesson_screen.dart';
import 'package:cmfi_connect/src/features/games/presentation/widgets/game_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

/// A course of one level and three lessons: the first done, the second open.
const _path = GamePath(
  courses: [
    GameCourse(code: 'ministry', title: 'Notre ministère'),
    GameCourse(code: 'bible', title: 'La Bible'),
  ],
  course: 'ministry',
  player: GamePlayer(
    totalPoints: 240,
    level: 2,
    levelFloor: 200,
    nextLevelAt: 600,
    streakDays: 6,
    playedToday: true,
    pointsToday: 30,
  ),
  levels: [
    GameLevel(
      id: 1,
      position: 1,
      title: 'Notre fondateur',
      description: 'La vie du Pr Zacharias Tanee Fomum.',
      lessons: [
        GameLessonSummary(
          id: 10,
          position: 1,
          title: 'Ses premières années',
          state: LessonState.done,
          stars: 3,
        ),
        GameLessonSummary(
          id: 11,
          position: 2,
          title: 'Livré au Seigneur',
          state: LessonState.open,
        ),
        GameLessonSummary(id: 12, position: 3, title: 'Le professeur'),
      ],
    ),
  ],
);

/// Three questions; the right choice always reads « La bonne ».
final _lesson = GameLesson(
  id: 11,
  title: 'Livré au Seigneur',
  levelTitle: 'Notre fondateur',
  course: 'ministry',
  questions: [
    for (var id = 1; id <= 3; id++)
      GameQuestion(
        id: id,
        prompt: 'Question $id ?',
        choices: const [
          GameChoice(id: 'a', text: 'La bonne'),
          GameChoice(id: 'b', text: 'Une autre'),
          GameChoice(id: 'c', text: 'Encore une autre'),
        ],
        answer: 'a',
        explanation: 'Parce que $id.',
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

/// Answers the question on the screen ([right] or not) and goes on.
Future<void> _answer(WidgetTester tester, {required bool right}) async {
  await tester.tap(find.text(right ? 'La bonne' : 'Une autre'));
  await tester.pump();
  await tester.tap(find.text('VÉRIFIER'));
  await tester.pumpAndSettle();
  expect(find.text(right ? 'Bien joué !' : 'Pas tout à fait'), findsOneWidget);
  await tester.tap(find.text('CONTINUER'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('no course published yet: the games are coming', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await _openGames(tester);

    expect(find.byType(GamesScreen), findsOneWidget);
    expect(find.text('Bientôt disponible'), findsOneWidget);
    expect(find.text('Les jeux arrivent bientôt'), findsOneWidget);
    expect(app.gamesApi.pathCalls, 1);
  });

  testWidgets('the path: the player, the courses, the level and its lessons', (
    tester,
  ) async {
    await pumpApp(
      tester,
      token: 't',
      gamesApi: FakeGamesApi(gamePath: _path),
    );
    await _openGames(tester);

    // the streak, the points, the goal of the day, the level
    expect(find.text('6'), findsOneWidget);
    expect(find.text('240'), findsOneWidget);
    expect(find.text('30 sur 50'), findsOneWidget);
    expect(find.text('Niveau 2'), findsOneWidget);
    expect(find.text('Notre ministère'), findsOneWidget);
    expect(find.text('La Bible'), findsOneWidget);

    expect(find.text('NIVEAU 1 · 1 SUR 3'), findsOneWidget);
    expect(find.text('Notre fondateur'), findsOneWidget);
    // the last lesson is under the fold
    final nodes = find.byType(PathNode, skipOffstage: false);
    expect(nodes, findsNWidgets(3));
    expect(tester.widgetList<PathNode>(nodes).map((n) => n.state), [
      LessonState.done,
      LessonState.open,
      LessonState.locked,
    ]);
    // the one to play
    expect(find.text('COMMENCER'), findsOneWidget);
    expect(
      tester.widget<PathNode>(find.byType(PathNode).at(1)).label,
      'Livré au Seigneur, Commencer',
    );
  });

  testWidgets('a lesson closed does not open', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      gamesApi: FakeGamesApi(gamePath: _path, lessons: [_lesson]),
    );
    await _openGames(tester);

    // the last lesson is under the fold
    await tester.drag(find.byType(ListView).last, const Offset(0, -400));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(PathNode).last);
    await tester.pumpAndSettle();

    expect(find.byType(LessonScreen), findsNothing);
    expect(
      app.toasts.messages,
      contains("Termine d'abord la leçon précédente."),
    );
  });

  testWidgets('another course is asked for when its chip is touched', (
    tester,
  ) async {
    final api = FakeGamesApi(gamePath: _path);
    await pumpApp(tester, token: 't', gamesApi: api);
    await _openGames(tester);

    await tester.tap(find.text('La Bible'));
    await tester.pumpAndSettle();

    expect(api.coursesAsked, [null, 'bible']);
  });

  testWidgets('a lesson played to its end: a mistake comes back, the play is '
      'sent, the end shows what it gave and the path is read again', (
    tester,
  ) async {
    final api = FakeGamesApi(gamePath: _path, lessons: [_lesson]);
    final app = await pumpApp(tester, token: 't', gamesApi: api);
    await _openGames(tester);
    await tester.tap(find.byType(PathNode).at(1));
    await tester.pumpAndSettle();

    expect(find.byType(LessonScreen), findsOneWidget);
    expect(find.text('NOTRE FONDATEUR'), findsOneWidget);
    // nothing to check before a choice
    await tester.tap(find.text('VÉRIFIER'));
    await tester.pumpAndSettle();
    expect(find.text('Bien joué !'), findsNothing);

    // a mistake: the right answer and why
    await tester.tap(find.text('Une autre'));
    await tester.pump();
    await tester.tap(find.text('VÉRIFIER'));
    await tester.pumpAndSettle();
    expect(find.text('Pas tout à fait'), findsOneWidget);
    expect(find.text('La bonne réponse : La bonne'), findsOneWidget);
    expect(find.textContaining('Parce que'), findsOneWidget);
    await tester.tap(find.text('CONTINUER'));
    await tester.pumpAndSettle();

    await _answer(tester, right: true);
    await _answer(tester, right: true);
    // the question missed comes back
    expect(find.text('ON LA REVOIT'), findsOneWidget);
    await _answer(tester, right: true);

    // sent, with the second attempt last
    final sent = api.submitted.single;
    expect(sent.lessonId, 11);
    expect(sent.clientId, isNotEmpty);
    expect(sent.answers, hasLength(4));
    expect(sent.answers.map((answer) => answer.attempt), [1, 1, 1, 2]);
    expect(sent.answers.first.choice, 'b');
    expect(sent.answers.last.questionId, sent.answers.first.questionId);
    expect(sent.answers.last.choice, 'a');

    // the end
    expect(find.text('Leçon terminée !'), findsOneWidget);
    expect(find.text('Livré au Seigneur'), findsOneWidget);
    expect(find.text('+90'), findsOneWidget);
    expect(find.text('7 / 8'), findsOneWidget);
    expect(find.text('7 jours de suite'), findsOneWidget);
    expect(find.text('Niveau 3 atteint !'), findsOneWidget);
    // a level up is heard with the longer fanfare, once
    expect(app.gameSounds.played, ['level']);

    await tester.tap(find.text('CONTINUER'));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsNothing);
    expect(find.byType(GamesScreen), findsOneWidget);
    // the path was read again: the lesson done, the next one open
    expect(api.pathCalls, 2);
  });

  testWidgets('without network at the end, the lesson waits: « Réessayer » '
      'sends the same play', (tester) async {
    final api = FakeGamesApi(gamePath: _path, lessons: [_lesson])
      ..offline = true;
    await pumpApp(tester, token: 't', gamesApi: api);
    await _openGames(tester);
    await tester.tap(find.byType(PathNode).at(1));
    await tester.pumpAndSettle();
    for (var i = 0; i < 3; i++) {
      await _answer(tester, right: true);
    }

    expect(find.textContaining("n'a pas pu être envoyée"), findsOneWidget);
    expect(api.submitted, isEmpty);
    expect(api.attempts, hasLength(1));

    api.offline = false;
    await tester.tap(find.text('RÉESSAYER'));
    await tester.pumpAndSettle();

    expect(find.text('Leçon terminée !'), findsOneWidget);
    expect(api.attempts, hasLength(2));
    expect(api.attempts.toSet(), hasLength(1), reason: 'the same client id');
  });

  testWidgets('leaving a lesson under way asks first, and sends nothing', (
    tester,
  ) async {
    final api = FakeGamesApi(gamePath: _path, lessons: [_lesson]);
    await pumpApp(tester, token: 't', gamesApi: api);
    await _openGames(tester);
    await tester.tap(find.byType(PathNode).at(1));
    await tester.pumpAndSettle();
    await _answer(tester, right: true);

    await tester.tap(find.byTooltip('Quitter la leçon'));
    await tester.pumpAndSettle();
    expect(find.text('Quitter la leçon ?'), findsOneWidget);
    // staying
    await tester.tap(find.text('Annuler'));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsOneWidget);

    await tester.tap(find.byTooltip('Quitter la leçon'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Quitter'));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsNothing);
    expect(api.attempts, isEmpty);
  });

  testWidgets('in Arabic (right to left), the path and a lesson fit', (
    tester,
  ) async {
    await LocaleSettings.setLocale(AppLocale.ar);
    final ar = AppLocale.ar.buildSync();
    await pumpApp(
      tester,
      token: 't',
      gamesApi: FakeGamesApi(gamePath: _path, lessons: [_lesson]),
    );
    await tester.tap(find.text(ar.nav.games).last);
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.tap(find.byType(PathNode).at(1));
    await tester.pumpAndSettle();
    await tester.tap(find.text('La bonne'));
    await tester.pump();
    await tester.tap(find.text(ar.games.check.toUpperCase()));
    await tester.pumpAndSettle();
    expect(find.text(ar.games.right), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
