import 'package:cmfi_connect/src/core/utils/countries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a country has its dial code, flag and names', () {
    expect(Country.cameroon.dialCode, '+237');
    expect(Country.cameroon.flag, '🇨🇲');
    expect(Country.cameroon.name('fr'), 'Cameroun');
    expect(Country.cameroon.name('en'), 'Cameroon');
    expect(Country.cameroon.name('ar'), 'الكاميرون');
  });

  test('a profile country is read from its code or from an old free text', () {
    expect(Country.tryParse('CM'), Country.cameroon);
    expect(Country.tryParse('cm'), Country.cameroon);
    expect(Country.tryParse(' cameroun '), Country.cameroon);
    expect(Country.tryParse('Cameroon'), Country.cameroon);
    expect(Country.tryParse("Côte d'Ivoire")?.code, 'CI');
    expect(Country.tryParse('Atlantide'), isNull);
    expect(Country.tryParse(''), isNull);
    expect(Country.tryParse(null), isNull);
  });

  test('the list follows the alphabet of the language', () {
    final french = Country.sortedFor('fr').map((c) => c.name('fr')).toList();
    // É sorts with E in French, not after Z
    expect(french.indexOf('Égypte'), lessThan(french.indexOf('Espagne')));
    expect(Country.sortedFor('fr'), hasLength(Country.sortedFor('zh').length));
  });

  test('a country is found by name, code or dial code', () {
    expect(Country.cameroon.matches('camer', 'fr'), isTrue);
    expect(Country.cameroon.matches('CAMÉR', 'fr'), isTrue);
    // the English name works in every language
    expect(Country.cameroon.matches('cameroon', 'de'), isTrue);
    expect(Country.cameroon.matches('cm', 'fr'), isTrue);
    expect(Country.cameroon.matches('+237', 'fr'), isTrue);
    expect(Country.cameroon.matches('23', 'fr'), isTrue);
    expect(Country.cameroon.matches('33', 'fr'), isFalse);
    expect(Country.cameroon.matches('france', 'fr'), isFalse);
  });
}
