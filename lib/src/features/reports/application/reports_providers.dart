import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/activity_type.dart';
import '../domain/daily_report.dart';
import '../domain/report_streak.dart';
import '../domain/report_summary.dart';
import '../infrastructure/activities_api.dart';
import '../infrastructure/reports_api.dart';
import '../infrastructure/reports_local_store.dart';
import 'pending_reports.dart';

part 'reports_providers.g.dart';

/// Active report items (standard + personal), in display order. Without
/// network, the ones seen last time, so a day can still be filled in.
@riverpod
Future<List<ActivityType>> activities(Ref ref) async {
  final store = ref.watch(reportsLocalStoreProvider);
  try {
    final activities = await ref.watch(activitiesApiProvider).list();
    await store.saveActivities(activities);
    return activities;
  } on NetworkException {
    final cached = store.activities();
    if (cached == null) {
      rethrow;
    }
    return cached;
  }
}

/// The last history the server gave for each period, shown again while the
/// network is gone. In memory only.
@Riverpod(keepAlive: true)
Map<(DateTime, DateTime), List<DailyReport>> lastHistory(Ref ref) => {};

/// Days with a report between [from] and [to] (included), newest first.
/// The days saved offline and not sent yet are included, as the user sees them.
@riverpod
Future<List<DailyReport>> reportHistory(
  Ref ref, {
  required DateTime from,
  required DateTime to,
}) async {
  // a day kept offline or sent: merged again (the server answer is reused offline)
  ref.watch(pendingReportsProvider);
  final memory = ref.watch(lastHistoryProvider);
  Future<List<DailyReport>> fromServer() async {
    try {
      return memory[(from, to)] = await ref
          .watch(reportsApiProvider)
          .history(from: from, to: to);
    } on NetworkException {
      final last = memory[(from, to)];
      if (last == null) {
        rethrow;
      }
      return last;
    }
  }

  final days = await fromServer();
  final waiting = [
    for (final day in ref.read(reportsLocalStoreProvider).pending().values)
      if (!day.date.isBefore(from) && !day.date.isAfter(to))
        day.copyWith(
          entries: day.entries.where((entry) => entry.isFilled).toList(),
        ),
  ];
  if (waiting.isEmpty) {
    return days;
  }
  final replaced = {for (final day in waiting) day.date};
  return [...days.where((day) => !replaced.contains(day.date)), ...waiting]
    ..sort((a, b) => b.date.compareTo(a.date));
}

/// Days in a row with a report, up to today (see [currentStreak]).
@riverpod
Future<int> reportStreak(Ref ref) async {
  final now = today();
  // a month is enough for most; a longer series looks a year back
  for (final span in const [35, 366]) {
    final days = await ref.watch(
      reportHistoryProvider(
        from: DateTime(now.year, now.month, now.day - span + 1),
        to: now,
      ).future,
    );
    final streak = currentStreak([for (final day in days) day.date], now);
    if (streak < span - 1) {
      return streak;
    }
  }
  return 365;
}

/// The dates that have a report in the week of [day] (Monday to Sunday).
@riverpod
Future<Set<DateTime>> reportedDaysOfWeek(Ref ref, DateTime day) async {
  final monday = day.startOfWeek;
  final days = await ref.watch(
    reportHistoryProvider(
      from: monday,
      to: DateTime(monday.year, monday.month, monday.day + 6),
    ).future,
  );
  return {for (final report in days) report.date};
}

enum SummaryPeriod {
  week,
  month,
  year;

  /// From the start of the week / month / year to [today] included.
  ({DateTime from, DateTime to}) rangeEnding(DateTime today) => (
    from: switch (this) {
      week => today.startOfWeek,
      month => today.startOfMonth,
      year => DateTime(today.year),
    },
    to: today,
  );
}

@riverpod
Future<ReportSummary> reportSummary(Ref ref, SummaryPeriod period) {
  final range = period.rangeEnding(today());
  return ref.watch(reportsApiProvider).summary(from: range.from, to: range.to);
}

/// The three views of the Reports tab.
enum ReportsView { today, history, summary }

/// Kept alive so other tabs can open a given view (Home -> week -> history).
@Riverpod(keepAlive: true)
class SelectedReportsView extends _$SelectedReportsView {
  @override
  ReportsView build() => ReportsView.today;

  void select(ReportsView view) => state = view;
}

/// The day shown in the "Today" view. null means today, so the app follows
/// midnight without having to be restarted.
@Riverpod(keepAlive: true)
class SelectedReportDay extends _$SelectedReportDay {
  @override
  DateTime? build() => null;

  void select(DateTime day) =>
      state = day.isSameDay(today()) ? null : day.dateOnly;
}
