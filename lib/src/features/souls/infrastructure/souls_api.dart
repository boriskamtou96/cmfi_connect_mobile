import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/soul.dart';

part 'souls_api.g.dart';

/// Suivi des âmes on the server (/v1/souls): each member's own, so that the
/// list follows the account from one phone to another.
class SoulsApi {
  const SoulsApi(this._dio);

  final Dio _dio;

  Future<List<Soul>> list() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/souls');
    return [
      for (final json in response.contentList)
        Soul.fromJson(json as Map<String, dynamic>),
    ];
  });

  /// Added or changed.
  Future<void> save(Soul soul) => apiCall(() async {
    await _dio.put<Map<String, dynamic>>(
      '/souls/${Uri.encodeComponent(soul.id)}',
      data: soul.toJson(),
    );
  });

  /// Gone (also fine when it was not there).
  Future<void> remove(String id) => apiCall(() async {
    await _dio.delete<void>('/souls/${Uri.encodeComponent(id)}');
  });
}

@Riverpod(keepAlive: true)
SoulsApi soulsApi(Ref ref) => SoulsApi(ref.watch(dioProvider));
