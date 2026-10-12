/// The app targets Cameroon first.
const defaultDialCode = '+237';

/// Builds the number sent to the API: "6 90 00 00 01" -> "+237690000001".
/// A number typed with its own "+" prefix is kept as is.
String toInternationalPhone(String input, {String dialCode = defaultDialCode}) {
  final compact = input.replaceAll(RegExp(r'[^0-9+]'), '');
  if (compact.startsWith('+')) {
    return compact;
  }
  if (compact.startsWith('00')) {
    return '+${compact.substring(2)}';
  }
  return '$dialCode$compact';
}

/// "+237690000001" -> "+237 6 90 00 00 01". Other numbers are shown as stored.
String formatPhone(String phone) {
  final match = RegExp(
    r'^\+237(\d)(\d{2})(\d{2})(\d{2})(\d{2})$',
  ).firstMatch(phone);
  if (match == null) {
    return phone;
  }
  return '+237 ${[for (var i = 1; i <= 5; i++) match.group(i)].join(' ')}';
}
