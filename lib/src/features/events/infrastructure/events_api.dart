import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/event.dart';
import '../domain/event_draft.dart';

part 'events_api.g.dart';

/// upcoming: not over yet, soonest first; past: latest first.
enum EventPeriod { upcoming, past }

/// The community events (/v1/events) and their management by the admins
/// (/v1/admin/events, /v1/admin/media).
class EventsApi {
  const EventsApi(this._dio);

  final Dio _dio;

  Future<List<CommunityEvent>> list({
    EventPeriod period = EventPeriod.upcoming,
    int page = 1,
    int size = 20,
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/events/',
      queryParameters: {'when': period.name, 'page': page, 'size': size},
    );
    return _events(response);
  });

  /// The whole event. 404 for a draft, unless the user is an admin.
  Future<CommunityEvent> get(int id) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/events/$id');
    return CommunityEvent.fromJson(response.content);
  });

  /// Registers the user, or changes their answers: the event comes back with
  /// its new counts. 409 EVENT_FULL / REGISTRATION_CLOSED.
  Future<CommunityEvent> register(
    int id, {
    required int people,
    bool needsLodging = false,
    String departureCity = '',
  }) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/events/$id/registration',
      data: {
        'people': people,
        'needs_lodging': needsLodging,
        'departure_city': departureCity,
      },
    );
    return CommunityEvent.fromJson(response.content);
  });

  Future<CommunityEvent> unregister(int id) => apiCall(() async {
    final response = await _dio.delete<Map<String, dynamic>>(
      '/events/$id/registration',
    );
    return CommunityEvent.fromJson(response.content);
  });

  // ----- admins -----

  /// Every event, drafts included, latest first.
  Future<List<CommunityEvent>> adminList({int page = 1, int size = 50}) =>
      apiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>(
          '/admin/events',
          queryParameters: {'page': page, 'size': size},
        );
        return _events(response);
      });

  /// Sends a JPEG or PNG (8 MB at most): the image comes back with its id, to
  /// set as a poster or add to the gallery. 413 MEDIA_TOO_LARGE,
  /// 415 MEDIA_UNSUPPORTED.
  Future<EventImage> upload(Uint8List bytes, {required String filename}) =>
      apiCall(() async {
        final response = await _dio.post<Map<String, dynamic>>(
          '/admin/media',
          data: FormData.fromMap({
            'file': MultipartFile.fromBytes(bytes, filename: filename),
          }),
          options: Options(
            contentType: Headers.multipartFormDataContentType,
            sendTimeout: const Duration(minutes: 2),
          ),
        );
        return EventImage.fromJson(response.content);
      });

  Future<CommunityEvent> create(EventDraft draft) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/admin/events',
      data: draft.toJson(),
    );
    return CommunityEvent.fromJson(response.content);
  });

  Future<CommunityEvent> update(int id, EventDraft draft) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/admin/events/$id',
      data: draft.toJson(),
    );
    return CommunityEvent.fromJson(response.content);
  });

  Future<void> delete(int id) => apiCall(() async {
    await _dio.delete<void>('/admin/events/$id');
  });

  /// Replaces the whole program.
  Future<CommunityEvent> saveProgram(int id, List<SessionDraft> sessions) =>
      apiCall(() async {
        final response = await _dio.put<Map<String, dynamic>>(
          '/admin/events/$id/sessions',
          data: {
            'sessions': [for (final session in sessions) session.toJson()],
          },
        );
        return CommunityEvent.fromJson(response.content);
      });

  /// The next edition, as a draft one year later, with the same program.
  Future<CommunityEvent> prepareNextEdition(int id) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/admin/events/$id/duplicate',
    );
    return CommunityEvent.fromJson(response.content);
  });

  Future<EventRegistrations> registrations(int id) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/admin/events/$id/registrations',
    );
    return EventRegistrations.fromJson(response.content);
  });

  Future<CommunityEvent> addPost(
    int id, {
    required String body,
    int? imageId,
    bool pinned = false,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/admin/events/$id/posts',
      data: {'body': body, 'image_id': ?imageId, 'pinned': pinned},
    );
    return CommunityEvent.fromJson(response.content);
  });

  Future<void> deletePost(int id, int postId) => apiCall(() async {
    await _dio.delete<void>('/admin/events/$id/posts/$postId');
  });

  /// Adds uploaded images to the gallery.
  Future<CommunityEvent> addPhotos(int id, List<int> imageIds) =>
      apiCall(() async {
        final response = await _dio.post<Map<String, dynamic>>(
          '/admin/events/$id/photos',
          data: {'media_ids': imageIds},
        );
        return CommunityEvent.fromJson(response.content);
      });

  Future<void> deletePhoto(int id, int photoId) => apiCall(() async {
    await _dio.delete<void>('/admin/events/$id/photos/$photoId');
  });

  static List<CommunityEvent> _events(
    Response<Map<String, dynamic>> response,
  ) => [
    for (final json in response.contentList)
      CommunityEvent.fromJson(json as Map<String, dynamic>),
  ];
}

@riverpod
EventsApi eventsApi(Ref ref) => EventsApi(ref.watch(dioProvider));
