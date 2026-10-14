import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/announcement.dart';

part 'notifications_api.g.dart';

/// The notifications of the admins (/v1/notifications) and the phones that
/// receive their push (/v1/devices).
class NotificationsApi {
  const NotificationsApi(this._dio);

  final Dio _dio;

  /// The latest first.
  Future<AnnouncementPage> list({int page = 1, int size = 20}) =>
      apiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>(
          '/notifications',
          queryParameters: {'page': page, 'size': size},
        );
        final content = response.content;
        final meta = response.data!['meta'] as Map<String, dynamic>?;
        return (
          items: [
            for (final item in content['items'] as List<dynamic>)
              Announcement.fromJson(item as Map<String, dynamic>),
          ],
          unread: content['unread'] as int? ?? 0,
          total: meta?['total'] as int? ?? 0,
        );
      });

  /// 404 NOT_FOUND for a notification sent to others.
  Future<Announcement> get(int id) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/notifications/$id');
    return Announcement.fromJson(response.content);
  });

  /// Opened: it comes back with its reading time.
  Future<Announcement> markRead(int id) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/notifications/$id/read',
    );
    return Announcement.fromJson(response.content);
  });

  /// This phone receives the pushes of the signed-in member.
  Future<void> registerDevice({
    required String token,
    required String platform,
    required String language,
  }) => apiCall(() async {
    await _dio.put<void>(
      '/devices',
      data: {'token': token, 'platform': platform, 'language': language},
    );
  });

  /// Signing out: this phone no longer receives them.
  Future<void> unregisterDevice(String token) => apiCall(() async {
    await _dio.delete<void>('/devices/${Uri.encodeComponent(token)}');
  });
}

@Riverpod(keepAlive: true)
NotificationsApi notificationsApi(Ref ref) =>
    NotificationsApi(ref.watch(dioProvider));
