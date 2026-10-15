import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/reports/presentation/widgets/entry_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets(
    'the widget follows the day: to fill in, then done with its goals',
    (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        premium: FakePremiumStore(active: true),
        initialPreferences: {'report_goals': '{"1":{"quantity":4}}'},
      );

      final before = app.homeWidgets.last!;
      expect(before.signedIn, isTrue);
      expect(before.premium, isTrue);
      expect(before.done, isFalse);
      expect(before.goalPercent, 0);
      expect(before.texts['todo'], 'À remplir');

      await tester.tap(find.text('Compte rendu').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Lecture biblique'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.descendant(
          of: find.byType(EntrySheet),
          matching: find.byType(TextField),
        ),
        '2',
      );
      await tester.tap(find.text('Valider'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Enregistrer la journée'));
      await tester.pumpAndSettle();

      final after = app.homeWidgets.last!;
      expect(after.done, isTrue);
      expect(after.goalPercent, 50);
      expect(after.filled, 1);
      expect(after.texts['items'], startsWith('1 sur'));
    },
  );

  testWidgets('a touch on the widget opens today', (tester) async {
    final app = await pumpApp(tester, token: 't');

    app.homeWidgets.clicksController.add(Uri.parse('cmficonnect://today'));
    await tester.pumpAndSettle();

    expect(find.text('Enregistrer la journée'), findsOneWidget);
  });

  testWidgets('signing out empties the widget', (tester) async {
    final app = await pumpApp(tester, token: 't');

    await openMore(tester);
    await tester.pumpAndSettle();
    await scrollToEnd(tester);
    await tester.tap(find.text('Se déconnecter'));
    await tester.pumpAndSettle();

    expect(app.homeWidgets.last!.signedIn, isFalse);
    expect(
      app.homeWidgets.last!.texts['signed_out'],
      'Connecte-toi dans l\'app',
    );
  });
}
