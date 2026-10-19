import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible.dart';
import 'package:cmfi_connect/src/features/bible/domain/reading_plan.dart';
import 'package:cmfi_connect/src/features/bible/presentation/bible_plan_screen.dart';
import 'package:cmfi_connect/src/features/bible/presentation/bible_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('a plan, day by day', () {
    final start = DateTime(2026, 10, 17);

    test('the 66 books: 929 + 260 = 1 189 chapters', () {
      expect(scopeChapters(PlanScope.bible), hasLength(1189));
      expect(scopeChapters(PlanScope.oldTestament), hasLength(929));
      expect(scopeChapters(PlanScope.newTestament), hasLength(260));
      expect(scopeChapters(PlanScope.psalmsProverbs), hasLength(181));
      expect(
        scopeChapters(PlanScope.newTestament).first,
        const BibleRef('MAT', 1),
      );
    });

    test('every chapter once, in order, evenly over the days', () {
      for (final days in [91, 182, 365, 120]) {
        final plan = ReadingPlan(
          scope: PlanScope.bible,
          order: PlanOrder.canonical,
          days: days,
          start: start,
        );
        final schedule = plan.schedule;
        expect(schedule, hasLength(days));
        expect(schedule.expand((day) => day), scopeChapters(PlanScope.bible));
        final sizes = schedule.map((day) => day.length).toSet();
        expect(
          sizes.reduce((a, b) => a > b ? a : b) -
              sizes.reduce((a, b) => a < b ? a : b),
          lessThanOrEqualTo(1),
        );
      }
    });

    test('in parallel: each day the Old Testament and the New', () {
      final plan = ReadingPlan(
        scope: PlanScope.bible,
        order: PlanOrder.parallel,
        days: 365,
        start: start,
      );
      final first = plan.schedule.first;
      expect(first.first, const BibleRef('GEN', 1));
      expect(first, contains(const BibleRef('MAT', 1)));
      expect(plan.schedule.last, contains(const BibleRef('MAL', 4)));
      expect(
        plan.schedule.reversed.firstWhere(
          (day) => day.any((c) => c.book == 'REV'),
        ),
        contains(const BibleRef('REV', 22)),
      );
      expect(plan.schedule.expand((day) => day).toSet(), hasLength(1189));
    });

    test('fewer chapters than days: as many days as chapters', () {
      final plan = ReadingPlan(
        scope: PlanScope.psalmsProverbs,
        order: PlanOrder.canonical,
        days: 365,
        start: start,
      );
      expect(plan.schedule, hasLength(181));
      expect(plan.end, DateTime(2027, 4, 15));
    });

    test('the place of a day, and the label of a reading', () {
      final plan = ReadingPlan(
        scope: PlanScope.bible,
        order: PlanOrder.canonical,
        days: 91,
        start: start,
      );
      expect(plan.dayOf(start), 0);
      expect(plan.dayOf(DateTime(2026, 10, 20, 23)), 3);
      expect(plan.dayOf(DateTime(2026, 10, 16)), -1);
      expect(
        readingLabel(const [
          BibleRef('GEN', 4),
          BibleRef('GEN', 5),
          BibleRef('GEN', 6),
          BibleRef('GEN', 8),
          BibleRef('MAT', 2),
        ], (book) => {'GEN': 'Genèse', 'MAT': 'Matthieu'}[book]!),
        'Genèse 4–6, 8 · Matthieu 2',
      );
    });
  });

  Future<TestApp> openPlan(
    WidgetTester tester, {
    Map<String, Object> preferences = const {},
  }) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {'bible_tap_hint_seen': true, ...preferences},
    );
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Bible'),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip("Plus d'options"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Plan de lecture'));
    await tester.pumpAndSettle();
    return app;
  }

  /// A plan of the whole Bible in a year (Genèse 1–4 the first day),
  /// started [daysAgo] days ago.
  Map<String, Object> planStarted(int daysAgo, {List<String> read = const []}) {
    final start = today().subtract(Duration(days: daysAgo));
    return {
      'bible_plan': jsonEncode(
        ReadingPlan(
          scope: PlanScope.bible,
          order: PlanOrder.canonical,
          days: 365,
          start: DateTime(start.year, start.month, start.day),
          reminderMinutes: 23 * 60 + 59,
        ).toJson(),
      ),
      'bible_plan_read': read,
    };
  }

  testWidgets('made in a few taps: 3 months, the New Testament', (
    tester,
  ) async {
    final app = await openPlan(tester);

    expect(find.byType(BiblePlanScreen), findsOneWidget);
    // a year of the whole Bible by default
    expect(
      find.text('1189 chapitres en 365 jours, environ 3,3 par jour'),
      findsOneWidget,
    );
    await tester.tap(find.text('3 mois'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Psaumes et Proverbes'));
    await tester.pumpAndSettle();
    expect(
      find.text('181 chapitres en 91 jours, environ 2 par jour'),
      findsOneWidget,
    );
    await tester.tap(find.text('Commencer le plan'));
    await tester.pumpAndSettle();

    expect(find.text('Jour 1 sur 91'), findsOneWidget);
    expect(find.text('0 chapitres sur 181'), findsOneWidget);
    expect(find.text('LECTURE DU JOUR'), findsOneWidget);
    expect(find.text('Psaumes'), findsOneWidget);
    expect(find.textContaining('Lire · Psaumes 1'), findsOneWidget);
    // the reminder of the coming days
    expect(app.notifications.groups[NotificationGroup.biblePlan], isNotEmpty);
  });

  testWidgets('a chapter ticked: read in the plan, counted in the report', (
    tester,
  ) async {
    final app = await openPlan(tester, preferences: planStarted(0));

    await tester.tap(find.byTooltip('Marquer Genèse 1 comme lu'));
    await tester.pumpAndSettle();

    expect(find.text('1 chapitres sur 1189'), findsOneWidget);
    expect(
      app.reportsApi.days[today()]?.entries
          .where((entry) => entry.code == 'LB')
          .firstOrNull
          ?.quantity,
      1,
    );
    expect(app.preferences.getStringList('bible_plan_read'), ['GEN.1']);
  });

  testWidgets('late: the days missed, and what is left to catch up', (
    tester,
  ) async {
    await openPlan(tester, preferences: planStarted(2, read: ['GEN.1']));

    expect(find.text('Jour 3 sur 365'), findsOneWidget);
    expect(find.textContaining('2 jours de retard'), findsOneWidget);
    // the first chapter not read yet, the late ones first
    expect(find.textContaining('Lire · Genèse 2'), findsOneWidget);
    // the chapters to catch up, in a sheet
    await tester.tap(find.textContaining('2 jours de retard'));
    await tester.pumpAndSettle();
    expect(find.text('En retard'), findsOneWidget);
    expect(find.byTooltip('Marquer Genèse 2 comme lu'), findsOneWidget);
  });

  testWidgets('"Lire" opens the chapter in the Bible tab', (tester) async {
    await openPlan(tester, preferences: planStarted(0));

    await tester.tap(find.textContaining('Lire · Genèse 1'));
    await tester.pumpAndSettle();
    expect(find.byType(BibleScreen), findsOneWidget);
    expect(find.text('Genèse 1'), findsOneWidget);
  });

  testWidgets('stopped: the plan and its reminders go', (tester) async {
    final app = await openPlan(tester, preferences: planStarted(0));

    await tester.tap(find.byTooltip("Plus d'options"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Arrêter le plan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Arrêter le plan').last);
    await tester.pumpAndSettle();

    expect(find.text('Commencer le plan'), findsWidgets);
    expect(app.preferences.getString('bible_plan'), isNull);
    expect(
      app.notifications.groups[NotificationGroup.biblePlan] ?? const [],
      isEmpty,
    );
  });

  testWidgets("today's reading on the home screen", (tester) async {
    await pumpApp(tester, token: 't', initialPreferences: planStarted(0));

    expect(find.text('Lecture du jour'), findsOneWidget);
    await scrollTo(tester, find.text('Lecture du jour'));
    await tester.tap(find.text('Lecture du jour'));
    await tester.pumpAndSettle();
    expect(find.byType(BiblePlanScreen), findsOneWidget);
  });
}
