import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/core/services/phone_verification.dart';
import 'package:cmfi_connect/src/features/auth/presentation/forgot_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<void> openForgotPassword(WidgetTester tester) async {
    await tester.tap(find.text("J'ai déjà un compte"));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), '6 90 00 00 01');
    await tester.tap(find.text('Mot de passe oublié ?'));
    await tester.pumpAndSettle();
  }

  Future<void> tapButton(WidgetTester tester, String label) async {
    await tester.tap(find.widgetWithText(FilledButton, label));
    await tester.pumpAndSettle();
  }

  testWidgets('a forgotten password: SMS code, new password, signed in', (
    tester,
  ) async {
    final sms = FakePhoneVerification();
    final app = await pumpApp(tester, phoneVerification: sms);
    await openForgotPassword(tester);

    // the number typed on the login screen is kept
    expect(find.text('Mot de passe oublié'), findsOneWidget);
    expect(find.text('1 / 3'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Recevoir le code'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(sms.sent, ['+237690000001']);
    expect(find.text('Entre le code'), findsOneWidget);
    expect(find.textContaining('+237 6 90 00 00 01'), findsOneWidget);
    expect(find.text('Renvoyer le code dans 30 s'), findsOneWidget);
    // 30 s later, another SMS may be asked
    await tester.pump(resendDelay);
    await tester.pump();
    await tester.tap(find.text('Renvoyer le code'));
    await tester.pumpAndSettle();
    expect(sms.sent, ['+237690000001', '+237690000001']);

    // a wrong code
    await tester.enterText(find.byType(TextFormField), '000000');
    await tapButton(tester, 'Vérifier');
    expect(app.toasts.messages, ['Ce code n\'est pas le bon.']);

    await tester.enterText(find.byType(TextFormField), '123456');
    await tapButton(tester, 'Vérifier');
    expect(find.text('Nouveau mot de passe'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Nouveau456');
    await tapButton(tester, 'Enregistrer et me connecter');

    expect(app.authApi.resets, [('firebase:+237690000001', 'Nouveau456')]);
    expect(app.authApi.loggedInWith, '+237690000001');
    expect(sms.forgotten, isTrue);
    expect(
      app.toasts.messages.last,
      'Mot de passe changé. Content de te revoir !',
    );
    expect(find.text('Accueil'), findsWidgets);
  });

  testWidgets('without account for the number, back to the number', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      authApi: FakeAuthApi()
        ..resetError = const ApiException(
          status: 404,
          code: 'NOT_FOUND',
          message: 'User not found',
        ),
    );
    await openForgotPassword(tester);
    await tapButton(tester, 'Recevoir le code');
    await tester.enterText(find.byType(TextFormField), '123456');
    await tapButton(tester, 'Vérifier');
    await tester.enterText(find.byType(TextFormField), 'Nouveau456');
    await tapButton(tester, 'Enregistrer et me connecter');

    expect(app.toasts.messages, ['Aucun compte n\'utilise ce numéro.']);
    expect(find.text('Mot de passe oublié'), findsOneWidget);
    expect(app.authApi.loggedInWith, isNull);
  });

  testWidgets('too many SMS: said, and the number stays', (tester) async {
    final app = await pumpApp(
      tester,
      phoneVerification: FakePhoneVerification(
        sendError: const PhoneVerificationException(
          PhoneVerificationError.tooManyRequests,
        ),
      ),
    );
    await openForgotPassword(tester);
    await tapButton(tester, 'Recevoir le code');

    expect(app.toasts.messages, [
      'Trop de tentatives. Réessaie dans un moment.',
    ]);
    expect(find.text('Mot de passe oublié'), findsOneWidget);
  });
}
