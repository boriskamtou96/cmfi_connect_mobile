import '../../../core/utils/date_extensions.dart';
import '../../bible/domain/memory_verse.dart';
import '../../bible/domain/reading_plan.dart';
import '../../prayer/domain/prayer.dart';
import '../../reports/domain/activity_type.dart';
import '../../reports/domain/daily_report.dart';
import '../../reports/domain/report_export.dart';
import '../../reports/domain/report_goal.dart';
import '../../reports/domain/standard_item.dart';
import 'week_story.dart';

/// The chapters of the Bible (1 189), as the reading plan counts them.
final bibleChapters = planBooks.fold(0, (sum, book) => sum + book.$2);

/// "Ton année avec Dieu": what a year told, from 1 January (or the first day
/// filled in, for a member who began during the year) to 31 December (to
/// today while the year goes on).
class YearStory {
  const YearStory({
    required this.year,
    required this.start,
    required this.end,
    required this.daysCounted,
    required this.daysFilled,
    required this.bestStreak,
    required this.monthDays,
    required this.retreats,
    required this.prayerMinutes,
    required this.chapters,
    required this.versesKnown,
    required this.versesLearning,
    required this.fullFasts,
    required this.partialFasts,
    required this.monthlyGoals,
    this.goals,
  });

  /// [history]: the reports of the year up to [today]; [startedBefore]: the
  /// member filled in days before this year (then the year counts from
  /// 1 January, whatever its first day); [retreats]: those of the year;
  /// [verses]: the verses learnt by heart (Mémorisation).
  factory YearStory.build({
    required int year,
    required DateTime today,
    required List<DailyReport> history,
    required List<ActivityType> activities,
    required Map<int, ReportGoal> goals,
    required List<RetreatRecord> retreats,
    List<MemoryVerse> verses = const [],
    bool startedBefore = false,
  }) {
    final first = DateTime(year);
    final last = DateTime(year, 12, 31);
    final end = today.isBefore(last) ? today : last;
    bool inYear(DateTime day) => !day.isBefore(first) && !day.isAfter(end);

    final reported = {
      for (final report in history)
        if (report.submitted || report.entries.isNotEmpty) report.date.dateOnly,
    }.where(inYear).toSet();
    final sorted = reported.toList()..sort();
    // a member who began during the year: from their first day
    final start = startedBefore || sorted.isEmpty ? first : sorted.first;
    // today, before it is filled, is not a day missed yet
    final todayWaits = end.isSameDay(today) && !reported.contains(end);
    final daysCounted = end.difference(start).inDays + 1 - (todayWaits ? 1 : 0);
    final yearHistory = [
      for (final report in history)
        if (inYear(report.date.dateOnly)) report,
    ];

    final export = ReportExport.build(
      from: start,
      to: end,
      history: yearHistory,
      activities: activities,
      goals: goals,
    );
    ExportItem? standard(StandardItem item) => export.items
        .where(
          (each) =>
              StandardItem.of(each.code, standard: !each.personal) == item,
        )
        .firstOrNull;
    int count(StandardItem item) => switch (standard(item)) {
      null => 0,
      final found when found.tracksQuantity => found.totalQuantity,
      final found => found.daysCount,
    };

    final ids = [for (final activity in activities) activity.id];
    double? goalsOf(DateTime from, DateTime to) => periodGoals(
      goals,
      itemIds: ids,
      history: yearHistory,
      from: from,
      to: to,
      today: today,
    )?.total;
    // a month, within the days counted (null: none of them)
    double? goalsOfMonth(int month) {
      final first = DateTime(year, month);
      final last = DateTime(year, month + 1, 0);
      final from = first.isBefore(start) ? start : first;
      final to = last.isAfter(end) ? end : last;
      return from.isAfter(to) ? null : goalsOf(from, to);
    }

    int versesOf(Iterable<MemoryVerse> verses) =>
        verses.fold(0, (sum, verse) => sum + verse.last - verse.first + 1);

    return YearStory(
      year: year,
      start: start,
      end: end,
      daysCounted: daysCounted < 0 ? 0 : daysCounted,
      daysFilled: reported.length,
      bestStreak: longestStreak(reported),
      monthDays: [
        for (var month = 1; month <= 12; month++)
          reported.where((day) => day.month == month).length,
      ],
      retreats: [
        for (final record in retreats)
          if (inYear(record.day.dateOnly)) record,
      ],
      prayerMinutes: standard(StandardItem.personalPrayer)?.totalMinutes ?? 0,
      chapters: count(StandardItem.bibleReading),
      versesKnown: versesOf(
        verses.where(
          (verse) => verse.knownOn != null && inYear(verse.knownOn!.dateOnly),
        ),
      ),
      versesLearning: versesOf(
        verses.where(
          (verse) => verse.knownOn == null && inYear(verse.added.dateOnly),
        ),
      ),
      fullFasts: count(StandardItem.fullFast),
      partialFasts: count(StandardItem.partialFast),
      goals: goalsOf(start, end),
      monthlyGoals: [
        for (var month = 1; month <= 12; month++) goalsOfMonth(month),
      ],
    );
  }

