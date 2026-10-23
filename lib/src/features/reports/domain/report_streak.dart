import '../../../core/utils/date_extensions.dart';

/// A series of days with a report: how many, the first of them, and the
/// days of grace that kept it going.
typedef StreakResult = ({int days, DateTime? since, Set<DateTime> graced});

/// Days in a row that have a report, up to [today]. A today not filled in
/// yet doesn't break the series: it counts from yesterday until midnight.
///
/// One missed day a week (Monday to Sunday) doesn't break it either: a day
/// of grace, when the day before it has a report. Two days missed in a row,
/// or a second one in the same week, end it. The days of grace don't count.
StreakResult streakWithGrace(Iterable<DateTime> reportedDays, DateTime today) {
  final days = {for (final day in reportedDays) day.dateOnly};
  var day = today.dateOnly;
  if (!days.contains(day)) {
    day = DateTime(day.year, day.month, day.day - 1);
  }
  var count = 0;
  DateTime? since;
  final graced = <DateTime>{};
  final gracedWeeks = <DateTime>{};
  while (true) {
    final before = DateTime(day.year, day.month, day.day - 1);
    if (days.contains(day)) {
      count++;
      since = day;
    } else if (days.contains(before) && gracedWeeks.add(day.startOfWeek)) {
      graced.add(day);
    } else {
      break;
    }
    day = before;
  }
  return (days: count, since: since, graced: graced);
}

/// Days in a row that have a report, with the days of grace (see
/// [streakWithGrace]).
int currentStreak(Iterable<DateTime> reportedDays, DateTime today) =>
    streakWithGrace(reportedDays, today).days;

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
