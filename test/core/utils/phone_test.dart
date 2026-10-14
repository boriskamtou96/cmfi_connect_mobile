import 'package:cmfi_connect/src/core/utils/countries.dart';
import 'package:cmfi_connect/src/core/utils/phone.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

void main() {
  const france = Country(IsoCode.FR);

  test('a local number gets the dial code of its country', () {
    expect(toInternationalPhone('6 90 00 00 01'), '+237690000001');
    expect(toInternationalPhone('690-000-001'), '+237690000001');
    // the French national 0 is dropped
    expect(
      toInternationalPhone('06 12 34 56 78', country: france),
      '+33612345678',
    );
  });

  test('a number with its own dial code keeps it', () {
    expect(toInternationalPhone('+33 6 12 34 56 78'), '+33612345678');
    expect(toInternationalPhone('0033612345678'), '+33612345678');
    expect(
      toInternationalPhone('+237 6 90 00 00 01', country: france),
      '+237690000001',
    );
  });

  test('a number is checked for its country', () {
    expect(isValidPhone('6 90 00 00 01', Country.cameroon), isTrue);
    expect(isValidPhone('6 00 00 00 00', Country.cameroon), isFalse);
    expect(isValidPhone('6 12 34 56 78', france), isTrue);
    expect(isValidPhone('6 90 00', Country.cameroon), isFalse);
    expect(isValidPhone('', Country.cameroon), isFalse);
  });

  test('signing in only checks the length', () {
    expect(
      isValidPhone('6 00 00 00 00', Country.cameroon, lenient: true),
      isTrue,
    );
    expect(isValidPhone('6 90 00', Country.cameroon, lenient: true), isFalse);
  });

  test('a number is shown in the grouping of its country', () {
    expect(formatPhone('+237690000001'), '+237 6 90 00 00 01');
    expect(formatPhone('+33612345678'), '+33 6 12 34 56 78');
    expect(formatPhone('not a number'), 'not a number');
  });

  test('the hint is a mobile number of the country', () {
    expect(examplePhone(Country.cameroon), '6 71 23 45 67');
    expect(examplePhone(france), '6 12 34 56 78');
  });
}
