import 'dart:typed_data';

import 'package:cmfi_connect/src/core/utils/xlsx.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a sheet written is read back: texts, numbers, empty cells', () {
    final bytes = writeXlsx([
      ['Date', 'LB – Lecture (chapitres)', 'PS – Prière & <jeûne> (min)'],
      ['2026-11-01', 3, 45],
      ['2026-11-02', null, 30.5],
    ]);
    expect(readXlsx(bytes), [
      ['Date', 'LB – Lecture (chapitres)', 'PS – Prière & <jeûne> (min)'],
      ['2026-11-01', 3, 45],
      ['2026-11-02', null, 30.5],
    ]);
  });

  test('a date typed in Excel is a number of days', () {
    expect(excelDate(46327), DateTime(2026, 11, 1));
  });

  test('what is not an Excel file is refused', () {
    expect(
      () => readXlsx(Uint8List.fromList([1, 2, 3])),
      throwsFormatException,
    );
  });
}
