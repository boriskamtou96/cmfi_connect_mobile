import 'package:dio/dio.dart';

import '../services/app_log.dart';
import 'app_exception.dart';

/// Runs a Dio request and turns any DioException into an [AppException].
/// Every API class wraps its calls with it, so callers only deal with AppException.
Future<T> apiCall<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioException catch (e, stack) {
    final error = AppException.fromDio(e);
    _log(e, error, stack);
    throw error;
  }
}

/// A server error or an unexpected answer goes to the log, with what leads
/// to its lines on the server (X-Request-ID); no network is only a step.
/// Never the query string nor the body: they may hold personal data.
void _log(DioException e, AppException error, StackTrace stack) {
  final request = e.requestOptions;
  final status = e.response?.statusCode;
  final id = e.response?.headers.value('x-request-id');
  final where =
      '${request.method} ${request.uri.path} → ${status ?? e.type.name}'
      '${id == null ? '' : ' (request $id)'}';
  switch (error) {
    case NetworkException():
      AppLog.info('no network: $where');
    // a service switched off on the server (mobile money): not a crash
    case ApiException(code: 'PAYMENTS_DISABLED'):
      AppLog.info('disabled: $where');
    case ApiException(:final status) when status >= 500:
      AppLog.error(error, stack, reason: 'server error: $where');
    case UnknownException():
      AppLog.error(e, stack, reason: 'unexpected answer: $where');
    case ApiException() || UnauthorizedException():
      AppLog.info('refused: $where');
  }
}

extension ApiResponseX on Response<Map<String, dynamic>> {
  /// The API wraps every success in {"status": 200, "content": ...}.
  Map<String, dynamic> get content => data!['content'] as Map<String, dynamic>;

  List<dynamic> get contentList => data!['content'] as List<dynamic>;
}
