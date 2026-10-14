import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/date_extensions.dart';
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

/// The goals of one day: the items of [entries] that have a goal, and how
/// many of them are reached.
typedef DayGoals = ({double progress, int reached, int total});

/// How far the goals of a day are reached: the mean of the progress of each
/// item of [entries] with a goal (an item left empty counts 0), from 0 to 1.
/// Null when none of these items has a goal.
DayGoals? dayGoals(Map<int, ReportGoal> goals, Iterable<ReportEntry> entries) {
  var sum = 0.0;
  var reached = 0;
  var total = 0;
  for (final entry in entries) {
    final goal = goals[entry.activityTypeId];
    if (goal == null || goal.isEmpty) {
      continue;
    }
    final progress = goal.progress(
      quantity: entry.quantity,
      minutes: entry.durationMinutes,
    );
    sum += progress;
    total++;
    if (progress >= 1) {
      reached++;
    }
  }
  return total == 0
      ? null
      : (progress: sum / total, reached: reached, total: total);
}

/// The goals over a period: for each item, the mean of its daily progress;
/// [total], the mean of the items.
typedef PeriodGoals = ({Map<int, double> byItem, double total});

/// The goals of [itemIds] from [from] to [to]: every day counts, even one
/// without a report, except [today] while it is not filled in (like the
/// series). Null when none of the items has a goal, or no day counts yet.
PeriodGoals? periodGoals(
  Map<int, ReportGoal> goals, {
  required Iterable<int> itemIds,
  required Iterable<DailyReport> history,
  required DateTime from,
  required DateTime to,
  required DateTime today,
}) {
  final ids = [
    for (final id in itemIds)
      if (goals[id] case final goal? when !goal.isEmpty) id,
  ];
  final byDay = {for (final report in history) report.date.dateOnly: report};
  final days = [
    for (final day in from.daysUntil(to))
      if (!day.isSameDay(today) || byDay.containsKey(day)) day,
  ];
  if (ids.isEmpty || days.isEmpty) {
    return null;
  }
  final byItem = <int, double>{};
  for (final id in ids) {
    var sum = 0.0;
    for (final day in days) {
      final entry = byDay[day]?.entries
          .where((entry) => entry.activityTypeId == id)
          .firstOrNull;
      sum += goals[id]!.progress(
        quantity: entry?.quantity,
        minutes: entry?.durationMinutes,
      );
    }
    byItem[id] = sum / days.length;
  }
  return (
    byItem: byItem,
    total: byItem.values.reduce((a, b) => a + b) / byItem.length,
  );
}

/// [dayGoals] as a whole percentage (0 to 100): what the server keeps of a
/// day, for the disciple maker's dashboard. Null without goals.
int? dayGoalPercent(Map<int, ReportGoal> goals, Iterable<ReportEntry> entries) {
  final day = dayGoals(goals, entries);
  return day == null ? null : (day.progress * 100).round().clamp(0, 100);
}
