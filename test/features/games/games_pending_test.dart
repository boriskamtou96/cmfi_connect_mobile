import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/games/application/game_path.dart';
import 'package:cmfi_connect/src/features/games/application/pending_plays.dart';
import 'package:cmfi_connect/src/features/games/domain/game.dart';
import 'package:cmfi_connect/src/features/games/presentation/games_screen.dart';
import 'package:cmfi_connect/src/features/games/presentation/lesson_screen.dart';
import 'package:cmfi_connect/src/features/games/presentation/widgets/game_widgets.dart';
import 'package:cmfi_connect/src/features/ministry/presentation/life_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

const _path = GamePath(
  courses: [GameCourse(code: 'ministry', title: 'Notre ministère')],
  course: 'ministry',
  levels: [
    GameLevel(
      id: 1,
      position: 1,
      title: 'Notre fondateur',
      lessons: [
        GameLessonSummary(
          id: 11,
          title: 'Ses premières années',
          state: LessonState.open,
        ),
      ],
    ),
  ],
);

const _lesson = GameLesson(
  id: 11,
  title: 'Ses premières années',
  levelTitle: 'Notre fondateur',
  questions: [
    GameQuestion(
      id: 1,
      prompt: 'En quelle année est-il né ?',
      choices: [
        GameChoice(id: 'a', text: '1945'),
        GameChoice(id: 'b', text: '1955'),
      ],
      answer: 'a',
      explanation: 'Il est né le 20 juin 1945.',
      source: 'ministry:founder',
    ),
  ],
);

String _kept({required int accountId}) => jsonEncode([
  {
    'account_id': accountId,
    'lesson_id': 11,
    'client_id': 'kept-1',
    'answers': [
      {'question_id': 1, 'choice': 'a', 'attempt': 1},
    ],
  },
]);

Future<void> _openGames(WidgetTester tester) async {
  await tester.tap(
    find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text('Jeux'),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('without network, a lesson finished is kept: the member can '
      'leave, and it is sent when the tab is read again', (tester) async {
    final api = FakeGamesApi(gamePath: _path, lessons: [_lesson])
      ..offline = true;
    final app = await pumpApp(
      tester,
      token: 't',
      account: sampleAccount,
      gamesApi: api,
    );
    await _openGames(tester);
    await tester.tap(find.byType(PathNode));
    await tester.pumpAndSettle();
    await tester.tap(find.text('1945'));
    await tester.pump();
    await tester.tap(find.text('VÉRIFIER'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUER'));
    await tester.pumpAndSettle();

    expect(find.textContaining("n'a pas pu être envoyée"), findsOneWidget);
    expect(find.textContaining('Tu peux quitter'), findsOneWidget);
    final kept = app.container.read(pendingGamePlaysProvider);
    expect(kept.single.accountId, sampleAccount.id);
    expect(kept.single.lessonId, 11);
    expect(kept.single.clientId, api.attempts.single);

    // leaving does not ask: nothing would be lost
    await tester.tap(find.text('Quitter la leçon'));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsNothing);
    expect(find.text('Quitter la leçon ?'), findsNothing);
    expect(find.byType(GamesScreen), findsOneWidget);

    // the network is back: the tab reads its path again
    api.offline = false;
    app.container.invalidate(gamePathProvider);
    await tester.pumpAndSettle();

    expect(api.submitted.single.clientId, kept.single.clientId);
    expect(api.submitted.single.answers.single.choice, 'a');
    expect(app.container.read(pendingGamePlaysProvider), isEmpty);
  });

  testWidgets('« Réessayer » that works forgets the play kept', (tester) async {
    final api = FakeGamesApi(gamePath: _path, lessons: [_lesson])
      ..offline = true;
    final app = await pumpApp(
      tester,
      token: 't',
      account: sampleAccount,
      gamesApi: api,
    );
    await _openGames(tester);
    await tester.tap(find.byType(PathNode));
    await tester.pumpAndSettle();
    await tester.tap(find.text('1945'));
    await tester.pump();
    await tester.tap(find.text('VÉRIFIER'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CONTINUER'));
    await tester.pumpAndSettle();
    expect(app.container.read(pendingGamePlaysProvider), hasLength(1));

    api.offline = false;
    await tester.tap(find.text('RÉESSAYER'));
    await tester.pumpAndSettle();

    expect(find.text('Leçon terminée !'), findsOneWidget);
    expect(app.container.read(pendingGamePlaysProvider), isEmpty);
    expect(api.submitted, hasLength(1));
  });

  testWidgets('a play kept by another account is never sent for this one', (
    tester,
  ) async {
    final api = FakeGamesApi(gamePath: _path);
    final app = await pumpApp(
      tester,
      token: 't',
      account: sampleAccount,
      gamesApi: api,
      initialPreferences: {
        'games_pending_plays': _kept(accountId: sampleAccount.id + 1),
      },
    );
    await _openGames(tester);

    expect(api.attempts, isEmpty);
    expect(app.container.read(pendingGamePlaysProvider), hasLength(1));
  });

  testWidgets('a play the server refuses for good is dropped', (tester) async {
    final api = FakeGamesApi(gamePath: _path)..refused = true;
    final app = await pumpApp(
      tester,
      token: 't',
      account: sampleAccount,
      gamesApi: api,
      initialPreferences: {
        'games_pending_plays': _kept(accountId: sampleAccount.id),
      },
    );
    await _openGames(tester);

    expect(api.attempts, ['kept-1']);
    expect(api.submitted, isEmpty);
    expect(app.container.read(pendingGamePlaysProvider), isEmpty);
    expect(find.byType(PathNode), findsOneWidget);
  });

  testWidgets('after an answer about our ministry, « Lire » opens its page, '
      'and the lesson waits', (tester) async {
    final api = FakeGamesApi(gamePath: _path, lessons: [_lesson]);
    await pumpApp(tester, token: 't', account: sampleAccount, gamesApi: api);
    await _openGames(tester);
    await tester.tap(find.byType(PathNode));
    await tester.pumpAndSettle();

    // nothing to read before the answer
    expect(find.text('Lire dans « Notre ministère »'), findsNothing);
    await tester.tap(find.text('1945'));
    await tester.pump();
    await tester.tap(find.text('VÉRIFIER'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Lire dans « Notre ministère »'));
    await tester.pumpAndSettle();
    expect(find.byType(FounderScreen), findsOneWidget);

    await tester.tap(find.byTooltip('Retour').last);
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsOneWidget);
    expect(find.text('Bien joué !'), findsOneWidget);
    expect(api.attempts, isEmpty);
  });
}
