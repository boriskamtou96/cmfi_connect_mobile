import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/reports/presentation/widgets/entry_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<void> openReports(WidgetTester tester) async {
    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();
  }

  testWidgets('lists standard and personal items with what they measure', (
    tester,
  ) async {
    await pumpApp(tester, token: 'saved-token');
    await openReports(tester);

    expect(find.text('Lecture biblique'), findsOneWidget);
    expect(find.text('chapitres'), findsOneWidget);
    expect(find.text('STANDARDS'), findsOneWidget);
    expect(find.text('MES ÉLÉMENTS'), findsOneWidget);
    // "Nombre de fois" + duration -> "fois et durée"
    expect(find.text('fois et durée'), findsOneWidget);
    expect(find.text('0 sur 3 renseignés'), findsOneWidget);
  });

  testWidgets('fill an item in the sheet, then save the day', (tester) async {
    final app = await pumpApp(tester, token: 'saved-token');
    await openReports(tester);

    await tester.tap(find.text('Lecture biblique'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byType(EntrySheet),
        matching: find.byType(TextField),
      ),
      '3',
    );
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();

    expect(find.text('3 chapitres'), findsOneWidget);
    expect(find.text('1 sur 3 renseignés'), findsOneWidget);
    expect(find.text('Non enregistré'), findsOneWidget);

    await tester.tap(find.text('Enregistrer la journée'));
    await tester.pumpAndSettle();

    final saved = app.reportsApi.saves.single;
    expect(saved.date, today());
    expect(saved.entries.single.activityTypeId, 1);
    expect(saved.entries.single.quantity, 3);
    expect(app.toasts.messages, ['Journée enregistrée']);
    expect(find.text('Enregistré'), findsOneWidget);
  });

  testWidgets('a duration is picked with the preset chips', (tester) async {
    final app = await pumpApp(tester, token: 'saved-token');
    await openReports(tester);

    await tester.tap(find.text('Prière seule'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('45 min'));
    await tester.tap(find.text('+ 1 min'));
    await tester.tap(find.text('+ 1 min'));
    // "−" turns on once the sheet has rebuilt with a duration
    await tester.pump();
    await tester.tap(find.text('− 1 min'));
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();

    expect(find.text('46 min'), findsOneWidget);

    await tester.tap(find.text('Enregistrer la journée'));
    await tester.pumpAndSettle();

    expect(app.reportsApi.saves.single.entries.single.durationMinutes, 46);
  });

  testWidgets('from an empty duration, "+ 1 min" gives 1 min', (tester) async {
    final app = await pumpApp(tester, token: 'saved-token');
    await openReports(tester);

    await tester.tap(find.text('Prière seule'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<OutlinedButton>(
            find.widgetWithText(OutlinedButton, '− 1 min'),
          )
          .onPressed,
      isNull,
    );

    await tester.tap(find.text('+ 1 min'));
    await tester.pumpAndSettle();
    // the value of the sheet, above the presets
    expect(find.text('1 min'), findsOneWidget);

    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();
    expect(find.text('1 min'), findsOneWidget);

    await tester.tap(find.text('Enregistrer la journée'));
    await tester.pumpAndSettle();
    expect(app.reportsApi.saves.single.entries.single.durationMinutes, 1);
  });

  testWidgets('holding "+ 1 min" repeats, faster after a second', (
    tester,
  ) async {
    await pumpApp(tester, token: 'saved-token');
    await openReports(tester);

    await tester.tap(find.text('Prière seule'));
    await tester.pumpAndSettle();

    final hold = await tester.startGesture(
      tester.getCenter(find.text('+ 1 min')),
    );
    // first repeat after 400 ms, then every 120 ms, every 60 ms after 1 s:
    // steps at 400, 520, 640, 760, 880, 1000, then 1060 … 1480 ms
    await tester.pump(const Duration(milliseconds: 1500));
    await hold.up();
    await tester.pumpAndSettle();

    // releasing the button doesn't add one more minute
    expect(find.text('14 min'), findsOneWidget);

    // and the repeat has stopped
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('14 min'), findsOneWidget);
  });

  testWidgets('unsaved values survive a tab change', (tester) async {
    await pumpApp(tester, token: 'saved-token');
    await openReports(tester);

    await tester.tap(find.text('Prière seule'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('1 h'));
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Accueil'));
    await tester.pumpAndSettle();
    // the home card reads the same draft
    expect(find.text('1 sur 3'), findsOneWidget);

    await openReports(tester);
    expect(find.text('Non enregistré'), findsOneWidget);
  });
}
