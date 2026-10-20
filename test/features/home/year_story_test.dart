import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/bible/domain/memory_verse.dart';
import 'package:cmfi_connect/src/features/home/domain/year_story.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_goal.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

ReportEntry _lb(int chapters) => ReportEntry(
  activityTypeId: 1,
  code: 'LB',
  label: 'Lecture biblique',
  tracksQuantity: true,
  quantityUnit: 'chapitres',
  quantity: chapters,
);

ReportEntry _ps(int minutes) => ReportEntry(
  activityTypeId: 2,
  code: 'PS',
  label: 'Prière seule',
  tracksDuration: true,
  durationMinutes: minutes,
);

ReportEntry _fast(String code, int id) => ReportEntry(
  activityTypeId: id,
  code: code,
  label: code,
  tracksQuantity: true,
  quantityUnit: 'Nombre de fois',
  quantity: 1,
);

DailyReport _day(DateTime date, List<ReportEntry> entries) =>
    DailyReport(date: date, submitted: true, entries: entries);

const _activities = [
  ...sampleActivities,
  ActivityType(
    id: 5,
    code: 'JC',
    label: 'Jeûne complet',
    tracksQuantity: true,
    quantityUnit: 'Nombre de fois',
    isStandard: true,
  ),
  ActivityType(
    id: 6,
    code: 'JP',
    label: 'Jeûne partiel',
    tracksQuantity: true,
    quantityUnit: 'Nombre de fois',
    isStandard: true,
  ),
];

