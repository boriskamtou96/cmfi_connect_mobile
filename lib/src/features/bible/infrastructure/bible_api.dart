import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/bible.dart';

part 'bible_api.g.dart';

/// The Free Use Bible API (bible.helloao.org): free, without key, the same
/// JSON for every version. Reached with the app's client, which keeps the
/// user's token for our own API.
class BibleApi {
  const BibleApi(this._dio);

  static const base = 'https://bible.helloao.org/api';

  final Dio _dio;

  /// The books of [version], in order.
  Future<List<BibleBook>> books(String version) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$base/$version/books.json',
    );
    return [
      for (final book in response.data!['books'] as List<dynamic>)
        BibleBook.fromJson(book as Map<String, dynamic>),
    ];
  });

  /// A chapter as the API writes it ({number, content}), to keep and read.
  Future<Map<String, dynamic>> chapter(
    String version,
    String book,
    int number,
  ) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$base/$version/$book/$number.json',
    );
    return response.data!['chapter'] as Map<String, dynamic>;
  });

  /// The whole of [version] (about 7 MB): the raw bytes, kept as they are.
  Future<List<int>> complete(
    String version, {
    void Function(int received, int total)? onProgress,
  }) => apiCall(() async {
    final response = await _dio.get<List<int>>(
      '$base/$version/complete.json',
      options: Options(
        responseType: ResponseType.bytes,
        receiveTimeout: const Duration(minutes: 5),
      ),
      onReceiveProgress: onProgress,
    );
    return response.data!;
  });
}

// kept: the downloads (kept providers) go through it
@Riverpod(keepAlive: true)
BibleApi bibleApi(Ref ref) => BibleApi(ref.watch(dioProvider));
