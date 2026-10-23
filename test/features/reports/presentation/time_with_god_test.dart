import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/reports/application/day_report_controller.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_summary.dart';
import 'package:cmfi_connect/src/features/reports/domain/time_with_god.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  DailyReport prayed(DateTime date, int minutes) => DailyReport(
    date: date,
    submitted: true,
    entries: [
      ReportEntry(
        activityTypeId: 2,
        code: 'PS',
        label: 'Prière seule',
        tracksDuration: true,
        durationMinutes: minutes,
      ),
      const ReportEntry(
        activityTypeId: 1,
        code: 'LB',
        label: 'Lecture biblique',
        quantityUnit: 'chapitres',
        quantity: 3,
      ),
    ],
  );

  test('every item in minutes counts, the others not', () {
    expect(minutesOfEntries(prayed(today(), 45).entries), 45);
    expect(
      minutesOfItems(const [
        SummaryItem(
          activityTypeId: 2,
          code: 'PS',
          label: 'Prière seule',
          tracksDuration: true,
          totalMinutes: 90,
        ),
        SummaryItem(
          activityTypeId: 9,
          code: 'MIN',
          label: 'Mon élément',
          tracksDuration: true,
          totalMinutes: 30,
        ),
        SummaryItem(
          activityTypeId: 1,
          code: 'LB',
          label: 'Lecture biblique',
          tracksQuantity: true,
          totalQuantity: 12,
        ),
      ]),
      120,
    );
  });

  testWidgets('home tells the time with God of the day', (tester) async {
    await pumpApp(tester, token: 't');
    expect(
      find.text("Pas encore de temps avec Dieu noté aujourd'hui"),
      findsOneWidget,
    );
  });

  testWidgets('home: the minutes of the day, retreats included', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    app.reportsApi.days[today()] = prayed(today(), 85);
    app.container.invalidate(dayReportControllerProvider(today()));
    await tester.pumpAndSettle();

    expect(find.text("1 h 25 avec Dieu aujourd'hui"), findsOneWidget);
  });

  testWidgets('Bilan: the time of the period, a day on average, by item', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    final now = today();
    final monday = now.startOfWeek;
    app.reportsApi.days[monday] = prayed(monday, 60);
    if (now != monday) {
      app.reportsApi.days[now] = prayed(now, 30);
    }

    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bilan'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Semaine'));
    await tester.pumpAndSettle();

    final minutes = now == monday ? 60 : 90;
    expect(find.text('TEMPS AVEC DIEU'), findsOneWidget);
    expect(find.text(minutes.toDurationLabel()), findsWidgets);
    expect(find.textContaining('par jour en moyenne'), findsOneWidget);
  });
}
