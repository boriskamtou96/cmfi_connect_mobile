import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:flutter_test/flutter_test.dart';

ReportEntry _entry(
  String code, {
  bool quantity = true,
  bool duration = true,
  String? unit,
}) => ReportEntry(
  activityTypeId: 1,
  code: code,
  label: code,
  tracksQuantity: quantity,
  quantityUnit: unit,
  tracksDuration: duration,
);

void main() {
  test('countsTimes: standard « times » items and personal ones without a '
      'unit', () {
    expect(_entry('RDQAD', unit: 'Nombre de fois').countsTimes, isTrue);
    expect(_entry('PG', unit: 'Nombre de fois').countsTimes, isTrue);
    expect(_entry('LB', unit: 'chapitres').countsTimes, isFalse);
    expect(_entry('LLC', unit: 'Nombre de pages').countsTimes, isFalse);
    expect(_entry('PS', quantity: false).countsTimes, isFalse);
    expect(
      _entry('JC', duration: false, unit: 'Nombre de fois').countsTimes,
      isFalse,
    );
    expect(_entry('CHANT').countsTimes, isTrue);
    expect(_entry('CHANT', unit: '  ').countsTimes, isTrue);
    expect(_entry('CHANT', unit: 'personnes').countsTimes, isFalse);
  });
}
