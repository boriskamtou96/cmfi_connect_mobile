import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/admin/infrastructure/admin_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  /// A frame for the new text, then the 400 ms the pseudo field waits.
  Future<void> waitForCheck(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
  }

  Future<void> openProfileForm(WidgetTester tester) async {
    await openProfile(tester);
    // the profile card opens the profile
    await scrollTo(tester, find.text('Modifier mon profil'));
    await tester.tap(find.text('Modifier mon profil'));
    await tester.pumpAndSettle();
  }

  // first name, last name, then the pseudo
  Finder pseudoField() => find.byType(TextFormField).at(2);

  testWidgets('the profile shows the pseudo', (tester) async {
    await pumpApp(tester, token: 't');
    await openProfile(tester);

    expect(find.textContaining('@boris.kamtou'), findsOneWidget);
  });

  testWidgets('the pseudo is changed from the profile', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await openProfileForm(tester);
    expect(find.text("C'est ton pseudo actuel"), findsOneWidget);

    await tester.enterText(pseudoField(), 'Boris.K');
    await waitForCheck(tester);
    expect(find.text('@boris.k est libre'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
    await tester.pumpAndSettle();

    expect(app.membersApi.account.username, 'boris.k');
    expect(find.text('@boris.k'), findsOneWidget);
  });

  testWidgets('a pseudo already taken is said, and not saved', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await openProfileForm(tester);

    await tester.enterText(pseudoField(), 'marc.tientcheu');
    await waitForCheck(tester);
    expect(find.text('Ce pseudo est déjà pris.'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
    await tester.pumpAndSettle();

    expect(app.membersApi.account.username, 'boris.kamtou');
    expect(app.profileApi.updates, isEmpty);
  });

  testWidgets('a member has no administration', (tester) async {
    await pumpApp(tester, token: 't');
    await openMenu(tester);
    await scrollToEnd(tester);

    expect(inMenu('ADMINISTRATION'), findsNothing);
  });

  testWidgets('a superadmin sees the team and gives a role', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      membersApi: FakeMembersApi(
        account: sampleAccount.copyWith(role: 'superadmin'),
      ),
      adminApi: FakeAdminApi(const [
        StaffMember(
          username: 'boris.kamtou',
          firstName: 'Boris',
          lastName: 'Kamtou',
          role: MemberRole.superadmin,
        ),
      ]),
    );
    await openMenu(tester);
    await scrollTo(tester, inMenu('Équipe et rôles'));
    expect(inMenu('ADMINISTRATION'), findsOneWidget);
    await tester.tap(inMenu('Équipe et rôles'));
    await tester.pumpAndSettle();

    expect(find.text('Boris Kamtou (toi)'), findsOneWidget);
    expect(find.text('Superadmin'), findsOneWidget);

    await tester.tap(find.text('Donner un rôle'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '@clarisse.nguele');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Donner un rôle').last);
    await tester.pumpAndSettle();

    expect(app.adminApi.roles, {'clarisse.nguele': MemberRole.admin});
    expect(app.toasts.messages, ['@clarisse.nguele : Admin']);
    expect(find.text('Clarisse Nguele'), findsOneWidget);
  });
}
