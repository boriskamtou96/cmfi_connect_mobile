import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/app_update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

AppVersion v(String text) => AppVersion.tryParse(text)!;

const lockedTitle = 'Mise à jour nécessaire';
const offeredTitle = 'Nouvelle version disponible';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('required', () {
    testWidgets('a version no longer allowed opens on the update screen', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        token: 't',
        updateRules: FakeUpdateRules(
          UpdateRules(
            minimum: v('1.0.22'),
            messages: const {'fr': 'Les comptes rendus passent par la v2.'},
            storeUrl: 'https://apps.apple.com/app/id1',
          ),
        ),
      );

      expect(find.text(lockedTitle), findsOneWidget);
      expect(
        find.text('Les comptes rendus passent par la v2.'),
        findsOneWidget,
      );
      expect(
        find.text('Ta version : 1.0.21 · Nouvelle : 1.0.22'),
        findsOneWidget,
      );
      expect(find.byType(NavigationBar), findsNothing);

      await tester.tap(find.text('Mettre à jour'));
      await tester.pumpAndSettle();
      expect(app.installer.updates, [
        (required: true, storeUrl: 'https://apps.apple.com/app/id1'),
      ]);

      // no way back to the app
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text(lockedTitle), findsOneWidget);
    });

    testWidgets('a rule published while the app is open locks it at once, '
        'and lifted, gives it back', (tester) async {
      final app = await pumpApp(tester, token: 't');
      expect(find.byType(NavigationBar), findsOneWidget);

      app.updateRules.publish(UpdateRules(minimum: v('1.0.22')));
      await tester.pumpAndSettle();
      expect(find.text(lockedTitle), findsOneWidget);

      app.updateRules.publish(UpdateRules.none);
      await tester.pumpAndSettle();
      expect(find.text(lockedTitle), findsNothing);
      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets('the store could not be opened: said under the button', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        updateRules: FakeUpdateRules(UpdateRules(minimum: v('2.0'))),
      );
      app.installer.answer = UpdateStart.failed;

      await tester.tap(find.text('Mettre à jour'));
      await tester.pumpAndSettle();
      expect(
        find.text("Impossible d'ouvrir le store. Réessaie plus tard."),
        findsOneWidget,
      );
    });

    testWidgets('the version unknown: never locked', (tester) async {
      await pumpApp(
        tester,
        token: 't',
        installer: FakeAppInstaller(version: null),
        updateRules: FakeUpdateRules(UpdateRules(minimum: v('9.0'))),
      );
      expect(find.text(lockedTitle), findsNothing);
      expect(find.byType(NavigationBar), findsOneWidget);
    });
  });

  group('optional', () {
    testWidgets('offered once per version', (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        updateRules: FakeUpdateRules(UpdateRules(latest: v('1.0.22'))),
      );

      expect(find.text(offeredTitle), findsOneWidget);
      expect(
        find.text(
          'La version 1.0.22 est prête, avec des améliorations et des '
          'corrections.',
        ),
        findsOneWidget,
      );
      await tester.tap(find.text('Plus tard'));
      await tester.pumpAndSettle();
      expect(find.text(offeredTitle), findsNothing);
      expect(app.installer.updates, isEmpty);

      // the same version again: not offered
      app.updateRules.publish(UpdateRules(latest: v('1.0.22')));
      await tester.pumpAndSettle();
      expect(find.text(offeredTitle), findsNothing);

      // a newer one: offered, and accepted
      app.updateRules.publish(UpdateRules(latest: v('1.0.23')));
      await tester.pumpAndSettle();
      expect(find.text(offeredTitle), findsOneWidget);
      await tester.tap(find.text('Mettre à jour'));
      await tester.pumpAndSettle();
      expect(app.installer.updates, [(required: false, storeUrl: '')]);
    });

    testWidgets('Plus keeps a button to update later', (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        updateRules: FakeUpdateRules(UpdateRules(latest: v('1.0.22'))),
        initialPreferences: {AppUpdate.offeredKey: '1.0.22'},
      );
      expect(find.text(offeredTitle), findsNothing);

      await openSettings(tester);
      await scrollToEnd(tester);
      await tester.tap(find.text('Mettre à jour vers la version 1.0.22'));
      await tester.pumpAndSettle();
      expect(app.installer.updates, [(required: false, storeUrl: '')]);
    });

    testWidgets('downloaded by Google Play: installed when asked', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        token: 't',
        updateRules: FakeUpdateRules(UpdateRules(latest: v('1.0.22'))),
      );
      app.installer.answer = UpdateStart.downloading;
      await tester.tap(find.text('Mettre à jour'));
      await tester.pumpAndSettle();
      expect(app.toasts.messages, ['Téléchargement de la mise à jour…']);

      app.installer.downloads.add(null);
      await tester.pumpAndSettle();
      expect(find.text('La mise à jour est prête'), findsOneWidget);
      await tester.tap(find.text('Redémarrer'));
      await tester.pumpAndSettle();
      expect(app.installer.installs, 1);
    });

    testWidgets('up to date: nothing offered, nothing in Plus', (tester) async {
      await pumpApp(
        tester,
        token: 't',
        updateRules: FakeUpdateRules(UpdateRules(latest: v('1.0.21'))),
      );
      expect(find.text(offeredTitle), findsNothing);

      await openSettings(tester);
      await scrollToEnd(tester);
      expect(find.textContaining('Mettre à jour vers'), findsNothing);
    });
  });
}
