import 'dart:typed_data';

import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/features/events/domain/event.dart';
import 'package:cmfi_connect/src/features/events/domain/event_draft.dart';
import 'package:cmfi_connect/src/features/events/infrastructure/events_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioAdapter server;
  late EventsApi api;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/v1'));
    server = DioAdapter(dio: dio);
    api = EventsApi(dio);
  });

  // GET /v1/events/:id as the Go API writes it
  final event = <String, Object?>{
    'id': 2,
    'series_id': 1,
    'title': 'Conférence annuelle 2026',
    'theme': "Marcher dans l'Esprit",
    'starts_at': '2026-11-20T07:00:00Z',
    'ends_at': '2026-11-22T12:00:00Z',
    'time_zone': 'Africa/Douala',
    'venue': 'Centre de conférences de Mvolyé',
    'city': 'Yaoundé',
    'country': 'Cameroun',
    'poster': {
      'id': 4,
      'url': '/v1/media/fe6af56d9fa7b3b687528ab9df79fc70.jpg',
      'width': 1080,
      'height': 1350,
      'color': '#1F4D3A',
    },
    'status': 'published',
    'registration': {
      'state': 'open',
      'registered': true,
      'registrations': 128,
      'people': 340,
    },
    'theme_verse': 'Galates 5.25',
    'description': '',
    'address': 'Mvolyé',
    'maps_url': '',
    'contact_name': '',
    'contact_phone': '',
    'registration_open': true,
    'registration_deadline': '2026-11-15T22:59:00Z',
    'capacity': 1500,
    'asks_lodging': true,
    'asks_departure_city': true,
    'fee_note': '',
    'sessions': [
      {
        'id': 1,
        'starts_at': '2026-11-20T09:00:00Z',
        'ends_at': null,
        'title': "Culte d'ouverture",
        'speaker': 'Pasteur principal',
        'place': 'Grande salle',
        'description': '',
        'hymns': [
          {'book': 'rendons-ministere-1', 'number': 12},
        ],
      },
    ],
    'posts': [
      {
        'id': 3,
        'body': 'Les inscriptions sont ouvertes !',
        'image': null,
        'pinned': true,
        'created_at': '2026-10-09T21:00:00Z',
      },
    ],
    'photos': <Object>[],
    'my_registration': {
      'people': 2,
      'needs_lodging': true,
      'departure_city': 'Douala',
      'updated_at': '2026-10-09T21:10:00Z',
    },
    'editions': [
      {
        'id': 1,
        'title': 'Conférence annuelle 2025',
        'starts_at': '2025-11-21T07:00:00Z',
        'ends_at': '2025-11-23T12:00:00Z',
        'time_zone': 'Africa/Douala',
        'poster': null,
      },
    ],
  };

  test('reads a whole event', () async {
    server.onGet(
      '/events/2',
      (s) => s.reply(200, {'status': 200, 'content': event}),
    );

    final read = await api.get(2);

    expect(read.title, 'Conférence annuelle 2026');
    expect(read.startsAt, DateTime.utc(2026, 11, 20, 7));
    expect(read.poster?.aspectRatio, 0.8);
    expect(read.poster?.argb, 0xFF1F4D3A);
    expect(read.registration.state, RegistrationState.open);
    expect(read.placesLeft, 1160);
    expect(read.sessions.single.endsAt, isNull);
    expect(read.sessions.single.hymns.single.number, 12);
    expect(read.posts.single.pinned, isTrue);
    expect(read.myRegistration?.departureCity, 'Douala');
    expect(read.editions.single.poster, isNull);
  });

  test('lists the upcoming events', () async {
    server.onGet(
      '/events/',
      (s) => s.reply(200, {
        'status': 200,
        'content': [
          {
            for (final key in [
              'id',
              'series_id',
              'title',
              'theme',
              'starts_at',
              'ends_at',
              'time_zone',
              'venue',
              'city',
              'country',
              'poster',
              'status',
              'registration',
            ])
              key: event[key],
          },
        ],
      }),
      queryParameters: {'when': 'upcoming', 'page': 1, 'size': 20},
    );

    final events = await api.list();

    expect(events.single.city, 'Yaoundé');
    expect(events.single.sessions, isEmpty);
  });

  test('registering sends the answers', () async {
    server.onPut(
      '/events/2/registration',
      (s) => s.reply(200, {'status': 200, 'content': event}),
      data: {'people': 2, 'needs_lodging': true, 'departure_city': 'Douala'},
    );

    final read = await api.register(
      2,
      people: 2,
      needsLodging: true,
      departureCity: 'Douala',
    );

    expect(read.registration.registered, isTrue);
  });

  test('a full event answers EVENT_FULL', () async {
    server.onPut(
      '/events/2/registration',
      (s) => s.reply(409, {
        'status': 409,
        'code': 'EVENT_FULL',
        'message': 'no place left',
      }),
      data: {'people': 1, 'needs_lodging': false, 'departure_city': ''},
    );

    await expectLater(
      api.register(2, people: 1),
      throwsA(isA<ApiException>().having((e) => e.code, 'code', 'EVENT_FULL')),
    );
  });

  test('an event sent by an admin has its instants in UTC', () async {
    final draft = EventDraft(
      title: 'Retraite',
      startsAt: DateTime.utc(2026, 12, 1, 7),
      endsAt: DateTime.utc(2026, 12, 1, 16),
      posterId: 4,
    );
    server.onPost(
      '/admin/events',
      (s) => s.reply(201, {'status': 201, 'content': event}),
      data: {
        'title': 'Retraite',
        'theme': '',
        'theme_verse': '',
        'description': '',
        'starts_at': '2026-12-01T07:00:00.000Z',
        'ends_at': '2026-12-01T16:00:00.000Z',
        'time_zone': 'Africa/Douala',
        'venue': '',
        'address': '',
        'city': '',
        'country': '',
        'maps_url': '',
        'contact_name': '',
        'contact_phone': '',
        'poster_id': 4,
        'registration_open': true,
        'asks_lodging': false,
        'asks_departure_city': false,
        'fee_note': '',
        'status': 'draft',
      },
    );

    final created = await api.create(draft);

    expect(created.id, 2);
  });

  test('an image is sent as a form', () async {
    server.onPost(
      '/admin/media',
      (s) => s.reply(201, {
        'status': 201,
        'content': {
          'id': 9,
          'url': '/v1/media/abc.jpg',
          'width': 800,
          'height': 600,
          'color': '#808080',
        },
      }),
      data: Matchers.any,
    );

    final image = await api.upload(
      Uint8List.fromList([1, 2, 3]),
      filename: 'affiche.jpg',
    );

    expect(image.id, 9);
    expect(image.aspectRatio, closeTo(1.33, 0.01));
  });
}
