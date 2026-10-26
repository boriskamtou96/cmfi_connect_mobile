/// What the Nos documents list asks the server: the words, and a category.
/// '' means "all". The same query gives the same list: it is the key of the
/// provider.
class DocumentsQuery {
  const DocumentsQuery({this.search = '', this.category = ''});

  /// Words of the title, the description, the category or the file's name;
  /// case and accents left aside on the server.
  final String search;

  /// A category's slug ("formulaires"), or its name; '' for all.
  final String category;

  /// Whether a search or a category narrows the list.
  bool get narrowed => search.isNotEmpty || category.isNotEmpty;

  /// The same query with some fields changed.
  DocumentsQuery copyWith({String? search, String? category}) =>
      DocumentsQuery(
        search: search ?? this.search,
        category: category ?? this.category,
      );

  @override
  bool operator ==(Object other) =>
      other is DocumentsQuery &&
      other.search == search &&
      other.category == category;

  @override
  int get hashCode => Object.hash(search, category);
}
