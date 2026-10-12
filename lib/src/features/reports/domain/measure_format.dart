import '../../../core/utils/date_extensions.dart';

/// Units come from the database as typed by an admin ("Nombre de fois",
/// "Pourcentage", "chapitres"...). These helpers make them readable next to a number.
abstract final class MeasureFormat {
  static const _countPrefixes = ['nombre de ', "nombre d'", 'number of '];
  static const _percent = {'pourcentage', 'percentage', 'pourcent', '%'};

  /// "Nombre de fois" -> "fois", "Pourcentage" -> "pourcentage". For subtitles.
  static String? unitLabel(String? unit) {
    final value = unit?.trim() ?? '';
    if (value.isEmpty) {
      return null;
    }
    final lower = value.toLowerCase();
    for (final prefix in _countPrefixes) {
      if (lower.startsWith(prefix)) {
        return value.substring(prefix.length);
      }
    }
    return value[0].toLowerCase() + value.substring(1);
  }

  /// Like [unitLabel], but "%" for a percentage. Written after a number.
  static String? unitSymbol(String? unit) {
    final label = unitLabel(unit);
    return label != null && _percent.contains(label.toLowerCase())
        ? '%'
        : label;
  }

  /// "10 chapitres", "2 h", "1 fois · 30 min". [withUnit] false gives "10", "1 · 30 min".
  static String value({
    int? quantity,
    int? minutes,
    String? unit,
    bool withUnit = true,
  }) {
    final symbol = withUnit ? unitSymbol(unit) : null;
    return [
      if (quantity != null) symbol == null ? '$quantity' : '$quantity $symbol',
      if (minutes != null) minutes.toDurationLabel(),
    ].join(' · ');
  }
}
