import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/storage/preferences.dart';
import '../domain/game.dart';
import '../infrastructure/games_api.dart';

part 'pending_plays.g.dart';

/// A play finished without network: what the server needs to count it, and
/// the account that played it (never sent for another one).
@immutable
class PendingPlay {
  const PendingPlay({
    required this.accountId,
    required this.lessonId,
    required this.clientId,
    required this.answers,
  });

  factory PendingPlay.fromJson(Map<String, dynamic> json) => PendingPlay(
    accountId: json['account_id'] as int,
    lessonId: json['lesson_id'] as int,
    clientId: json['client_id'] as String,
    answers: [
      for (final answer in json['answers'] as List<dynamic>)
        GameAnswer.fromJson(answer as Map<String, dynamic>),
    ],
  );

  final int accountId;

  /// [dailyLessonId] for the challenge of the day.
  final int lessonId;
  final String clientId;
  final List<GameAnswer> answers;

  Map<String, dynamic> toJson() => {
    'account_id': accountId,
    'lesson_id': lessonId,
    'client_id': clientId,
    'answers': [for (final answer in answers) answer.toJson()],
  };
}

/// The plays that could not be sent, kept on the phone (key
/// `games_pending_plays`) until the network is back: a lesson finished is
/// never lost. They are sent again when the tab reads its path; the client
/// id makes a play count once, even sent twice.
@Riverpod(keepAlive: true)
class PendingGamePlays extends _$PendingGamePlays {
  static const _key = 'games_pending_plays';

  @override
  List<PendingPlay> build() {
    final raw = ref.watch(sharedPreferencesProvider).getString(_key);
    if (raw == null) {
      return const [];
    }
    try {
      return [
        for (final play in jsonDecode(raw) as List<dynamic>)
          PendingPlay.fromJson(play as Map<String, dynamic>),
      ];
    } on Object {
      // unreadable: nothing to send
      return const [];
    }
  }

  Future<void> keep(PendingPlay play) =>
      _save([...state.where((other) => other.clientId != play.clientId), play]);

  Future<void> forget(String clientId) async {
    if (state.any((play) => play.clientId == clientId)) {
      await _save([...state.where((play) => play.clientId != clientId)]);
    }
  }

  /// Sends the plays of account [accountId] that wait. Those the server took
  /// leave the list, and so do those it refuses for good (the lesson is gone);
  /// without network the rest waits for the next time.
  Future<void> flush(int accountId) async {
    final api = ref.read(gamesApiProvider);
    final mine = [...state.where((play) => play.accountId == accountId)];
    for (final play in mine) {
      try {
        if (play.lessonId == dailyLessonId) {
          await api.submitDaily(clientId: play.clientId, answers: play.answers);
        } else {
          await api.submitLesson(
            play.lessonId,
            clientId: play.clientId,
            answers: play.answers,
          );
        }
      } on ApiException {
        // refused for good: sending it again would change nothing
      } on Object {
        return;
      }
      await forget(play.clientId);
    }
  }

  Future<void> _save(List<PendingPlay> plays) async {
    state = plays;
    final preferences = ref.read(sharedPreferencesProvider);
    if (plays.isEmpty) {
      await preferences.remove(_key);
    } else {
      await preferences.setString(
        _key,
        jsonEncode([for (final play in plays) play.toJson()]),
      );
    }
  }
}
