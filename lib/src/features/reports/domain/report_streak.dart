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

/// The streaks Zoé celebrates, once each per account.
const streakMilestones = [7, 30, 100, 365];

/// The milestone a save made the streak cross, going from [before] to
/// [after] days (the highest one, when a day filled in late joins two
/// series), or null: none crossed, or already [celebrated].
int? crossedMilestone({
  required int before,
  required int after,
  required Set<int> celebrated,
}) {
  for (final milestone in streakMilestones.reversed) {
    if (before < milestone && milestone <= after) {
      return celebrated.contains(milestone) ? null : milestone;
    }
  }
  return null;
}
