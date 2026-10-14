/// The units of the standard items, written in the app's language.
enum StandardUnit { chapters, times, pages, percent }

/// The 9 items the server gives every member (no owner, `isStandard`). The
/// server writes them in French; the app shows their name and unit in its own
/// language, recognized by their code. A personal item can't take one of
/// these codes: the server refuses it (409, at creation and when renamed),
/// and a personal code is only A-Z, 0-9 and _ (so never "Dîmes").
enum StandardItem {
  bibleReading('LB', StandardUnit.chapters),
  personalPrayer('PS'),
  meditation('RDQAD', StandardUnit.times),
  groupPrayer('PG', StandardUnit.times),
  christianLiterature('LLC', StandardUnit.pages),
  fullFast('JC', StandardUnit.times),
  partialFast('JP', StandardUnit.times),
  tithes('Dîmes', StandardUnit.percent),
  offerings('OFF', StandardUnit.percent);

  const StandardItem(this.code, [this.unit]);

  /// The code the server gives it (case and accent included).
  final String code;

  /// null when the item only counts a duration.
  final StandardUnit? unit;

  static final _byCode = {for (final item in values) item.code: item};

  /// The standard item with this [code]. [standard] false (an item the server
  /// marks as personal) gives null, whatever its code.
  static StandardItem? of(String code, {bool standard = true}) =>
      standard ? _byCode[code] : null;
}
