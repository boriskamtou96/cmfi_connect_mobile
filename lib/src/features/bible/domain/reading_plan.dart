import 'bible.dart';

/// What a reading plan covers.
enum PlanScope { bible, newTestament, oldTestament, psalmsProverbs }

/// In the order of the books, or each day a passage of the Old Testament
/// and one of the New (the whole Bible only).
enum PlanOrder { canonical, parallel }

/// The 66 books (USFM codes) and their chapters, as the Protestant Bibles
/// number them (Louis Segond, KJV, WEB…): 929 + 260 = 1 189 chapters. A plan
/// is made from this list, never from a version, so it stays the same when
/// the member changes Bible.
const planBooks = <(String, int)>[
  ('GEN', 50), ('EXO', 40), ('LEV', 27), ('NUM', 36), ('DEU', 34), //
  ('JOS', 24), ('JDG', 21), ('RUT', 4), ('1SA', 31), ('2SA', 24),
  ('1KI', 22), ('2KI', 25), ('1CH', 29), ('2CH', 36), ('EZR', 10),
  ('NEH', 13), ('EST', 10), ('JOB', 42), ('PSA', 150), ('PRO', 31),
  ('ECC', 12), ('SNG', 8), ('ISA', 66), ('JER', 52), ('LAM', 5),
  ('EZK', 48), ('DAN', 12), ('HOS', 14), ('JOL', 3), ('AMO', 9),
  ('OBA', 1), ('JON', 4), ('MIC', 7), ('NAM', 3), ('HAB', 3),
  ('ZEP', 3), ('HAG', 2), ('ZEC', 14), ('MAL', 4),
  // the New Testament
  ('MAT', 28), ('MRK', 16), ('LUK', 24), ('JHN', 21), ('ACT', 28),
  ('ROM', 16), ('1CO', 16), ('2CO', 13), ('GAL', 6), ('EPH', 6),
  ('PHP', 4), ('COL', 4), ('1TH', 5), ('2TH', 3), ('1TI', 6),
  ('2TI', 4), ('TIT', 3), ('PHM', 1), ('HEB', 13), ('JAS', 5),
  ('1PE', 5), ('2PE', 3), ('1JN', 5), ('2JN', 1), ('3JN', 1),
  ('JUD', 1), ('REV', 22),
];

/// Genesis to Malachi.
const oldTestamentBooks = 39;

List<BibleRef> _chapters(Iterable<(String, int)> books) => [
  for (final (book, chapters) in books)
    for (var chapter = 1; chapter <= chapters; chapter++)
      BibleRef(book, chapter),
];

/// The chapters of [scope], in the order of the books.
List<BibleRef> scopeChapters(PlanScope scope) => switch (scope) {
  PlanScope.bible => _chapters(planBooks),
  PlanScope.oldTestament => _chapters(planBooks.take(oldTestamentBooks)),
  PlanScope.newTestament => _chapters(planBooks.skip(oldTestamentBooks)),
  PlanScope.psalmsProverbs => _chapters(
    planBooks.where((book) => book.$1 == 'PSA' || book.$1 == 'PRO'),
  ),
};

/// [chapters] shared out over [days] as evenly as possible, in order; the
/// first day always has one (a day may have none when there are fewer
/// chapters than days: the New Testament beside the Old in a year).
List<List<BibleRef>> _shared(List<BibleRef> chapters, int days) {
  int from(int day) => (day * chapters.length + days - 1) ~/ days;
  return [
    for (var day = 0; day < days; day++)
      chapters.sublist(from(day), from(day + 1)),
  ];
}

/// A reading plan the member made: what, in which order, over how many days,
/// from when; and the daily reminder.
class ReadingPlan {
  const ReadingPlan({
    required this.scope,
    required this.order,
    required this.days,
    required this.start,
    this.reminder = true,
    this.reminderMinutes = 7 * 60,
  });

  factory ReadingPlan.fromJson(Map<String, dynamic> json) => ReadingPlan(
    scope: PlanScope.values.byName(json['scope'] as String),
    order: PlanOrder.values.byName(json['order'] as String),
    days: json['days'] as int,
    start: DateTime.parse(json['start'] as String),
    reminder: json['reminder'] as bool? ?? true,
    reminderMinutes: json['reminder_minutes'] as int? ?? 7 * 60,
  );

  final PlanScope scope;
  final PlanOrder order;

  /// As asked (90, 182, 365…); [schedule] has fewer when there are fewer
  /// chapters than days (Psaumes et Proverbes in a year).
  final int days;

  /// The first day, at midnight.
  final DateTime start;
  final bool reminder;
  final int reminderMinutes;

  /// Each day's chapters.
  List<List<BibleRef>> get schedule {
    final chapters = scopeChapters(scope);
    final count = days.clamp(1, chapters.length);
    if (order == PlanOrder.parallel && scope == PlanScope.bible) {
      final old = _shared(chapters.sublist(0, 929), count);
      final fresh = _shared(chapters.sublist(929), count);
      return [for (var day = 0; day < count; day++) old[day] + fresh[day]];
    }
    return _shared(chapters, count);
  }

  /// How many chapters in all.
  int get total => scopeChapters(scope).length;

  /// The last day.
  DateTime get end =>
      DateTime(start.year, start.month, start.day + schedule.length - 1);

  /// [day]'s place in the plan: 0 the first day; negative before it, past
  /// the last one after it.
  int dayOf(DateTime day) => DateTime.utc(
    day.year,
    day.month,
    day.day,
  ).difference(DateTime.utc(start.year, start.month, start.day)).inDays;

  ReadingPlan copyWith({bool? reminder, int? reminderMinutes}) => ReadingPlan(
    scope: scope,
    order: order,
    days: days,
    start: start,
    reminder: reminder ?? this.reminder,
    reminderMinutes: reminderMinutes ?? this.reminderMinutes,
  );

  Map<String, dynamic> toJson() => {
    'scope': scope.name,
    'order': order.name,
    'days': days,
    'start': start.toIso8601String().substring(0, 10),
    'reminder': reminder,
    'reminder_minutes': reminderMinutes,
  };
}

/// "Genèse 4–6 · Matthieu 2": [chapters] grouped by book, a dash for those
/// that follow one another; [nameOf] gives a book's name in the Bible read.
String readingLabel(
  List<BibleRef> chapters,
  String Function(String book) nameOf,
) {
  final parts = <String>[];
  var i = 0;
  while (i < chapters.length) {
    final book = chapters[i].book;
    final numbers = <int>[];
    while (i < chapters.length && chapters[i].book == book) {
      numbers.add(chapters[i].chapter);
      i++;
    }
    final runs = <String>[];
    var first = numbers.first;
    var last = first;
    for (final number in numbers.skip(1)) {
      if (number == last + 1) {
        last = number;
        continue;
      }
      runs.add(first == last ? '$first' : '$first–$last');
      first = last = number;
    }
    runs.add(first == last ? '$first' : '$first–$last');
    parts.add('${nameOf(book)} ${runs.join(', ')}');
  }
  return parts.join(' · ');
}
