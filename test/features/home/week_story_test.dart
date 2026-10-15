import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/home/domain/week_story.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_goal.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

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

DailyReport _day(DateTime date, List<ReportEntry> entries) =>
    DailyReport(date: date, submitted: true, entries: entries);

DateTime _d(int day) => DateTime(2026, 10, day);

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('the week told', () {
    // Monday 12 to Sunday 18 October 2026
    final monday = _d(12);
    final history = [
      // a run of 9 days in September, the record before this week
      for (var i = 1; i <= 9; i++) _day(DateTime(2026, 9, i), [_lb(1)]),
      // the week: 6 days of 7 (not Wednesday), and the days before it
      _day(_d(10), [_lb(2)]),
      _day(_d(11), [_lb(2)]),
      _day(_d(12), [_lb(3), _ps(60)]),
      _day(_d(13), [_lb(5), _ps(30)]),
      _day(_d(15), [_lb(4)]),
      _day(_d(16), [_lb(4), _ps(60)]),
      _day(_d(17), [_lb(4)]),
      _day(_d(18), [_lb(4), _ps(30)]),
    ];
    WeekStory build({
      DateTime? today,
      List<RetreatRecord> retreats = const [],
    }) => WeekStory.build(
      monday: monday,
      today: today ?? _d(25),
      history: history,
      activities: sampleActivities,
      goals: const {1: ReportGoal(quantity: 4), 2: ReportGoal(minutes: 60)},
      retreats: retreats,
    );

    test('the days filled, the streak, and the items most kept first', () {
      final story = build();

      expect(story.daysInWeek, 7);
      expect(story.daysFilled, 6);
      // Thursday to Sunday
      expect(story.streak, 4);
      expect(story.bestStreak, 9);
      expect(story.streakIsRecord, isFalse);
      expect([for (final item in story.items) item.code], ['LB', 'PS']);
      expect(story.items.first.totalQuantity, 24);
      expect(story.items.last.totalMinutes, 180);
    });

    test('the week going on stops today', () {
      final story = build(today: _d(15));

      expect(story.end, _d(15));
      expect(story.daysInWeek, 4);
      expect(story.daysFilled, 3);
      expect(story.dailyGoals, hasLength(4));
    });

    test('the goals: the mean of the week, and the best day', () {
      final story = build();

      // a day: LB toward 4 chapters and PS toward an hour, the mean of both
      expect(story.dailyGoals.first, closeTo((3 / 4 + 1) / 2, 0.001));
      expect(story.dailyGoals[2], 0);
      expect(story.bestDay?.day, _d(16));
      expect(story.goals, greaterThan(0));
    });

    test('the retreats, and the moment prayed the most', () {
      final story = build(
        retreats: [
          RetreatRecord(day: _d(12), moment: RetreatMoment.noon),
          RetreatRecord(day: _d(13), moment: RetreatMoment.noon),
          RetreatRecord(day: _d(13), moment: RetreatMoment.morning),
          // another week
          RetreatRecord(day: _d(20), moment: RetreatMoment.night),
        ],
      );

      expect(story.retreats, hasLength(3));
      expect(story.retreatMinutes, 45);
      expect(story.faithfulMoment?.moment, RetreatMoment.noon);
      expect(story.faithfulMoment?.times, 2);
      expect(story.prayed(_d(13), RetreatMoment.morning), isTrue);
      expect(story.prayed(_d(14), RetreatMoment.morning), isFalse);
    });

    test('the longest run of days', () {
      expect(longestStreak([]), 0);
      expect(longestStreak([_d(1), _d(2), _d(4), _d(5), _d(6)]), 3);
    });
  });

  group('when it is told', () {
    test('on the home screen from Sunday 18:00 to Monday evening', () {
      expect(storyWeekAt(DateTime(2026, 10, 18, 17, 59)), isNull);
      expect(storyWeekAt(DateTime(2026, 10, 18, 18)), _d(12));
      expect(storyWeekAt(DateTime(2026, 10, 19, 23)), _d(12));
      expect(storyWeekAt(DateTime(2026, 10, 20, 9)), isNull);
    });

    test('a notification every Sunday at 18:00', () {
      expect(weekStoryTimes(now: DateTime(2026, 10, 14, 9), count: 2), [
        DateTime(2026, 10, 18, 18),
        DateTime(2026, 10, 25, 18),
      ]);
      // this Sunday's has gone: the next one
      expect(weekStoryTimes(now: DateTime(2026, 10, 18, 19), count: 1), [
        DateTime(2026, 10, 25, 18),
      ]);
      final payload = weekStoryPayload(DateTime(2026, 10, 18, 18));
      expect(weekStoryOf(payload), _d(12));
      expect(weekStoryOf('retreat:noon'), isNull);
    });
  });

  group('the screen', () {
    // last week, from the real date: the screen reads the clock
    final monday = DateTime(
      today().year,
      today().month,
      today().day - 7,
    ).startOfWeek;
    DateTime day(int i) => DateTime(monday.year, monday.month, monday.day + i);
    final reportDays = {
      for (final i in [0, 1, 3, 4, 5, 6])
        day(i): _day(day(i), [_lb(3 + i % 2), if (i.isEven) _ps(30)]),
    };

    Future<TestApp> openStory(WidgetTester tester, {bool goals = true}) async {
      final app = await pumpApp(
        tester,
        token: 't',
        reportDays: reportDays,
        prayerApi: FakePrayerApi()
          ..retreatList.addAll([
            RetreatRecord(day: day(0), moment: RetreatMoment.noon),
            RetreatRecord(day: day(2), moment: RetreatMoment.noon),
            RetreatRecord(day: day(2), moment: RetreatMoment.night),
          ]),
        initialPreferences: {
          if (goals)
            'report_goals': jsonEncode({
              '1': {'quantity': 4},
            }),
        },
      );
      app.container
          .read(appRouterProvider)
          .push(WeekStoryRoute(monday: monday.toApiDate()))
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

    testWidgets('page by page: the days, the items, the retreats, the goals', (
      tester,
    ) async {
      await openStory(tester);

      expect(find.text('Ta semaine avec Dieu'), findsOneWidget);
      expect(find.textContaining('Revois ce que tu as vécu'), findsOneWidget);

      await next(tester);
      expect(find.text('Tu as été fidèle'), findsOneWidget);
      expect(find.text('6 jours\nsur 7'), findsOneWidget);
      expect(find.text('#1'), findsOneWidget);
      expect(find.text('Lecture biblique'), findsOneWidget);

      await next(tester);
      expect(find.text('3 retraites'), findsOneWidget);
      expect(
        find.text('Ton moment le plus fidèle : Midi (2 fois)'),
        findsOneWidget,
      );

      await next(tester);
      expect(find.text('Tes objectifs'), findsOneWidget);

      await next(tester);
      expect(find.text('Ma semaine avec Dieu'), findsOneWidget);

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

    testWidgets('without goals, no page for them', (tester) async {
      await openStory(tester, goals: false);

      for (var i = 0; i < 3; i++) {
        await next(tester);
      }
      expect(find.text('Tes objectifs'), findsNothing);
      expect(find.text('Ma semaine avec Dieu'), findsOneWidget);
    });

    testWidgets('the page is shared as an image', (tester) async {
      final app = await openStory(tester);

      await tester.tap(find.text('Partager ma semaine'));
      await tester.runAsync(() async {
        for (var i = 0; i < 50 && app.share.files.isEmpty; i++) {
          await Future<void>.delayed(const Duration(milliseconds: 20));
        }
      });
      await tester.pump();

      expect(app.share.files.single.mimeType, 'image/png');
      expect(
        app.share.files.single.name,
        'ma-semaine-avec-dieu-${monday.toApiDate()}.png',
      );
    });

    testWidgets('the Sunday notification is planned, and opens the week', (
      tester,
    ) async {
      final notifications = FakeLocalNotifications(
        launchedWith: weekStoryPayload(DateTime(2026, 10, 18, 18)),
      );
      await pumpApp(tester, token: 't', notifications: notifications);
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }

      final planned = notifications.groups[NotificationGroup.weekStory]!;
      expect(planned, hasLength(4));
      expect(planned.first.at.weekday, DateTime.sunday);
      expect(planned.first.at.hour, 18);
      expect(planned.first.title, 'Ta semaine avec Dieu est prête');
      // the week of 12 October
      expect(find.text('Du 12 octobre au 18 octobre'), findsOneWidget);
    });

    testWidgets('the past weeks open from the Bilan', (tester) async {
      await pumpApp(tester, token: 't', reportDays: reportDays);
      await tester.tap(find.text('Compte rendu').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bilan'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Semaine'));
      await tester.pumpAndSettle();

      final past = find.text(
        'Semaine du ${DateFormat('d MMM', 'fr').format(monday)}',
      );
      await tester.scrollUntilVisible(past, 200);
      await tester.tap(past);
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(find.textContaining('Revois ce que tu as vécu'), findsOneWidget);
    });
  });
}
