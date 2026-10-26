const _unset = Object();

/// What the Enseignements list asks the server: the words, a category, a
/// speaker, a year, an annual edition and the day of it. '' or null mean
/// "all". The same query gives the same list: it is the key of the provider.
class TeachingQuery {
  const TeachingQuery({
    this.search = '',
    this.category = '',
    this.speaker = '',
    this.year,
    this.edition,
    this.day,
  });

  /// Words of the title, the speaker, the description, the category or the
  /// edition; case and accents left aside on the server.
  final String search;

  /// A category's slug ("camp-des-jeunes"), or its name; '' for all.
  final String category;

  /// Part of a speaker's name ("andoseh"); '' for all.
  final String speaker;

  /// "2026"; null for all.
  final int? year;

  /// The annual edition ("Camp des jeunes 2026"); null for all.
  final int? edition;

  /// Day 1, 2… of the edition; null for all.
  final int? day;

  /// Whether a filter narrows the list (a search, a category, a speaker, a
  /// year, an edition or a day).
  bool get narrowed =>
      search.isNotEmpty ||
      category.isNotEmpty ||
      speaker.isNotEmpty ||
      year != null ||
      edition != null ||
      day != null;

  /// Whether the first page may be kept on the phone: an untouched list, or
  /// one category.
  bool get keepable =>
      search.isEmpty && speaker.isEmpty && year == null && edition == null && day == null;

  /// How many filters narrow the list.
  int get filterCount => [
    search.isNotEmpty,
    category.isNotEmpty,
    speaker.isNotEmpty,
    year != null,
    edition != null,
    day != null,
  ].where((narrows) => narrows).length;

  /// The same query with some fields changed; `year: null` (like `edition`
  /// and `day`) removes it.
  TeachingQuery copyWith({
    String? search,
    String? category,
    String? speaker,
    Object? year = _unset,
    Object? edition = _unset,
    Object? day = _unset,
  }) => TeachingQuery(
    search: search ?? this.search,
    category: category ?? this.category,
    speaker: speaker ?? this.speaker,
    year: identical(year, _unset) ? this.year : year as int?,
    edition: identical(edition, _unset) ? this.edition : edition as int?,
    day: identical(day, _unset) ? this.day : day as int?,
  );

  /// The list without the speaker, the year, the edition and the day.
  TeachingQuery get withoutAdvanced =>
      TeachingQuery(search: search, category: category);

  @override
  bool operator ==(Object other) =>
      other is TeachingQuery &&
      other.search == search &&
      other.category == category &&
      other.speaker == speaker &&
      other.year == year &&
      other.edition == edition &&
      other.day == day;

  @override
  int get hashCode =>
      Object.hash(search, category, speaker, year, edition, day);
}
