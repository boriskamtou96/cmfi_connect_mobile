import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/session/account.dart';
import 'package:cmfi_connect/src/features/profile/domain/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  const account = Account(
    firstName: 'Boris',
    lastName: 'Kamtou',
    phoneNumber: '+237659460125',
  );
  // what the dev database holds for some users: church filled, name and phone empty
  const incomplete = Profile(
    firstName: '',
    phoneNumber: '',
    city: 'Yaoundé',
    church: 'PSU-Yaoundé',
  );

  Future<void> openMore(WidgetTester tester) async {
    await tester.tap(find.text('Plus'));
    await tester.pumpAndSettle();
  }

  testWidgets('login keeps the account, logout forgets it', (tester) async {
    final app = await pumpApp(tester);

    await tester.tap(find.text("J'ai déjà un compte"));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), '690000001');
    await tester.enterText(find.byType(TextFormField).at(1), 'Secret123');
    await tester.tap(find.widgetWithText(FilledButton, 'Se connecter'));
    await tester.pumpAndSettle();

    expect(app.accountStorage.account?.firstName, 'Boris');

    await openMore(tester);
    await scrollToEnd(tester);
    await tester.tap(find.text('Se déconnecter'));
    await tester.pumpAndSettle();

    expect(app.accountStorage.account, isNull);
  });

  testWidgets('a profile without name shows the name of the account', (
    tester,
  ) async {
    await pumpApp(tester, token: 't', account: account, profile: incomplete);

    expect(find.text('Bonjour Boris'), findsOneWidget);

    await openMore(tester);
    // the card shows the name and pseudo, no longer the phone
    expect(find.text('Boris Kamtou'), findsOneWidget);
  });

  testWidgets('saving the profile writes the name back to the server', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      account: account,
      profile: incomplete,
    );
    await openMore(tester);

    await tester.tap(find.text('Boris Kamtou'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
    await tester.pumpAndSettle();

    final saved = app.profileApi.updates.single;
    expect(saved.firstName, 'Boris');
    expect(saved.lastName, 'Kamtou');
    expect(saved.phoneNumber, '+237659460125');
    expect(saved.church, 'PSU-Yaoundé');
  });

  testWidgets(
    'no name anywhere: "Ajoute ton nom", then type it in the profile',
    (tester) async {
      final app = await pumpApp(tester, token: 't', profile: incomplete);
      await openMore(tester);

      await tester.tap(find.text('Ajoute ton nom'));
      await tester.pumpAndSettle();
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.at(0), 'Boris');
      await tester.enterText(fields.at(1), 'Kamtou');
      await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
      await tester.pumpAndSettle();

      expect(app.profileApi.updates.single.fullName, 'Boris Kamtou');
      expect(find.text('Boris Kamtou'), findsOneWidget);
    },
  );

  testWidgets('a user without profile on the server gets one created', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      account: account,
      profile: null,
    );
    await openMore(tester);

    expect(find.text('Boris Kamtou'), findsOneWidget);

    await tester.tap(find.text('Boris Kamtou'));
    await tester.pumpAndSettle();
    // first name, last name, pseudo, country, city, then the church
    await tester.enterText(find.byType(TextField).at(5), 'PSU-Yaoundé');
    await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
    await tester.pumpAndSettle();

    expect(app.profileApi.updates, isEmpty);
    expect(app.profileApi.creates.single.church, 'PSU-Yaoundé');
    expect(app.profileApi.creates.single.firstName, 'Boris');
  });
}
