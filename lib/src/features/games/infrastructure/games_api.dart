import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/game.dart';

part 'games_api.g.dart';

/// The games (/v1/games): the path of a course, a lesson to play, a lesson
/// played. The server counts the points; the texts come in the language of
/// the app (French when a text has no translation).
class GamesApi {
  const GamesApi(this._dio, {String Function()? language})
    : _language = language;

  final Dio _dio;
  final String Function()? _language;

  String get _lang =>
      _language?.call() ?? LocaleSettings.currentLocale.languageCode;

  /// The courses and the path of [course] (the first one by default).
  /// NOT_FOUND while no course is published.
  Future<GamePath> path({String? course}) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/games/path',
      queryParameters: {'lang': _lang, 'course': ?course},
    );
    return GamePath.fromJson(response.content);
  });

  /// The questions of a lesson open to the member (LESSON_LOCKED otherwise).
  Future<GameLesson> lesson(int id) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/games/lessons/$id',
      queryParameters: {'lang': _lang},
    );
    return GameLesson.fromJson(response.content);
  });

  /// Every published lesson of [course] with its questions, to keep on the
  /// phone and play without network.
  Future<List<GameLesson>> download(String course) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/games/courses/$course/download',
      queryParameters: {'lang': _lang},
    );
    return [
      for (final lesson in response.content['lessons'] as List<dynamic>)
        GameLesson.fromJson(lesson as Map<String, dynamic>),
    ];
  });

  /// A lesson played. [clientId] names the play: sent again after a network
  /// failure, it counts once.
  Future<GameResult> submitLesson(
    int id, {
    required String clientId,
    required List<GameAnswer> answers,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/games/lessons/$id/results',
      data: {
        'client_id': clientId,
        'answers': [for (final answer in answers) answer.toJson()],
      },
    );
    return GameResult.fromJson(response.content);
  });

  /// The leaderboard over [period] (« week », « all ») and [scope] (« all »,
  /// « circle »).
  Future<GameLeaderboard> leaderboard({
    required String period,
    required String scope,
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/games/leaderboard',
      queryParameters: {'period': period, 'scope': scope},
    );
    return GameLeaderboard.fromJson(response.content);
  });

  /// The choices of the player; what is not given stays.
  Future<GamePlayer> updateMe({bool? inLeaderboard, int? dailyGoal}) =>
      apiCall(() async {
        final response = await _dio.put<Map<String, dynamic>>(
          '/games/me',
          data: {'in_leaderboard': ?inLeaderboard, 'daily_goal': ?dailyGoal},
        );
        return GamePlayer.fromJson(response.content);
      });

  /// The challenge of the day (NOT_FOUND before the first lesson done).
  Future<GameDaily> daily() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/games/daily',
      queryParameters: {'lang': _lang},
    );
    return GameDaily.fromJson(response.content);
  });

  /// The challenge of the day done; like a lesson, [clientId] names the play.
  Future<GameDailyResult> submitDaily({
    required String clientId,
    required List<GameAnswer> answers,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/games/daily/results',
      data: {
        'client_id': clientId,
        'answers': [for (final answer in answers) answer.toJson()],
      },
    );
    return GameDailyResult.fromJson(response.content);
  });
}

@Riverpod(keepAlive: true)
GamesApi gamesApi(Ref ref) => GamesApi(ref.watch(dioProvider));
