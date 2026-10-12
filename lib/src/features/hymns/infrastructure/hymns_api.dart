import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/hymn.dart';

part 'hymns_api.g.dart';

/// The hymn books (/v1/hymns).
class HymnsApi {
  const HymnsApi(this._dio);

  final Dio _dio;

  /// The books, without their hymns, with their current version.
  Future<List<HymnBookSummary>> listBooks() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/hymns/books');
    return [
      for (final json in response.contentList)
        HymnBookSummary.fromJson(json as Map<String, dynamic>),
    ];
  });

  /// A whole book. With the [version] the phone already has, the server answers
  /// 304 Not Modified when it is still current: then this returns null.
  Future<HymnBook?> getBook(String code, {String? version}) =>
      apiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>(
          '/hymns/books/$code',
          options: Options(
            headers: {if (version != null) 'If-None-Match': '"$code@$version"'},
            validateStatus: (status) =>
                status != null &&
                ((status >= 200 && status < 300) || status == 304),
          ),
        );
        if (response.statusCode == 304) {
          return null;
        }
        return HymnBook.fromJson(response.content);
      });
}

@Riverpod(keepAlive: true)
HymnsApi hymnsApi(Ref ref) => HymnsApi(ref.watch(dioProvider));
