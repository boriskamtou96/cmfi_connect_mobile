import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/infrastructure/reports_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioAdapter server;
  late ReportsApi api;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/v1'));
    server = DioAdapter(dio: dio);
    api = ReportsApi(dio);
  });

  // exact shape of GET / PUT /v1/reports/:date
  final dayJson = {
    'date': '2026-10-08',
    'note': 'Psaume 23',
    'submitted': true,
    'entries': [
      {
        'activity_type_id': 1,
        'code': 'LB',
        'label': 'Lecture biblique',
        'tracks_quantity': true,
        'quantity_unit': 'chapitres',
        'tracks_duration': false,
        'quantity': 10,
        'duration_minutes': null,
      },
      {
        'activity_type_id': 2,
        'code': 'PS',
        'label': 'Prière seule',
        'tracks_quantity': false,
        'quantity_unit': null,
        'tracks_duration': true,
        'quantity': null,
        'duration_minutes': null,
      },
    ],
  };

  test('parses the day form', () async {
    server.onGet(
      '/reports/2026-10-08',
      (s) => s.reply(200, {'status': 200, 'content': dayJson}),
    );

    final day = await api.getDay(DateTime(2026, 10, 8));

    expect(day.date, DateTime(2026, 10, 8));
    expect(day.note, 'Psaume 23');
    expect(day.submitted, isTrue);
    expect(day.entries.first.quantity, 10);
    expect(day.entries.first.isFilled, isTrue);
    expect(day.entries.last.isFilled, isFalse);
  });

  test('saving sends only the filled items, without null values', () async {
    server.onPut(
      '/reports/2026-10-08',
      (s) => s.reply(200, {'status': 200, 'content': dayJson}),
      data: {
        'note': 'Psaume 23',
        'entries': [
          {'activity_type_id': 1, 'quantity': 10},
          {'activity_type_id': 3, 'quantity': 1, 'duration_minutes': 30},
        ],
      },
    );

    final saved = await api.saveDay(
      DateTime(2026, 10, 8),
      note: '  Psaume 23 ',
      entries: const [
        ReportEntry(
          activityTypeId: 1,
          code: 'LB',
          label: 'Lecture biblique',
          quantity: 10,
        ),
        ReportEntry(activityTypeId: 2, code: 'PS', label: 'Prière seule'),
        ReportEntry(
          activityTypeId: 3,
          code: 'RDQAD',
          label: 'Méditation',
          quantity: 1,
          durationMinutes: 30,
        ),
      ],
    );

    expect(saved.submitted, isTrue);
  });

  test('a future date answers BAD_REQUEST', () async {
    server.onPut(
      '/reports/2026-10-09',
      (s) => s.reply(400, {
        'status': 400,
        'code': 'BAD_REQUEST',
        'message': 'cannot save a report for a future date',
      }),
      data: {'note': '', 'entries': <Object>[]},
    );

    await expectLater(
      api.saveDay(DateTime(2026, 10, 9), note: '', entries: const []),
      throwsA(isA<ApiException>().having((e) => e.code, 'code', 'BAD_REQUEST')),
    );
  });

  test('parses the history, newest first', () async {
    server.onGet(
      '/reports/',
      (s) => s.reply(200, {
        'status': 200,
        'content': [
          {
            'date': '2026-10-08',
            'note': null,
            'entries': [
              {
                'activity_type_id': 2,
                'code': 'PS',
                'label': 'Prière seule',
                'quantity_unit': null,
                'quantity': null,
                'duration_minutes': 45,
              },
            ],
          },
          {'date': '2026-10-06', 'note': 'Jeûne', 'entries': <Object>[]},
        ],
      }),
      queryParameters: {'from': '2026-10-01', 'to': '2026-10-08'},
    );

    final days = await api.history(
      from: DateTime(2026, 10),
      to: DateTime(2026, 10, 8),
    );

    expect(days.map((day) => day.date), [
      DateTime(2026, 10, 8),
      DateTime(2026, 10, 6),
    ]);
    expect(days.first.entries.single.durationMinutes, 45);
    expect(days.last.note, 'Jeûne');
  });

  test('parses the summary', () async {
    server.onGet(
      '/reports/summary',
      (s) => s.reply(200, {
        'status': 200,
        'content': {
          'from': '2026-10-01',
          'to': '2026-10-08',
          'days_in_range': 8,
          'days_reported': 6,
          'items': [
            {
              'activity_type_id': 1,
              'code': 'LB',
              'label': 'Lecture biblique',
              'quantity_unit': 'chapitres',
              'tracks_quantity': true,
              'tracks_duration': false,
              'days_count': 5,
              'total_quantity': 42,
              'total_minutes': 0,
            },
          ],
        },
      }),
      queryParameters: {'from': '2026-10-01', 'to': '2026-10-08'},
    );

    final summary = await api.summary(
      from: DateTime(2026, 10),
      to: DateTime(2026, 10, 8),
    );

    expect(summary.daysInRange, 8);
    expect(summary.daysReported, 6);
    expect(summary.items.single.totalQuantity, 42);
    expect(summary.items.single.daysCount, 5);
  });
}
