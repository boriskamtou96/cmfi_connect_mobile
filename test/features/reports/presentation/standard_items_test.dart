import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/reports/presentation/widgets/entry_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.en));
  tearDown(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<void> openReports(WidgetTester tester) async {
    await pumpApp(tester, token: 'saved-token');
    await tester.tap(find.text('Report').last);
    await tester.pumpAndSettle();
  }

  testWidgets(
    'in English, standard items are in English, personal ones as typed',
    (tester) async {
      await openReports(tester);

      // the server sends "Lecture biblique", "chapitres", "Prière seule"
      expect(find.text('Bible reading'), findsOneWidget);
      expect(find.text('chapters'), findsOneWidget);
      expect(find.text('Personal prayer'), findsOneWidget);
      expect(find.text('Lecture biblique'), findsNothing);
      // RQDQA is the user's own item ("Nombre de fois"): unchanged
      expect(find.text('fois and duration'), findsOneWidget);

      await tester.tap(find.text('Bible reading'));
      await tester.pumpAndSettle();
      final sheet = find.byType(EntrySheet);
      expect(
        find.descendant(of: sheet, matching: find.text('Bible reading')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: sheet, matching: find.text('Number of chapters')),
        findsOneWidget,
      );
      await tester.enterText(
        find.descendant(of: sheet, matching: find.byType(TextField)),
        '1',
      );
      await tester.tap(find.descendant(of: sheet, matching: find.text('Done')));
      await tester.pumpAndSettle();

      expect(find.text('1 chapter'), findsOneWidget);
    },
  );

  testWidgets('my items list the standard ones in English', (tester) async {
    await openReports(tester);

    await tester.tap(find.byTooltip('My items'));
    await tester.pumpAndSettle();

    expect(find.text('Bible reading'), findsOneWidget);
    expect(find.text('Quantity · chapters'), findsOneWidget);
    expect(find.text('Personal prayer'), findsOneWidget);
    expect(find.text('Quantity (fois) and duration'), findsOneWidget);
  });
}
