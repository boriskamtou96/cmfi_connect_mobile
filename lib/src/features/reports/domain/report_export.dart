import '../../../core/utils/date_extensions.dart';
import 'activity_type.dart';
import 'daily_report.dart';
import 'report_goal.dart';

/// One item over the exported period.
class ExportItem {
  const ExportItem({
    required this.activityTypeId,
    required this.code,
    required this.label,
    required this.tracksQuantity,
    required this.tracksDuration,
    required this.personal,
    this.unit,
    this.daysCount = 0,
    this.totalQuantity = 0,
    this.totalMinutes = 0,
    this.goal,
    this.goalDays = 0,
  });

  final int activityTypeId;
  final String code;
  final String label;
  final String? unit;
  final bool tracksQuantity;
  final bool tracksDuration;
  final bool personal;

  /// Days on which the item was filled in.
  final int daysCount;
  final int totalQuantity;
  final int totalMinutes;

  final ReportGoal? goal;

  /// Days on which [goal] was reached.
  final int goalDays;
}

/// The reports of a period, ready to be written out (text, CSV, PDF).
class ReportExport {
  const ReportExport({
    required this.from,
    required this.to,
    required this.reports,
    required this.items,
  });

  /// [history]: the days with a report in the period, as the API gives them.
  /// The items are the active ones (even never filled), then the archived
  /// ones that still have values in the period.
  factory ReportExport.build({
    required DateTime from,
    required DateTime to,
    required List<DailyReport> history,
    required List<ActivityType> activities,
    Map<int, ReportGoal> goals = const {},
  }) {
    final reports = {
      for (final report in history)
        if (report.submitted || report.entries.isNotEmpty)
          report.date.dateOnly: report,
    };
    final entriesById = <int, List<ReportEntry>>{};
    for (final report in reports.values) {
      for (final entry in report.entries.where((entry) => entry.isFilled)) {
        (entriesById[entry.activityTypeId] ??= []).add(entry);
      }
    }

    ExportItem item({
      required int id,
      required String code,
      required String label,
      required String? unit,
      required bool tracksQuantity,
      required bool tracksDuration,
      required bool personal,
    }) {
      final entries = entriesById[id] ?? const <ReportEntry>[];
      final goal = goals[id];
      return ExportItem(
        activityTypeId: id,
        code: code,
        label: label,
        unit: unit,
        tracksQuantity: tracksQuantity,
        tracksDuration: tracksDuration,
        personal: personal,
        daysCount: entries.length,
        totalQuantity: entries.fold(0, (sum, e) => sum + (e.quantity ?? 0)),
        totalMinutes: entries.fold(
          0,
          (sum, e) => sum + (e.durationMinutes ?? 0),
        ),
        goal: goal == null || goal.isEmpty ? null : goal,
        goalDays: goal == null ? 0 : goal.daysReached(reports.values, id),
      );
    }

    final sorted = [...activities]
      ..sort((a, b) {
        // standard items first, then the user's own, each in display order
        if (a.isStandard != b.isStandard) {
          return a.isStandard ? -1 : 1;
        }
        return a.position.compareTo(b.position);
      });
    final active = {for (final activity in sorted) activity.id};
    final archived = [
      for (final entries in entriesById.values)
        if (!active.contains(entries.first.activityTypeId)) entries.first,
    ]..sort((a, b) => a.code.compareTo(b.code));

    return ReportExport(
      from: from.dateOnly,
      to: to.dateOnly,
      reports: reports,
      items: [
        for (final activity in sorted)
          item(
            id: activity.id,
            code: activity.code,
            label: activity.label,
            unit: activity.quantityUnit,
            tracksQuantity: activity.tracksQuantity,
            tracksDuration: activity.tracksDuration,
            personal: !activity.isStandard,
          ),
        for (final entry in archived)
          item(
            id: entry.activityTypeId,
            code: entry.code,
            label: entry.label,
            unit: entry.quantityUnit,
            tracksQuantity:
                entry.tracksQuantity ||
                entriesById[entry.activityTypeId]!.any(
                  (e) => e.quantity != null,
                ),
            tracksDuration:
                entry.tracksDuration ||
                entriesById[entry.activityTypeId]!.any(
                  (e) => e.durationMinutes != null,
                ),
            personal: true,
          ),
      ],
    );
  }

  final DateTime from;
  final DateTime to;

  /// Days with a report, by date.
  final Map<DateTime, DailyReport> reports;
  final List<ExportItem> items;

  /// Every day of the period, the first one first.
  List<DateTime> get days => from.daysUntil(to);

  int get daysInRange => days.length;
  int get daysReported => reports.length;

  /// The items that have at least one value in the period.
  List<ExportItem> get filledItems =>
      items.where((item) => item.daysCount > 0).toList();
}
