// « Verset en vol », a bonus game of the tab (13/11/2026, made with Flame):
// Zoé flies across the night; the words of a verse come towards her, and she
// must catch them in their order. A wrong word costs a heart (three in all).
// No points from the server: it is played to keep the Word in mind.

/// A verse to fly through: its text and where it comes from.
typedef FlightVerse = ({String text, String reference});

/// The pieces of [text] Zoé catches one by one: its words, the punctuation
/// kept with them (« éternelle. »). Chinese has no spaces: its text is cut in
/// pieces of three characters (two at the end of a phrase).
List<String> flightWords(String text, {required String language}) {
  final clean = text.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (language != 'zh') {
    return clean.split(' ').where((word) => word.isNotEmpty).toList();
  }
  final pieces = <String>[];
  for (final phrase in clean.split(RegExp('(?<=[，。；：！？、])'))) {
    final chars = phrase.replaceAll(' ', '').runes.toList();
    for (var i = 0; i < chars.length; i += 3) {
      final end = i + 3 > chars.length ? chars.length : i + 3;
      pieces.add(String.fromCharCodes(chars.sublist(i, end)));
    }
  }
  return pieces.where((piece) => piece.isNotEmpty).toList();
}

/// A verse fits the game when it has between 6 and 14 pieces: long enough to
/// be a verse, short enough to fly through in a minute.
bool fitsFlight(String text, {required String language}) {
  final count = flightWords(text, language: language).length;
  return count >= 6 && count <= 14;
}

/// What a word caught did.
enum Catch {
  /// The word expected: the verse grows.
  right,

  /// Another one: a heart lost.
  wrong,

  /// The last word of the verse: won.
  won,

  /// The last heart lost: the flight starts again.
  lost,
}

/// A flight under way: the words of the verse, how many are caught, the
/// hearts left. Immutable: each catch gives the flight after it.
class VerseFlight {
  const VerseFlight({
    required this.verse,
    required this.words,
    this.caught = 0,
    this.hearts = maxHearts,
  });

  factory VerseFlight.of(FlightVerse verse, {required String language}) =>
      VerseFlight(
        verse: verse,
        words: flightWords(verse.text, language: language),
      );

  static const maxHearts = 3;

  final FlightVerse verse;
  final List<String> words;
  final int caught;
  final int hearts;

  bool get won => caught >= words.length;
  bool get lost => hearts <= 0;
  bool get over => won || lost;

  /// The index of the word to catch next, null once won.
  int? get next => won ? null : caught;

  /// Zoé meets the word at [index] of the verse.
  (VerseFlight, Catch) meet(int index) {
    if (over) {
      return (this, won ? Catch.won : Catch.lost);
    }
    if (index == caught) {
      final after = VerseFlight(
        verse: verse,
        words: words,
        caught: caught + 1,
        hearts: hearts,
      );
      return (after, after.won ? Catch.won : Catch.right);
    }
    final after = VerseFlight(
      verse: verse,
      words: words,
      caught: caught,
      hearts: hearts - 1,
    );
    return (after, after.lost ? Catch.lost : Catch.wrong);
  }
}
