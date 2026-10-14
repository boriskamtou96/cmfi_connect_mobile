import '../../../core/i18n/strings.g.dart';
import '../domain/measure_format.dart';
import '../domain/standard_item.dart';

/// The name and unit of a report item, as every screen and export writes
/// them: a standard item (LB, PS…, recognized by its code, see [StandardItem])
/// in the app's language, the user's own item exactly as typed.
///
/// [standard]: pass `isStandard` when the server gives it (an `ActivityType`);
/// false keeps the typed texts whatever the code. Entries, summary and export
/// items don't carry it: their code is enough, the server reserves the
/// standard codes.
extension ReportItemTexts on Translations {
  /// "Bible reading" for LB in English, "Évangélisation" for a personal item.
  String itemLabel(String code, String label, {bool standard = true}) =>
      switch (StandardItem.of(code, standard: standard)) {
        null => label,
        final item => _label(item),
      };

  /// The unit of an item (null if it has none): the app's words for a
  /// standard item, else [unit] as typed ("Nombre de fois" -> "fois").
  ItemUnit? itemUnit(String code, String? unit, {bool standard = true}) =>
      switch (StandardItem.of(code, standard: standard)?.unit) {
        null => ItemUnit.typed(unit),
        final unit => _unit(unit),
      };

  String _label(StandardItem item) {
    final names = reports.standardItems;
    return switch (item) {
      StandardItem.bibleReading => names.lb,
      StandardItem.personalPrayer => names.ps,
      StandardItem.meditation => names.rdqad,
      StandardItem.groupPrayer => names.pg,
      StandardItem.christianLiterature => names.llc,
      StandardItem.fullFast => names.jc,
      StandardItem.partialFast => names.jp,
      StandardItem.tithes => names.dimes,
      StandardItem.offerings => names.off,
    };
  }

  ItemUnit _unit(StandardUnit unit) {
    final units = reports.units;
    return switch (unit) {
      StandardUnit.chapters => ItemUnit(
        name: units.chapters.name,
        label: units.chapters.label,
        symbol: units.chapters.symbol,
        count: (n, number) => units.chapters.count(n: n, value: number),
      ),
      StandardUnit.times => ItemUnit(
        name: units.times.name,
        label: units.times.label,
        symbol: units.times.symbol,
        count: (n, number) => units.times.count(n: n, value: number),
      ),
      StandardUnit.pages => ItemUnit(
        name: units.pages.name,
        label: units.pages.label,
        symbol: units.pages.symbol,
        count: (n, number) => units.pages.count(n: n, value: number),
      ),
      StandardUnit.percent => ItemUnit(
        name: units.percent.name,
        label: units.percent.label,
        symbol: units.percent.symbol,
        count: (_, number) => units.percent.count(value: number),
      ),
    };
  }
}
