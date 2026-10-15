import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../session/session.dart';
import '../storage/token_storage.dart';

/// Adds `Authorization: Bearer <token>` to the requests of our API, and signs
/// the user out when one comes back with 401 (expired or invalid token).
/// Another host (the public Bible API) never gets the token.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._ref, {required this.apiBaseUrl});

  final Ref _ref;

  /// Where our API lives: only its host gets the token.
  final String apiBaseUrl;

  bool _isOurs(RequestOptions options) =>
      options.uri.host == Uri.parse(apiBaseUrl).host;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _isOurs(options)
        ? await _ref.read(tokenStorageProvider).read()
        : null;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final hadToken = err.requestOptions.headers.containsKey('Authorization');
    final body = err.response?.data;
    final code = body is Map<String, dynamic> ? body['code'] : null;

    if (err.response?.statusCode == 401 &&
        hadToken &&
        code != 'INVALID_CREDENTIALS') {
      // the router guard sends the user back to the login screen
      await _ref.read(sessionProvider.notifier).signOut();
    }
    handler.next(err);
  }
}
