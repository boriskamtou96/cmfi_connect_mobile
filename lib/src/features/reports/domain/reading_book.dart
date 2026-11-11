import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_converters.dart';
import 'daily_report.dart';

part 'reading_book.freezed.dart';
part 'reading_book.g.dart';

/// Where a book stands on the member's shelf.
enum ReadingStatus {
  @JsonValue('reading')
  reading,
  @JsonValue('finished')
  finished,
  @JsonValue('abandoned')
  abandoned,
}

/// Mes lectures: a book on the member's shelf (GET /v1/reading/books). The
/// LLC item of the reports names it; [pagesRead] adds up their pages.
@freezed
abstract class ReadingBook with _$ReadingBook {
  const factory ReadingBook({
    required int id,
    required String title,
    @Default('') String author,
    required int totalPages,
    @Default('') String coverUrl,
    @JsonKey(unknownEnumValue: ReadingStatus.reading)
    @Default(ReadingStatus.reading)
    ReadingStatus status,

    /// The first day a report named it (else the day it was added).
    @ApiDateConverter() required DateTime startedOn,
    @ApiDateConverter() DateTime? finishedOn,

    /// The pages of the reports that name it (may pass [totalPages]).
    @Default(0) int pagesRead,
  }) = _ReadingBook;

  const ReadingBook._();

  factory ReadingBook.fromJson(Map<String, dynamic> json) =>
      _$ReadingBookFromJson(json);

  /// The page reached, [totalPages] at most.
  int get pageReached => math.min(pagesRead, totalPages);

  /// 0 to 1.
  double get progress => totalPages == 0 ? 0 : pageReached / totalPages;

  bool get isReading => status == ReadingStatus.reading;

  /// What a report entry keeps of it.
  EntryBook get asEntry => EntryBook(
    id: id,
    title: title,
    author: author,
    totalPages: totalPages,
    coverUrl: coverUrl,
  );
}

/// A book the search proposes (Open Library): what the member would type.
/// [totalPages] is 0 when unknown.
@freezed
abstract class BookFound with _$BookFound {
  const factory BookFound({
    required String title,
    @Default('') String author,
    @Default(0) int totalPages,
    @Default('') String coverUrl,
  }) = _BookFound;

  factory BookFound.fromJson(Map<String, dynamic> json) =>
      _$BookFoundFromJson(json);
}

/// The books finished each month of a year (GET /v1/reading/stats).
@freezed
abstract class ReadingStats with _$ReadingStats {
  const factory ReadingStats({
    required int year,

    /// The 12 months, January first.
    @Default(<ReadingMonth>[]) List<ReadingMonth> months,
    @Default(0) int booksFinished,

    /// The pages read in books that year.
    @Default(0) int pages,
  }) = _ReadingStats;

  const ReadingStats._();

  factory ReadingStats.fromJson(Map<String, dynamic> json) =>
      _$ReadingStatsFromJson(json);

  /// The books finished in [month] (1 to 12).
  int booksIn(int month) =>
      month >= 1 && month <= months.length ? months[month - 1].books : 0;
}

@freezed
abstract class ReadingMonth with _$ReadingMonth {
  /// [month]: "2026-11".
  const factory ReadingMonth({required String month, @Default(0) int books}) =
      _ReadingMonth;

  factory ReadingMonth.fromJson(Map<String, dynamic> json) =>
      _$ReadingMonthFromJson(json);
}
