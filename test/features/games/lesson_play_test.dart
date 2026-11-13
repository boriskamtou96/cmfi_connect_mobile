import 'package:cmfi_connect/src/features/games/application/lesson_play.dart';
import 'package:cmfi_connect/src/features/games/domain/game.dart';
import 'package:flutter_test/flutter_test.dart';

GameQuestion _question(int id) => GameQuestion(
  id: id,
  prompt: 'Question $id ?',
  choices: const [
    GameChoice(id: 'a', text: 'La bonne'),
    GameChoice(id: 'b', text: 'Une autre'),
  ],
  answer: 'a',
  explanation: 'Parce que.',
);

final _lesson = GameLesson(
  id: 11,
  title: 'Leçon',
  questions: [for (var id = 1; id <= 3; id++) _question(id)],
);

/// Answers the current question with [choice] and goes on.
LessonPlay _answer(LessonPlay play, String choice) =>
    play.choose(choice).check().next();

void main() {
  test('a right answer goes on to the next question', () {
    var play = LessonPlay.start(_lesson);
    expect(play.current!.id, 1);
    expect(play.progress, 0);

    // nothing is checked without a choice
    expect(play.check().checked, isFalse);

    play = play.choose('a');
    expect(play.selected, 'a');
    expect(play.checked, isFalse);
    play = play.check();
    expect(play.checked, isTrue);
    expect(play.isRight, isTrue);
    expect(play.run, 1);
    // the choice is settled once checked
    expect(play.choose('b').selected, 'a');
    expect(play.progress, closeTo(1 / 3, 0.001));

    play = play.next();
    expect(play.current!.id, 2);
    expect(play.selected, isNull);
    expect(play.checked, isFalse);
    expect(play.answers, const [
      GameAnswer(questionId: 1, choice: 'a', attempt: 1),
    ]);
  });

  test('a wrong answer comes back once at the end, as a second attempt', () {
    var play = LessonPlay.start(_lesson);
    play = play.choose('b').check();
    expect(play.isRight, isFalse);
    expect(play.run, 0);
    expect(play.progress, 0);
    play = play.next();

    play = _answer(_answer(play, 'a'), 'a');
    expect(play.finished, isFalse);
    expect(play.current!.id, 1, reason: 'the question missed comes back');
    expect(play.isRetry, isTrue);

    play = play.choose('a').check();
    expect(play.isRight, isTrue);
    play = play.next();
    expect(play.finished, isTrue);
    expect(play.current, isNull);
    expect(play.progress, 1);
    expect(play.firstTry, 2);
    expect(play.answers, const [
      GameAnswer(questionId: 1, choice: 'b', attempt: 1),
      GameAnswer(questionId: 2, choice: 'a', attempt: 1),
      GameAnswer(questionId: 3, choice: 'a', attempt: 1),
      GameAnswer(questionId: 1, choice: 'a', attempt: 2),
    ]);
  });

  test('missed twice, a question does not come back again', () {
    var play = LessonPlay.start(_lesson);
    play = _answer(_answer(_answer(play, 'b'), 'a'), 'a');
    play = _answer(play, 'b');
    expect(play.finished, isTrue);
    expect(
      play.answers.last,
      const GameAnswer(questionId: 1, choice: 'b', attempt: 2),
    );
  });

  test('the row of right answers starts again after a mistake', () {
    var play = LessonPlay.start(_lesson);
    play = _answer(play, 'a');
    play = play.choose('a').check();
    expect(play.run, 2);
    play = play.next().choose('b').check();
    expect(play.run, 0);
  });

  test('next waits for the answer to be checked', () {
    final play = LessonPlay.start(_lesson).choose('a');
    expect(play.next().current!.id, 1);
  });

  test('a lesson without questions is finished at once', () {
    final play = LessonPlay.start(const GameLesson(id: 1, title: 'Vide'));
    expect(play.finished, isTrue);
    expect(play.progress, 1);
  });
}
