import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

const welcomeTitle = 'Bienvenue sur CMFI Connect';

/// Plus › Supprimer mon compte, then the password.
Future<void> openAndConfirm(WidgetTester tester, String password) async {
  await openMore(tester);
  await tester.pumpAndSettle();
  await scrollToEnd(tester);
  await tester.tap(find.text('Supprimer mon compte'));
  await tester.pumpAndSettle();

  expect(
    find.text(
      "C'est définitif. Ton compte et tout ce qui y est lié seront effacés :",
    ),
    findsOneWidget,
  );
  final confirm = find.widgetWithText(FilledButton, 'Supprimer définitivement');
  // nothing typed yet: the button waits
  expect(tester.widget<FilledButton>(confirm).onPressed, isNull);

  await tester.enterText(find.byType(TextFormField), password);
  await tester.pump();
  await tester.tap(confirm);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('with the right password the account goes, back to welcome', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 'saved-token');

    await openAndConfirm(tester, 'Secret123');

    expect(app.membersApi.deletions, ['Secret123']);
    expect(app.toasts.messages, [
      'Ton compte a été supprimé. Que Dieu te bénisse !',
    ]);
    expect(find.text(welcomeTitle), findsOneWidget);
    expect(app.storage.token, isNull);
  });

  testWidgets('a wrong password is said under the field, the account stays', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 'saved-token');

    await openAndConfirm(tester, 'not-my-password');

    expect(find.text('Mot de passe incorrect.'), findsOneWidget);
    expect(app.toasts.messages, isEmpty);
    expect(app.storage.token, 'saved-token');
  });

  testWidgets('the last superadmin is told to give the role first', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 'saved-token',
      membersApi: FakeMembersApi()..lastSuperadmin = true,
    );

    await openAndConfirm(tester, 'Secret123');

    expect(app.toasts.errors, [
      "Tu es le seul superadmin : donne ce rôle à quelqu'un d'autre avant de supprimer ton compte.",
    ]);
    expect(app.storage.token, 'saved-token');
    expect(find.text(welcomeTitle), findsNothing);
  });
}
