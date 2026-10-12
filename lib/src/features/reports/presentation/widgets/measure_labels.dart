import '../../../../core/i18n/strings.g.dart';
import '../../domain/measure_format.dart';

/// "chapitres", "fois et durée", "durée": what an item measures, under its name.
String measureSubtitle(
  Translations t, {
  required bool quantity,
  required bool duration,
  String? unit,
}) {
  final label = MeasureFormat.unitLabel(unit);
  return switch ((quantity, duration)) {
    (true, true) =>
      label == null
          ? t.reports.measure.bothNoUnit
          : t.reports.measure.both(unit: label),
    (true, false) =>
      label == null
          ? t.reports.measure.quantityNoUnit
          : t.reports.measure.quantity(unit: label),
    _ => t.reports.measure.duration,
  };
}

/// "Quantité · chapitres", "Quantité (fois) et durée", "Durée": the item list wording.
String measureDescription(
  Translations t, {
  required bool quantity,
  required bool duration,
  String? unit,
}) {
  final label = MeasureFormat.unitSymbol(unit);
  return switch ((quantity, duration)) {
    (true, true) =>
      label == null
          ? t.items.measure.bothNoUnit
          : t.items.measure.both(unit: label),
    (true, false) =>
      label == null
          ? t.items.measure.quantityNoUnit
          : t.items.measure.quantity(unit: label),
    _ => t.items.measure.duration,
  };
}
