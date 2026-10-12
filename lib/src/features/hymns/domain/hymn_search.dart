import 'hymn.dart';

/// Text made comparable: lowercase, without accents or punctuation, so "eternel"
/// finds "Éternel" and "coeur" finds "cœur". [positions] maps each character of [text]
/// back to the original string, to highlight what matched.
typedef NormalizedText = ({String text, List<int> positions});

const _foldings = {
  'à': 'a',
  'á': 'a',
  'â': 'a',
  'ä': 'a',
  'ã': 'a',
  'å': 'a',
  'ç': 'c',
  'é': 'e',
  'è': 'e',
  'ê': 'e',
  'ë': 'e',
  'í': 'i',
  'ì': 'i',
  'î': 'i',
  'ï': 'i',
  'ñ': 'n',
  'ó': 'o',
  'ò': 'o',
  'ô': 'o',
  'ö': 'o',
  'õ': 'o',
  'ú': 'u',
  'ù': 'u',
  'û': 'u',
  'ü': 'u',
  'ý': 'y',
  'ÿ': 'y',
  'œ': 'oe',
  'æ': 'ae',
  'ß': 'ss',
};

NormalizedText normalizeForSearch(String input) {
  final text = StringBuffer();
  final positions = <int>[];
  var lastWasSpace = true;
  final lower = input.toLowerCase();
  for (var i = 0; i < lower.length; i++) {
    final char = lower[i];
    final folded = _foldings[char] ?? char;
    final code = folded.codeUnitAt(0);
    final isWord =
        (code >= 0x61 && code <= 0x7a) ||
        (code >= 0x30 && code <= 0x39); // a-z, 0-9
    if (isWord) {
      for (var k = 0; k < folded.length; k++) {
        text.write(folded[k]);
        positions.add(i);
      }
      lastWasSpace = false;
    } else if (!lastWasSpace) {
      text.write(' ');
      positions.add(i);
      lastWasSpace = true;
    }
  }
  var result = text.toString();
  if (result.endsWith(' ')) {
    result = result.substring(0, result.length - 1);
    positions.removeLast();
  }
  return (text: result, positions: positions);
}

/// Where a search matched in a hymn, best first.
enum HymnMatch { number, title, firstLine, lyrics }

typedef HymnSearchResult = ({
  HymnBook book,
  Hymn hymn,
  HymnMatch match,
  String? snippet,
});

/// A hymn prepared for searching: its texts normalized once.
class _Entry {
  _Entry(this.hymn)
    : title = normalizeForSearch(hymn.title).text,
      firstLine = normalizeForSearch(hymn.firstLine).text,
      lines = [
        for (final part in hymn.parts)
          for (final line in part.lines)
            (original: line, normalized: normalizeForSearch(line).text),
      ] {
    lyrics = lines.map((line) => line.normalized).join(' ');
  }

  final Hymn hymn;
  final String title;
  final String firstLine;
  final List<({String original, String normalized})> lines;
  late final String lyrics;
}

/// Searches a book by number, title or words. All the words of the query must appear.
class HymnSearchIndex {
  HymnSearchIndex(this.book)
    : _entries = [for (final hymn in book.hymns) _Entry(hymn)];

  final HymnBook book;
  final List<_Entry> _entries;

  List<HymnSearchResult> search(String query, {int limit = 200}) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return const [];
    }

    // "12" or "n° 12": the hymn with that number first, then those starting with it
    final number = RegExp(
      r'^(?:n\s*[°o.]?\s*)?(\d{1,4})$',
      caseSensitive: false,
    ).firstMatch(trimmed);
    if (number != null) {
      final digits = number.group(1)!;
      return [
        for (final entry in _entries)
          if (entry.hymn.number.toString() == digits)
            (
              book: book,
              hymn: entry.hymn,
              match: HymnMatch.number,
              snippet: null,
            ),
        for (final entry in _entries)
          if (entry.hymn.number.toString() != digits &&
              entry.hymn.number.toString().startsWith(digits))
            (
              book: book,
              hymn: entry.hymn,
              match: HymnMatch.number,
              snippet: null,
            ),
      ].take(limit).toList();
    }

    final words = normalizeForSearch(
      trimmed,
    ).text.split(' ').where((word) => word.isNotEmpty).toList();
    if (words.isEmpty) {
      return const [];
    }
    bool containsAll(String text) => words.every(text.contains);

    final byTitle = <HymnSearchResult>[];
    final byFirstLine = <HymnSearchResult>[];
    final byLyrics = <HymnSearchResult>[];
    for (final entry in _entries) {
      if (containsAll(entry.title)) {
        byTitle.add((
          book: book,
          hymn: entry.hymn,
          match: HymnMatch.title,
          snippet: null,
        ));
      } else if (containsAll(entry.firstLine)) {
        byFirstLine.add((
          book: book,
          hymn: entry.hymn,
          match: HymnMatch.firstLine,
          snippet: null,
        ));
      } else if (containsAll(entry.lyrics)) {
        // show the line holding most of the words
        final best = entry.lines.reduce(
          (a, b) =>
              words.where(b.normalized.contains).length >
                  words.where(a.normalized.contains).length
              ? b
              : a,
        );
        byLyrics.add((
          book: book,
          hymn: entry.hymn,
          match: HymnMatch.lyrics,
          snippet: best.original,
        ));
      }
    }
    return [...byTitle, ...byFirstLine, ...byLyrics].take(limit).toList();
  }
}

/// Ranges of [original] that match the words of [query], for highlighting.
List<({int start, int end})> matchRanges(String original, String query) {
  final normalized = normalizeForSearch(original);
  final words = normalizeForSearch(
    query,
  ).text.split(' ').where((word) => word.isNotEmpty);
  final ranges = <({int start, int end})>[];
  for (final word in words) {
    var from = 0;
    while (true) {
      final index = normalized.text.indexOf(word, from);
      if (index < 0) {
        break;
      }
      final start = normalized.positions[index];
      final end = normalized.positions[index + word.length - 1] + 1;
      ranges.add((start: start, end: end));
      from = index + word.length;
    }
  }
  ranges.sort((a, b) => a.start.compareTo(b.start));
  // merge overlaps
  final merged = <({int start, int end})>[];
  for (final range in ranges) {
    if (merged.isNotEmpty && range.start <= merged.last.end) {
      final last = merged.removeLast();
      merged.add((
        start: last.start,
        end: range.end > last.end ? range.end : last.end,
      ));
    } else {
      merged.add(range);
    }
  }
  return merged;
}
