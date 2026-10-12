import 'package:dio/dio.dart';

/// Every error the API layer can throw. The UI turns it into a translated message
/// (see app_exception_message.dart), never shows raw server text.
sealed class AppException implements Exception {
  const AppException();

  factory AppException.fromDio(DioException e) {
    final status = e.response?.statusCode;
    final body = e.response?.data;
    final code = body is Map<String, dynamic> ? body['code'] as String? : null;

    return switch (e.type) {
      DioExceptionType.connectionError ||
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout => const NetworkException(),
      // 401 means "session expired", except for a wrong phone/password on login
      _ when status == 401 && code != 'INVALID_CREDENTIALS' =>
        const UnauthorizedException(),
      // The Go API answers {"status", "code", "message"} on every error
      _ when status != null && code != null => ApiException(
        status: status,
        code: code,
        message: (body as Map<String, dynamic>)['message'] as String? ?? '',
      ),
      _ => UnknownException(e),
    };
  }
}

final class NetworkException extends AppException {
  const NetworkException();
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException();
}

final class ApiException extends AppException {
  const ApiException({
    required this.status,
    required this.code,
    required this.message,
  });

  final int status;

  /// Stable error code from the API: BAD_REQUEST, CONFLICT, NOT_FOUND, INVALID_CREDENTIALS...
  final String code;

  /// English text from the server, for logs only: show a translated message instead.
  final String message;

  @override
  String toString() => 'ApiException($status, $code, $message)';
}

final class UnknownException extends AppException {
  const UnknownException([this.cause]);

  final Object? cause;

  @override
  String toString() => 'UnknownException($cause)';
}
