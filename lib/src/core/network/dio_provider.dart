import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import 'auth_interceptor.dart';

part 'dio_provider.g.dart';

/// The single HTTP client of the app. Feature APIs receive it, they never create their own.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ref.watch(appConfigProvider).apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      contentType: Headers.jsonContentType,
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(ref),
    if (kDebugMode)
      PrettyDioLogger(requestBody: true, compact: true, maxWidth: 100),
  ]);

  ref.onDispose(dio.close);
  return dio;
}
