import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import 'auth_interceptor.dart';

part 'dio_provider.g.dart';

/// The single HTTP client of the app. Feature APIs receive it, they never create their own.
/// A request to another host (absolute URL) goes without the user's token.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final apiBaseUrl = ref.watch(appConfigProvider).apiBaseUrl;
  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      contentType: Headers.jsonContentType,
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(ref, apiBaseUrl: apiBaseUrl),
    if (kDebugMode)
      PrettyDioLogger(
        requestBody: true,
        compact: true,
        maxWidth: 100,
        // a whole Bible (7 MB) is not worth printing
        filter: (options, _) => options.uri.host == Uri.parse(apiBaseUrl).host,
      ),
  ]);

  ref.onDispose(dio.close);
  return dio;
}
