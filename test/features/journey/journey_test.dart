import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/journey/application/journey_steps.dart';
import 'package:cmfi_connect/src/features/journey/domain/journey_step.dart';
import 'package:cmfi_connect/src/features/journey/presentation/journey_screen.dart';
import 'package:cmfi_connect/src/features/prayer/application/retreats.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/reports/application/reports_providers.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  DateTime daysAgo(int n) {
    final now = today();
    return DateTime(now.year, now.month, now.day - n);
  }

  void seedDay(TestApp app, int ago) {
    final date = daysAgo(ago);
    app.reportsApi.days[date] = DailyReport(
      date: date,
      submitted: true,
      entries: const [
        ReportEntry(
          activityTypeId: 1,
          code: 'LB',
          label: 'Lecture biblique',
          quantityUnit: 'chapitres',
          quantity: 2,
        ),
      ],
    );
  }

  testWidgets('home shows the 3 steps of the day, checked as they are done', (
    tester,
  ) async {
    final prayer = FakePrayerApi();
    await pumpApp(tester, token: 't', prayerApi: prayer);

    expect(find.text('Tes 3 pas du jour'), findsOneWidget);
    expect(find.text('0 sur 3'), findsOneWidget);
    expect(find.text('Remplir mon compte rendu'), findsOneWidget);
    expect(find.text('Faire une retraite de prière'), findsOneWidget);
    expect(find.text('Lire un chapitre de la Bible'), findsOneWidget);
    expect(
      find.bySemanticsLabel('Faire une retraite de prière, Fait'),
      findsNothing,
    );
  });

  testWidgets('a step reached on the tabs: Zoé shows it, then « Mes étapes »', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');

    await app.container
        .read(journeyStepsProvider.notifier)
        .reach(JourneyStep.lyricsShared);
    await tester.pumpAndSettle();

    expect(find.text('NOUVELLE ÉTAPE'), findsOneWidget);
    expect(find.text('Un chant partagé'), findsOneWidget);

    await tester.tap(find.text('Voir mes étapes'));
    await tester.pumpAndSettle();
    expect(find.byType(JourneyScreen), findsOneWidget);
    expect(find.text('1 sur 15'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.textContaining('Atteinte le'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.textContaining('Atteinte le'), findsOneWidget);
    // the others say how to reach them
    await tester.scrollUntilVisible(
      find.text('Suivre ta première âme.'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Suivre ta première âme.'), findsOneWidget);

    // reached once only
    expect(
      await app.container
          .read(journeyStepsProvider.notifier)
          .reach(JourneyStep.lyricsShared),
      isFalse,
    );
  });

  testWidgets('reached away from the tabs: Zoé waits for the way back', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    await openProfile(tester);

    // « Mes étapes » in Mon profil, with the next one
    expect(find.text('Mes étapes'), findsOneWidget);
    expect(find.textContaining('0 sur 15'), findsOneWidget);

    await app.container
        .read(journeyStepsProvider.notifier)
        .reach(JourneyStep.firstEncouragement);
    await tester.pumpAndSettle();
    expect(find.text('NOUVELLE ÉTAPE'), findsNothing);

    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    expect(find.text('Encourageur'), findsOneWidget);

    await tester.tap(find.text('Continuer'));
    await tester.pumpAndSettle();
    expect(find.text('NOUVELLE ÉTAPE'), findsNothing);
  });

  testWidgets('the four retreats of a day: « Une journée de prière »', (
    tester,
  ) async {
    final prayer = FakePrayerApi();
    final app = await pumpApp(tester, token: 't', prayerApi: prayer);

    for (final moment in RetreatMoment.values) {
      prayer.retreatList.add(
        RetreatRecord(day: today(), moment: moment, minutes: 15),
      );
    }
    app.container.invalidate(retreatLogProvider);
    await tester.pumpAndSettle();

    expect(find.text('Une journée de prière'), findsOneWidget);
    expect(
      app.container.read(journeyStepsProvider).value,
      contains(JourneyStep.fourRetreats),
    );
  });

  testWidgets('a day missed: the streak goes on, Zoé says so once', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    // yesterday and the day before it filled, two days ago missed
    seedDay(app, 1);
    seedDay(app, 3);
    seedDay(app, 4);
    app.container.invalidate(reportHistoryProvider);
    await tester.pumpAndSettle();

    expect(find.text('Un jour de grâce'), findsOneWidget);
    await tester.tap(find.text('Merci !'));
    await tester.pumpAndSettle();
    expect(find.text('3 j'), findsOneWidget);

    // told once
    app.container.invalidate(reportHistoryProvider);
    await tester.pumpAndSettle();
    expect(find.text('Un jour de grâce'), findsNothing);
  });
}
