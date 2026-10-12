import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/session/account.dart';
import '../domain/member.dart';

part 'members_api.g.dart';

/// Pseudos and members (/v1/usernames, /v1/users). Throws AppException.
class MembersApi {
  const MembersApi(this._dio);

  final Dio _dio;

  /// Whether [username] is free, and free pseudos made from the name. Works
  /// signed out (sign-up form). An empty [username] gives only suggestions.
  Future<UsernameCheck> availability({
    String username = '',
    String firstName = '',
    String lastName = '',
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/usernames/availability',
      queryParameters: {
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
      },
    );
    return UsernameCheck.fromJson(response.content);
  });

  /// The member with this pseudo; ApiException NOT_FOUND when nobody has it.
  Future<MemberCard> byUsername(String username) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/users/by-username/${Uri.encodeComponent(username)}',
    );
    return MemberCard.fromJson(response.content);
  });

  /// The signed-in account, with its pseudo and role.
  Future<Account> me() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/users/me');
    return Account.fromJson(response.content['user'] as Map<String, dynamic>);
  });

  /// 409 USERNAME_TAKEN, 400 USERNAME_INVALID / USERNAME_RESERVED.
  Future<Account> updateUsername(String username) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/users/me/username',
      data: {'username': username},
    );
    return Account.fromJson(response.content['user'] as Map<String, dynamic>);
  });

  /// Deletes the account and everything that is the user's, for good.
  /// 401 INVALID_CREDENTIALS for a wrong password, 409 LAST_SUPERADMIN.
  Future<void> deleteAccount({required String password}) => apiCall(() async {
    await _dio.delete<void>('/users/me', data: {'password': password});
  });
}

@Riverpod(keepAlive: true)
MembersApi membersApi(Ref ref) => MembersApi(ref.watch(dioProvider));
