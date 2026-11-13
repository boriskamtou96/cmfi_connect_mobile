import 'package:cmfi_connect/src/features/games/domain/game.dart';
import 'package:cmfi_connect/src/features/games/infrastructure/games_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioAdapter server;
  late GamesApi api;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/v1'));
    server = DioAdapter(dio: dio);
    api = GamesApi(dio, language: () => 'fr');
  });

  test('the leaderboard of a period and a scope, and where I stand', () async {
    server.onGet(
      '/games/leaderboard',
      (s) => s.reply(200, {
        'status': 200,
        'content': {
          'period': 'all',
          'scope': 'circle',
          'entries': [
            {
              'rank': 1,
              'username': 'marie.ngo',
              'avatar': null,
              'points': 420,
              'me': false,
            },
            {
              'rank': 2,
              'username': 'boris.kamtou',
              'avatar': null,
              'points': 240,
              'me': true,
            },
          ],
          'me': {'rank': 2, 'points': 240},
        },
      }),
      queryParameters: {'period': 'all', 'scope': 'circle'},
    );

    final board = await api.leaderboard(period: 'all', scope: 'circle');

    expect(board.period, 'all');
    expect(board.scope, 'circle');
    expect(board.entries.map((entry) => entry.username), [
      'marie.ngo',
      'boris.kamtou',
    ]);
    expect(board.entries.last.me, isTrue);
    expect(board.entries.first.avatar, isNull);
    expect(board.me, const GameStanding(rank: 2, points: 240));
  });

  test('out of the leaderboard, me is null', () async {
    server.onGet(
      '/games/leaderboard',
      (s) => s.reply(200, {
        'status': 200,
        'content': {
          'period': 'week',
          'scope': 'all',
          'entries': <Object>[],
          'me': null,
        },
      }),
      queryParameters: {'period': 'week', 'scope': 'all'},
    );

    final board = await api.leaderboard(period: 'week', scope: 'all');

    expect(board.entries, isEmpty);
    expect(board.me, isNull);
  });

  test('the choices of the player: only what changes is sent', () async {
    server.onPut(
      '/games/me',
      (s) => s.reply(200, {
        'status': 200,
        'content': {
          'total_points': 0,
          'level': 1,
          'in_leaderboard': true,
          'daily_goal': 50,
        },
      }),
      data: {'in_leaderboard': true},
    );

    final player = await api.updateMe(inLeaderboard: true);

    expect(player.inLeaderboard, isTrue);
    expect(player.dailyGoal, 50);
  });

  test('the challenge of the day, then its answers', () async {
    server
      ..onGet(
        '/games/daily',
        (s) => s.reply(200, {
          'status': 200,
          'content': {
            'done': false,
            'questions': [
              {
                'id': 5,
                'kind': 'choice',
                'prompt': 'Quand ?',
                'choices': [
                  {'id': 'a', 'text': '1945'},
                ],
                'answer': 'a',
                'explanation': '',
                'source': '',
              },
            ],
          },
        }),
        queryParameters: {'lang': 'fr'},
      )
      ..onPost(
        '/games/daily/results',
        (s) => s.reply(200, {
          'status': 200,
          'content': {
            'points': 15,
            'first_try': 1,
            'total': 1,
            'level_up': false,
            'player': {'total_points': 120, 'daily_done': true},
          },
        }),
        data: {
          'client_id': 'daily-1',
          'answers': [
            {'question_id': 5, 'choice': 'a', 'attempt': 1},
          ],
        },
      );

    final daily = await api.daily();
    expect(daily.done, isFalse);
    expect(daily.questions.single.id, 5);

    final result = await api.submitDaily(
      clientId: 'daily-1',
      answers: const [GameAnswer(questionId: 5, choice: 'a', attempt: 1)],
    );
    expect(result.points, 15);
    expect(result.player.dailyDone, isTrue);
    expect(result.player.totalPoints, 120);
  });
}
