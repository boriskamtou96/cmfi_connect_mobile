import 'package:phone_numbers_parser/metadata.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

import 'countries.dart';

/// A typed number read for [country]: "6 90 00 00 01" in Cameroon is
/// +237 6 90 00 00 01. A number typed with its own "+" or "00" prefix keeps
/// its own country. Null when nothing can be read.
PhoneNumber? parsePhone(String input, Country country) {
  final compact = input.replaceAll(RegExp(r'[^0-9+]'), '');
  if (compact.replaceAll('+', '').isEmpty) {
    return null;
  }
  try {
    if (compact.startsWith('+')) {
      return PhoneNumber.parse(compact);
    }
    if (compact.startsWith('00')) {
      return PhoneNumber.parse('+${compact.substring(2)}');
    }
    return PhoneNumber.parse(compact, destinationCountry: country.isoCode);
  } on PhoneNumberException {
    return null;
  }
}

/// Whether [input] is a real number of [country] (or of the country of its
/// own "+" prefix). With [lenient], only its length is checked: signing in
/// must never refuse a number that already has an account.
bool isValidPhone(String input, Country country, {bool lenient = false}) {
  final number = parsePhone(input, country);
  if (number == null) {
    return false;
  }
  return lenient ? number.isValidLength() : number.isValid();
}

/// Builds the number sent to the API: "6 90 00 00 01" -> "+237690000001".
String toInternationalPhone(
  String input, {
  Country country = Country.cameroon,
}) {
  if (parsePhone(input, country) case final number?) {
    return number.international;
  }
  return '${country.dialCode}${input.replaceAll(RegExp(r'[^0-9]'), '')}';
}

/// "+237690000001" -> "+237 6 90 00 00 01", in the usual grouping of each
/// country. A number that can't be read is shown as stored.
String formatPhone(String phone) {
  final number = parsePhone(phone, Country.cameroon);
  if (number == null || !number.isValidLength()) {
    return phone;
  }
  return '+${number.countryCode} ${number.formatNsn()}';
}

/// A mobile number of [country] in its usual grouping ("6 71 23 45 67"),
/// shown as a hint in the empty field.
String examplePhone(Country country) {
  final example = metadataExamplesByIsoCode[country.isoCode]?.mobile ?? '';
  if (example.isEmpty) {
    return '';
  }
  return PhoneNumber(isoCode: country.isoCode, nsn: example).formatNsn();
}
