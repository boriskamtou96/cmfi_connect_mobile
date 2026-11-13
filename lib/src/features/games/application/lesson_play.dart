import 'dart:math';

import 'package:flutter/foundation.dart';

import '../domain/game.dart';

/// A lesson being played: one question at a time, a choice, « Vérifier »,
/// then the next one. A question answered wrong comes back once at the end.
/// Immutable: each move gives the play after it.
@immutable
class LessonPlay {
  const LessonPlay._({
    required this.lesson,
    required this.queue,
    this.index = 0,
    this.selected,
    this.checked = false,
    this.answers = const [],
    this.run = 0,
    this.retried = const {},
  });

  /// The start of [lesson]. With [random], its questions and their choices
  /// are shuffled (the app); without, they keep their order (the tests).
  factory LessonPlay.start(GameLesson lesson, {Random? random}) {
    var questions = lesson.questions;
    if (random != null) {
      questions = [
        for (final question in lesson.questions)
          question.copyWith(choices: [...question.choices]..shuffle(random)),
      ]..shuffle(random);
    }
    return LessonPlay._(lesson: lesson, queue: questions);
  }

  final GameLesson lesson;

  /// The questions to ask, those that come back added at the end.
  final List<GameQuestion> queue;
  final int index;

  /// The id of the choice touched, null before.
  final String? selected;

  /// « Vérifier » was pressed: the answer shows right or wrong.
  final bool checked;

  /// Every answer checked so far, in order (what the server counts).
  final List<GameAnswer> answers;

  /// Right answers in a row.
  final int run;

  /// The questions already missed once.
  final Set<int> retried;

  bool get finished => index >= queue.length;

  /// The question asked, null once finished.
  GameQuestion? get current => finished ? null : queue[index];

  /// The question asked is one that comes back.
  bool get isRetry => !finished && index >= lesson.questions.length;

  /// The answer checked is the right one.
  bool get isRight => checked && selected == current?.answer;

  /// The questions answered right at once.
  int get firstTry => answers
      .where((answer) => answer.attempt == 1 && _rightChoice(answer))
      .length;

  bool _rightChoice(GameAnswer answer) => lesson.questions.any(
    (question) =>
        question.id == answer.questionId && question.answer == answer.choice,
  );

  /// The share of the lesson settled, 0 to 1: a question counts once it is
  /// answered right, or missed twice.
  double get progress {
    final total = lesson.questions.length;
    if (total == 0) {
      return 1;
    }
    final settled = {
      for (final answer in answers)
        if (answer.attempt > 1 || _rightChoice(answer)) answer.questionId,
    };
    return settled.length / total;
  }

  /// Touches a choice (until the answer is checked).
  LessonPlay choose(String choice) =>
      checked || finished ? this : _copy(selected: choice);

  /// « Vérifier »: the answer is kept; wrong the first time, the question
  /// goes back to the end.
  LessonPlay check() {
    final question = current;
    final choice = selected;
    if (question == null || choice == null || checked) {
      return this;
    }
    final right = choice == question.answer;
    final second = retried.contains(question.id);
    return LessonPlay._(
      lesson: lesson,
      queue: right || second ? queue : [...queue, question],
      index: index,
      selected: choice,
      checked: true,
      answers: [
        ...answers,
        GameAnswer(
          questionId: question.id,
          choice: choice,
          attempt: second ? 2 : 1,
        ),
      ],
      run: right ? run + 1 : 0,
      retried: right ? retried : {...retried, question.id},
    );
  }

  /// « Continuer »: the next question, once the answer is checked.
  LessonPlay next() => !checked
      ? this
      : LessonPlay._(
          lesson: lesson,
          queue: queue,
          index: index + 1,
          answers: answers,
          run: run,
          retried: retried,
        );

  LessonPlay _copy({String? selected}) => LessonPlay._(
    lesson: lesson,
    queue: queue,
    index: index,
    selected: selected,
    checked: checked,
    answers: answers,
    run: run,
    retried: retried,
  );
}
