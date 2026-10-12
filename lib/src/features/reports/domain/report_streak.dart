import '../../../core/utils/date_extensions.dart';

/// Days in a row that have a report, up to [today]. A today not filled in
/// yet doesn't break the series: it counts from yesterday until midnight.
int currentStreak(Iterable<DateTime> reportedDays, DateTime today) {
  final days = {for (final day in reportedDays) day.dateOnly};
  var day = today.dateOnly;
  if (!days.contains(day)) {
    day = DateTime(day.year, day.month, day.day - 1);
  }
  var count = 0;
  while (days.contains(day)) {
    count++;
    day = DateTime(day.year, day.month, day.day - 1);
  }
  return count;
}
