import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/prayer/presentation/importunity_screen.dart';
import 'package:cmfi_connect/src/features/prayer/presentation/widgets/invitation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

/// Opens the Prière tab.
Future<void> openPrayer(WidgetTester tester) async {
  await tester.tap(find.text('Prière').last);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  // Marc invites the user to pray
  final marc = sampleMembers['marc.tientcheu']!;
  final invitation = Importunity(
    id: 7,
    title: 'Seigneur, sauve Paul',
    goal: 100,
    total: 40,
    owner: marc,
    invitedBy: marc,
    myStatus: ImportunityMemberStatus.invited,
    participants: 3,
  );

  Future<void> openMenu(WidgetTester tester) async {
    await tester.tap(find.byType(InvitationMenu).last);
    await tester.pumpAndSettle();
  }

  testWidgets('blocking whoever invited: asked first, then the invitation '
      'is gone and the screen leaves', (tester) async {
    final api = FakePrayerApi(importunities: [invitation]);
    final app = await pumpApp(tester, token: 't', prayerApi: api);
    await openPrayer(tester);
    await tester.tap(find.text('Seigneur, sauve Paul'));
    await tester.pumpAndSettle();
    expect(find.byType(ImportunityScreen), findsOneWidget);

    await openMenu(tester);
    expect(find.text('Signaler'), findsOneWidget);
    await tester.tap(find.text('Bloquer Marc'));
    await tester.pumpAndSettle();
    expect(find.text('Bloquer Marc ?'), findsOneWidget);
    expect(
      find.text(
        'Tu ne recevras plus d\'invitation de Marc. '
        'Cette invitation est retirée.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Bloquer'));
    await tester.pumpAndSettle();

    expect(api.blockedList.single.username, 'marc.tientcheu');
    expect(app.toasts.messages, ['Marc ne pourra plus t\'inviter.']);
    // back on the Prière tab, without the invitation
    expect(find.byType(ImportunityScreen), findsNothing);
    expect(find.text('Seigneur, sauve Paul'), findsNothing);
    expect(find.text('Marc Tientcheu t\'invite à prier'), findsNothing);
  });

  testWidgets('blocking can be cancelled, and fails with a translated '
      'message', (tester) async {
    final api = FakePrayerApi(importunities: [invitation]);
    final app = await pumpApp(tester, token: 't', prayerApi: api);
    await openPrayer(tester);

    await openMenu(tester);
    await tester.tap(find.text('Bloquer Marc'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Annuler'));
    await tester.pumpAndSettle();
    expect(api.blockedList, isEmpty);

    api.offline = true;
    await openMenu(tester);
    await tester.tap(find.text('Bloquer Marc'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bloquer'));
    await tester.pumpAndSettle();

    expect(api.blockedList, isEmpty);
    expect(app.toasts.errors, [
      'Pas de connexion à internet. Vérifie ton réseau et réessaie.',
    ]);
    expect(find.text('Seigneur, sauve Paul'), findsOneWidget);
  });

  testWidgets('reporting an invitation from its card: a reason, a comment', (
    tester,
  ) async {
    final api = FakePrayerApi(importunities: [invitation]);
    final app = await pumpApp(tester, token: 't', prayerApi: api);
    await openPrayer(tester);

    await openMenu(tester);
    await tester.tap(find.text('Signaler'));
    await tester.pumpAndSettle();
    expect(find.text('Signaler cette invitation'), findsOneWidget);
    expect(find.text('Indésirable'), findsOneWidget);
    expect(find.text('Autre'), findsOneWidget);
    // a reason first
    final send = find.widgetWithText(FilledButton, 'Envoyer le signalement');
    expect(tester.widget<FilledButton>(send).onPressed, isNull);

    await tester.tap(find.text('Contenu choquant ou offensant'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Des insultes');
    await tester.pump();
    await tester.tap(send);
    await tester.pumpAndSettle();

    expect(api.reports, [
      (
        username: 'marc.tientcheu',
        importunityId: 7,
        reason: ReportReason.offensive,
        comment: 'Des insultes',
      ),
    ]);
    expect(app.toasts.messages, ['Merci, les responsables vont regarder.']);
    expect(find.text('Signaler cette invitation'), findsNothing);
    // reporting doesn't block: the invitation stays
    expect(api.blockedList, isEmpty);
    expect(find.text('Seigneur, sauve Paul'), findsOneWidget);
  });

  testWidgets('Plus › Membres bloqués: unblocked in one tap', (tester) async {
    final api = FakePrayerApi()
      ..blockedList.add(sampleMembers['clarisse.nguele']!);
    final app = await pumpApp(tester, token: 't', prayerApi: api);
    await tester.tap(find.text('Plus'));
    await tester.pumpAndSettle();
    await scrollToEnd(tester);
    await tester.tap(find.text('Membres bloqués'));
    await tester.pumpAndSettle();

    expect(find.text('Clarisse Nguele'), findsOneWidget);
    expect(find.text('@clarisse.nguele'), findsOneWidget);
    await tester.tap(find.text('Débloquer'));
    await tester.pumpAndSettle();

    expect(api.blockedList, isEmpty);
    expect(app.toasts.messages, ['Clarisse peut de nouveau t\'inviter.']);
    expect(find.text('Tu n\'as bloqué personne.'), findsOneWidget);
  });
}
