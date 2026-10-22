import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/authority.dart';

part 'authorities_api.g.dart';

/// The user's spiritual authorities (/v1/authorities). No update endpoint:
/// to change someone, remove and add again.
class AuthoritiesApi {
  const AuthoritiesApi(this._dio);

  final Dio _dio;

  /// The API pages by 5 to 10 ({content, meta: {total}}); this reads every page.
  Future<List<Authority>> list() => apiCall(() async {
    const size = 10;
    const maxPages = 20;
    final authorities = <Authority>[];
    for (var page = 1; page <= maxPages; page++) {
      final response = await _dio.get<Map<String, dynamic>>(
        '/authorities/',
        queryParameters: {'page': page, 'size': size},
      );
      authorities.addAll([
        for (final json in response.contentList)
          Authority.fromJson(json as Map<String, dynamic>),
      ]);
      final meta = response.data!['meta'] as Map<String, dynamic>?;
      final total = (meta?['total'] as num?)?.toInt() ?? 0;
      if (authorities.length >= total) {
        break;
      }
    }
    return authorities;
  });

  Future<Authority> create({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required bool isDiscipleMaker,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/authorities/',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'email': email,
        'is_disciple_maker': isDiscipleMaker,
      },
    );
    return Authority.fromJson(response.content);
  });

  /// Asks the member with this pseudo to accompany the user: the authority is
  /// pending until they accept. 404 when nobody has this pseudo, 409
  /// AUTHORITY_EXISTS / DISCIPLE_MAKER_EXISTS.
  Future<Authority> createForMember({
    required String username,
    required bool isDiscipleMaker,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/authorities/',
      data: {'username': username, 'is_disciple_maker': isDiscipleMaker},
    );
    return Authority.fromJson(response.content);
  });

  /// The members who ask the user to accompany them, waiting for an answer.
  Future<List<AuthorityRequest>> requests() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/authorities/requests',
    );
    return [
      for (final json in response.contentList)
        AuthorityRequest.fromJson(json as Map<String, dynamic>),
    ];
  });

  /// 404 when the request was already answered or withdrawn.
  Future<void> answer(int requestId, {required bool accept}) =>
      apiCall(() async {
        await _dio.post<Map<String, dynamic>>(
          '/authorities/requests/$requestId/${accept ? 'accept' : 'decline'}',
        );
      });

  /// 204 on success, 404 if it no longer exists.
  Future<void> remove(int id) => apiCall(() async {
    await _dio.delete<void>('/authorities/$id');
  });

  /// The authority [id] becomes the user's disciple maker; the former one
  /// stays among their authorities.
  Future<Authority> chooseDiscipleMaker(int id) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/authorities/$id/disciple-maker',
    );
    return Authority.fromJson(response.content);
  });

  /// Whether the disciple maker [id] sees the user's regularity.
  Future<Authority> setSharing(int id, {required bool shares}) =>
      apiCall(() async {
        final response = await _dio.put<Map<String, dynamic>>(
          '/authorities/$id/sharing',
          data: {'shares': shares},
        );
        return Authority.fromJson(response.content);
      });
}

@riverpod
AuthoritiesApi authoritiesApi(Ref ref) =>
    AuthoritiesApi(ref.watch(dioProvider));
