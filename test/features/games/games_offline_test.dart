import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/games/application/game_path.dart';
import 'package:cmfi_connect/src/features/games/domain/game.dart';
import 'package:cmfi_connect/src/features/games/presentation/lesson_screen.dart';
import 'package:cmfi_connect/src/features/games/presentation/widgets/game_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

const _path = GamePath(
  courses: [GameCourse(code: 'ministry', title: 'Notre ministère')],
  course: 'ministry',
  player: GamePlayer(level: 1, nextLevelAt: 200),
  levels: [
    GameLevel(
      id: 1,
      position: 1,
      title: 'Notre fondateur',
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

final _lessons = [
  for (final id in [10, 11, 12])
    GameLesson(
      id: id,
      title: 'Leçon $id',
      levelTitle: 'Notre fondateur',
      course: 'ministry',
      questions: [
        for (var q = 1; q <= 2; q++)
          GameQuestion(
            id: id * 10 + q,
            prompt: 'Question $q ?',
            choices: const [
              GameChoice(id: 'a', text: 'La bonne'),
              GameChoice(id: 'b', text: 'Une autre'),
            ],
            answer: 'a',
          ),
      ],
    ),
];

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('a course downloaded is played without network; the lesson '
      'waits and opens the next one', (tester) async {
    final api = FakeGamesApi(gamePath: _path, lessons: _lessons);
    final storage = FakeGameStorage();
    final app = await pumpApp(
      tester,
      token: 't',
      gamesApi: api,
      gameStorage: storage,
      account: sampleAccount,
    );
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Jeux'),
      ),
    );
    await tester.pumpAndSettle();

    // online: the course is downloaded
    expect(find.text('3 leçons'), findsOneWidget);
    await tester.tap(find.text('Jouer hors ligne'));
    await tester.pumpAndSettle();
    expect(api.downloads, ['ministry']);
    expect(storage.courses['ministry'], hasLength(3));
    expect(
      app.toasts.messages,
      contains('Parcours gardé : tu peux jouer sans réseau.'),
    );
    expect(find.text('Gardé'), findsOneWidget);

    // the network goes: the path comes from the phone
    api
      ..readsOffline = true
      ..offline = true;
    app.container.invalidate(gamePathProvider);
    await tester.pumpAndSettle();
    expect(
      find.text('Hors ligne : tes leçons partiront dès le retour du réseau.'),
      findsOneWidget,
    );

    // the lesson open is played from the copy
    await tester.tap(find.byType(PathNode).at(1));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsOneWidget);
    for (var q = 0; q < 2; q++) {
      await tester.tap(find.text('La bonne'));
      await tester.pump();
      await tester.tap(find.text('VÉRIFIER'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('CONTINUER'));
      await tester.pumpAndSettle();
    }
    // kept on the phone: leaving loses nothing
    expect(find.textContaining('Tu peux quitter'), findsOneWidget);
    await tester.tap(find.text('Quitter la leçon'));
    await tester.pumpAndSettle();

    // on the phone the next lesson opens
    final nodes = tester.widgetList<PathNode>(find.byType(PathNode)).toList();
    expect(nodes.map((node) => node.state), [
      LessonState.done,
      LessonState.done,
      LessonState.open,
    ]);

    // the network is back: the play goes
    api
      ..readsOffline = false
      ..offline = false;
    app.container.invalidate(gamePathProvider);
    await tester.pumpAndSettle();
    expect(api.submitted.map((play) => play.lessonId), [11]);
  });

  test('plays waiting open the lessons one after the other', () {
    final path = withPlayedOffline(_path, {11, 12});
    expect(
      [
        for (final lesson in path.levels.single.lessons)
          (lesson.state, lesson.stars),
      ],
      [(LessonState.done, 3), (LessonState.done, 1), (LessonState.done, 1)],
    );
  });
}
