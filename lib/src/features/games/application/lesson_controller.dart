import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/session/session.dart';
import '../domain/game.dart';
import '../infrastructure/game_storage.dart';
import '../infrastructure/games_api.dart';
import 'game_path.dart';
import 'lesson_play.dart';
import 'pending_plays.dart';

part 'lesson_controller.g.dart';

/// A lesson on the screen: the play, then its sending, then what it gave.
@immutable
class LessonSession {
  const LessonSession({
    required this.play,
    required this.clientId,
    this.result,
    this.sending = false,
    this.sendError,
    this.kept = false,
  });

  final LessonPlay play;

  /// Names the play for the server: sent again, it counts once.
  final String clientId;

  /// What the server counted, once the lesson is sent.
  final GameResult? result;
  final bool sending;

  /// Why the last sending failed (the play is kept: « Réessayer »).
  final Object? sendError;

  /// The play that could not be sent is kept on the phone: leaving loses
  /// nothing, it goes when the network is back.
  final bool kept;

  LessonSession _with({
    LessonPlay? play,
    GameResult? result,
    bool? sending,
    Object? sendError,
    bool kept = false,
  }) => LessonSession(
    play: play ?? this.play,
    clientId: clientId,
    result: result ?? this.result,
    sending: sending ?? this.sending,
    sendError: sendError,
    kept: kept,
  );
}

/// Plays lesson [lessonId]: loads its questions (shuffled), takes the
/// answers, and sends the play once every question is settled. The server
/// counts the points.
@riverpod
class LessonController extends _$LessonController {
  @override
  Future<LessonSession> build(int lessonId) async {
    final api = ref.watch(gamesApiProvider);
    final lesson = lessonId == dailyLessonId
        ? GameLesson(
            id: dailyLessonId,
            title: '',
            questions: (await api.daily()).questions,
          )
        : await _lesson(api);
    final random = Random();
    return LessonSession(
      play: LessonPlay.start(lesson, random: random),
      clientId:
          '${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}-'
          '${random.nextInt(1 << 32).toRadixString(36)}',
    );
  }

  /// The lesson from the server, or without network the copy of a course
  /// downloaded.
  Future<GameLesson> _lesson(GamesApi api) async {
    try {
      return await api.lesson(lessonId);
    } on ApiException {
      rethrow;
    } on Object {
      final kept = await ref.read(gameStorageProvider).lesson(lessonId);
      if (kept == null) {
        rethrow;
      }
      return kept;
    }
  }

  void choose(String choice) => _move((play) => play.choose(choice));

  /// « Vérifier ».
  void check() => _move((play) => play.check());

  /// « Continuer »: the next question, or the lesson sent once it is over.
  Future<void> next() async {
    _move((play) => play.next());
    if (state.value?.play.finished ?? false) {
      await send();
    }
  }

  /// Sends the play (again after a failure: the same [LessonSession.clientId]).
  Future<void> send() async {
    final session = state.value;
    if (session == null ||
        session.sending ||
        session.result != null ||
        !session.play.finished) {
      return;
    }
    state = AsyncData(session._with(sending: true));
    try {
      final result = await _submit(session);
      if (!ref.mounted) {
        return;
      }
      state = AsyncData(session._with(result: result, sending: false));
      // the path: the lesson done, the next one open, the points
      ref.invalidate(gamePathProvider);
      await ref
          .read(pendingGamePlaysProvider.notifier)
          .forget(session.clientId);
    } on Object catch (error) {
      if (!ref.mounted) {
        return;
      }
      // without network the play is kept on the phone, for this account,
      // and sent later; what the server refuses would be refused again
      var kept = false;
      if (error is! ApiException) {
        final account = await ref.read(signedInAccountProvider.future);
        if (account != null && ref.mounted) {
          await ref
              .read(pendingGamePlaysProvider.notifier)
              .keep(
                PendingPlay(
                  accountId: account.id,
                  lessonId: lessonId,
                  clientId: session.clientId,
                  answers: session.play.answers,
                ),
              );
          kept = true;
          // the path without network: this lesson done, the next one open
          ref.invalidate(gamePathProvider);
        }
      }
      if (ref.mounted) {
        state = AsyncData(
          session._with(sending: false, sendError: error, kept: kept),
        );
      }
    }
  }

  Future<GameResult> _submit(LessonSession session) async {
    final api = ref.read(gamesApiProvider);
    final answers = session.play.answers;
    if (lessonId != dailyLessonId) {
      return api.submitLesson(
        lessonId,
        clientId: session.clientId,
        answers: answers,
      );
    }
    final daily = await api.submitDaily(
      clientId: session.clientId,
      answers: answers,
    );
    final perfect = daily.total > 0 && daily.firstTry == daily.total;
    return GameResult(
      points: daily.points,
      firstTry: daily.firstTry,
      total: daily.total,
      stars: perfect
          ? 3
          : daily.firstTry * 4 >= daily.total * 3
          ? 2
          : 1,
      perfect: perfect,
      levelUp: daily.levelUp,
      player: daily.player,
    );
  }

  void _move(LessonPlay Function(LessonPlay play) move) {
    final session = state.value;
    if (session != null) {
      state = AsyncData(session._with(play: move(session.play)));
    }
  }
}
