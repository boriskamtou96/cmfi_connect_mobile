import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/core/utils/stopwatch_clock.dart';
import 'package:cmfi_connect/src/features/reports/application/report_timer.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/presentation/widgets/timer_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  test('the time counted, pauses aside, and the minutes it adds', () {
    final start = DateTime(2026, 10, 19, 6);
    final timer = RunningTimer(
      activityTypeId: 2,
      code: 'PS',
      label: 'Prière seule',
      startedAt: start,
      pausedAt: start.add(const Duration(minutes: 50)),
      pausedFor: const Duration(minutes: 5),
    );
    expect(
      timer.elapsedAt(DateTime(2026, 10, 19, 9)),
      const Duration(minutes: 45),
    );
    expect(RunningTimer.minutesOf(const Duration(seconds: 20)), 1);
    expect(
      RunningTimer.minutesOf(const Duration(minutes: 44, seconds: 40)),
      45,
    );
    expect(stopwatchClock(const Duration(minutes: 3, seconds: 7)), '3:07');
    expect(
      stopwatchClock(const Duration(hours: 1, minutes: 2, seconds: 5)),
      '1:02:05',
    );
  });

  testWidgets('started from the item, shown above the tabs', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Prière seule'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Démarrer le chrono'));
    // the seconds go by: no pumpAndSettle while it runs
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));

    expect(app.container.read(reportTimerProvider)?.code, 'PS');
    expect(find.byType(TimerBanner), findsOneWidget);
    expect(find.text('Prière seule'), findsWidgets);
    // on the lock screen too, running
    final started = app.container.read(reportTimerProvider)!.startedAt;
    expect(app.lockScreen.shown?.label, 'Prière seule');
    expect(app.lockScreen.shown?.since, started);
    expect(app.lockScreen.shown?.paused, isNull);

    await tester.tap(find.byTooltip('Mettre en pause'));
    await tester.pumpAndSettle();
    expect(app.container.read(reportTimerProvider)?.paused, isTrue);
    expect(find.textContaining('En pause'), findsOneWidget);
    // still, at the time counted
    expect(app.lockScreen.shown?.paused, isNotNull);
  });

  testWidgets('« Terminer »: its minutes go to the report of the day', (
    tester,
  ) async {
    final now = DateTime.now();
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {
        // started 45 minutes ago, paused now (so the seconds don't tick)
        ReportTimer.key: jsonEncode(
          RunningTimer(
            activityTypeId: 2,
            code: 'PS',
            label: 'Prière seule',
            startedAt: now.subtract(const Duration(minutes: 45)),
            pausedAt: now,
          ).toJson(),
        ),
      },
    );

    expect(find.text('45:00 · En pause'), findsOneWidget);
    // the app opens: shown again outside it (after a restart of the phone)
    expect(app.lockScreen.shown?.paused, const Duration(minutes: 45));
    await tester.tap(find.text('Terminer'));
    await tester.pumpAndSettle();

    expect(app.container.read(reportTimerProvider), isNull);
    expect(app.lockScreen.shown, isNull);
    expect(find.byType(TimerBanner), findsOneWidget);
    expect(find.text('Terminer'), findsNothing);
    expect(app.toasts.messages, ['45 min ajoutées à « Prière seule »']);
    final entry = app.reportsApi.days[today()]!.entries.firstWhere(
      (entry) => entry.code == 'PS',
    );
    expect(entry.durationMinutes, 45);
  });

  testWidgets('the stopwatch apart: an item chosen, then its minutes saved', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Lancer un chrono'));
    await tester.pumpAndSettle();
    expect(find.text('Que veux-tu chronométrer ?'), findsOneWidget);
    // only the items counted in time
    expect(find.text('Prière seule'), findsWidgets);
    expect(
      find.descendant(
        of: find.byType(BottomSheet),
        matching: find.text('Lecture biblique'),
      ),
      findsNothing,
    );

    await tester.tap(find.text('Prière seule').last);
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('Que veux-tu chronométrer ?'), findsNothing);
    expect(app.container.read(reportTimerProvider)?.code, 'PS');

    // « Terminer »: in today's report, by itself
    await app.container.read(reportTimerProvider.notifier).pause();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Terminer'));
    await tester.pumpAndSettle();
    expect(
      app.reportsApi.days[today()]!.entries
          .firstWhere((entry) => entry.code == 'PS')
          .durationMinutes,
      1,
    );
  });

  /// A stopwatch on [code] started [minutes] ago, paused now.
  Map<String, Object> pausedTimer(
    int id,
    String code,
    String label,
    int minutes,
  ) {
    final now = DateTime.now();
    return {
      ReportTimer.key: jsonEncode(
        RunningTimer(
          activityTypeId: id,
          code: code,
          label: label,
          startedAt: now.subtract(Duration(minutes: minutes)),
          pausedAt: now,
        ).toJson(),
      ),
    };
  }

  testWidgets('« Terminer » on an item counted in times: its minutes and one '
      'more time', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      activities: [
        ...sampleActivities,
        const ActivityType(
          id: 3,
          code: 'RDQAD',
          label: 'Méditation',
          tracksQuantity: true,
          quantityUnit: 'Nombre de fois',
          tracksDuration: true,
          isStandard: true,
        ),
      ],
      initialPreferences: pausedTimer(3, 'RDQAD', 'Méditation', 20),
    );
    ReportEntry meditation() => app.reportsApi.days[today()]!.entries
        .firstWhere((entry) => entry.code == 'RDQAD');

    await tester.tap(find.text('Terminer'));
    await tester.pumpAndSettle();
    expect(meditation().quantity, 1);
    expect(meditation().durationMinutes, 20);

    // a second one: one more time
    final timer = app.container.read(reportTimerProvider.notifier);
    await timer.start(activityTypeId: 3, code: 'RDQAD', label: 'Méditation');
    await timer.pause();
    await tester.pumpAndSettle();
    await timer.finish();
    await tester.pumpAndSettle();
    expect(meditation().quantity, 2);
    expect(meditation().durationMinutes, 21);
  });

  testWidgets('« Terminer » on Lecture biblique leaves its chapters alone', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      activities: const [
        ActivityType(
          id: 1,
          code: 'LB',
          label: 'Lecture biblique',
          tracksQuantity: true,
          quantityUnit: 'chapitres',
          tracksDuration: true,
          isStandard: true,
        ),
      ],
      initialPreferences: pausedTimer(1, 'LB', 'Lecture biblique', 10),
      reportDays: {
        today(): DailyReport(
          date: today(),
          submitted: true,
          entries: const [
            ReportEntry(
              activityTypeId: 1,
              code: 'LB',
              label: 'Lecture biblique',
              tracksQuantity: true,
              quantityUnit: 'chapitres',
              tracksDuration: true,
              quantity: 3,
            ),
          ],
        ),
      },
    );

    await tester.tap(find.text('Terminer'));
    await tester.pumpAndSettle();
    final entry = app.reportsApi.days[today()]!.entries.firstWhere(
      (entry) => entry.code == 'LB',
    );
    expect(entry.quantity, 3);
    expect(entry.durationMinutes, 10);
  });
}
