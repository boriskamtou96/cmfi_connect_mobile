import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/features/reports/infrastructure/activities_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioAdapter server;
  late ActivitiesApi api;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/v1'));
    server = DioAdapter(dio: dio);
    api = ActivitiesApi(dio);
  });

  test('parses standard and personal items', () async {
    server.onGet(
      '/activities/',
      (s) => s.reply(200, {
        'status': 200,
        'content': [
          {
            'id': 2,
            'code': 'PS',
            'label': 'Prière seule',
            'tracks_quantity': false,
            'quantity_unit': null,
            'tracks_duration': true,
            'position': 2,
            'is_standard': true,
            'created_at': '2026-10-08T10:00:00Z',
          },
          {
            'id': 30,
            'code': 'RQDQA',
            'label': 'RQDQA',
            'tracks_quantity': true,
            'quantity_unit': 'fois',
            'tracks_duration': true,
            'position': 100,
            'is_standard': false,
            'created_at': '2026-10-08T10:00:00Z',
          },
        ],
      }),
    );

    final items = await api.list();

    expect(items.map((item) => item.code), ['PS', 'RQDQA']);
    expect(items.first.isStandard, isTrue);
    expect(items.first.quantityUnit, isNull);
    expect(items.last.isStandard, isFalse);
  });

  test('a code already used answers CONFLICT', () async {
    server.onPost(
      '/activities/',
      (s) => s.reply(409, {
        'status': 409,
        'code': 'CONFLICT',
        'message': 'code LB is reserved for a standard item',
      }),
      data: {
        'code': 'LB',
        'label': 'Lecture',
        'tracks_quantity': false,
        'quantity_unit': '',
        'tracks_duration': true,
      },
    );

    await expectLater(
      api.create(
        code: 'LB',
        label: 'Lecture',
        tracksQuantity: false,
        quantityUnit: 'ignored',
        tracksDuration: true,
      ),
      throwsA(isA<ApiException>().having((e) => e.code, 'code', 'CONFLICT')),
    );
  });
}
