import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/features/events/domain/event.dart';
import 'package:cmfi_connect/src/features/payments/domain/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

/// "10 000 FCFA", grouped the French way.
String fcfa(int amount) => formatMoney(amount, 'XAF', 'fr');

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  /// The next event costs 5 000 FCFA per person.
  FakeEventsApi paidEvents({MyRegistration? mine}) {
    final sample = sampleEvents();
    return FakeEventsApi(
      upcoming: [
        sample.next.copyWith(
          price: const EventPrice(amount: 5000),
          myRegistration: mine,
          registration: sample.next.registration.copyWith(
            registered: mine != null,
          ),
        ),
      ],
    );
  }

  Future<void> openEvent(WidgetTester tester) async {
    await scrollTo(tester, find.text('Conférence annuelle 2026'));
    await tester.tap(find.text('Conférence annuelle 2026'));
    await tester.pumpAndSettle();
  }

  /// The sheet, two people, an Orange number.
  Future<void> fillPayment(WidgetTester tester) async {
    await tester.tap(find.text('Je participe'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Une personne de plus'));
    await tester.enterText(
      find.widgetWithText(TextField, 'Numéro mobile money'),
      '+237 6 90 00 00 01',
    );
    // the operator is guessed once typed
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
  }

  Future<void> tapPay(WidgetTester tester) async {
    final pay = find.text('Payer ${fcfa(10000)}');
    await tester.ensureVisible(pay);
    await tester.pumpAndSettle();
    await tester.tap(pay);
  }

  testWidgets('a paid event: the member pays, then is registered', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't', eventsApi: paidEvents());
    await openEvent(tester);

    expect(find.text('${fcfa(5000)} par personne'), findsOneWidget);
    await fillPayment(tester);
    expect(find.text(fcfa(10000)), findsOneWidget);
    final orange = tester.widget<ChoiceChip>(
      find.widgetWithText(ChoiceChip, 'Orange'),
    );
    expect(orange.selected, isTrue);

    await tapPay(tester);
    await tester.pump();
    await tester.pump();
    expect(app.paymentsApi.started.single, (
      eventId: 2,
      people: 2,
      phoneNumber: '+237 6 90 00 00 01',
      provider: 'ORANGE_CMR',
    ));
    expect(find.text('Confirme sur ton téléphone'), findsOneWidget);
    // not registered while the member types their PIN
    expect(app.eventsApi.events[2]?.myRegistration, isNull);

    await app.paymentsApi.complete('pay-1');
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(app.toasts.messages, ['Paiement reçu : tu es inscrit !']);
    expect(find.text('Tu es inscrit'), findsOneWidget);
    expect(find.text('2 personnes · payé'), findsOneWidget);
  });

  testWidgets('a failed payment says why, and can be tried again', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't', eventsApi: paidEvents());
    await openEvent(tester);
    await fillPayment(tester);
    await tapPay(tester);
    await tester.pump();
    await tester.pump();

    app.paymentsApi.fail('pay-1', 'INSUFFICIENT_BALANCE');
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(find.text("Le paiement n'a pas abouti"), findsOneWidget);
    expect(
      find.text('Le solde de ce compte mobile money est insuffisant.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Réessayer'));
    await tester.pumpAndSettle();
    expect(find.text('Payer ${fcfa(10000)}'), findsOneWidget);
    expect(find.text('Tu es inscrit'), findsNothing);
  });

  testWidgets('a refusal from the server is shown in the sheet', (
    tester,
  ) async {
    final payments = FakePaymentsApi()
      ..payError = const ApiException(
        status: 409,
        code: 'AMOUNT_OUT_OF_BOUNDS',
        message: '',
      );
    final app = await pumpApp(
      tester,
      token: 't',
      eventsApi: paidEvents(),
      paymentsApi: payments,
    );
    await openEvent(tester);
    await fillPayment(tester);
    await tapPay(tester);
    await tester.pumpAndSettle();

    expect(app.toasts.errors, [
      "Ce montant dépasse ce que l'opérateur accepte.",
    ]);
    expect(find.text('Payer ${fcfa(10000)}'), findsOneWidget);
  });

  testWidgets('a paid registration keeps its people and is not cancelled '
      'in the app', (tester) async {
    await pumpApp(
      tester,
      token: 't',
      eventsApi: paidEvents(mine: const MyRegistration(people: 2, paid: true)),
    );
    await openEvent(tester);

    await tester.tap(find.text('Modifier'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Pour l\'annuler, contacte les organisateurs'),
      findsOneWidget,
    );
    expect(find.text('Annuler mon inscription'), findsNothing);
    expect(find.textContaining('Payer'), findsNothing);
    final more = tester.widget<IconButton>(
      find.ancestor(
        of: find.byTooltip('Une personne de plus'),
        matching: find.byType(IconButton),
      ),
    );
    expect(more.onPressed, isNull);
  });

  testWidgets('one may register now and pay later', (tester) async {
    final app = await pumpApp(tester, token: 't', eventsApi: paidEvents());
    await openEvent(tester);
    await fillPayment(tester);

    final later = find.text('Je paierai plus tard');
    await tester.ensureVisible(later);
    await tester.pumpAndSettle();
    await tester.tap(later);
    await tester.pumpAndSettle();

    expect(app.toasts.messages, [
      "Tu es inscrit ! Pense à payer ${fcfa(10000)} avant l'évènement.",
    ]);
    expect(app.paymentsApi.started, isEmpty);
    expect(find.text('À payer : ${fcfa(10000)}'), findsOneWidget);
    // paid later from the same sheet
    await tester.tap(find.text('Payer'));
    await tester.pumpAndSettle();
    expect(find.text('Payer ${fcfa(10000)}'), findsOneWidget);
  });

  testWidgets('without mobile money on the server, registering stays open', (
    tester,
  ) async {
    final payments = FakePaymentsApi()
      ..operatorsError = const ApiException(
        status: 503,
        code: 'PAYMENTS_DISABLED',
        message: '',
      );
    final app = await pumpApp(
      tester,
      token: 't',
      eventsApi: paidEvents(),
      paymentsApi: payments,
    );
    await openEvent(tester);
    await tester.tap(find.text('Je participe'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining("n'est pas encore disponible : inscris-toi"),
      findsOneWidget,
    );
    expect(find.textContaining('Payer'), findsNothing);
    final confirm = find.text('Confirmer mon inscription');
    await tester.ensureVisible(confirm);
    await tester.pumpAndSettle();
    await tester.tap(confirm);
    await tester.pumpAndSettle();
    expect(find.text('Tu es inscrit'), findsOneWidget);
    expect(app.toasts.errors, isEmpty);
  });
}
