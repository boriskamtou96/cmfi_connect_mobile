import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_converters.dart';

part 'daily_report.freezed.dart';
part 'daily_report.g.dart';

/// One item of a day. In GET /reports/:date every active item is listed, with
/// null values when not filled in; in the history only filled items are listed.
@freezed
abstract class ReportEntry with _$ReportEntry {
  const factory ReportEntry({
    required int activityTypeId,
    required String code,
    required String label,
    @Default(false) bool tracksQuantity,
    String? quantityUnit,
    @Default(false) bool tracksDuration,
    int? quantity,
    int? durationMinutes,

    /// The book read that day: Lecture de la littérature chrétienne only.
    EntryBook? book,
  }) = _ReportEntry;

  const ReportEntry._();

  factory ReportEntry.fromJson(Map<String, dynamic> json) =>
      _$ReportEntryFromJson(json);

  bool get isFilled => quantity != null || durationMinutes != null;
}

/// The book named by an LLC entry. [pageReached] (history only): the page
/// reached in it that day, the pages of every day up to this one.
@freezed
abstract class EntryBook with _$EntryBook {
  const factory EntryBook({
    required int id,
    required String title,
    @Default('') String author,
    required int totalPages,

    /// Its cover, found for its title and author ('' when none: drawn).
    @Default('') String coverUrl,
    int? pageReached,
  }) = _EntryBook;

  factory EntryBook.fromJson(Map<String, dynamic> json) =>
      _$EntryBookFromJson(json);
}

/// A day: the form of GET/PUT /reports/:date, or a day of GET /reports/?from&to.
@freezed
abstract class DailyReport with _$DailyReport {
  const factory DailyReport({
    @ApiDateConverter() required DateTime date,
    String? note,

    /// The day was saved at least once.
    @Default(false) bool submitted,
    @Default(<ReportEntry>[]) List<ReportEntry> entries,
  }) = _DailyReport;

  factory DailyReport.fromJson(Map<String, dynamic> json) =>
      _$DailyReportFromJson(json);
}
