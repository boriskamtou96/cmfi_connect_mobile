import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import 'login_response.dart';

part 'auth_api.g.dart';

/// HTTP calls of the auth feature. Throws AppException, never DioException.
class AuthApi {
  const AuthApi(this._dio);

  final Dio _dio;

  Future<LoginResponse> login({
    required String phoneNumber,
    required String password,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/users/login',
      data: {'phone_number': phoneNumber, 'password': password},
    );
    return LoginResponse.fromJson(response.content);
  });

  /// Creates the account (201, no token: log in right after).
  /// A phone number or email that already has an account answers 403 FORBIDDEN,
  /// a pseudo already used 409 USERNAME_TAKEN.
  Future<void> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String username,
    String? email,
  }) => apiCall(() async {
    await _dio.post<Map<String, dynamic>>(
      '/users/register',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        // the API names the plain password "hash_password"
        'hash_password': password,
        'username': username,
        if (email != null && email.isNotEmpty) 'email': email,
      },
    );
  });
}

@riverpod
AuthApi authApi(Ref ref) => AuthApi(ref.watch(dioProvider));
