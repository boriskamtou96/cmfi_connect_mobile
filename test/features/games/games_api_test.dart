import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/features/games/domain/game.dart';
import 'package:cmfi_connect/src/features/games/infrastructure/games_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

const _player = {
  'total_points': 1240,
  'level': 4,
  'level_floor': 1200,
  'next_level_at': 2000,
  'streak_days': 6,
  'played_today': true,
  'daily_goal': 50,
  'points_today': 30,
  'in_leaderboard': null,
  'week_rank': null,
  'daily_done': false,
};

void main() {
  late DioAdapter server;
  late GamesApi api;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/v1'));
    server = DioAdapter(dio: dio);
    api = GamesApi(dio, language: () => 'en');
  });

  test('the path of a course, in the language of the app', () async {
    server.onGet(
      '/games/path',
      (s) => s.reply(200, {
        'status': 200,
        'content': {
          'courses': [
            {'code': 'ministry', 'title': 'Our ministry'},
          ],
          'course': 'ministry',
          'player': _player,
          'levels': [
            {
              'id': 1,
              'position': 1,
              'title': 'Our founder',
              'description': 'His life',
              'color': '#0B3B70',
              'lessons': [
                {
                  'id': 10,
                  'position': 1,
                  'title': 'First years',
                  'state': 'done',
                  'stars': 3,
                },
                {
                  'id': 11,
                  'position': 2,
                  'title': 'Given',
                  'state': 'open',
                  'stars': 0,
                },
                {
                  'id': 12,
                  'position': 3,
                  'title': 'Later',
                  'state': 'soon',
                  'stars': 0,
                },
              ],
            },
          ],
        },
      }),
      queryParameters: {'lang': 'en', 'course': 'ministry'},
    );

    final path = await api.path(course: 'ministry');

    expect(path.course, 'ministry');
    expect(
      path.courses.single,
      const GameCourse(code: 'ministry', title: 'Our ministry'),
    );
    expect(path.player.totalPoints, 1240);
    expect(path.player.streakDays, 6);
    expect(path.player.nextLevelAt, 2000);
    expect(path.player.inLeaderboard, isNull);
    final lessons = path.levels.single.lessons;
    expect(lessons.map((lesson) => lesson.state), [
      LessonState.done,
      LessonState.open,
      // a state this version does not know stays closed
      LessonState.locked,
    ]);
    expect(lessons.first.stars, 3);
    expect(path.levels.single.color, '#0B3B70');
  });

  test('no course published yet is NOT_FOUND', () async {
    server.onGet(
      '/games/path',
      (s) => s.reply(404, {
        'status': 404,
        'code': 'NOT_FOUND',
        'message': 'course not found',
      }),
      queryParameters: {'lang': 'en'},
    );

    await expectLater(
      api.path(),
      throwsA(isA<ApiException>().having((e) => e.code, 'code', 'NOT_FOUND')),
    );
  });

  test('a lesson and its questions', () async {
    server.onGet(
      '/games/lessons/11',
      (s) => s.reply(200, {
        'status': 200,
        'content': {
          'id': 11,
          'title': 'Given',
          'level_title': 'Our founder',
          'course': 'ministry',
          'questions': [
            {
              'id': 5,
              'kind': 'choice',
              'prompt': 'When?',
              'choices': [
                {'id': 'a', 'text': '1935'},
                {'id': 'b', 'text': '1945'},
              ],
              'answer': 'b',
              'explanation': 'Born in 1945.',
              'source': 'ministry:founder',
            },
          ],
        },
      }),
      queryParameters: {'lang': 'en'},
    );

    final lesson = await api.lesson(11);

    expect(lesson.levelTitle, 'Our founder');
    final question = lesson.questions.single;
    expect(question.choices.last, const GameChoice(id: 'b', text: '1945'));
    expect(question.answer, 'b');
    expect(question.explanation, 'Born in 1945.');
  });

  test('a lesson played is sent with its client id and its answers', () async {
    server.onPost(
      '/games/lessons/11/results',
      (s) => s.reply(200, {
        'status': 200,
        'content': {
          'points': 90,
          'first_try': 7,
          'total': 8,
          'stars': 2,
          'best_stars': 2,
          'perfect': false,
          'combo_bonus': 5,
          'replay': false,
          'level_up': true,
          'next_lesson_id': 12,
          'level_completed': false,
          'player': _player,
        },
      }),
      data: {
        'client_id': 'play-1',
        'answers': [
          {'question_id': 5, 'choice': 'a', 'attempt': 1},
          {'question_id': 5, 'choice': 'b', 'attempt': 2},
        ],
      },
    );

    final result = await api.submitLesson(
      11,
      clientId: 'play-1',
      answers: const [
        GameAnswer(questionId: 5, choice: 'a', attempt: 1),
        GameAnswer(questionId: 5, choice: 'b', attempt: 2),
      ],
    );

    expect(result.points, 90);
    expect(result.firstTry, 7);
    expect(result.comboBonus, 5);
    expect(result.levelUp, isTrue);
    expect(result.nextLessonId, 12);
    expect(result.player.level, 4);
  });
}
