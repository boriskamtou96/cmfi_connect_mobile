import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/reading_book.dart';

part 'reading_api.g.dart';

/// Mes lectures (/v1/reading): the member's books, named by the LLC item of
/// the reports.
class ReadingApi {
  const ReadingApi(this._dio);

  final Dio _dio;

  /// The books being read first, then the finished ones, latest first.
  Future<List<ReadingBook>> books() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/reading/books');
    return [
      for (final json in response.contentList)
        ReadingBook.fromJson(json as Map<String, dynamic>),
    ];
  });

  /// A book added to the shelf, being read. [coverUrl]: from the search only.
  Future<ReadingBook> add({
    required String title,
    required String author,
    required int totalPages,
    String coverUrl = '',
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/reading/books',
      data: {
        'title': title.trim(),
        'author': author.trim(),
        'total_pages': totalPages,
        'cover_url': coverUrl,
      },
    );
    return ReadingBook.fromJson(response.content);
  });

  /// Its title, author or pages corrected. [coverUrl] '' when the title or
  /// the author changed: the server looks for the cover again.
  Future<ReadingBook> update(
    int id, {
    required String title,
    required String author,
    required int totalPages,
    required String coverUrl,
  }) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/reading/books/$id',
      data: {
        'title': title.trim(),
        'author': author.trim(),
        'total_pages': totalPages,
        'cover_url': coverUrl,
      },
    );
    return ReadingBook.fromJson(response.content);
  });

  /// Finished (on [finishedOn], today by default), abandoned, or being read
  /// again.
  Future<ReadingBook> setStatus(
    int id,
    ReadingStatus status, {
    DateTime? finishedOn,
  }) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/reading/books/$id/status',
      data: {
        'status': switch (status) {
          ReadingStatus.reading => 'reading',
          ReadingStatus.finished => 'finished',
          ReadingStatus.abandoned => 'abandoned',
        },
        if (status == ReadingStatus.finished && finishedOn != null)
          'finished_on': finishedOn.toApiDate(),
      },
    );
    return ReadingBook.fromJson(response.content);
  });

  /// Removed from the shelf: the reports keep their pages, without the book.
  Future<void> delete(int id) => apiCall(() async {
    await _dio.delete<void>('/reading/books/$id');
  });

  /// The books finished each month of [year], and the pages read.
  Future<ReadingStats> stats(int year) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/reading/stats',
      queryParameters: {'year': year},
    );
    return ReadingStats.fromJson(response.content);
  });

  /// Books matching a title or an author (Open Library). An ApiException
  /// SEARCH_UNAVAILABLE (503) when it can't answer: the book is typed.
  Future<List<BookFound>> search(String query) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/reading/search',
      queryParameters: {'q': query.trim()},
    );
    return [
      for (final json in response.contentList)
        BookFound.fromJson(json as Map<String, dynamic>),
    ];
  });
}

@Riverpod(keepAlive: true)
ReadingApi readingApi(Ref ref) => ReadingApi(ref.watch(dioProvider));
