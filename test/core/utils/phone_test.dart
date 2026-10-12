import 'package:cmfi_connect/src/core/utils/phone.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a local number gets the Cameroon dial code', () {
    expect(toInternationalPhone('6 90 00 00 01'), '+237690000001');
    expect(toInternationalPhone('690-000-001'), '+237690000001');
  });

  test('a number with its own dial code is kept', () {
    expect(toInternationalPhone('+33 6 12 34 56 78'), '+33612345678');
    expect(toInternationalPhone('0033612345678'), '+33612345678');
  });

  test('a Cameroon number is shown in pairs', () {
    expect(formatPhone('+237690000001'), '+237 6 90 00 00 01');
    expect(formatPhone('+33612345678'), '+33612345678');
  });
}
