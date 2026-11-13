import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/games/domain/game.dart';
import 'package:cmfi_connect/src/features/games/presentation/widgets/game_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

const _path = GamePath(
  courses: [GameCourse(code: 'defi', title: 'Défi biblique')],
  course: 'defi',
  player: GamePlayer(level: 1, nextLevelAt: 200),
  levels: [
    GameLevel(
      id: 1,
      position: 1,
      title: 'Débutant',
      lessons: [
        GameLessonSummary(
          id: 7,
          position: 1,
          title: 'Les grands récits',
          state: LessonState.open,
        ),
      ],
    ),
  ],
);

const _order = GameQuestion(
  id: 1,
  kind: 'order',
  prompt: 'Remets dans l’ordre',
  choices: [
    GameChoice(id: 'a', text: 'Le déluge'),
    GameChoice(id: 'b', text: 'La création'),
    GameChoice(id: 'c', text: 'L’exode'),
    GameChoice(id: 'd', text: 'Abraham'),
  ],
  answer: 'b,a,d,c',
);

const _match = GameQuestion(
  id: 2,
  kind: 'match',
  prompt: 'Relie les paires',
  choices: [
    GameChoice(id: 'l1', text: 'Noé'),
    GameChoice(id: 'l2', text: 'Moïse'),
    GameChoice(id: 'l3', text: 'David'),
    GameChoice(id: 'r1', text: 'Goliath'),
    GameChoice(id: 'r2', text: 'L’arche'),
    GameChoice(id: 'r3', text: 'La mer Rouge'),
  ],
  answer: 'l1=r2,l2=r3,l3=r1',
);

Future<void> _open(WidgetTester tester, List<GameQuestion> questions) async {
  await pumpApp(
    tester,
    token: 't',
    gamesApi: FakeGamesApi(
      gamePath: _path,
      lessons: [
        GameLesson(
          id: 7,
          title: 'Les grands récits',
          levelTitle: 'Débutant',
          questions: questions,
        ),
      ],
    ),
  );
  await tester.tap(
    find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text('Jeux'),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.byType(PathNode).first);
  await tester.pumpAndSettle();
}

Future<void> _tap(WidgetTester tester, String text) async {
  await tester.tap(find.text(text));
  await tester.pump();
}

bool _canCheck(WidgetTester tester) =>
    tester.widget<GameButton>(find.byType(GameButton)).onPressed != null;

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('an order is checked once every thing has its place', (
    tester,
  ) async {
    await _open(tester, [_order]);

    await _tap(tester, 'La création');
    await _tap(tester, 'Le déluge');
    await _tap(tester, 'L’exode');
    expect(_canCheck(tester), isFalse);
    // a place touched empties it: the thing goes back to the pool
    await _tap(tester, 'L’exode');
    await _tap(tester, 'Abraham');
    await _tap(tester, 'L’exode');
    expect(_canCheck(tester), isTrue);

    await tester.tap(find.text('VÉRIFIER'));
    await tester.pumpAndSettle();
    expect(find.text('Bien joué !'), findsOneWidget);
  });

  testWidgets('a wrong order shows the right one in words', (tester) async {
    await _open(tester, [_order]);
    for (final text in ['Le déluge', 'La création', 'Abraham', 'L’exode']) {
      await _tap(tester, text);
    }
    await tester.tap(find.text('VÉRIFIER'));
    await tester.pumpAndSettle();

    expect(find.text('Pas tout à fait'), findsOneWidget);
    expect(
      find.text(
        'La bonne réponse : La création → Le déluge → Abraham → L’exode',
      ),
      findsOneWidget,
    );
  });

  testWidgets('pairs are linked one side then the other, and undone', (
    tester,
  ) async {
    await _open(tester, [_match]);

    await _tap(tester, 'Noé');
    await _tap(tester, 'Goliath');
    // a linked one touched undoes its pair
    await _tap(tester, 'Goliath');
    await _tap(tester, 'L’arche');
    await _tap(tester, 'Noé');
    await _tap(tester, 'La mer Rouge');
    await _tap(tester, 'Moïse');
    expect(_canCheck(tester), isFalse);
    await _tap(tester, 'Goliath');
    await _tap(tester, 'David');
    expect(_canCheck(tester), isTrue);

    await tester.tap(find.text('VÉRIFIER'));
    await tester.pumpAndSettle();
    expect(find.text('Bien joué !'), findsOneWidget);
  });

  test('the right answer of a match, in words and by left id', () {
    expect(
      _match.answerText,
      'Noé — L’arche · Moïse — La mer Rouge · David — Goliath',
    );
    expect(matchAnswer({'l2': 'r3', 'l1': 'r2'}), 'l1=r2,l2=r3');
  });
}
