import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<TestApp> openReports(WidgetTester tester) async {
    final app = await pumpApp(tester, token: 'saved-token');
    // a day already saved: 2 chapters today
    app.reportsApi.days[today()] = DailyReport(
      date: today(),
      submitted: true,
      entries: const [
        ReportEntry(
          activityTypeId: 1,
          code: 'LB',
          label: 'Lecture biblique',
          quantity: 2,
        ),
      ],
    );
    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();
    return app;
  }

  testWidgets('history shows the month and today\'s values', (tester) async {
    await openReports(tester);

    await tester.tap(find.text('Historique'));
    await tester.pumpAndSettle();

    expect(find.text('LB 2'), findsOneWidget);
    expect(find.text('Rempli'), findsOneWidget);
  });

  testWidgets('summary shows the regularity and the filled items', (
    tester,
  ) async {
    await openReports(tester);

    await tester.tap(find.text('Bilan'));
    await tester.pumpAndSettle();

    expect(find.text('RÉGULARITÉ'), findsOneWidget);
    expect(find.text('Lecture biblique'), findsOneWidget);

    await tester.tap(find.text('Semaine'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Année'));
    await tester.pumpAndSettle();

    expect(find.text('RÉGULARITÉ'), findsOneWidget);
  });

  testWidgets('create a personal item: it appears in the day', (tester) async {
    final app = await openReports(tester);

    await tester.tap(find.byTooltip('Mes éléments'));
    await tester.pumpAndSettle();
    expect(find.text('STANDARDS · POUR TOUS'), findsOneWidget);

    await tester.tap(find.text('Créer un élément').last);
    await tester.pumpAndSettle();

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'evg');
    await tester.enterText(fields.at(1), 'Évangélisation');
    await tester.enterText(fields.at(2), 'personnes');
    await tester.pump();
    await tester.tap(find.text("Créer l'élément"));
    await tester.pumpAndSettle();

    expect(app.activitiesApi.activities.last.code, 'EVG');
    expect(app.toasts.messages, ['EVG est créé.']);

    // back to the report: the new item is listed with the personal ones
    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    expect(find.text('Évangélisation'), findsOneWidget);
  });

  testWidgets('a code already used explains why', (tester) async {
    final app = await openReports(tester);

    await tester.tap(find.text('Créer un élément'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'LB');
    await tester.enterText(fields.at(1), 'Lecture');
    // the button turns on once the screen has rebuilt with both fields
    await tester.pump();
    await tester.tap(find.text("Créer l'élément"));
    await tester.pumpAndSettle();

    expect(app.toasts.errors.single, contains('Ce code est déjà utilisé'));
  });
}
