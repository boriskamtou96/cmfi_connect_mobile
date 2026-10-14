import 'package:cmfi_connect/src/features/notifications/infrastructure/notifications_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioAdapter server;
  late NotificationsApi api;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/v1'));
    server = DioAdapter(dio: dio);
    api = NotificationsApi(dio);
  });

  // exact answer of GET /v1/notifications (local API, 13 Oct 2026)
  final notificationJson = {
    'id': 7,
    'title': 'Veillée de prière',
    'body': 'Vendredi à 21 h.',
    'attachments': [
      {
        'id': 15,
        'kind': 'image',
        'url': '/v1/media/c8a5ddaf5afecaa6efda61f6dd2ba02a.png',
        'name': '',
        'width': 40,
        'height': 50,
        'color': '#1E6A55',
        'size_bytes': 109,
      },
    ],
    'created_at': '2026-10-13T21:09:53.571216+01:00',
    'read_at': null,
  };

  test('the list comes with the unread count and the total', () async {
    server.onGet(
      '/notifications',
      queryParameters: {'page': 1, 'size': 20},
      (request) => request.reply(200, {
        'status': 200,
        'content': {
          'items': [notificationJson],
          'unread': 1,
        },
        'meta': {'total': 1, 'limit': 20, 'offset': 0},
      }),
    );

    final page = await api.list();

    expect(page.unread, 1);
    expect(page.total, 1);
    final item = page.items.single;
    expect(item.title, 'Veillée de prière');
    expect(item.isRead, isFalse);
    expect(item.createdAt, DateTime.utc(2026, 10, 13, 20, 9, 53, 571, 216));
    final image = item.images.single;
    expect(image.aspectRatio, 40 / 50);
    expect(image.argb, 0xFF1E6A55);
    expect(item.documents, isEmpty);
  });

  test('opening one marks it read', () async {
    server.onPut(
      '/notifications/7/read',
      (request) => request.reply(200, {
        'status': 200,
        'content': {...notificationJson, 'read_at': '2026-10-13T21:12:00Z'},
      }),
    );

    expect((await api.markRead(7)).isRead, isTrue);
  });

  test('the phone is given with its platform and language', () async {
    server.onPut(
      '/devices',
      data: {'token': 'abc', 'platform': 'ios', 'language': 'fr'},
      (request) => request.reply(204, null),
    );

    await api.registerDevice(token: 'abc', platform: 'ios', language: 'fr');
  });
}
