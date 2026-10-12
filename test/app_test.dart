import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/core/session/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'helpers/fakes.dart';
import 'helpers/pump_app.dart';

const welcomeTitle = 'Bienvenue sur CMFI Connect';
const invalidCredentials = 'Numéro de téléphone ou mot de passe incorrect.';

Future<void> tapText(WidgetTester tester, String text) async {
  await tester.tap(find.text(text));
  await tester.pumpAndSettle();
}

Future<void> fillLoginForm(WidgetTester tester) async {
  await tester.enterText(find.byType(TextFormField).at(0), '6 90 00 00 01');
  await tester.enterText(find.byType(TextFormField).at(1), 'Secret123');
  await tester.tap(find.widgetWithText(FilledButton, 'Se connecter'));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('launch', () {
    testWidgets(
      'first launch shows the presentation, skipping it opens the welcome screen',
      (tester) async {
        final app = await pumpApp(tester, onboardingSeen: false);

        expect(
          find.text('Ta marche avec Dieu, jour après jour'),
          findsOneWidget,
        );

        await tapText(tester, 'Passer');

        expect(find.text(welcomeTitle), findsOneWidget);
        expect(app.preferences.getBool('onboarding_seen'), isTrue);
      },
    );

    testWidgets('the presentation has three pages, the last one starts', (
      tester,
    ) async {
      await pumpApp(tester, onboardingSeen: false);

      await tapText(tester, 'Suivant');
      expect(find.text('Chante et prie, où que tu sois'), findsOneWidget);
      await tapText(tester, 'Suivant');
      expect(find.text('Reste lié à ta communauté'), findsOneWidget);
      await tapText(tester, 'Commencer');

      expect(find.text(welcomeTitle), findsOneWidget);
    });

    testWidgets('presentation already seen: the welcome screen comes first', (
      tester,
    ) async {
      await pumpApp(tester);

      expect(find.text(welcomeTitle), findsOneWidget);
    });

    testWidgets('a stored token opens the home tab directly', (tester) async {
      await pumpApp(tester, token: 'saved-token');

      expect(find.text('Bonjour Boris'), findsOneWidget);
      expect(find.text('Compte rendu du jour'), findsOneWidget);
    });
  });

  group('login', () {
    testWidgets('welcome -> login -> home, the number gets the +237 prefix', (
      tester,
    ) async {
      final app = await pumpApp(tester);

      await tapText(tester, "J'ai déjà un compte");
      await fillLoginForm(tester);

      expect(find.text('Bonjour Boris'), findsOneWidget);
      expect(app.storage.token, 'test-token');
      expect(app.authApi.loggedInWith, '+237690000001');
    });

    testWidgets('wrong password shows a translated message in a popup', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        authApi: FakeAuthApi(
          error: const ApiException(
            status: 401,
            code: 'INVALID_CREDENTIALS',
            message: 'invalid credentials',
          ),
        ),
      );

      await tapText(tester, "J'ai déjà un compte");
      await fillLoginForm(tester);

      expect(app.toasts.errors, [invalidCredentials]);
      expect(find.text('Content de te revoir'), findsOneWidget);
    });

    testWidgets(
      'unknown phone number shows the same message (no account leak)',
      (tester) async {
        final app = await pumpApp(
          tester,
          authApi: FakeAuthApi(
            error: const ApiException(
              status: 404,
              code: 'NOT_FOUND',
              message: 'User not found',
            ),
          ),
        );

        await tapText(tester, "J'ai déjà un compte");
        await fillLoginForm(tester);

        expect(app.toasts.errors, [invalidCredentials]);
      },
    );
  });

  group('sign-up', () {
    Future<void> fillAccount(WidgetTester tester) async {
      await tapText(tester, 'Créer mon compte');
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Boris');
      await tester.enterText(fields.at(1), 'Kamtou');
      // the pseudo field fills itself with a free one made from the name
      // (a frame for the new name, then the 400 ms the field waits)
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();
      await tester.enterText(fields.at(3), '690000001');
      await tester.enterText(fields.at(4), 'Secret123');
      await tester.tap(find.widgetWithText(FilledButton, 'Continuer'));
      await tester.pumpAndSettle();
    }

    testWidgets('account, then the church step, then the app', (tester) async {
      final app = await pumpApp(tester);

      await fillAccount(tester);

      expect(app.authApi.registered, ['+237690000001']);
      // boris.kamtou is taken: the next suggestion
      expect(app.authApi.registeredUsername, 'boriskamtou');
      expect(app.storage.token, 'test-token');
      expect(find.text('Ton église'), findsOneWidget);

      await tester.enterText(find.byType(TextField).at(2), 'CMFI Yaoundé');
      await tester.tap(find.widgetWithText(FilledButton, 'Terminer'));
      await tester.pumpAndSettle();

      expect(find.text('Bonjour Boris'), findsOneWidget);
      final saved = app.profileApi.updates.single;
      expect(saved.church, 'CMFI Yaoundé');
      // the API overwrites these two: they must be sent back unchanged
      expect(saved.firstName, 'Boris');
      expect(saved.phoneNumber, '+237690000001');
    });

    testWidgets('the church step can be skipped', (tester) async {
      final app = await pumpApp(tester);

      await fillAccount(tester);
      await tapText(tester, 'Passer cette étape');

      expect(find.text('Bonjour Boris'), findsOneWidget);
      expect(app.profileApi.updates, isEmpty);
    });

    testWidgets('a number that already has an account says to sign in', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        authApi: FakeAuthApi(
          registerError: const ApiException(
            status: 403,
            code: 'FORBIDDEN',
            message: 'forbidden',
          ),
        ),
      );

      await fillAccount(tester);

      expect(app.toasts.errors, [
        'Ce numéro ou cet e-mail a déjà un compte. Connecte-toi.',
      ]);
    });
  });

  group('sign out', () {
    testWidgets(
      '"Se déconnecter" in the More tab goes back to the welcome screen',
      (tester) async {
        final app = await pumpApp(tester, token: 'saved-token');

        await tapText(tester, 'Plus');
        // last item of the tab, below the fold
        await scrollToEnd(tester);
        await tapText(tester, 'Se déconnecter');

        expect(find.text(welcomeTitle), findsOneWidget);
        expect(app.storage.token, isNull);
      },
    );

    testWidgets(
      'a 401 elsewhere in the app signs out and returns to the welcome screen',
      (tester) async {
        final app = await pumpApp(tester, token: 'expired-token');
        expect(find.text('Bonjour Boris'), findsOneWidget);

        // what AuthInterceptor does when an authenticated request gets a 401
        await app.container.read(sessionProvider.notifier).signOut();
        await tester.pumpAndSettle();

        expect(find.text(welcomeTitle), findsOneWidget);
      },
    );
  });
}
