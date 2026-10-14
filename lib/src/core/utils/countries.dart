import 'package:phone_numbers_parser/metadata.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

import '../i18n/country_names.dart';

/// A country of a phone number or of the profile, kept by its ISO code ("CM").
/// The names come in the 7 languages of the app (`country_names.dart`).
class Country {
  const Country(this.isoCode);

  static const cameroon = Country(IsoCode.CM);

  final IsoCode isoCode;

  /// "CM": what the API stores for the profile.
  String get code => isoCode.name;

  /// "+237"
  String get dialCode => '+${metadataByIsoCode[isoCode]!.countryCode}';

  /// 🇨🇲, made of the two "regional indicator" letters of the code.
  String get flag => String.fromCharCodes(
    code.codeUnits.map((letter) => 0x1F1E6 + letter - 0x41),
  );

  /// "Cameroun" in French, "Cameroon" in English…
  String name(String languageCode) =>
      countryNames[languageCode]?[code] ?? countryNames['en']![code] ?? code;

  /// A country from its ISO code, any case; null if unknown.
  static Country? tryCode(String? code) {
    final isoCode = IsoCode.values.asNameMap()[code?.trim().toUpperCase()];
    return isoCode == null ? null : Country(isoCode);
  }

  /// A country from its code or from its name in any language of the app
  /// ("Cameroun", "cameroon"): profiles saved before the country list held
  /// free text. Null when nothing matches.
  static Country? tryParse(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (tryCode(value) case final country?) {
      return country;
    }
    final wanted = foldForSearch(value);
    for (final names in countryNames.values) {
      for (final MapEntry(key: code, value: name) in names.entries) {
        if (foldForSearch(name) == wanted) {
          return tryCode(code);
        }
      }
    }
    return null;
  }

  /// Every country, in the alphabetical order of [languageCode].
  static List<Country> sortedFor(String languageCode) => [
    for (final code
        in countryCodesByName[languageCode] ?? countryCodesByName['en']!)
      tryCode(code)!,
  ];

  /// Whether [query] finds this country: its name in [languageCode] or in
  /// English, its code ("cm") or its dial code ("237", "+237").
  bool matches(String query, String languageCode) {
    final wanted = foldForSearch(query);
    if (wanted.isEmpty) {
      return true;
    }
    final digits = wanted.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isNotEmpty && digits == wanted.replaceAll('+', '')) {
      return dialCode.substring(1).startsWith(digits);
    }
    return code.toLowerCase() == wanted ||
        foldForSearch(name(languageCode)).contains(wanted) ||
        foldForSearch(name('en')).contains(wanted);
  }

  @override
  bool operator ==(Object other) =>
      other is Country && other.isoCode == isoCode;

  @override
  int get hashCode => isoCode.hashCode;

  @override
  String toString() => 'Country($code)';
}

const _accents = {
  'àáâãäåā': 'a',
  'çćč': 'c',
  'èéêëēė': 'e',
  'ìíîïī': 'i',
  'ñń': 'n',
  'òóôõöøō': 'o',
  'ùúûüū': 'u',
  'ýÿ': 'y',
  'ß': 'ss',
  'œ': 'oe',
  'æ': 'ae',
  '’\'-': ' ',
};

/// Lower case without accents nor apostrophes, for searching:
/// "Côte d’Ivoire" -> "cote d ivoire".
String foldForSearch(String text) {
  final buffer = StringBuffer();
  for (final char in text.trim().toLowerCase().split('')) {
    buffer.write(
      _accents.entries
              .where((entry) => entry.key.contains(char))
              .map((entry) => entry.value)
              .firstOrNull ??
          char,
    );
  }
  return buffer.toString().replaceAll(RegExp(r'\s+'), ' ');
}
