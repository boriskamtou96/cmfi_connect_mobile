import 'dart:typed_data';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/core/utils/xlsx.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_import.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

const _items = [
  ActivityType(
    id: 1,
    code: 'LB',
    label: 'Lecture biblique',
    tracksQuantity: true,
    quantityUnit: 'chapitres',
    isStandard: true,
  ),
  ActivityType(
    id: 2,
    code: 'PS',
    label: 'Prière seule',
    tracksDuration: true,
    isStandard: true,
  ),
];

ReportImport _read(List<List<Object?>> rows, {DateTime? now}) =>
    ReportImport.read(
      rows,
      items: _items,
      now: now ?? DateTime(2026, 11, 13),
      fromSerial: excelDate,
    );

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  test('a row per day: dates written three ways, numbers, empty cells', () {
    final read = _read([
      ['Date', 'LB – Lecture biblique (chapitres)', 'PS – Prière seule (min)'],
      ['2026-11-01', 3, 45],
      ['02/11/2026', '4', null],
      [46329, null, 30],
      [null, null, null],
    ]);

    expect(read.badRows, isEmpty);
    expect(read.unknownColumns, isEmpty);
    expect(read.days.keys, [
      DateTime(2026, 11, 1),
      DateTime(2026, 11, 2),
      DateTime(2026, 11, 3),
    ]);
    final first = read.days[DateTime(2026, 11, 1)]!;
    expect(
      first.map((entry) => (entry.code, entry.quantity, entry.durationMinutes)),
      [('LB', 3, null), ('PS', null, 45)],
    );
    expect(read.days[DateTime(2026, 11, 2)]!.single.quantity, 4);
    expect(read.days[DateTime(2026, 11, 3)]!.single.durationMinutes, 30);
  });

  test('what cannot be read is named: no date, a word for a number, an '
      'unknown column, a day to come', () {
    final read = _read([
      ['Date', 'LB – Lecture', 'XX – Inconnu'],
      ['bientôt', 2, null],
      ['2026-11-05', 'beaucoup', null],
      ['31/02/2026', 1, null],
      ['2026-12-25', 1, null],
    ]);

    expect(read.days, isEmpty);
    expect(read.badRows, [2, 3, 4]);
    expect(read.unknownColumns, ['XX – Inconnu']);
    expect(read.future, 1);
  });

  testWidgets('a file chosen is shown before anything is saved; a day '
      'already filled is left; the others are sent', (tester) async {
    final yesterday = today().subtract(const Duration(days: 1));
    final before = today().subtract(const Duration(days: 2));
    final app = await pumpApp(
      tester,
      token: 't',
      activities: _items,
      reportDays: {yesterday: DailyReport(date: yesterday, submitted: true)},
    );
    app.documentPicker.next.add((
      bytes: Uint8List.fromList(
        writeXlsx([
          ['Date', 'LB – Lecture biblique (chapitres)', 'PS – Prière (min)'],
          [yesterday.toApiDate(), 5, 20],
          [before.toApiDate(), 2, 60],
        ]),
      ),
      name: 'mes_jours.xlsx',
    ));
    // ignore: unawaited_futures
    app.container.read(appRouterProvider).push(const ImportReportRoute());
    await tester.pumpAndSettle();

    expect(find.text('Importer depuis Excel'), findsOneWidget);
    await tester.tap(find.text('Choisir un fichier Excel'));
    await tester.pumpAndSettle();

    expect(find.textContaining('1 jour à importer'), findsOneWidget);
    expect(find.text('1 jour déjà rempli, laissé tel quel'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Importer 1 jour'), 200);
    await tester.tap(find.text('Importer 1 jour'));
    await tester.pumpAndSettle();

    expect(find.text('1 jour importé.'), findsOneWidget);
    final saved = app.reportsApi.saves.single;
    expect(saved.date, before);
    expect(
      saved.entries.map(
        (entry) => (entry.code, entry.quantity, entry.durationMinutes),
      ),
      [('LB', 2, null), ('PS', null, 60)],
    );
  });
}
