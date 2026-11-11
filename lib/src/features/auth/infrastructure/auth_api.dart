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

  /// Google or Apple ([firebaseToken], Firebase): the account it signs in
  /// to. 404 NO_ACCOUNT the first time: the member completes a profile
  /// ([socialRegister]). 401 INVALID_SOCIAL_TOKEN, 503
  /// SOCIAL_SIGN_IN_UNAVAILABLE.
  Future<LoginResponse> socialSignIn(String firebaseToken) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/users/social',
      data: {'firebase_token': firebaseToken},
    );
    return LoginResponse.fromJson(response.content);
  });

  /// The account of a Google or Apple account, signed in. 409 PHONE_TAKEN
  /// when the number has an account: [socialLink] with its password.
  Future<LoginResponse> socialRegister({
    required String firebaseToken,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/users/social/register',
      data: {
        'firebase_token': firebaseToken,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
      },
    );
    return LoginResponse.fromJson(response.content);
  });

  /// An account that has a password signs in with Google or Apple from now
  /// on. 401 INVALID_CREDENTIALS, 409 IDENTITY_TAKEN.
  Future<LoginResponse> socialLink({
    required String firebaseToken,
    required String phoneNumber,
    required String password,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/users/social/link',
      data: {
        'firebase_token': firebaseToken,
        'phone_number': phoneNumber,
        'password': password,
      },
    );
    return LoginResponse.fromJson(response.content);
  });

  /// Forgot password: [firebaseToken] proves the phone (the SMS code), then
  /// log in with [password]. 404 NOT_FOUND without account for the number,
  /// 401 INVALID_PHONE_VERIFICATION when the proof expired, 503
  /// PASSWORD_RESET_UNAVAILABLE when the server can't check it.
  Future<void> resetPassword({
    required String firebaseToken,
    required String password,
  }) => apiCall(() async {
    await _dio.post<void>(
      '/users/password/reset',
      data: {'firebase_token': firebaseToken, 'password': password},
    );
  });
}

@riverpod
AuthApi authApi(Ref ref) => AuthApi(ref.watch(dioProvider));
