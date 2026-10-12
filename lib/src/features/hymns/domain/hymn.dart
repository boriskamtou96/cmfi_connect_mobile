import 'package:freezed_annotation/freezed_annotation.dart';

part 'hymn.freezed.dart';
part 'hymn.g.dart';

enum HymnPartKind { verse, chorus }

/// A verse or a chorus. [label] is the number printed before it ("1", or "2" for
/// "Refrain 2"); [repeat] how many times it is sung (0: once).
@freezed
abstract class HymnPart with _$HymnPart {
  const factory HymnPart({
    @JsonKey(unknownEnumValue: HymnPartKind.verse) required HymnPartKind kind,
    String? label,
    @Default(0) int repeat,
    required List<String> lines,
  }) = _HymnPart;

  factory HymnPart.fromJson(Map<String, dynamic> json) =>
      _$HymnPartFromJson(json);
}

@freezed
abstract class Hymn with _$Hymn {
  const factory Hymn({
    required int number,
    required String title,

    /// Words / music credit printed under the hymn, when the book has one.
    String? author,
    @Default('') String firstLine,
    required List<HymnPart> parts,
  }) = _Hymn;

  factory Hymn.fromJson(Map<String, dynamic> json) => _$HymnFromJson(json);
}

/// A whole hymn book, as returned by GET /v1/hymns/books/:code and kept on the phone.
@freezed
abstract class HymnBook with _$HymnBook {
  const factory HymnBook({
    required String code,
    required String title,
    @Default('fr') String language,
    @Default(0) int hymnCount,

    /// Changes each time the book changes on the server.
    required String version,
    @Default(<Hymn>[]) List<Hymn> hymns,
  }) = _HymnBook;

  const HymnBook._();

  factory HymnBook.fromJson(Map<String, dynamic> json) =>
      _$HymnBookFromJson(json);

  /// The hymn numbered [number], or null.
  Hymn? hymn(int number) {
    // the hymns are sorted and usually numbered 1..n
    final guess = number - 1;
    if (guess >= 0 && guess < hymns.length && hymns[guess].number == number) {
      return hymns[guess];
    }
    for (final hymn in hymns) {
      if (hymn.number == number) {
        return hymn;
      }
    }
    return null;
  }

  int indexOf(int number) => hymns.indexWhere((hymn) => hymn.number == number);
}

/// A book in GET /v1/hymns/books: enough to know whether the copy on the phone is current.
@freezed
abstract class HymnBookSummary with _$HymnBookSummary {
  const factory HymnBookSummary({
    required String code,
    required String title,
    @Default('fr') String language,
    @Default(0) int hymnCount,
    required String version,
  }) = _HymnBookSummary;

  factory HymnBookSummary.fromJson(Map<String, dynamic> json) =>
      _$HymnBookSummaryFromJson(json);
}

/// Points to a hymn of a book: favorites, recently opened.
@freezed
abstract class HymnRef with _$HymnRef {
  const factory HymnRef({required String bookCode, required int number}) =
      _HymnRef;

  const HymnRef._();

  /// "rendons-ministere-1:12", how it is stored.
  factory HymnRef.parse(String key) {
    final separator = key.lastIndexOf(':');
    return HymnRef(
      bookCode: key.substring(0, separator),
      number: int.parse(key.substring(separator + 1)),
    );
  }

  String get key => '$bookCode:$number';
}
