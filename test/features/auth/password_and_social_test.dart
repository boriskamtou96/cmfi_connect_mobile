import 'dart:typed_data';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/social_photo.dart';
import 'package:cmfi_connect/src/core/services/social_sign_in.dart';
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

  Future<void> signIn(WidgetTester tester) async {
    await tester.enterText(find.byType(TextFormField).at(0), '6 90 00 00 01');
    await tester.enterText(find.byType(TextFormField).at(1), 'Secret123');
    await tester.tap(find.widgetWithText(FilledButton, 'Se connecter'));
    await tester.pumpAndSettle();
  }

  const paul = SocialAccount(
    idToken: 'firebase:google',
    provider: SocialProvider.google,
    firstName: 'Paul',
    lastName: 'Ngono',
    email: 'paul.ngono@gmail.com',
  );

  testWidgets('a temporary password asks for a new one before the app', (
    tester,
  ) async {
    final app = await pumpApp(tester);
    app.authApi.temporary = true;
    await openLogin(tester);
    await signIn(tester);

    expect(find.text('Choisis ton mot de passe'), findsOneWidget);
    // typed at the sign-in: not asked again
    expect(find.text('Mot de passe actuel'), findsNothing);

    await tester.enterText(find.byType(TextFormField).at(0), 'Nouveau456');
    await tester.enterText(find.byType(TextFormField).at(1), 'Nouveau457');
    await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
    await tester.pumpAndSettle();
    expect(find.text('Les deux mots de passe ne sont pas pareils.'), findsOne);
    expect(app.membersApi.passwordChanges, isEmpty);

    await tester.enterText(find.byType(TextFormField).at(1), 'Nouveau456');
    await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
    await tester.pumpAndSettle();
    expect(app.membersApi.passwordChanges, [('Secret123', 'Nouveau456')]);
    expect(app.toasts.messages, contains('Mot de passe enregistré.'));
    expect(find.text('Choisis ton mot de passe'), findsNothing);
    expect(find.text('Bonjour Boris'), findsOneWidget);
  });

  testWidgets('a forgotten password: ask the team for a temporary one', (
    tester,
  ) async {
    final app = await pumpApp(tester);
    await openLogin(tester);
    await tester.tap(find.text('Mot de passe oublié ?'));
    await tester.pumpAndSettle();

    expect(find.textContaining('mot de passe provisoire'), findsOneWidget);
    await tester.tap(find.text("Écrire à l'équipe"));
    await tester.pumpAndSettle();
    expect(app.links.opened.single.scheme, 'mailto');
    expect(app.links.opened.single.path, 'contact@cmfi-connect.com');
  });

  testWidgets('Google the first time: the profile is completed', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      socialSignIn: FakeSocialSignIn(next: paul),
    );
    await openLogin(tester);
    await tester.ensureVisible(find.text('Continuer avec Google'));
    await tester.tap(find.text('Continuer avec Google'));
    await tester.pumpAndSettle();

    expect(find.text("Plus qu'une étape"), findsOneWidget);
    expect(find.text('paul.ngono@gmail.com'), findsOneWidget);
    // the name Google gave, to check
    expect(find.widgetWithText(TextFormField, 'Paul'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Ngono'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(2), '6 77 11 22 33');
    await tester.tap(find.widgetWithText(FilledButton, 'Créer mon compte'));
    await tester.pumpAndSettle();
    expect(app.authApi.socialRegistered, [
      ('firebase:google', '+237677112233'),
    ]);
    // a new account: its church next
    expect(find.text('Ton église'), findsOneWidget);
  });

  testWidgets('Google the first time: its photo becomes the profile photo', (
    tester,
  ) async {
    const photo = 'https://lh3.googleusercontent.com/a/paul=s400-c';
    final bytes = Uint8List.fromList([1, 2, 3]);
    final downloader = FakePhotoDownloader({photo: bytes});
    final app = await pumpApp(
      tester,
      socialSignIn: FakeSocialSignIn(
        next: const SocialAccount(
          idToken: 'firebase:google',
          provider: SocialProvider.google,
          firstName: 'Paul',
          lastName: 'Ngono',
          email: 'paul.ngono@gmail.com',
          photoUrl: photo,
        ),
      ),
      photoDownloader: downloader,
    );
    await openLogin(tester);
    await tester.ensureVisible(find.text('Continuer avec Google'));
    await tester.tap(find.text('Continuer avec Google'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(2), '6 77 11 22 33');
    await tester.tap(find.widgetWithText(FilledButton, 'Créer mon compte'));
    await tester.pumpAndSettle();

    // the photo is taken once the app opens, after the church step
    expect(downloader.asked, isEmpty);
    await tester.tap(find.text('Passer cette étape'));
    await tester.pumpAndSettle();

    expect(downloader.asked, [photo]);
    expect(app.profileApi.avatars, [bytes]);

    // only the pictures of Google accounts are downloaded
    expect(HttpPhotoDownloader.isGooglePhoto(Uri.parse(photo)), isTrue);
    expect(
      HttpPhotoDownloader.isGooglePhoto(
        Uri.parse('http://lh3.googleusercontent.com/a'),
      ),
      isFalse,
    );
    expect(
      HttpPhotoDownloader.isGooglePhoto(
        Uri.parse('https://googleusercontent.com.evil.test/a'),
      ),
      isFalse,
    );
  });

  testWidgets('a number that has an account is linked with its password', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      socialSignIn: FakeSocialSignIn(next: paul),
    );
    app.authApi.takenPhones.add('+237690000001');
    await openLogin(tester);
    await tester.ensureVisible(find.text('Continuer avec Google'));
    await tester.tap(find.text('Continuer avec Google'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(2), '6 90 00 00 01');
    await tester.tap(find.widgetWithText(FilledButton, 'Créer mon compte'));
    await tester.pumpAndSettle();
    expect(find.text('Ce numéro a déjà un compte'), findsOneWidget);
    expect(app.authApi.socialRegistered, isEmpty);

    await tester.enterText(find.byType(TextFormField).at(3), 'Secret123');
    await tester.tap(
      find.widgetWithText(FilledButton, 'Relier et me connecter'),
    );
    await tester.pumpAndSettle();
    expect(app.authApi.socialLinks, [('firebase:google', '+237690000001')]);
    expect(find.text('Bonjour Boris'), findsOneWidget);
  });

  testWidgets('a Google account already linked signs in at once', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      socialSignIn: FakeSocialSignIn(next: paul),
    );
    app.authApi.socialAccounts.add('firebase:google');
    await openLogin(tester);
    await tester.ensureVisible(find.text('Continuer avec Google'));
    await tester.tap(find.text('Continuer avec Google'));
    await tester.pumpAndSettle();

    expect(find.text("Plus qu'une étape"), findsNothing);
    expect(find.text('Content de te revoir'), findsNothing);
    expect(app.storage.token, 'social-token');
  });

  testWidgets('the window closed: nothing happens', (tester) async {
    final app = await pumpApp(tester, socialSignIn: FakeSocialSignIn());
    await openLogin(tester);
    await tester.ensureVisible(find.text('Continuer avec Google'));
    await tester.tap(find.text('Continuer avec Google'));
    await tester.pumpAndSettle();

    expect(find.text('Content de te revoir'), findsOneWidget);
    expect(app.toasts.errors, isEmpty);
  });

  testWidgets('the password is changed from Plus with the current one', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 'test-token');
    await openSettings(tester);
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text('Mot de passe'));
    await tester.tap(find.text('Mot de passe'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Faux1234');
    await tester.enterText(find.byType(TextFormField).at(1), 'Nouveau456');
    await tester.enterText(find.byType(TextFormField).at(2), 'Nouveau456');
    await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
    await tester.pumpAndSettle();
    expect(find.text("Le mot de passe actuel n'est pas le bon."), findsOne);

    await tester.enterText(find.byType(TextFormField).at(0), 'Secret123');
    await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
    await tester.pumpAndSettle();
    expect(app.membersApi.passwordChanges, [('Secret123', 'Nouveau456')]);
    expect(app.toasts.messages, contains('Mot de passe enregistré.'));
  });
}
