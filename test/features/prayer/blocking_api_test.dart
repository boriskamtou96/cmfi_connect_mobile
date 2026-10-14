import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/prayer/infrastructure/prayer_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioAdapter server;
  late PrayerApi api;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/v1'));
    server = DioAdapter(dio: dio);
    api = PrayerApi(dio);
  });

  test('blocking and unblocking a member answer 204', () async {
    server
      ..onPost('/members/paul.m/block', (s) => s.reply(204, null))
      ..onDelete('/members/paul.m/block', (s) => s.reply(204, null));

    await api.block('paul.m');
    await api.unblock('paul.m');
  });

  test('blocking oneself is refused', () async {
    server.onPost(
      '/members/boris.kamtou/block',
      (s) => s.reply(400, {
        'status': 400,
        'code': 'BAD_REQUEST',
        'message': 'you cannot block yourself',
      }),
    );

    await expectLater(
      api.block('boris.kamtou'),
      throwsA(isA<ApiException>().having((e) => e.code, 'code', 'BAD_REQUEST')),
    );
  });

  test('the blocked members come with their church', () async {
    server.onGet(
      '/members/blocked',
      (s) => s.reply(200, {
        'status': 200,
        'content': [
          {
            'username': 'paul.m',
            'first_name': 'Paul',
            'last_name': 'Mbarga',
            'church': 'PSU-Yaoundé',
            'assembly': 'Mvog-Ada',
          },
        ],
      }),
    );

    final member = (await api.blocked()).single;

    expect(member.username, 'paul.m');
    expect(member.fullName, 'Paul Mbarga');
    expect(member.place, 'PSU-Yaoundé · Mvog-Ada');
  });

  test('a report sends the reason, the invitation and the comment', () async {
    server.onPost(
      '/reports',
      data: {
        'username': 'paul.m',
        'importunity_id': 7,
        'reason': 'offensive',
        'comment': 'Des insultes',
      },
      (s) => s.reply(201, {
        'status': 201,
        'content': {'id': 12},
      }),
    );

    final id = await api.report(
      username: 'paul.m',
      importunityId: 7,
      reason: ReportReason.offensive,
      comment: ' Des insultes ',
    );

    expect(id, 12);
  });

  test('a report without comment leaves it out', () async {
    server.onPost(
      '/reports',
      data: {'username': 'paul.m', 'reason': 'spam'},
      (s) => s.reply(201, {
        'status': 201,
        'content': {'id': 13},
      }),
    );

    expect(await api.report(username: 'paul.m', reason: ReportReason.spam), 13);
  });

  test('reporting an unknown pseudo is NOT_FOUND', () async {
    server.onPost(
      '/reports',
      data: {'username': 'nobody', 'reason': 'other'},
      (s) => s.reply(404, {
        'status': 404,
        'code': 'NOT_FOUND',
        'message': 'member not found',
      }),
    );

    await expectLater(
      api.report(username: 'nobody', reason: ReportReason.other),
      throwsA(isA<ApiException>().having((e) => e.code, 'code', 'NOT_FOUND')),
    );
  });
}
