import '../../../core/utils/date_extensions.dart';
import '../../prayer/domain/prayer.dart';
import '../../reports/domain/activity_type.dart';
import '../../reports/domain/daily_report.dart';
import '../../reports/domain/report_export.dart';
import '../../reports/domain/report_goal.dart';
import '../../reports/domain/report_streak.dart';

/// "Ta semaine avec Dieu": what a week told, Monday to Sunday (to today while
/// the week goes on).
class WeekStory {
  const WeekStory({
    required this.monday,
    required this.end,
    required this.daysFilled,
    required this.streak,
    required this.bestStreak,
    required this.items,
    required this.retreats,
    required this.dailyGoals,
    this.goals,
  });

  /// [history]: the reports up to the end of the week, over a long enough time
  /// for the streaks (a year); [retreats]: those of the week.
  factory WeekStory.build({
    required DateTime monday,
    required DateTime today,
    required List<DailyReport> history,
    required List<ActivityType> activities,
    required Map<int, ReportGoal> goals,
    required List<RetreatRecord> retreats,
  }) {
    final sunday = DateTime(monday.year, monday.month, monday.day + 6);
    final end = today.isBefore(sunday) ? today : sunday;
    bool inWeek(DateTime day) => !day.isBefore(monday) && !day.isAfter(end);

    final reported = {
      for (final report in history)
        if (report.submitted || report.entries.isNotEmpty) report.date.dateOnly,
    }.where((day) => !day.isAfter(end)).toSet();
    final week = [
      for (final report in history)
        if (inWeek(report.date.dateOnly)) report,
    ];

    final export = ReportExport.build(
      from: monday,
      to: end,
      history: week,
      activities: activities,
      goals: goals,
    );
    // the item kept most faithfully first, then the one done the most
    final items =
        [
          for (final item in export.items)
            if (item.daysCount > 0) item,
        ]..sort(
          (a, b) => b.daysCount != a.daysCount
              ? b.daysCount.compareTo(a.daysCount)
              : (b.totalMinutes + b.totalQuantity).compareTo(
                  a.totalMinutes + a.totalQuantity,
                ),
        );

    final ids = [for (final activity in activities) activity.id];
    double? goalsOf(DateTime from, DateTime to) => periodGoals(
      goals,
      itemIds: ids,
      history: week,
      from: from,
      to: to,
      today: today,
    )?.total;

    return WeekStory(
      monday: monday,
      end: end,
      daysFilled: reported.where(inWeek).length,
      streak: currentStreak(reported, end),
      bestStreak: longestStreak(reported),
      items: items,
      retreats: [
        for (final record in retreats)
          if (inWeek(record.day.dateOnly)) record,
      ],
      goals: goalsOf(monday, end),
      dailyGoals: [
        for (final day in monday.daysUntil(end))
          // today, before it is filled, is not a day missed yet
          if (day.isSameDay(today) && !reported.contains(day))
            null
          else
            goalsOf(day, day),
      ],
    );
  }

  final DateTime monday;

  /// Sunday, or today while the week goes on.
  final DateTime end;

  int get daysInWeek => end.difference(monday).inDays + 1;
  final int daysFilled;

  /// Days in a row at the end of the week, and the longest run over the
  /// history read.
  final int streak;
  final int bestStreak;
  bool get streakIsRecord => streak >= 2 && streak >= bestStreak;

  /// The items filled in, the most faithful first.
  final List<ExportItem> items;

  /// The 15-minute retreats of the week.
  final List<RetreatRecord> retreats;
  int get retreatMinutes =>
      retreats.fold(0, (sum, record) => sum + record.minutes);

  /// The moment prayed the most often (the earliest of the day on a tie).
  ({RetreatMoment moment, int times})? get faithfulMoment {
    if (retreats.isEmpty) {
      return null;
    }
    final counts = {
      for (final moment in RetreatMoment.values)
        moment: retreats.where((record) => record.moment == moment).length,
    };
    final best = RetreatMoment.values.reduce(
      (a, b) => counts[b]! > counts[a]! ? b : a,
    );
    return (moment: best, times: counts[best]!);
  }

  bool prayed(DateTime day, RetreatMoment moment) => retreats.any(
    (record) => record.day.isSameDay(day) && record.moment == moment,
  );

  /// The mean share of the goals reached (0 to 1), null without goals.
  final double? goals;

  /// The same, day by day from Monday (null: today, not filled yet).
  final List<double?> dailyGoals;

  /// The day the goals went best, or null.
  ({DateTime day, double goals})? get bestDay {
    ({DateTime day, double goals})? best;
    for (final (i, value) in dailyGoals.indexed) {
      if (value != null && value > 0 && (best == null || value > best.goals)) {
        best = (
          day: DateTime(monday.year, monday.month, monday.day + i),
          goals: value,
        );
      }
    }
    return best;
  }
}

/// The longest run of days in a row among [days].
int longestStreak(Iterable<DateTime> days) {
  final sorted = {for (final day in days) day.dateOnly}.toList()..sort();
  var best = 0;
  var run = 0;
  DateTime? previous;
  for (final day in sorted) {
    run = previous != null && day.difference(previous).inDays == 1
        ? run + 1
        : 1;
    if (run > best) {
      best = run;
    }
    previous = day;
  }
  return best;
}

/// The Monday of the week to show on the home screen: from Sunday 18:00 to
/// Monday evening, the week that ends (or just ended); null the other days.
DateTime? storyWeekAt(DateTime now) {
  final day = now.dateOnly;
  if (now.weekday == DateTime.sunday && now.hour >= weekStoryHour) {
    return day.startOfWeek;
  }
  if (now.weekday == DateTime.monday) {
    return DateTime(day.year, day.month, day.day - 7).startOfWeek;
  }
  return null;
}

/// When the story of the week is ready: Sunday evening.
const weekStoryHour = 18;

/// The next [count] Sundays at 18:00 after [now].
List<DateTime> weekStoryTimes({required DateTime now, int count = 4}) {
  final day = now.dateOnly;
  var sunday = DateTime(
    day.year,
    day.month,
    day.day + DateTime.sunday - day.weekday,
  );
  if (!DateTime(
    sunday.year,
    sunday.month,
    sunday.day,
    weekStoryHour,
  ).isAfter(now)) {
    sunday = DateTime(sunday.year, sunday.month, sunday.day + 7);
  }
  return [
    for (var i = 0; i < count; i++)
      DateTime(sunday.year, sunday.month, sunday.day + 7 * i, weekStoryHour),
  ];
}

const _payloadPrefix = 'week_story:';

/// The notification of a week: its Monday.
String weekStoryPayload(DateTime sunday) =>
    '$_payloadPrefix${sunday.startOfWeek.toApiDate()}';

DateTime? weekStoryOf(String? payload) =>
    payload != null && payload.startsWith(_payloadPrefix)
    ? DateTime.tryParse(payload.substring(_payloadPrefix.length))
    : null;