MemoryVerse _verse(int first, int last, DateTime added, {DateTime? known}) =>
    MemoryVerse(
      book: 'JHN',
      chapter: 3,
      first: first,
      last: last,
      label: 'Jean 3:$first',
      text: 'Car Dieu a tant aimé le monde',
      version: 'LSG',
      added: added,
      due: added,
      knownOn: known,
    );

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('the year told', () {
    // a member who began on 12 October 2026
    final history = [
      // October: 18 days (not the 20th and 21st)
      for (var day = 12; day <= 31; day++)
        if (day != 20 && day != 21)
          _day(DateTime(2026, 10, day), [_lb(3), _ps(60)]),
      // November: every day, three of them fasting
      for (var day = 1; day <= 30; day++)
        _day(DateTime(2026, 11, day), [
          _lb(3),
          if (day == 6) _fast('JC', 5),
          if (day == 13 || day == 20) _fast('JP', 6),
        ]),
      // December: the first 10 days
      for (var day = 1; day <= 10; day++)
        _day(DateTime(2026, 12, day), [_lb(3)]),
      // the year before and the year after are not told
      _day(DateTime(2025, 12, 31), [_lb(50)]),
      _day(DateTime(2027, 1, 2), [_lb(50)]),
    ];
    YearStory build({
      DateTime? today,
      bool startedBefore = false,
      List<RetreatRecord> retreats = const [],
      List<MemoryVerse> verses = const [],
    }) => YearStory.build(
      year: 2026,
      today: today ?? DateTime(2027, 1, 15),
      history: history,
      activities: _activities,
      goals: const {1: ReportGoal(quantity: 3)},
      retreats: retreats,
      verses: verses,
      startedBefore: startedBefore,
    );

    test('from the first day filled in, for a member who began', () {
      final story = build();

      expect(story.start, DateTime(2026, 10, 12));
      expect(story.startedDuring, isTrue);
      expect(story.end, DateTime(2026, 12, 31));
      // 12 October to 31 December
      expect(story.daysCounted, 81);
      expect(story.daysFilled, 58);
      // 22 October to 10 December
      expect(story.bestStreak, 50);
      expect(story.monthDays.sublist(9), [18, 30, 10]);
      expect(story.monthDays.take(9), everyElement(0));
      expect(story.faithfulMonth, (month: 11, days: 30));
    });

    test('from 1 January when the member was there before', () {
      final story = build(startedBefore: true);

      expect(story.start, DateTime(2026));
      expect(story.startedDuring, isFalse);
      expect(story.daysCounted, 365);
    });

    test('the year going on stops today, not filled yet', () {
      final story = build(today: DateTime(2026, 12, 11));

      expect(story.end, DateTime(2026, 12, 11));
      // 12 October to 10 December: today is not a day missed yet
      expect(story.daysCounted, 60);
    });

    test('the prayer: the retreats of the year, the hours of PS', () {
      final story = build(
        retreats: [
          RetreatRecord(
            day: DateTime(2026, 10, 12),
            moment: RetreatMoment.noon,
          ),
          RetreatRecord(
            day: DateTime(2026, 10, 13),
            moment: RetreatMoment.noon,
          ),
          RetreatRecord(
            day: DateTime(2026, 11, 2),
            moment: RetreatMoment.morning,
          ),
          // another year
          RetreatRecord(
            day: DateTime(2025, 12, 30),
            moment: RetreatMoment.night,
          ),
        ],
      );

      expect(story.retreats, hasLength(3));
      expect(story.retreatMinutes, 45);
      expect(story.momentCounts[RetreatMoment.noon], 2);
      expect(story.faithfulMoment, (moment: RetreatMoment.noon, times: 2));
      // an hour each day of October
      expect(story.prayerMinutes, 18 * 60);
      expect(story.prayed, isTrue);
    });

    test('the Word: the chapters, their share of the Bible, the verses', () {
      final story = build(
        verses: [
          // two verses known this year, one still learnt
          _verse(16, 17, DateTime(2026, 11, 2), known: DateTime(2026, 12, 1)),
          _verse(1, 1, DateTime(2026, 12, 5, 9, 30)),
          // learnt the year before
          _verse(3, 3, DateTime(2025, 3, 1), known: DateTime(2025, 4, 1)),
        ],
      );

      expect(bibleChapters, 1189);
      expect(story.chapters, 58 * 3);
      expect(story.bibleShare, closeTo(174 / 1189, 0.0001));
      expect(story.versesKnown, 2);
      expect(story.versesLearning, 1);
      expect(story.readTheWord, isTrue);
    });

    test('the days of fasting, complete and partial', () {
      final story = build();

      expect(story.fullFasts, 1);
      expect(story.partialFasts, 2);
      expect(story.fastDays, 3);
    });

    test('the goals: the mean since the start, month by month', () {
      final story = build();

      expect(story.goals, closeTo(58 / 81, 0.001));
      expect(story.monthlyGoals.take(9), everyElement(isNull));
      expect(story.monthlyGoals[9], closeTo(18 / 20, 0.001));
      expect(story.monthlyGoals[10], 1);
      expect(story.monthlyGoals[11], closeTo(10 / 31, 0.001));
      expect(story.bestGoalsMonth, (month: 11, goals: 1.0));
    });

    test('an empty year has nothing to tell', () {
      final story = YearStory.build(
        year: 2026,
        today: DateTime(2026, 10, 20),
        history: const [],
        activities: _activities,
        goals: const {},
        retreats: const [],
      );

      expect(story.daysFilled, 0);
      expect(story.prayed, isFalse);
      expect(story.readTheWord, isFalse);
      expect(story.fastDays, 0);
      expect(story.goals, isNull);
      expect(story.faithfulMonth, isNull);
    });
  });

  group('when it is told', () {
    test('on the home screen from 26 December to the end of January', () {
      expect(storyYearAt(DateTime(2026, 12, 25, 23)), isNull);
      expect(storyYearAt(DateTime(2026, 12, 26)), 2026);
      expect(storyYearAt(DateTime(2027, 1, 31, 22)), 2026);
      expect(storyYearAt(DateTime(2027, 2)), isNull);
    });

    test('in Plus all year long, the year just ended in January', () {
      expect(latestStoryYear(DateTime(2026, 10, 20)), 2026);
      expect(latestStoryYear(DateTime(2027, 1, 10)), 2026);
      expect(latestStoryYear(DateTime(2027, 2)), 2027);
    });

    test('a notification on 31 December at 18:00', () {
      expect(
        yearStoryTime(now: DateTime(2026, 10, 20)),
        DateTime(2026, 12, 31, 18),
      );
      // this year's has gone: next year's
      expect(
        yearStoryTime(now: DateTime(2026, 12, 31, 19)),
        DateTime(2027, 12, 31, 18),
      );
      expect(yearStoryPayload(2026), 'year_story:2026');
      expect(yearStoryOf(yearStoryPayload(2026)), 2026);
      expect(yearStoryOf('week_story:2026-10-12'), isNull);
    });
  });

  group('the screen', () {
    // last year, whole: the screen reads the clock
    final year = today().year - 1;
    final days = [
      for (var day = 12; day <= 18; day++) DateTime(year, 10, day),
      for (var day = 1; day <= 5; day++) DateTime(year, 11, day),
    ];
    Map<DateTime, DailyReport> reportDays({bool prayer = true}) => {
      for (final (i, day) in days.indexed)
        day: _day(day, [_lb(3), if (prayer && i.isEven) _ps(30)]),
    };

    Future<TestApp> openStory(
      WidgetTester tester, {
      bool prayer = true,
      bool goals = true,
    }) async {
      final app = await pumpApp(
        tester,
        token: 't',
        reportDays: reportDays(prayer: prayer),
        prayerApi: FakePrayerApi()
          ..retreatList.addAll([
            if (prayer) ...[
              RetreatRecord(day: days[0], moment: RetreatMoment.noon),
              RetreatRecord(day: days[1], moment: RetreatMoment.noon),
              RetreatRecord(day: days[1], moment: RetreatMoment.night),
            ],
          ]),
        initialPreferences: {
          if (goals)
            'report_goals': jsonEncode({
              '1': {'quantity': 3},
            }),
        },
      );
      app.container
          .read(appRouterProvider)
          .push(YearStoryRoute(year: year))
          .ignore();
      // the pages run by themselves: no pumpAndSettle
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      return app;
    }

    Future<void> next(WidgetTester tester) async {
      await tester.tapAt(const Offset(330, 420));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
    }

    testWidgets('page by page: the year, the days, the prayer, the Word', (
      tester,
    ) async {
      await openStory(tester);

      expect(find.text('$year'), findsOneWidget);
      expect(find.text('Ton année avec Dieu'), findsOneWidget);
      expect(find.text('Depuis le 12 octobre'), findsOneWidget);

      await next(tester);
      expect(find.text('Tu as été fidèle'), findsOneWidget);
      // 12 October to 31 December
      expect(find.text('12 jours\nsur 81'), findsOneWidget);
      expect(
        find.text('Ta plus longue série : 7 jours d\'affilée'),
        findsOneWidget,
      );
      expect(
        find.text('Ton mois le plus fidèle : octobre (7\u00a0jours)'),
        findsOneWidget,
      );

      await next(tester);
      expect(find.text('3 retraites'), findsOneWidget);
      // the duration keeps its order in Arabic (isolated)
      expect(find.text('\u20663 h\u2069 de prière seule'), findsOneWidget);
      expect(
        find.text('Ton moment le plus fidèle : Midi (2\u00a0fois)'),
        findsOneWidget,
      );

      await next(tester);
      expect(find.text('Tu as lu la Parole'), findsOneWidget);
      expect(find.text('36 chapitres'), findsOneWidget);

      // no fast this year: straight to the goals
      await next(tester);
      expect(find.text('Tes objectifs'), findsOneWidget);

      await next(tester);
      expect(find.text('Mon année avec Dieu'), findsOneWidget);
      expect(find.text('12/81'), findsOneWidget);

      // on the left: back
      await tester.tapAt(const Offset(40, 420));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Tes objectifs'), findsOneWidget);
    });

    testWidgets('a page goes on by itself', (tester) async {
      await openStory(tester);

      await tester.pump(const Duration(seconds: 9));
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Tu as été fidèle'), findsOneWidget);
    });

    testWidgets('a page without anything to tell is left out', (tester) async {
      await openStory(tester, prayer: false, goals: false);

      await next(tester);
      expect(find.text('Tu as été fidèle'), findsOneWidget);
      await next(tester);
      expect(find.text('Tu as lu la Parole'), findsOneWidget);
      await next(tester);
      expect(find.text('Mon année avec Dieu'), findsOneWidget);
      expect(find.text('Tu as prié'), findsNothing);
    });

    testWidgets('the page is shared as an image', (tester) async {
      final app = await openStory(tester);

      await tester.tap(find.text('Partager mon année'));
      await tester.runAsync(() async {
        for (var i = 0; i < 50 && app.share.files.isEmpty; i++) {
          await Future<void>.delayed(const Duration(milliseconds: 20));
        }
      });
      await tester.pump();

      expect(app.share.files.single.mimeType, 'image/png');
      expect(app.share.files.single.name, 'mon-annee-avec-dieu-$year.png');
    });

    testWidgets('the year so far opens from Plus', (tester) async {
      final now = DateTime.now();
      final shown = latestStoryYear(now);
      await pumpApp(tester, token: 't');
      await openMore(tester);

      final row = find.text('Mon année avec Dieu');
      await tester.scrollUntilVisible(row, 200);
      await tester.ensureVisible(row);
      await tester.pumpAndSettle();
      expect(
        find.text(
          shown < now.year ? "Toute l'année $shown" : "$shown jusqu'ici",
        ),
        findsOneWidget,
      );

      await tester.tap(row);
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(find.text('$shown'), findsOneWidget);
      expect(find.text('Ton année avec Dieu'), findsOneWidget);
    });

    testWidgets('the notification of 31 December is planned, and opens the '
        'year', (tester) async {
      final notifications = FakeLocalNotifications(
        launchedWith: yearStoryPayload(year),
      );
      await pumpApp(
        tester,
        token: 't',
        notifications: notifications,
        reportDays: reportDays(),
      );
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }

      final planned = notifications.groups[NotificationGroup.yearStory]!;
      expect(planned, hasLength(1));
      expect(planned.single.at.month, 12);
      expect(planned.single.at.day, 31);
      expect(planned.single.at.hour, 18);
      expect(planned.single.title, 'Ton année avec Dieu est prête');
      expect(planned.single.payload, yearStoryPayload(planned.single.at.year));
      // last year's story
      expect(find.text('$year'), findsOneWidget);
      expect(find.text('Depuis le 12 octobre'), findsOneWidget);
    });
  });
}
