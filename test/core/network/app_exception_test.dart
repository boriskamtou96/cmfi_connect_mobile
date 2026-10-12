import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _badResponse(int status, Object? body) {
  final options = RequestOptions(path: '/test');
  return DioException.badResponse(
    statusCode: status,
    requestOptions: options,
    response: Response(requestOptions: options, statusCode: status, data: body),
  );
}

void main() {
  test('no connection -> NetworkException', () {
    final error = DioException.connectionError(
      requestOptions: RequestOptions(path: '/test'),
      reason: 'offline',
    );
    expect(AppException.fromDio(error), isA<NetworkException>());
  });

  test('401 from the auth middleware -> UnauthorizedException', () {
    final error = _badResponse(401, {
      'status': 401,
      'code': 'UNAUTHORIZED',
      'message': 'authorization header is not provided',
    });
    expect(AppException.fromDio(error), isA<UnauthorizedException>());
  });

  test('401 INVALID_CREDENTIALS on login stays an ApiException', () {
    final error = _badResponse(401, {
      'status': 401,
      'code': 'INVALID_CREDENTIALS',
      'message': 'invalid credentials',
    });
    expect(
      AppException.fromDio(error),
      isA<ApiException>().having((e) => e.code, 'code', 'INVALID_CREDENTIALS'),
    );
  });

  test('error body from the API -> ApiException with its code', () {
    final error = _badResponse(409, {
      'status': 409,
      'code': 'CONFLICT',
      'message': 'code LB is reserved for a standard item',
    });
    expect(
      AppException.fromDio(error),
      isA<ApiException>()
          .having((e) => e.status, 'status', 409)
          .having((e) => e.code, 'code', 'CONFLICT'),
    );
  });

  test('response without the API error format -> UnknownException', () {
    expect(
      AppException.fromDio(_badResponse(502, '<html>Bad gateway</html>')),
      isA<UnknownException>(),
    );
  });
}
