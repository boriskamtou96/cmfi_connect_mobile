import 'package:cmfi_connect/src/core/config/flavor.dart';
import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets(
    'dev: « Annuler la souscription » forgets the purchase of the store',
    (tester) async {
      final store = FakePremiumStore(active: true, inStore: true);
      final app = await pumpApp(
        tester,
        token: 't',
        account: sampleAccount,
        premium: store,
      );
      expect(store.loggedIn, ['1']);
      await openMenu(tester);
      expect(find.text('CMFI Connect Premium'), findsOneWidget);

      await scrollToEnd(tester);
      await tester.tap(find.text('Annuler la souscription (dev)'));
      await tester.pumpAndSettle();
      // a confirmation first (its title and its button say the same)
      await tester.tap(find.text('Annuler la souscription').last);
      await tester.pumpAndSettle();

      // a new user of the store: the purchase is no longer theirs
      expect(store.loggedIn.last, startsWith('1-dev-'));
      expect(store.active, isFalse);
      expect(app.toasts.messages, contains('Souscription annulée (dev)'));
      expect(find.text('Annuler la souscription (dev)'), findsNothing);
      await tester.drag(find.byType(Scrollable).first, const Offset(0, 3000));
      await tester.pumpAndSettle();
      expect(find.text('Devenir Premium'), findsOneWidget);
    },
  );

  testWidgets('dev: the next launch keeps the new user of the store', (
    tester,
  ) async {
    final store = FakePremiumStore();
    await pumpApp(
      tester,
      token: 't',
      account: sampleAccount,
      premium: store,
      initialPreferences: const {'premium_dev_user': '123'},
    );
    expect(store.loggedIn, ['1-dev-123']);
  });

  testWidgets('the published app has no such button', (tester) async {
    final store = FakePremiumStore(active: true, inStore: true);
    await pumpApp(
      tester,
      token: 't',
      account: sampleAccount,
      premium: store,
      flavor: Flavor.prod,
      initialPreferences: const {'premium_dev_user': '123'},
    );
    // and the account is the user of the store
    expect(store.loggedIn, ['1']);
    await openMenu(tester);
    await scrollToEnd(tester);
    expect(find.text('Annuler la souscription (dev)'), findsNothing);
  });
}
