import 'daily_report.dart';
import 'report_summary.dart';

/// The time spent with God: every item measured in minutes, the member's own
/// included (the retreats are in « Prière seule », counted once).
int minutesOfEntries(Iterable<ReportEntry> entries) =>
    entries.fold(0, (sum, entry) => sum + (entry.durationMinutes ?? 0));

/// The same over a period, from the totals of its items.
int minutesOfItems(Iterable<SummaryItem> items) => items
    .where((item) => item.tracksDuration)
    .fold(0, (sum, item) => sum + item.totalMinutes);
