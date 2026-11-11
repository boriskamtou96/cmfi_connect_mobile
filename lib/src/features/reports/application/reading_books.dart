import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/session/session.dart';
import '../domain/reading_book.dart';
import '../infrastructure/reading_api.dart';

part 'reading_books.g.dart';

/// Mes lectures: the member's books with their progress, those being read
/// first. Read again after a report is saved (its pages move the progress).
@Riverpod(keepAlive: true)
class ReadingBooks extends _$ReadingBooks {
  @override
  Future<List<ReadingBook>> build() async {
    final status = await ref.watch(sessionProvider.future);
    if (status != SessionStatus.authenticated) {
      return const [];
    }
    return ref.watch(readingApiProvider).books();
  }

  /// Adds a book, being read; answers it.
  Future<ReadingBook> add({
    required String title,
    required String author,
    required int totalPages,
    String coverUrl = '',
  }) async {
    final book = await ref
        .read(readingApiProvider)
        .add(
          title: title,
          author: author,
          totalPages: totalPages,
          coverUrl: coverUrl,
        );
    _replace(book);
    return book;
  }

  /// Finished ([finishedOn], today by default), set aside, or read again.
  Future<ReadingBook> setStatus(
    int id,
    ReadingStatus status, {
    DateTime? finishedOn,
  }) async {
    final book = await ref
        .read(readingApiProvider)
        .setStatus(id, status, finishedOn: finishedOn);
    _replace(book);
    // the books of the month change
    ref.invalidate(readingStatsProvider);
    return book;
  }

  Future<void> delete(int id) async {
    await ref.read(readingApiProvider).delete(id);
    final books = state.value;
    if (books != null) {
      state = AsyncData([
        for (final book in books)
          if (book.id != id) book,
      ]);
    }
    ref.invalidate(readingStatsProvider);
  }

  /// The book in the list (first when new), the order of the server kept:
  /// those being read first.
  void _replace(ReadingBook book) {
    final books = [...?state.value];
    final at = books.indexWhere((other) => other.id == book.id);
    if (at < 0) {
      books.insert(0, book);
    } else {
      books[at] = book;
    }
    // a book finished goes after those being read
    state = AsyncData([
      ...books.where((book) => book.isReading),
      ...books.where((book) => !book.isReading),
    ]);
  }
}

/// The book being read the most recently started: the one an LLC entry
/// names by default. null without any.
@riverpod
ReadingBook? currentBook(Ref ref) {
  final books = ref.watch(readingBooksProvider).value ?? const <ReadingBook>[];
  for (final book in books) {
    if (book.isReading) {
      return book;
    }
  }
  return null;
}

/// The books finished each month of [year], and the pages read.
@riverpod
Future<ReadingStats> readingStats(Ref ref, int year) =>
    ref.watch(readingApiProvider).stats(year);
