import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/reports/application/report_files.dart';
import 'package:cmfi_connect/src/features/reports/application/report_reminder.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_export.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_goal.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_streak.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/fakes.dart';

DailyReport day(
  int d, {
  int? lb,
  int? ps,
  String? note,
  ({int? q, int? m})? rqdqa,
}) => DailyReport(
  date: DateTime(2026, 10, d),
  submitted: true,
  note: note,
  entries: [
    if (lb != null)
      ReportEntry(
        activityTypeId: 1,
        code: 'LB',
        label: 'Lecture biblique',
        quantityUnit: 'chapitres',
        quantity: lb,
      ),
    if (ps != null)
      ReportEntry(
        activityTypeId: 2,
        code: 'PS',
        label: 'Prière seule',
        durationMinutes: ps,
      ),
    if (rqdqa != null)
      ReportEntry(
        activityTypeId: 30,
        code: 'RQDQA',
        label: 'RQDQA',
        quantityUnit: 'Nombre de fois',
        quantity: rqdqa.q,
        durationMinutes: rqdqa.m,
      ),
  ],
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(initializeDateFormatting);
  final t = AppLocale.fr.buildSync();

  group('streak', () {
    final today = DateTime(2026, 10, 9);

    test('counts the days in a row up to today', () {
      final days = [for (var d = 5; d <= 9; d++) DateTime(2026, 10, d)];
      expect(currentStreak(days, today), 5);
    });

    test('today not filled yet does not break it', () {
      final days = [for (var d = 5; d <= 8; d++) DateTime(2026, 10, d)];
      expect(currentStreak(days, today), 4);
    });

    test('a missed day ends it', () {
      expect(
        currentStreak([DateTime(2026, 10, 9), DateTime(2026, 10, 7)], today),
        1,
      );
      expect(currentStreak([DateTime(2026, 10, 7)], today), 0);
    });

    test('goes through the start of the month', () {
      final days = [
        DateTime(2026, 9, 29),
        DateTime(2026, 9, 30),
        DateTime(2026, 10, 1),
      ];
      expect(currentStreak(days, DateTime(2026, 10, 1)), 3);
    });
  });

  group('goal', () {
    const both = ReportGoal(quantity: 2, minutes: 30);

    test('progress counts each target for half', () {
      expect(both.progress(quantity: 2, minutes: 15), 0.75);
      expect(both.progress(quantity: 4, minutes: 60), 1);
      expect(both.reachedBy(quantity: 2, minutes: 29), isFalse);
      expect(both.reachedBy(quantity: 2, minutes: 30), isTrue);
    });

    test('an empty goal is never reached', () {
      expect(const ReportGoal().isEmpty, isTrue);
      expect(const ReportGoal(quantity: 0).isEmpty, isTrue);
      expect(const ReportGoal().reachedBy(quantity: 5), isFalse);
    });

    test('days reached in a history', () {
      const goal = ReportGoal(quantity: 3);
      final history = [day(1, lb: 3), day(2, lb: 1), day(3, lb: 5), day(4)];
      expect(goal.daysReached(history, 1), 2);
    });

    const goals = {1: ReportGoal(quantity: 4), 2: ReportGoal(minutes: 30)};

    test('the goals of a day: the mean of the items with a goal', () {
      final result = dayGoals(goals, day(1, lb: 2, ps: 30).entries)!;
      expect(result.progress, 0.75);
      expect(result.reached, 1);
      expect(result.total, 2);
    });

    test('an item left empty counts 0, an item without goal not at all', () {
      final entries = [
        ...day(1, lb: 4).entries,
        // in the form but not filled in
        const ReportEntry(activityTypeId: 2, code: 'PS', label: 'Prière seule'),
        const ReportEntry(
          activityTypeId: 9,
          code: 'EV',
          label: 'Évangélisation',
          quantity: 1,
        ),
      ];
      final result = dayGoals(goals, entries)!;
      expect(result.progress, 0.5);
      expect(result.total, 2);
      expect(dayGoals(const {}, entries), isNull);
    });

    test('the goals of a period count every day, today once filled', () {
      final history = [day(5, lb: 4, ps: 30), day(6, lb: 2)];
      // 5, 6, 7 (no report) and 8 (today, not filled): three days count
      final result = periodGoals(
        goals,
        itemIds: [1, 2],
        history: history,
        from: DateTime(2026, 10, 5),
        to: DateTime(2026, 10, 8),
        today: DateTime(2026, 10, 8),
      )!;
      expect(result.byItem[1], closeTo((1 + 0.5 + 0) / 3, 1e-9));
      expect(result.byItem[2], closeTo(1 / 3, 1e-9));
      expect(result.total, closeTo((0.5 + 1 / 3) / 2, 1e-9));

      // today filled in: it counts
      final withToday = periodGoals(
        goals,
        itemIds: [1, 2],
        history: [...history, day(8, lb: 4, ps: 30)],
        from: DateTime(2026, 10, 5),
        to: DateTime(2026, 10, 8),
        today: DateTime(2026, 10, 8),
      )!;
      expect(withToday.byItem[1], closeTo(2.5 / 4, 1e-9));
    });

    test('no goal, or only today not filled: no percentage', () {
      expect(
        periodGoals(
          const {},
          itemIds: [1],
          history: const [],
          from: DateTime(2026, 10, 5),
          to: DateTime(2026, 10, 8),
          today: DateTime(2026, 10, 8),
        ),
        isNull,
      );
      expect(
        periodGoals(
          goals,
          itemIds: [1],
          history: const [],
          from: DateTime(2026, 10, 8),
          to: DateTime(2026, 10, 8),
          today: DateTime(2026, 10, 8),
        ),
        isNull,
      );
    });
  });

  group('reminder times', () {
    test('two weeks of evenings, today included before the time', () {
      final times = reminderTimes(
        now: DateTime(2026, 10, 9, 18),
        time: const TimeOfDay(hour: 20, minute: 30),
        todayDone: false,
      );
      expect(times, hasLength(14));
      expect(times.first, DateTime(2026, 10, 9, 20, 30));
      expect(times.last, DateTime(2026, 10, 22, 20, 30));
    });

    test('not today once filled in, or once the time is past', () {
      final done = reminderTimes(
        now: DateTime(2026, 10, 9, 18),
        time: const TimeOfDay(hour: 20, minute: 0),
        todayDone: true,
      );
      expect(done.first, DateTime(2026, 10, 10, 20));
      expect(done, hasLength(13));

      final late = reminderTimes(
        now: DateTime(2026, 10, 9, 21),
        time: const TimeOfDay(hour: 20, minute: 0),
        todayDone: false,
      );
      expect(late.first, DateTime(2026, 10, 10, 20));
    });
  });

  group('export', () {
    final export = ReportExport.build(
      from: DateTime(2026, 10),
      to: DateTime(2026, 10, 5),
      history: [
        day(1, lb: 3, ps: 60, note: 'Psaume 23; "le berger"'),
        day(2, lb: 1),
        day(4, rqdqa: (q: 2, m: 30)),
      ],
      activities: sampleActivities,
      goals: const {1: ReportGoal(quantity: 3)},
    );

    test('totals per item, goals, and days', () {
      expect(export.daysInRange, 5);
      expect(export.daysReported, 3);
      final lb = export.items.firstWhere((item) => item.code == 'LB');
      expect(lb.totalQuantity, 4);
      expect(lb.daysCount, 2);
      expect(lb.goalDays, 1);
      final ps = export.items.firstWhere((item) => item.code == 'PS');
      expect(ps.totalMinutes, 60);
      expect(export.filledItems.map((item) => item.code), [
        'LB',
        'PS',
        'RQDQA',
      ]);
    });

    test('an archived item that has values is still exported', () {
      final withArchived = ReportExport.build(
        from: DateTime(2026, 10),
        to: DateTime(2026, 10, 5),
        history: [day(1, lb: 3)],
        activities: sampleActivities.where((a) => a.id != 1).toList(),
      );
      final lb = withArchived.items.last;
      expect(lb.code, 'LB');
      expect(lb.tracksQuantity, isTrue);
      expect(lb.personal, isTrue);
    });

    test('the message lists the filled items', () {
      final text = reportAsText(
        export,
        t: t,
        locale: 'fr',
        owner: (name: 'Boris Kamtou', church: null),
      );
      expect(text, startsWith('*Compte rendu · Boris Kamtou*'));
      expect(text, contains('Du 1 au 5 octobre 2026'));
      expect(text, contains('Régularité : 3 jours remplis sur 5'));
      expect(text, contains('• LB Lecture biblique : 4 chapitres (2 jours)'));
      expect(text, contains('objectif atteint 1 jour sur 5'));
      expect(text, contains('• RQDQA : 2 fois · 30 min (1 jour)'));
    });

    test('the spreadsheet has one line per day and one column per measure', () {
      final bytes = reportAsCsv(export, t: t, locale: 'fr');
      // the UTF-8 BOM, for Excel (utf8.decode drops it)
      expect(bytes.sublist(0, 3), [0xEF, 0xBB, 0xBF]);
      final lines = utf8.decode(bytes).trim().split('\r\n');
      expect(
        lines.first,
        'Date;Compte rendu;LB – Lecture biblique (chapitres);'
        'PS – Prière seule (min);RQDQA – RQDQA (fois);RQDQA – RQDQA (min);Note',
      );
      expect(lines, hasLength(6));
      // the note has the separator and quotes: it is quoted
      expect(lines[1], '2026-10-01;oui;3;60;;;"Psaume 23; ""le berger"""');
      expect(lines[3], '2026-10-03;non;;;;;');
      expect(lines[4], '2026-10-04;oui;;;2;30;');
    });

    test('English uses commas', () {
      final csv = utf8.decode(
        reportAsCsv(export, t: AppLocale.en.buildSync(), locale: 'en'),
      );
      expect(csv, contains('Date,Report,'));
    });

    test('the PDF is a real document', () async {
      final bytes = await reportAsPdf(
        export,
        t: t,
        locale: 'fr',
        owner: (name: 'Boris Kamtou', church: 'PSU-Yaoundé'),
      );
      expect(ascii.decode(bytes.sublist(0, 5)), '%PDF-');
      expect(bytes.length, greaterThan(5000));
    });
  });
}
