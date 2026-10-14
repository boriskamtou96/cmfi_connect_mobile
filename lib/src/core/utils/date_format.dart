import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'zoned_time.dart';

extension DateFormatX on BuildContext {
  /// [date] in the app language, e.g. pattern 'EEEE d MMMM' -> "vendredi 9 octobre".
  String formatDate(DateTime date, String pattern) => DateFormat(
    pattern,
    Localizations.localeOf(this).toLanguageTag(),
  ).format(date);

  /// "20 – 22 nov. 2026", "28 nov. – 2 déc. 2026", "20 nov. 2026" (one day),
  /// on the calendar of [timeZone] ("Africa/Douala") when given.
  String formatDayRange(DateTime from, DateTime to, {String? timeZone}) {
    final locale = Localizations.localeOf(this).toLanguageTag();
    final start = timeZone == null ? from : from.inZone(timeZone);
    final end = timeZone == null ? to : to.inZone(timeZone);
    final full = DateFormat.yMMMd(locale);
    if (start.year == end.year &&
        start.month == end.month &&
        start.day == end.day) {
      return full.format(start);
    }
    if (start.year != end.year) {
      return '${full.format(start)} – ${full.format(end)}';
    }
    if (start.month == end.month && locale.startsWith('fr')) {
      return '${start.day} – ${full.format(end)}';
    }
    return '${DateFormat.MMMd(locale).format(start)} – ${full.format(end)}';
  }
}

extension NumberFormatX on BuildContext {
  /// [n] in the app language: "10 000", "10,000".
  String formatNumber(num n) => NumberFormat.decimalPattern(
    Localizations.localeOf(this).toLanguageTag(),
  ).format(n);
}

extension CapitalizeX on String {
  /// "vendredi 9 octobre" -> "Vendredi 9 octobre".
  String get capitalized =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);
}

extension PercentFormatX on BuildContext {
  /// [ratio] (0 to 1) as a percentage in the app language: "72 %", "72%".
  String formatPercent(double ratio) => NumberFormat.percentPattern(
    Localizations.localeOf(this).toLanguageTag(),
  ).format(ratio);
}