  final int year;

  /// 1 January, or the first day filled in by a member who began during the
  /// year.
  final DateTime start;

  /// 31 December, or today while the year goes on.
  final DateTime end;

  /// The member began during the year: "depuis le 12 octobre".
  bool get startedDuring => start != DateTime(year);

  /// The days from [start] to [end] (today only once it is filled).
  final int daysCounted;
  final int daysFilled;

  /// The longest run of days in a row in the year.
  final int bestStreak;

  /// The days filled in, month by month (12, from January).
  final List<int> monthDays;

  /// The month with the most days filled in (the first one on a tie), or
  /// null.
  ({int month, int days})? get faithfulMonth {
    ({int month, int days})? best;
    for (final (i, days) in monthDays.indexed) {
      if (days > 0 && (best == null || days > best.days)) {
        best = (month: i + 1, days: days);
      }
    }
    return best;
  }

  /// The 15-minute retreats of the year.
  final List<RetreatRecord> retreats;
  int get retreatMinutes =>
      retreats.fold(0, (sum, record) => sum + record.minutes);

  /// The retreats made at each moment of the day.
  Map<RetreatMoment, int> get momentCounts => {
    for (final moment in RetreatMoment.values)
      moment: retreats.where((record) => record.moment == moment).length,
  };

  /// The moment prayed the most often (the earliest of the day on a tie).
  ({RetreatMoment moment, int times})? get faithfulMoment {
    if (retreats.isEmpty) {
      return null;
    }
    final counts = momentCounts;
    final best = RetreatMoment.values.reduce(
      (a, b) => counts[b]! > counts[a]! ? b : a,
    );
    return (moment: best, times: counts[best]!);
  }

  /// The minutes of "Prière seule" (PS), the retreats included.
  final int prayerMinutes;

  bool get prayed => retreats.isNotEmpty || prayerMinutes > 0;

  /// The chapters of "Lecture biblique" (LB).
  final int chapters;

  /// The share of the Bible they make (1 and more: the whole Bible).
  double get bibleShare => chapters / bibleChapters;

  /// The verses learnt by heart this year (known), and those added this year
  /// that are still being learnt.
  final int versesKnown;
  final int versesLearning;

  bool get readTheWord => chapters > 0 || versesKnown > 0 || versesLearning > 0;

  /// The days of "Jeûne complet" (JC) and "Jeûne partiel" (JP).
  final int fullFasts;
  final int partialFasts;
  int get fastDays => fullFasts + partialFasts;

  /// The mean share of the goals reached (0 to 1) since [start], null
  /// without goals.
  final double? goals;

  /// The same, month by month from January (null: a month not counted).
  final List<double?> monthlyGoals;

  /// The month the goals went best, or null.
  ({int month, double goals})? get bestGoalsMonth {
    ({int month, double goals})? best;
    for (final (i, value) in monthlyGoals.indexed) {
      if (value != null && value > 0 && (best == null || value > best.goals)) {
        best = (month: i + 1, goals: value);
      }
    }
    return best;
  }
}

/// The year to show on the home screen: from 26 December to 31 January, the
/// year that ends (or just ended); null the other days.
int? storyYearAt(DateTime now) {
  if (now.month == 12 && now.day >= yearStoryFirstDay) {
    return now.year;
  }
  if (now.month == 1) {
    return now.year - 1;
  }
  return null;
}

/// The year Plus offers: in January the one just ended, then the year so far.
int latestStoryYear(DateTime now) => now.month == 1 ? now.year - 1 : now.year;

/// The day of December from which the year is told on the home screen.
const yearStoryFirstDay = 26;

/// The evening of 31 December, when the year is ready.
const yearStoryHour = 18;

/// The next 31 December at 18:00 after [now].
DateTime yearStoryTime({required DateTime now}) {
  final thisYear = DateTime(now.year, 12, 31, yearStoryHour);
  return thisYear.isAfter(now)
      ? thisYear
      : DateTime(now.year + 1, 12, 31, yearStoryHour);
}

const _payloadPrefix = 'year_story:';

/// The notification of a year: "year_story:2026".
String yearStoryPayload(int year) => '$_payloadPrefix$year';

int? yearStoryOf(String? payload) =>
    payload != null && payload.startsWith(_payloadPrefix)
    ? int.tryParse(payload.substring(_payloadPrefix.length))
    : null;
