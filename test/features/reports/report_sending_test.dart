import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/core/widgets/app_back_button.dart';
import 'package:cmfi_connect/src/features/authorities/domain/authority.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_sending.dart';
import 'package:cmfi_connect/src/features/reports/presentation/report_send_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('when', () {
    // Wednesday 14 October 2026, 10:00
    final wednesday = DateTime(2026, 10, 14, 10);

    test('every week: the chosen day at the chosen time', () {
      final times = sendingTimes(const SendingSettings(), now: wednesday);
      expect(times.first, DateTime(2026, 10, 18, 20));
      expect(times[1], DateTime(2026, 10, 25, 20));
      // that Sunday, once 20:00 passed: the next one
      expect(
        sendingTimes(
          const SendingSettings(),
          now: DateTime(2026, 10, 18, 21),
        ).first,
        DateTime(2026, 10, 25, 20),
      );
    });

    test('every two weeks: from the first chosen day', () {
      final settings = SendingSettings(
        rhythm: SendingRhythm.biweekly,
        anchor: DateTime(2026, 10, 18),
      );
      expect(sendingTimes(settings, now: wednesday).take(2), [
        DateTime(2026, 10, 18, 20),
        DateTime(2026, 11, 1, 20),
      ]);
      expect(
        sendingTimes(settings, now: DateTime(2026, 10, 19)).first,
        DateTime(2026, 11, 1, 20),
      );
    });

    test('every month: the 1st, across the new year', () {
      final times = sendingTimes(
        const SendingSettings(rhythm: SendingRhythm.monthly),
        now: DateTime(2026, 11, 20),
      );
      expect(times.take(2), [
        DateTime(2026, 12, 1, 20),
        DateTime(2027, 1, 1, 20),
      ]);
    });

    test('the days a report covers', () {
      final sunday = DateTime(2026, 10, 18);
      expect(sendingPeriod(SendingRhythm.weekly, sunday), (
        from: DateTime(2026, 10, 12),
        to: sunday,
      ));
      expect(
        sendingPeriod(SendingRhythm.biweekly, sunday).from,
        DateTime(2026, 10, 5),
      );
      expect(sendingPeriod(SendingRhythm.monthly, DateTime(2027, 1, 1)), (
        from: DateTime(2026, 12, 1),
        to: DateTime(2026, 12, 31),
      ));
    });

    test('the notification says which day', () {
      expect(
        sendingDayOf(sendingPayload(DateTime(2026, 10, 18))),
        DateTime(2026, 10, 18),
      );
      expect(sendingDayOf('report_today'), isNull);
    });
  });

  const paul = Authority(
    id: 7,
    firstName: 'Paul',
    lastName: 'Ndi',
    phoneNumber: '+237 6 77 00 00 07',
    email: 'paul@example.com',
  );

  Future<void> reach(WidgetTester tester, String text) async {
    await tester.scrollUntilVisible(
      find.text(text),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.ensureVisible(find.text(text));
    await tester.pumpAndSettle();
  }

  testWidgets('the report prepared regularly, sent by WhatsApp in one tap', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      authoritiesApi: FakeAuthoritiesApi([paul]),
    );
    await openMore(tester);
    await tester.pumpAndSettle();
    await reach(tester, 'Envoi à mes autorités');
    expect(
      find.descendant(
        of: find.widgetWithText(ListTile, 'Envoi à mes autorités'),
        matching: find.text('Désactivé'),
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Envoi à mes autorités'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Me le préparer régulièrement'));
    await tester.pumpAndSettle();
    final planned = app.notifications.groups[NotificationGroup.reportSending]!;
    expect(planned, hasLength(6));
    expect(planned.every((n) => n.at.weekday == DateTime.sunday), isTrue);
    expect(planned.first.payload, startsWith('report_send:'));
    expect(find.textContaining('Prochain : dimanche'), findsOneWidget);

    await reach(tester, 'Paul Ndi');
    expect(find.text('Par WhatsApp ou e-mail'), findsOneWidget);
    await tester.tap(find.text('Paul Ndi'));
    await tester.pumpAndSettle();

    await reach(tester, 'Préparer maintenant');
    await tester.tap(find.text('Préparer maintenant'));
    await tester.pumpAndSettle();
    expect(find.byType(ReportSendScreen), findsOneWidget);
    expect(find.text('Ton compte rendu est prêt'), findsOneWidget);

    await tester.tap(find.byTooltip('WhatsApp'));
    await tester.pumpAndSettle();
    final link = app.links.opened.last;
    expect(link.host, 'wa.me');
    expect(link.path, '/237677000007');
    expect(link.queryParameters['text'], startsWith('Bonjour Paul,'));
    expect(find.text('Envoyé'), findsOneWidget);

    await tester.tap(find.byTooltip('E-mail'));
    await tester.pumpAndSettle();
    expect(app.links.opened.last.scheme, 'mailto');
    expect(app.links.opened.last.path, 'paul@example.com');

    // back in the settings: the report sent is in the history
    await tester.tap(find.byType(AppBackButton));
    await tester.pumpAndSettle();
    // the headers of the cards are in capitals
    await reach(tester, 'DERNIERS ENVOIS');
    expect(find.textContaining('Paul Ndi'), findsWidgets);
  });

  testWidgets('the notification opens the report of its period', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      authoritiesApi: FakeAuthoritiesApi([paul]),
    );

    app.notifications.tapsController.add('report_send:2026-10-18');
    await tester.pumpAndSettle();

    expect(find.byType(ReportSendScreen), findsOneWidget);
    // the period above, and in the message
    expect(find.textContaining('12 au 18 octobre 2026'), findsWidgets);
    // no recipient chosen yet: the settings, or the PDF
    expect(
      find.text(
        'Choisis tes destinataires dans les réglages, ou partage le PDF.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Partager le PDF'));
    await tester.pumpAndSettle();
    expect(
      app.share.files.single.name,
      'compte-rendu_2026-10-12_2026-10-18.pdf',
    );
  });
  testWidgets('a member who sees the reports gets it in the app, and answers', (
    tester,
  ) async {
    const marie = Authority(
      id: 8,
      firstName: 'Marie',
      lastName: 'Ewane',
      username: 'marie.ewane',
    );
    final app = await pumpApp(
      tester,
      token: 't',
      authoritiesApi: FakeAuthoritiesApi([paul, marie]),
      reportSendingsApi: FakeReportSendingsApi(receivers: {8}),
      initialPreferences: {'report_sending': '{"authorities":[7,8]}'},
    );

    app.notifications.tapsController.add('report_send:2026-10-18');
    await tester.pumpAndSettle();
    // Marie is a member: in the app; Paul only by WhatsApp or e-mail
    expect(find.text("Dans l'app"), findsOneWidget);
    expect(find.byTooltip("Envoyer dans l'app"), findsOneWidget);

    await tester.tap(find.byTooltip("Envoyer dans l'app"));
    await tester.pumpAndSettle();
    final sent = app.reportSendingsApi.sends.single;
    expect(sent.ids, [8]);
    expect(
      (sent.from, sent.to),
      (DateTime(2026, 10, 12), DateTime(2026, 10, 18)),
    );
    expect(app.toasts.messages, contains("Envoyé à Marie dans l'app"));
    expect(find.text('Envoyé'), findsOneWidget);

    // she answers: the push opens the settings, with her word
    final sending = app.reportSendingsApi.sentList.first;
    app.reportSendingsApi.sentList[0] = sending.copyWith(
      readAt: DateTime(2026, 10, 19, 8),
      reply: 'Belle fidélité, continue !',
      repliedAt: DateTime(2026, 10, 19, 8, 5),
    );
    app.push.tapsController.add({
      'type': 'report_reply',
      'id': '${sending.id}',
    });
    await tester.pumpAndSettle();
    await reach(tester, "ENVOYÉS DANS L'APP");
    await reach(tester, '« Belle fidélité, continue ! »');
    expect(find.text('Marie Ewane'), findsWidgets);
    expect(find.textContaining('Répondu'), findsOneWidget);
  });

  testWidgets('no longer able to receive it: said, nothing marked sent', (
    tester,
  ) async {
    const marie = Authority(id: 8, firstName: 'Marie', username: 'marie.ewane');
    final app = await pumpApp(
      tester,
      token: 't',
      authoritiesApi: FakeAuthoritiesApi([marie]),
      initialPreferences: {'report_sending': '{"authorities":[8]}'},
    );
    app.notifications.tapsController.add('report_send:2026-10-18');
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip("Envoyer dans l'app"));
    await tester.pumpAndSettle();
    expect(
      app.toasts.messages,
      contains("Marie ne peut pas le recevoir dans l'app pour l'instant."),
    );
    expect(find.text('Envoyé'), findsNothing);
  });

  testWidgets('signing out forgets what the phone kept for the account', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {
        'report_goals': '{"1":{"quantity":2}}',
        'report_sending': '{"enabled":true,"authorities":[7]}',
      },
    );
    await openMore(tester);
    await tester.pumpAndSettle();
    await scrollToEnd(tester);
    await tester.tap(find.text('Se déconnecter'));
    await tester.pumpAndSettle();

    expect(app.preferences.getString('report_goals'), isNull);
    expect(app.preferences.getString('report_sending'), isNull);
  });
}
