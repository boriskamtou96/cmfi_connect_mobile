import 'package:freezed_annotation/freezed_annotation.dart';

import 'daily_report.dart';

part 'report_goal.freezed.dart';
part 'report_goal.g.dart';

/// What the user aims at each day for one item: a quantity, a duration, or
/// both. Kept on the phone for now (no API yet).
@freezed
abstract class ReportGoal with _$ReportGoal {
  const factory ReportGoal({int? quantity, int? minutes}) = _ReportGoal;

  const ReportGoal._();

  factory ReportGoal.fromJson(Map<String, dynamic> json) =>
      _$ReportGoalFromJson(json);

  bool get isEmpty => (quantity ?? 0) <= 0 && (minutes ?? 0) <= 0;

  /// How far the values of a day go towards the goal, from 0 to 1. With two
  /// targets, each counts for half.
  double progress({int? quantity, int? minutes}) {
    final parts = [
      if (this.quantity case final target? when target > 0)
        ((quantity ?? 0) / target).clamp(0.0, 1.0),
      if (this.minutes case final target? when target > 0)
        ((minutes ?? 0) / target).clamp(0.0, 1.0),
    ];
    return parts.isEmpty ? 0 : parts.reduce((a, b) => a + b) / parts.length;
  }

  bool reachedBy({int? quantity, int? minutes}) =>
      !isEmpty && progress(quantity: quantity, minutes: minutes) >= 1;

  /// Days of [reports] on which item [activityTypeId] reached the goal.
  int daysReached(Iterable<DailyReport> reports, int activityTypeId) => reports
      .where(
        (report) => report.entries.any(
          (entry) =>
              entry.activityTypeId == activityTypeId &&
              reachedBy(
                quantity: entry.quantity,
                minutes: entry.durationMinutes,
              ),
        ),
      )
      .length;
}
