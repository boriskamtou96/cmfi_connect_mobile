import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/languages.dart';
import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/reports/application/report_files.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/fakes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await initializeDateFormatting();
    setUpLanguages();
  });

  const tithes = ActivityType(
    id: 8,
    code: 'Dîmes',
    label: 'Dîmes',
    tracksQuantity: true,
    quantityUnit: 'Pourcentage',
    position: 8,
    isStandard: true,
  );

  // the server writes the standard items in French
  final export = ReportExport.build(
    from: DateTime(2026, 10),
    to: DateTime(2026, 10, 3),
    history: [
      DailyReport(
        date: DateTime(2026, 10),
        submitted: true,
        entries: const [
          ReportEntry(
            activityTypeId: 1,
            code: 'LB',
            label: 'Lecture biblique',
            tracksQuantity: true,
            quantityUnit: 'chapitres',
            quantity: 1,
          ),
          ReportEntry(
            activityTypeId: 2,
            code: 'PS',
            label: 'Prière seule',
            tracksDuration: true,
            durationMinutes: 45,
          ),
          ReportEntry(
            activityTypeId: 30,
            code: 'RQDQA',
            label: 'RQDQA',
            tracksQuantity: true,
            quantityUnit: 'Nombre de fois',
            tracksDuration: true,
            quantity: 2,
            durationMinutes: 30,
          ),
          ReportEntry(
            activityTypeId: 8,
            code: 'Dîmes',
            label: 'Dîmes',
            tracksQuantity: true,
            quantityUnit: 'Pourcentage',
            quantity: 10,
          ),
        ],
      ),
    ],
    activities: [...sampleActivities, tithes],
  );
  final en = AppLocale.en.buildSync();
  final fr = AppLocale.fr.buildSync();

  test('the message names the standard items in the app language', () {
    final text = reportAsText(
      export,
      t: en,
      locale: 'en',
      owner: (name: 'Boris Kamtou', church: null),
    );
    expect(text, contains('• LB Bible reading : 1 chapter (1 day)'));
    expect(text, contains('• PS Personal prayer : 45 min (1 day)'));
    // the code stays as the server gives it, even when it is a word
    expect(text, contains('• Dîmes Tithes : 10% (1 day)'));
    // a personal item is written as typed
    expect(text, contains('• RQDQA : 2 fois · 30 min (1 day)'));
    expect(text, isNot(contains('Lecture biblique')));
  });

  test('in French, the words are the server ones, with a real singular', () {
    final text = reportAsText(
      export,
      t: fr,
      locale: 'fr',
      owner: (name: 'Boris Kamtou', church: null),
    );
    expect(text, contains('• LB Lecture biblique : 1 chapitre (1 jour)'));
    // named like its code: written once
    expect(text, contains('• Dîmes : 10 % (1 jour)'));
  });

  test('the spreadsheet columns are translated too', () {
    final header = utf8
        .decode(reportAsCsv(export, t: en, locale: 'en'))
        .split('\r\n')
        .first;
    expect(header, contains('LB – Bible reading (chapters)'));
    expect(header, contains('PS – Personal prayer (min)'));
    expect(header, contains('Dîmes – Tithes (%)'));
    expect(header, contains('RQDQA – RQDQA (fois)'));
  });

  test('the PDF is built with the translated names', () async {
    final bytes = await reportAsPdf(
      export,
      t: en,
      locale: 'en',
      owner: (name: 'Boris Kamtou', church: null),
    );
    expect(ascii.decode(bytes.sublist(0, 5)), '%PDF-');
  });
}
