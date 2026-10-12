import 'package:intl/intl.dart';

import 'strings.g.dart';

/// What the languages of the app need before the first text is shown.
void setUpLanguages() {
  _registerPluralRules();
  // dates in 0-9 digits, like every number of the app (Arabic would
  // otherwise write them ٠-٩)
  DateFormat.useNativeDigitsByDefaultFor('ar', false);
}

/// Plural rules slang doesn't ship (CLDR), for the languages that need them:
/// Hindi (0 and 1 are "one") and Chinese (one form). Arabic, French, English,
/// German and Spanish are built in. A special sentence for 0 (`zero`) wins,
/// as in the other languages.
void _registerPluralRules() {
  LocaleSettings.setPluralResolverSync(
    language: 'hi',
    cardinalResolver: (n, {zero, one, two, few, many, other}) {
      if (n == 0 && zero != null) {
        return zero;
      }
      if (n == 0 || n == 1) {
        return one ?? other!;
      }
      return other!;
    },
    ordinalResolver: (n, {zero, one, two, few, many, other}) => other!,
  );
  LocaleSettings.setPluralResolverSync(
    language: 'zh',
    cardinalResolver: (n, {zero, one, two, few, many, other}) =>
        n == 0 && zero != null ? zero : other!,
    ordinalResolver: (n, {zero, one, two, few, many, other}) => other!,
  );
}
