import '../../../core/utils/date_extensions.dart';

/// An item's unit, ready to be written: after a number ("4 chapitres"), under
/// the item's name ("chapitres", "pourcentage"), in a list or a column header
/// ("%") and above the quantity field ("Nombre de fois").
///
/// [ItemUnit.typed] reads a unit as typed by a user; the standard items get
/// theirs in the app's language (`ReportItemTexts.itemUnit`).
class ItemUnit {
  const ItemUnit({
    required this.name,
    required this.label,
    required this.symbol,
    required String Function(num n, String number) count,
  }) : _count = count;

  /// "Nombre de fois" -> "fois", "Pourcentage" -> "%", "chapitres" -> "4 chapitres".
  /// null when there is no unit.
  static ItemUnit? typed(String? unit) {
    final label = MeasureFormat.unitLabel(unit);
    final symbol = MeasureFormat.unitSymbol(unit);
    if (label == null || symbol == null) {
      return null;
    }
    return ItemUnit(
      name: unit!.trim(),
      label: label,
      symbol: symbol,
      count: (_, number) => '$number $symbol',
    );
  }

  /// The unit as a title: "Nombre de fois", "Chapitres".
  final String name;

  /// What the item counts, under its name: "fois", "pourcentage".
  final String label;

  /// Written after a number in a list or a header: "fois", "%".
  final String symbol;

  final String Function(num n, String number) _count;

  /// "4 chapitres", "1 chapitre", "10 %". [number] is [n] as written ("1,5"),
  /// [n] itself by default; [n] picks the plural form.
  String count(num n, {String? number}) => _count(n, number ?? '$n');
}

/// Units come from the database as typed by an admin or a user ("Nombre de
/// fois", "Pourcentage", "chapitres"...). These helpers make them readable next
/// to a number.
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
    ItemUnit? unit,
    bool withUnit = true,
  }) {
    final shown = withUnit ? unit : null;
    return [
      if (quantity != null) shown == null ? '$quantity' : shown.count(quantity),
      if (minutes != null) minutes.toDurationLabel(),
    ].join(' · ');
  }
}
