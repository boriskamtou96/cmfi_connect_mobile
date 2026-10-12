import 'package:cmfi_connect/src/features/authorities/infrastructure/authorities_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioAdapter server;
  late AuthoritiesApi api;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/v1'));
    server = DioAdapter(dio: dio);
    api = AuthoritiesApi(dio);
  });

  Map<String, Object?> authority(
    int id,
    String firstName, {
    bool maker = false,
  }) => {
    'id': id,
    'user_id': 26,
    'first_name': firstName,
    'last_name': 'Tientcheu',
    'phone_number': '+237697881122',
    'email': null,
    'is_disciple_maker': maker,
    'created_at': '2026-10-08T10:00:00Z',
  };

  test('reads every page until the total is reached, even short pages', () async {
    // the API pages over everyone's authorities, then keeps the user's: page 1 can be short
    server
      ..onGet(
        '/authorities/',
        (s) => s.reply(200, {
          'status': 200,
          'content': [authority(3, 'Marc', maker: true)],
          'meta': {'total': 2, 'limit': 10, 'offset': 0},
        }),
        queryParameters: {'page': 1, 'size': 10},
      )
      ..onGet(
        '/authorities/',
        (s) => s.reply(200, {
          'status': 200,
          'content': [authority(1, 'Paul')],
          'meta': {'total': 2, 'limit': 10, 'offset': 10},
        }),
        queryParameters: {'page': 2, 'size': 10},
      );

    final authorities = await api.list();

    expect(authorities.map((a) => a.firstName), ['Marc', 'Paul']);
    expect(authorities.first.isDiscipleMaker, isTrue);
    expect(authorities.first.email, isNull);
  });

  test('an empty list stops after the first page', () async {
    server.onGet(
      '/authorities/',
      (s) => s.reply(200, {
        'status': 200,
        'content': <Object>[],
        'meta': {'total': 0, 'limit': 10, 'offset': 0},
      }),
      queryParameters: {'page': 1, 'size': 10},
    );

    expect(await api.list(), isEmpty);
  });

  test('create sends the form as the API expects it', () async {
    server.onPost(
      '/authorities/',
      (s) => s.reply(201, {
        'status': 201,
        'content': authority(5, 'Marc', maker: true),
      }),
      data: {
        'first_name': 'Marc',
        'last_name': 'Tientcheu',
        'phone_number': '+237697881122',
        'email': '',
        'is_disciple_maker': true,
      },
    );

    final created = await api.create(
      firstName: 'Marc',
      lastName: 'Tientcheu',
      phoneNumber: '+237697881122',
      email: '',
      isDiscipleMaker: true,
    );

    expect(created.id, 5);
    expect(created.fullName, 'Marc Tientcheu');
  });
}
