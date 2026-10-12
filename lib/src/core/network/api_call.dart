import 'package:dio/dio.dart';

import 'app_exception.dart';

/// Runs a Dio request and turns any DioException into an [AppException].
/// Every API class wraps its calls with it, so callers only deal with AppException.
Future<T> apiCall<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioException catch (e) {
    throw AppException.fromDio(e);
  }
}

extension ApiResponseX on Response<Map<String, dynamic>> {
  /// The API wraps every success in {"status": 200, "content": ...}.
  Map<String, dynamic> get content => data!['content'] as Map<String, dynamic>;

  List<dynamic> get contentList => data!['content'] as List<dynamic>;
}
