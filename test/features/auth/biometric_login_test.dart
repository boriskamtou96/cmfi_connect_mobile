import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/core/services/biometrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<void> openLogin(WidgetTester tester) async {
    await tester.tap(find.text("J'ai déjà un compte"));
    await tester.pumpAndSettle();
  }

  Future<void> signIn(
    WidgetTester tester, {
    String phone = '6 90 00 00 01',
  }) async {
    if (phone.isNotEmpty) {
      await tester.enterText(find.byType(TextFormField).at(0), phone);
    }
    await tester.enterText(find.byType(TextFormField).at(1), 'Secret123');
    await tester.tap(find.widgetWithText(FilledButton, 'Se connecter'));
    await tester.pumpAndSettle();
  }

  testWidgets('the number stays for the next sign-in', (tester) async {
    final app = await pumpApp(
      tester,
      savedLogin: FakeSavedLoginStorage(savedPhone: '+237690000001'),
    );
    await openLogin(tester);

    // already there, as it is written in Cameroon
    expect(find.text('6 90 00 00 01'), findsOneWidget);
    await signIn(tester, phone: '');
    expect(app.authApi.loggedInWith, '+237690000001');
    expect(app.savedLogin.savedPhone, '+237690000001');
    // no biometrics on this phone: nothing kept nor offered
    expect(app.savedLogin.savedPassword, isNull);
  });

  testWidgets('offered once after a sign-in, then Face ID signs in', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      biometrics: FakeBiometrics(available: BiometricKind.face),
    );
    await openLogin(tester);
    await signIn(tester);

    expect(find.text('Te connecter avec ton visage ?'), findsOneWidget);
    await tester.tap(find.text('Activer'));
    await tester.pumpAndSettle();
    expect(app.biometrics.prompts, [
      'Active la connexion rapide à CMFI Connect',
    ]);
    expect(app.savedLogin.savedPassword, 'Secret123');
    expect(find.text('Bonjour Boris'), findsOneWidget);

    // signed out: the number and Face ID stay
    await openSettings(tester);
    await tester.pumpAndSettle();
    await scrollToEnd(tester);
    await tester.tap(find.text('Se déconnecter'));
    await tester.pumpAndSettle();
    app.authApi.loggedInWith = null;
    await openLogin(tester);

    await tester.tap(find.text('Se connecter avec ton visage'));
    await tester.pumpAndSettle();
    expect(app.biometrics.prompts.last, 'Connecte-toi à CMFI Connect');
    expect(app.authApi.loggedInWith, '+237690000001');
    expect(find.text('Bonjour Boris'), findsOneWidget);
  });

  testWidgets('"Plus tard": not asked again', (tester) async {
    final app = await pumpApp(
      tester,
      biometrics: FakeBiometrics(available: BiometricKind.fingerprint),
    );
    await openLogin(tester);
    await signIn(tester);

    await tester.tap(find.text('Plus tard'));
    await tester.pumpAndSettle();
    expect(app.savedLogin.savedPassword, isNull);
    expect(app.preferences.getBool('login_biometric_asked'), isTrue);
  });

  testWidgets('the password changed: Face ID is turned off, said why', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      biometrics: FakeBiometrics(available: BiometricKind.face),
      savedLogin: FakeSavedLoginStorage(
        savedPhone: '+237690000001',
        savedPassword: 'Old123',
      ),
      authApi: FakeAuthApi(
        error: const ApiException(
          status: 401,
          code: 'INVALID_CREDENTIALS',
          message: '',
        ),
      ),
    );
    await openLogin(tester);

    await tester.tap(find.text('Se connecter avec ton visage'));
    await tester.pumpAndSettle();

    expect(app.savedLogin.savedPassword, isNull);
    expect(
      app.toasts.messages.last,
      'Ton mot de passe a changé : connecte-toi avec ton mot de passe, puis '
      'réactive ton visage.',
    );
    expect(find.text('Se connecter avec ton visage'), findsNothing);
  });
}
