import 'package:cmfi_connect/src/core/config/flavor.dart';
import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/premium_store.dart';
import 'package:cmfi_connect/src/core/theme/app_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  // a list builds a little below the screen: scroll, then bring it in
  Future<void> reach(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(finder, 200);
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
  }

  // the paywall builds all of it: bring it in
  Future<void> show(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
  }

  Future<void> openSummary(WidgetTester tester) async {
    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bilan'));
    await tester.pumpAndSettle();
  }

  testWidgets('the year of the summary leads to Premium, bought in one tap', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {'report_goals': '{"1":{"quantity":2}}'},
    );
    await openSummary(tester);

    await reach(tester, find.text('Débloquer avec Premium'));
    expect(find.text('Débloquer avec Premium'), findsOneWidget);
    // back to the top of the summary
    await tester.drag(find.byType(Scrollable).last, const Offset(0, 3000));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Année'));
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('CMFI Connect Premium'), findsOneWidget);
    // the price large, the period under it
    expect(find.text('24,99 €'), findsOneWidget);
    expect(find.text('/ an'), findsOneWidget);
    expect(find.text('soit 2,08 € par mois'), findsOneWidget);
    expect(find.text('2,99 €'), findsOneWidget);
    expect(find.text('14,99 €'), findsOneWidget);
    expect(find.text('/ 6 mois'), findsOneWidget);
    expect(find.text('soit 2,50 € par mois'), findsOneWidget);
    // 6 months cost 16 % less than six times a month
    expect(find.textContaining('−16'), findsOneWidget);
    // the year costs 30 % less than twelve months
    expect(find.textContaining('−30'), findsOneWidget);
    expect(
      find.text('7 jours d\'essai gratuit, puis 24,99 € / an'),
      findsOneWidget,
    );

    await reach(tester, find.text('Commencer l\'essai gratuit'));
    await tester.tap(find.text('Commencer l\'essai gratuit'));
    await tester.pumpAndSettle();

    expect(app.premium.bought, [PremiumPeriod.annual]);
    expect(app.toasts.messages, ['Merci ! Premium est activé.']);
    expect(find.text('Tu as Premium'), findsOneWidget);

    await reach(tester, find.text('Fermer'));
    await tester.tap(find.text('Fermer'));
    await tester.pumpAndSettle();
    // the year opens now, and the progress of the goals shows
    await tester.tap(find.text('Année'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('CMFI Connect Premium'), findsNothing);
    await reach(tester, find.text('Évolution de tes objectifs'));
    expect(find.text('Évolution de tes objectifs'), findsOneWidget);
    expect(find.text('Débloquer avec Premium'), findsNothing);
  });

  testWidgets('v1: Premium offered to everyone, nothing leads to the paywall', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      premiumForEveryone: true,
      initialPreferences: {'report_goals': '{"1":{"quantity":2}}'},
    );

    // the widget, the year and the progress of the goals are open
    expect(app.homeWidgets.last!.premium, isTrue);
    await openSummary(tester);
    await reach(tester, find.text('Évolution de tes objectifs'));
    expect(find.text('Débloquer avec Premium'), findsNothing);
    await tester.drag(find.byType(Scrollable).last, const Offset(0, 3000));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Année'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('CMFI Connect Premium'), findsNothing);
    expect(find.byIcon(AppIcons.premiumLock), findsNothing);

    // no Premium row in Réglages
    await openSettings(tester);
    await tester.pumpAndSettle();
    expect(find.text('CMFI Connect Premium'), findsNothing);
    expect(find.text('Rappel du soir'), findsOneWidget);
    expect(app.premium.bought, isEmpty);
  });

  testWidgets('the team has Premium without paying', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      account: sampleAccount.copyWith(role: 'superadmin'),
    );

    // the widget and the year are open
    expect(app.homeWidgets.last!.premium, isTrue);
    await openSummary(tester);
    await tester.tap(find.text('Année'));
    await tester.pumpAndSettle();
    expect(find.text('CMFI Connect Premium'), findsNothing);

    await openSettings(tester);
    await tester.pumpAndSettle();
    await reach(tester, find.text('CMFI Connect Premium'));
    expect(find.text('Actif'), findsOneWidget);
    await scrollTo(tester, find.text('CMFI Connect Premium'));
    await tester.tap(find.text('CMFI Connect Premium'));
    await tester.pumpAndSettle();
    await reach(tester, find.text('Tu as Premium'));
    expect(
      find.text(
        'Premium t\'est offert parce que tu fais partie de l\'équipe de '
        'CMFI Connect.',
      ),
      findsOneWidget,
    );
    expect(app.premium.bought, isEmpty);
  });

  testWidgets('Premium follows the account, and leaves with it', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't', account: sampleAccount);

    expect(app.premium.loggedIn, ['1']);

    await openSettings(tester);
    await tester.pumpAndSettle();
    await reach(tester, find.text('CMFI Connect Premium'));
    expect(
      find.text('Widget, année, enseignements hors ligne'),
      findsOneWidget,
    );
    await scrollToEnd(tester);
    await tester.tap(find.text('Se déconnecter'));
    await tester.pumpAndSettle();

    expect(app.premium.loggedOut, isTrue);
  });

  testWidgets('restoring without purchase says so', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await openSettings(tester);
    await tester.pumpAndSettle();
    await reach(tester, find.text('CMFI Connect Premium'));
    await scrollTo(tester, find.text('CMFI Connect Premium'));
    await tester.tap(find.text('CMFI Connect Premium'));
    await tester.pumpAndSettle();

    await reach(tester, find.text('Restaurer'));
    await tester.tap(find.text('Restaurer'));
    await tester.pumpAndSettle();

    expect(app.toasts.messages, ['Aucun achat Premium pour ce compte']);
  });

  testWidgets('for life: paid once, then managed in the Customer Center', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    await openSettings(tester);
    await tester.pumpAndSettle();
    await reach(tester, find.text('CMFI Connect Premium'));
    await scrollTo(tester, find.text('CMFI Connect Premium'));
    await tester.tap(find.text('CMFI Connect Premium'));
    await tester.pumpAndSettle();

    // the last plan, without a saving badge
    await show(tester, find.text('À VIE'));
    expect(find.text('49,99 €'), findsOneWidget);
    expect(find.text('une fois'), findsOneWidget);
    await tester.tap(find.text('À VIE'));
    await tester.pumpAndSettle();
    await reach(
      tester,
      find.text('À vie : un seul paiement, sans abonnement ni renouvellement.'),
    );
    await tester.tap(find.text('Acheter à vie'));
    await tester.pumpAndSettle();

    expect(app.premium.bought, [PremiumPeriod.lifetime]);
    await show(tester, find.text('Gérer mon abonnement'));
    await tester.tap(find.text('Gérer mon abonnement'));
    await tester.pumpAndSettle();
    expect(app.premium.managed, 1);
  });

  test('both apps sell Premium (no longer offered to everyone)', () {
    for (final (flavor, offered) in [
      (Flavor.dev, false),
      (Flavor.prod, false),
    ]) {
      final container = ProviderContainer(
        overrides: [flavorProvider.overrideWithValue(flavor)],
      );
      addTearDown(container.dispose);
      expect(container.read(premiumForEveryoneProvider), offered);
    }
  });

  testWidgets('Premium offered by the admins: the push shows it at once', (
    tester,
  ) async {
    final store = FakePremiumStore();
    final app = await pumpApp(tester, token: 't', premium: store);

    // given in RevenueCat by the server
    store.active = true;
    app.push.tapsController.add({'type': 'premium_gift', 'id': '3'});
    await tester.pumpAndSettle();

    expect(store.refreshed, 1);
    expect(find.text('Tu as Premium'), findsOneWidget);
  });
}
