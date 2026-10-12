import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_converters.dart';

part 'report_summary.freezed.dart';
part 'report_summary.g.dart';

/// Content of GET /reports/summary: totals per item over a period.
@freezed
abstract class ReportSummary with _$ReportSummary {
  const factory ReportSummary({
    @ApiDateConverter() required DateTime from,
    @ApiDateConverter() required DateTime to,
    required int daysInRange,
    required int daysReported,
    @Default(<SummaryItem>[]) List<SummaryItem> items,
  }) = _ReportSummary;

  factory ReportSummary.fromJson(Map<String, dynamic> json) =>
      _$ReportSummaryFromJson(json);
}

@freezed
abstract class SummaryItem with _$SummaryItem {
  const factory SummaryItem({
    required int activityTypeId,
    required String code,
    required String label,
    String? quantityUnit,
    @Default(false) bool tracksQuantity,
    @Default(false) bool tracksDuration,

    /// Days on which this item was filled in.
    @Default(0) int daysCount,
    @Default(0) int totalQuantity,
    @Default(0) int totalMinutes,
  }) = _SummaryItem;

  factory SummaryItem.fromJson(Map<String, dynamic> json) =>
      _$SummaryItemFromJson(json);
}
