import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/widgets/phone_field.dart';
import 'package:cmfi_connect/src/features/payments/domain/payment.dart';
import 'package:cmfi_connect/src/features/payments/presentation/donation_screen.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

Future<TestApp> _open(WidgetTester tester, {FakePaymentsApi? payments}) async {
  final app = await pumpApp(
    tester,
    token: 't',
    account: sampleAccount,
    paymentsApi: payments,
  );
  // ignore: unawaited_futures
  app.container.read(appRouterProvider).push(const DonationRoute());
  await tester.pumpAndSettle();
  return app;
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('« Faire un don » is in the menu « Vous »', (tester) async {
    await pumpApp(tester, token: 't');
    await openMenu(tester);
    await tester.ensureVisible(find.text('Faire un don'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Faire un don'));
    await tester.pumpAndSettle();
    expect(find.byType(DonationScreen), findsOneWidget);
  });

  testWidgets('an amount typed is given by mobile money; once received, a '
      'thank you', (tester) async {
    final app = await _open(tester);

    // the amount offered by default
    expect(find.textContaining('Donner 2'), findsOneWidget);

    // out of bounds: said under the field, nothing is asked
    await tester.enterText(find.byType(TextField).first, '50');
    await tester.pump();
    expect(find.textContaining('Entre 100'), findsWidgets);
    await tester.tap(find.text('Faire un don').last);
    await tester.pump();
    expect(app.paymentsApi.donations, isEmpty);

    await tester.enterText(find.byType(TextField).first, '3500');
    await tester.enterText(find.byType(TextField).last, '+237690000001');
    // the operator is guessed a moment after the number
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();
    await tester.tap(find.textContaining('Donner 3'));
    await tester.pump();
    await tester.pump();

    expect(app.paymentsApi.donations.single.amount, 3500);
    expect(app.paymentsApi.donations.single.phoneNumber, '+237690000001');
    expect(app.paymentsApi.donations.single.provider, 'ORANGE_CMR');
    expect(app.paymentsApi.donations.single.method, PaymentMethod.mobileMoney);
    expect(find.text('Confirme sur ton téléphone'), findsOneWidget);

    app.paymentsApi.received('pay-1');
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Merci pour ton don !'), findsOneWidget);
    expect(find.textContaining(RegExp(r'3\s500')), findsOneWidget);

    await tester.tap(find.text('Terminer'));
    await tester.pumpAndSettle();
    expect(find.byType(DonationScreen), findsNothing);
  });

  testWidgets('a payment refused says why and stays on the form', (
    tester,
  ) async {
    final payments = FakePaymentsApi()
      ..startStatus = PaymentStatus.failed
      ..startFailure = 'INSUFFICIENT_BALANCE';
    final app = await _open(tester, payments: payments);

    await tester.tap(find.textContaining('Donner 2'));
    await tester.pumpAndSettle();

    expect(
      app.toasts.errors,
      contains('Le solde de ce compte mobile money est insuffisant.'),
    );
    expect(find.text('Merci pour ton don !'), findsNothing);
    expect(find.text('Montant'), findsOneWidget);
  });

  testWidgets('the dial code is chosen from the list, never typed', (
    tester,
  ) async {
    final app = await _open(tester);
    final number = find.descendant(
      of: find.byType(PhoneField),
      matching: find.byType(TextField),
    );

    // the account's number, its country in front
    expect(find.text('+237'), findsOneWidget);
    expect(
      tester.widget<TextField>(number).controller!.text,
      isNot(startsWith('+')),
    );

    await tester.ensureVisible(find.text('+237'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('+237'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byType(BottomSheet),
        matching: find.byType(TextField),
      ),
      'franc',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('France'));
    await tester.pumpAndSettle();
    expect(find.text('+33'), findsOneWidget);

    await tester.enterText(number, '6 12 34 56 78');
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();
    await tester.ensureVisible(find.textContaining('Donner 2'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Donner 2'));
    await tester.pump();
    await tester.pump();

    expect(app.paymentsApi.donations.single.phoneNumber, '+33612345678');
  });

  // a member abroad (their number, +33): KPAY takes their card in dollars
  FakePaymentsApi abroad() => FakePaymentsApi()
    ..cards = true
    ..cardCurrency = 'USD'
    ..preferred = 'card'
    ..donationRules = const [
      DonationRule(
        currency: 'XAF',
        amounts: [1000, 2000, 5000, 10000],
        min: 100,
        cardMin: 1000,
        max: 500000,
      ),
      DonationRule(
        currency: 'USD',
        amounts: [5, 10, 25, 50],
        min: 1,
        cardMin: 1,
        max: 1000,
      ),
    ];

  testWidgets('a member abroad gives by card, in dollars', (tester) async {
    final app = await _open(tester, payments: abroad());

    // the card first, in the currency of their country
    expect(find.text('5 \$'), findsOneWidget);
    await tester.tap(find.textContaining('Donner 10 \$ par carte'));
    await tester.pump();
    await tester.pump();

    final gift = app.paymentsApi.donations.single;
    expect(gift.amount, 10);
    expect(gift.currency, 'USD');
    expect(gift.method, PaymentMethod.card);
  });

  testWidgets('… and back to CFA francs with mobile money', (tester) async {
    final app = await _open(tester, payments: abroad());

    await tester.tap(find.text('Mobile Money'));
    await tester.pumpAndSettle();
    expect(find.text('5 \$'), findsNothing);
    await tester.ensureVisible(find.textContaining('Donner 2'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Donner 2'));
    await tester.pump();
    await tester.pump();

    final gift = app.paymentsApi.donations.single;
    expect(gift.amount, 2000);
    expect(gift.currency, 'XAF');
    expect(gift.method, PaymentMethod.mobileMoney);
  });
}
