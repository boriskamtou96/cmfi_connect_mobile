import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/reports/application/reports_providers.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/presentation/widgets/entry_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<void> openReports(WidgetTester tester) async {
    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();
  }

  Future<void> fillBibleReading(WidgetTester tester, String chapters) async {
    await tester.tap(find.text('Lecture biblique'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byType(EntrySheet),
        matching: find.byType(TextField),
      ),
      chapters,
    );
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();
  }

  /// A day with a report, [daysAgo] days before today.
  void seedDay(TestApp app, int daysAgo, {int chapters = 2}) {
    final now = today();
    final date = DateTime(now.year, now.month, now.day - daysAgo);
    app.reportsApi.days[date] = DailyReport(
      date: date,
      submitted: true,
      entries: [
        ReportEntry(
          activityTypeId: 1,
          code: 'LB',
          label: 'Lecture biblique',
          quantityUnit: 'chapitres',
          quantity: chapters,
        ),
      ],
    );
  }

  group('offline', () {
    testWidgets('the day waits on the phone, then leaves with the network', (
      tester,
    ) async {
      final app = await pumpApp(tester, token: 't');
      await openReports(tester);
      app.reportsApi.offline = true;
      app.activitiesApi.offline = true;

      await fillBibleReading(tester, '3');
      await tester.tap(find.text('Enregistrer la journée'));
      await tester.pumpAndSettle();

      expect(app.toasts.messages.single, contains('Pas de réseau'));
      expect(find.text('Pas encore envoyé'), findsOneWidget);
      expect(
        find.text('1 journée attend le réseau pour être envoyée'),
        findsOneWidget,
      );
      expect(app.reportsApi.saves, isEmpty);
      expect(
        app.preferences.getString('reports_pending'),
        contains('"quantity":3'),
      );

      // the network comes back
      app.reportsApi.offline = false;
      app.activitiesApi.offline = false;
      app.network.controller.add(true);
      await tester.pumpAndSettle();

      expect(app.reportsApi.saves.single.entries.single.quantity, 3);
      expect(find.textContaining('attend le réseau'), findsNothing);
      expect(find.text('Enregistré'), findsOneWidget);
      expect(app.preferences.getString('reports_pending'), '[]');
    });

    testWidgets('a day opened before can be filled in offline', (tester) async {
      final app = await pumpApp(tester, token: 't');
      await openReports(tester);
      // a fresh start without network: the copies kept on the phone are used
      app.reportsApi.offline = true;
      app.activitiesApi.offline = true;
      app.container.invalidate(activitiesProvider);
      await tester.pumpAndSettle();

      expect(find.text('Lecture biblique'), findsOneWidget);
      expect(find.text('0 sur 3 renseignés'), findsOneWidget);
    });

    testWidgets('signing out with a day not sent asks first', (tester) async {
      final app = await pumpApp(tester, token: 't');
      await openReports(tester);
      app.reportsApi.offline = true;
      await fillBibleReading(tester, '1');
      await tester.tap(find.text('Enregistrer la journée'));
      await tester.pumpAndSettle();
      // the "no network" snackbar goes away
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();

      await openMore(tester);
      await tester.pumpAndSettle();
      await scrollToEnd(tester);
      await tester.tap(find.text('Se déconnecter'));
      await tester.pumpAndSettle();

      expect(find.text('Journées pas encore envoyées'), findsOneWidget);
      await tester.tap(find.text('Annuler'));
      await tester.pumpAndSettle();
      expect(app.storage.token, 't');
    });
  });

  group('goals and streak', () {
    testWidgets(
      'a daily goal is set in "Mes éléments" and followed in the day',
      (tester) async {
        final app = await pumpApp(tester, token: 't');
        await openReports(tester);
        await tester.tap(find.byTooltip('Mes éléments'));
        await tester.pumpAndSettle();

        expect(find.text('Ajouter un objectif'), findsNWidgets(3));
        await fillBibleReading(tester, '3');
        expect(app.toasts.messages, ['Objectif enregistré']);
        expect(find.text('Objectif : 3 chapitres par jour'), findsOneWidget);
        expect(
          app.preferences.getString('report_goals'),
          '{"1":{"quantity":3}}',
        );

        await tester.tap(find.byTooltip('Retour'));
        await tester.pumpAndSettle();
        expect(find.text('Objectif : 3 chapitres'), findsOneWidget);

        await fillBibleReading(tester, '2');
        expect(find.text('Objectif : 3 chapitres'), findsOneWidget);
        expect(find.text('Objectifs de la journée'), findsOneWidget);
        expect(find.text('Atteints : 0 sur 1'), findsOneWidget);
        expect(find.text('67\u00a0%'), findsOneWidget);
        await fillBibleReading(tester, '3');
        expect(find.text('Objectif atteint'), findsOneWidget);
        expect(find.text('Atteints : 1 sur 1'), findsOneWidget);
        expect(find.text('100\u00a0%'), findsOneWidget);
      },
    );

    testWidgets('the home and the summary show how far the goals go', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        token: 't',
        initialPreferences: {'report_goals': '{"1":{"quantity":2}}'},
      );
      // yesterday reached: 2 chapters
      seedDay(app, 1);
      app.container.invalidate(reportHistoryProvider);
      await tester.pumpAndSettle();

      // today is not filled in yet
      expect(find.text('objectifs'), findsOneWidget);
      expect(find.text('0\u00a0%'), findsOneWidget);

      await openReports(tester);
      await tester.tap(find.text('Bilan'));
      await tester.pumpAndSettle();

      expect(
        find.text('Accomplissement moyen de tes objectifs'),
        findsOneWidget,
      );
    });

    testWidgets('the home screen shows the days in a row', (tester) async {
      final app = await pumpApp(tester, token: 't');
      for (final daysAgo in [1, 2, 3, 5]) {
        seedDay(app, daysAgo);
      }
      app.container.invalidate(reportHistoryProvider);
      await tester.pumpAndSettle();

      expect(find.text("3 jours d'affilée"), findsOneWidget);
      expect(find.text("Remplis aujourd'hui pour continuer"), findsOneWidget);
    });
  });

  group('reminder', () {
    testWidgets('offered after the first saved day, then planned', (
      tester,
    ) async {
      final app = await pumpApp(tester, token: 't', reminderOffered: false);
      await openReports(tester);
      await fillBibleReading(tester, '1');
      await tester.tap(find.text('Enregistrer la journée'));
      await tester.pumpAndSettle();

      expect(find.text('Un rappel chaque soir ?'), findsOneWidget);
      expect(find.text('20:00'), findsOneWidget);
      await tester.tap(find.text('Activer le rappel'));
      await tester.pumpAndSettle();

      expect(app.notifications.permissionAsked, isTrue);
      expect(app.toasts.messages.last, 'Rappel activé à 20:00');
      // today is filled in: from tomorrow, two weeks of evenings
      final planned = app.notifications.planned;
      expect(planned, hasLength(13));
      final now = today();
      expect(planned.first.at, DateTime(now.year, now.month, now.day + 1, 20));
      expect(planned.first.title, 'Ton compte rendu du jour');
      expect(app.preferences.getBool('reminder_enabled'), isTrue);
    });

    testWidgets('refused notifications: said, and the reminder stays off', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        token: 't',
        reminderOffered: false,
        notifications: FakeLocalNotifications(granted: false),
      );
      await openReports(tester);
      await fillBibleReading(tester, '1');
      await tester.tap(find.text('Enregistrer la journée'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Activer le rappel'));
      await tester.pumpAndSettle();

      expect(
        app.toasts.errors.single,
        contains('Les notifications sont bloquées'),
      );
      expect(app.notifications.planned, isEmpty);
      expect(app.preferences.getBool('reminder_enabled'), isNot(true));
    });

    testWidgets('turned off in Plus: nothing planned any more', (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        initialPreferences: {'reminder_enabled': true, 'reminder_time': 1290},
      );
      // planned again at start: 21:30
      expect(app.notifications.planned.last.at.hour, 21);
      expect(app.notifications.planned.last.at.minute, 30);

      await openMore(tester);
      await tester.pumpAndSettle();
      await scrollToEnd(tester);
      expect(find.text('21:30'), findsOneWidget);
      await tester.tap(find.text('Rappel du soir'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(app.notifications.planned, isEmpty);
      expect(app.preferences.getBool('reminder_enabled'), isFalse);
    });

    testWidgets(
      'on iPhone the time turns on the iOS wheel, in 24 hours',
      (tester) async {
        final app = await pumpApp(
          tester,
          token: 't',
          initialPreferences: {'reminder_enabled': true, 'reminder_time': 1290},
        );
        await openMore(tester);
        await tester.pumpAndSettle();
        await scrollToEnd(tester);
        await tester.tap(find.text('Rappel du soir'));
        await tester.pumpAndSettle();
        // the time row of the sheet (Plus shows it too, behind)
        await tester.tap(find.text('21:30').last);
        await tester.pumpAndSettle();

        final wheel = find.byType(CupertinoDatePicker);
        expect(wheel, findsOneWidget);
        expect(tester.widget<CupertinoDatePicker>(wheel).use24hFormat, isTrue);
        tester
            .widget<CupertinoDatePicker>(wheel)
            .onDateTimeChanged(DateTime(2000, 1, 1, 20, 45));
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        expect(app.preferences.getInt('reminder_time'), 20 * 60 + 45);
        expect(app.notifications.planned.last.at.hour, 20);
        expect(app.notifications.planned.last.at.minute, 45);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.iOS),
    );

    testWidgets("a tapped reminder opens the day's report", (tester) async {
      final app = await pumpApp(tester, token: 't');
      expect(find.text('Enregistrer la journée'), findsNothing);

      app.notifications.tapsController.add('report_today');
      await tester.pumpAndSettle();

      expect(find.text('Enregistrer la journée'), findsOneWidget);
    });

    testWidgets('a reminder that launched the app opens the day too', (
      tester,
    ) async {
      await pumpApp(
        tester,
        token: 't',
        notifications: FakeLocalNotifications(launchedWith: 'report_today'),
      );
      await tester.pumpAndSettle();

      expect(find.text('Enregistrer la journée'), findsOneWidget);
    });
  });

  group('export and share', () {
    Future<TestApp> openExport(WidgetTester tester) async {
      final app = await pumpApp(tester, token: 't');
      seedDay(app, 0, chapters: 4);
      app.container.invalidate(reportHistoryProvider);
      await openMore(tester);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Exporter mon compte rendu'),
        200,
      );
      await tester.tap(find.text('Exporter mon compte rendu'));
      await tester.pumpAndSettle();
      return app;
    }

    testWidgets('the month as a spreadsheet', (tester) async {
      final app = await openExport(tester);

      expect(find.text('Ce mois-ci'), findsOneWidget);
      expect(find.textContaining('1 jour rempli sur'), findsOneWidget);
      await tester.ensureVisible(find.text('Tableur'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Tableur'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Exporter'));
      await tester.pumpAndSettle();

      final file = app.share.files.single;
      final now = today();
      expect(
        file.name,
        'compte-rendu_${now.startOfMonth.toApiDate()}_${now.toApiDate()}.csv',
      );
      expect(file.mimeType, 'text/csv');
      expect(utf8.decode(file.bytes), contains('${now.toApiDate()};oui;4'));
    });

    testWidgets('a message to paste in WhatsApp', (tester) async {
      final app = await openExport(tester);

      await tester.ensureVisible(find.text('Message'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Message'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Partager'));
      await tester.pumpAndSettle();

      expect(
        app.share.texts.single,
        contains('• LB Lecture biblique : 4 chapitres (1 jour)'),
      );
    });

    testWidgets('a PDF', (tester) async {
      final app = await openExport(tester);

      // the document is built with real fonts and real async work
      await tester.runAsync(() async {
        await tester.tap(find.text('Exporter'));
        for (var i = 0; i < 50 && app.share.files.isEmpty; i++) {
          await Future<void>.delayed(const Duration(milliseconds: 100));
        }
      });
      await tester.pumpAndSettle();

      final file = app.share.files.single;
      expect(file.name, endsWith('.pdf'));
      expect(file.mimeType, 'application/pdf');
      expect(ascii.decode(file.bytes.sublist(0, 5)), '%PDF-');
    });

    testWidgets('the summary is shared in one tap', (tester) async {
      final app = await pumpApp(tester, token: 't');
      seedDay(app, 0);
      app.container.invalidate(reportHistoryProvider);
      await openReports(tester);
      await tester.tap(find.text('Bilan'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.text('Partager ce bilan'), 200);
      await tester.tap(find.text('Partager ce bilan'));
      await tester.pumpAndSettle();

      expect(app.share.texts.single, startsWith('*Compte rendu'));
      expect(app.share.texts.single, contains('Régularité'));
    });

    testWidgets('the lyrics of a hymn are shared', (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        initialPreferences: {'hymn_pinch_hint_seen': true},
      );
      await tester.tap(find.text('Cantiques').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('A Toi la gloire'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip("Plus d'options"));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Partager les paroles'));
      await tester.pumpAndSettle();

      expect(app.share.texts.single, startsWith('1. A Toi la gloire'));
    });
  });
}
