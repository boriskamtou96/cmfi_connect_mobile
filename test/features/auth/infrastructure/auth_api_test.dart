import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/features/auth/infrastructure/auth_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late Dio dio;
  late DioAdapter server;
  late AuthApi api;

  const body = {'phone_number': '+237690000001', 'password': 'Secret123'};

  setUp(() {
    dio = Dio(BaseOptions(baseUrl: 'http://api.test/v1'));
    server = DioAdapter(dio: dio);
    api = AuthApi(dio);
  });

  test('parses the login response of the Go API', () async {
    // exact shape returned by POST /v1/users/login
    server.onPost(
      '/users/login',
      (s) => s.reply(200, {
        'status': 200,
        'content': {
          'user': {
            'first_name': 'Boris',
            'last_name': 'Kamtou',
            'phone_number': '+237690000001',
            'email': '',
            'created_at': '2026-10-08T15:33:39.738447+01:00',
          },
          'accessToken': 'v2.local.abc',
        },
      }),
      data: body,
    );

    final response = await api.login(
      phoneNumber: '+237690000001',
      password: 'Secret123',
    );

    expect(response.accessToken, 'v2.local.abc');
    expect(response.account.firstName, 'Boris');
    expect(response.account.phoneNumber, '+237690000001');
  });

  test('wrong password -> ApiException INVALID_CREDENTIALS', () async {
    server.onPost(
      '/users/login',
      (s) => s.reply(401, {
        'status': 401,
        'code': 'INVALID_CREDENTIALS',
        'message': 'invalid credentials',
      }),
      data: body,
    );

    await expectLater(
      api.login(phoneNumber: '+237690000001', password: 'Secret123'),
      throwsA(
        isA<ApiException>().having(
          (e) => e.code,
          'code',
          'INVALID_CREDENTIALS',
        ),
      ),
    );
  });

  test('no connection -> NetworkException', () async {
    server.onPost(
      '/users/login',
      (s) => s.throws(
        0,
        DioException.connectionError(
          requestOptions: RequestOptions(path: '/users/login'),
          reason: 'offline',
        ),
      ),
      data: body,
    );

    await expectLater(
      api.login(phoneNumber: '+237690000001', password: 'Secret123'),
      throwsA(isA<NetworkException>()),
    );
  });
}
