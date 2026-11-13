import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
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
}
