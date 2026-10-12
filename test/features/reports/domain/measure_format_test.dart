import 'package:cmfi_connect/src/features/reports/domain/measure_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('unit labels drop "Nombre de" and lower the first letter', () {
    expect(MeasureFormat.unitLabel('Nombre de fois'), 'fois');
    expect(MeasureFormat.unitLabel('Nombre de pages'), 'pages');
    expect(MeasureFormat.unitLabel('Pourcentage'), 'pourcentage');
    expect(MeasureFormat.unitLabel('chapitres'), 'chapitres');
    expect(MeasureFormat.unitLabel('  '), isNull);
    expect(MeasureFormat.unitLabel(null), isNull);
  });

  test('a percentage is written with %', () {
    expect(MeasureFormat.unitSymbol('Pourcentage'), '%');
    expect(MeasureFormat.value(quantity: 10, unit: 'Pourcentage'), '10 %');
  });

  test('values join quantity and duration', () {
    expect(
      MeasureFormat.value(quantity: 10, unit: 'chapitres'),
      '10 chapitres',
    );
    expect(MeasureFormat.value(minutes: 120), '2 h');
    expect(
      MeasureFormat.value(quantity: 1, minutes: 30, unit: 'Nombre de fois'),
      '1 fois · 30 min',
    );
    expect(
      MeasureFormat.value(
        quantity: 1,
        minutes: 30,
        unit: 'Nombre de fois',
        withUnit: false,
      ),
      '1 · 30 min',
    );
  });
}
