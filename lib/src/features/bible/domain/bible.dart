import 'dart:math';

/// A book of a Bible: its USFM code ("JHN"), its name in that Bible, its
/// place (1 to 66) and how many chapters it has.
class BibleBook {
  const BibleBook({
    required this.id,
    required this.name,
    required this.order,
    required this.chapters,
  });

  /// From the API's books.json (or a book of complete.json).
  factory BibleBook.fromJson(Map<String, dynamic> json) => BibleBook(
    id: json['id'] as String,
    name: _bookName(json),
    order: json['order'] as int,
    chapters: json['numberOfChapters'] as int,
  );

  final String id;
  final String name;
  final int order;
  final int chapters;

  /// Genesis to Malachi.
  bool get oldTestament => order <= 39;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'order': order,
    'numberOfChapters': chapters,
  };
}

/// Some Bibles write the names in capitals ("JEAN"): shown like a title.
String _bookName(Map<String, dynamic> json) {
  final name = (json['commonName'] ?? json['name']) as String;
  final latin = RegExp('[A-Za-zÀ-ÿ]').hasMatch(name);
  if (!latin || name != name.toUpperCase()) {
    return name;
  }
  return name
      .toLowerCase()
      .split(' ')
      .map(
        (word) => word.isEmpty || RegExp(r'^\d').hasMatch(word)
            ? word
            : word[0].toUpperCase() + word.substring(1),
      )
      .join(' ');
}

/// A piece of a verse: words (said by Jesus, or not), or a line break of a
/// poem.
class BibleSegment {
  const BibleSegment(this.text, {this.jesus = false});

  const BibleSegment.lineBreak() : text = '\n', jesus = false;

  final String text;
  final bool jesus;

  bool get isBreak => text == '\n';
}

/// What a chapter is made of, in order.
sealed class BibleItem {
  const BibleItem();
}

/// A section title ("Entretien de Jésus avec Nicodème").
class BibleHeading extends BibleItem {
  const BibleHeading(this.text);

  final String text;
}

class BibleVerse extends BibleItem {
  const BibleVerse({required this.number, required this.segments});

  final int number;
  final List<BibleSegment> segments;

  /// The words alone, poem lines joined by a space (to copy, search, show).
  String get text => segments
      .map((segment) => segment.isBreak ? ' ' : segment.text)
      .join()
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

/// A blank line between two stanzas of a poem.
class BibleBreak extends BibleItem {
  const BibleBreak();
}

class BibleChapter {
  const BibleChapter({
    required this.bookId,
    required this.number,
    required this.items,
  });

  /// From the "chapter" object of the API: {number, content: [...]}.
  factory BibleChapter.fromJson(String bookId, Map<String, dynamic> json) =>
      BibleChapter(
        bookId: bookId,
        number: json['number'] as int,
        items: [
          for (final item in json['content'] as List<dynamic>)
            ?_item(item as Map<String, dynamic>),
        ],
      );

  final String bookId;
  final int number;
  final List<BibleItem> items;

  List<BibleVerse> get verses => [
    for (final item in items)
      if (item is BibleVerse) item,
  ];

  BibleVerse? verse(int number) =>
      verses.where((verse) => verse.number == number).firstOrNull;
}

BibleItem? _item(Map<String, dynamic> json) => switch (json['type']) {
  'heading' => BibleHeading(_plain(json['content'] as List<dynamic>)),
  'verse' => BibleVerse(
    number: json['number'] as int,
    segments: _tidy([
      for (final part in json['content'] as List<dynamic>) ?_segment(part),
    ]),
  ),
  'line_break' => const BibleBreak(),
  // a psalm's own title ("Psaume de David") reads like a heading
  'hebrew_subtitle' => BibleHeading(_plain(json['content'] as List<dynamic>)),
  _ => null,
};

/// A string, {text, wordsOfJesus?, poem?}, {lineBreak: true}; a note
/// ({noteId}) is left out.
BibleSegment? _segment(Object? part) => switch (part) {
  final String text => BibleSegment(text),
  {'lineBreak': true} => const BibleSegment.lineBreak(),
  {'text': final String text} => BibleSegment(
    text,
    jesus: (part as Map)['wordsOfJesus'] == true,
  ),
  _ => null,
};

/// The pieces as they read: a space between two pieces of words (the API
/// leaves it out: "répondit:" then "En vérité"), but not in Chinese; no line
/// break at the start or the end of the verse, nor two in a row.
List<BibleSegment> _tidy(List<BibleSegment> parts) {
  final tidy = <BibleSegment>[];
  for (final part in parts) {
    if (part.isBreak) {
      if (tidy.isNotEmpty && !tidy.last.isBreak) {
        tidy.add(part);
      }
      continue;
    }
    final text = part.text.trim();
    if (text.isEmpty) {
      continue;
    }
    final before = tidy.lastOrNull;
    final spaced =
        before != null &&
        !before.isBreak &&
        !_isCjk(before.text.runes.last) &&
        !_isCjk(text.runes.first);
    tidy.add(BibleSegment(spaced ? ' $text' : text, jesus: part.jesus));
  }
  while (tidy.isNotEmpty && tidy.last.isBreak) {
    tidy.removeLast();
  }
  return tidy;
}

/// Chinese characters and their punctuation, written without spaces.
bool _isCjk(int rune) =>
    (rune >= 0x2E80 && rune <= 0x9FFF) || (rune >= 0xFF00 && rune <= 0xFFEF);

String _plain(List<dynamic> content) => [
  for (final part in content)
    if (_segment(part) case final segment? when !segment.isBreak) segment.text,
].join(' ').trim();

/// A place in the Bible: a chapter, or one of its verses. [key] is the same
/// in every version ("JHN.3.16"), so a highlight follows the user from one
/// to another.
class BibleRef {
  const BibleRef(this.book, this.chapter, [this.verse]);

  /// "JHN.3.16" or "JHN.3"; null if it isn't one.
  static BibleRef? parse(String? key) {
    final match = RegExp(
      r'^([1-3A-Z]{3})\.(\d+)(?:\.(\d+))?$',
    ).firstMatch(key?.trim() ?? '');
    if (match == null) {
      return null;
    }
    return BibleRef(
      match.group(1)!,
      int.parse(match.group(2)!),
      match.group(3) == null ? null : int.parse(match.group(3)!),
    );
  }

  final String book;
  final int chapter;
  final int? verse;

  String get key => [book, chapter, ?verse].join('.');

  BibleRef get chapterRef => BibleRef(book, chapter);

  @override
  bool operator ==(Object other) =>
      other is BibleRef &&
      other.book == book &&
      other.chapter == chapter &&
      other.verse == verse;

  @override
  int get hashCode => Object.hash(book, chapter, verse);

  @override
  String toString() => key;
}

extension BibleBookList on List<BibleBook> {
  BibleBook? byId(String id) => where((book) => book.id == id).firstOrNull;

  /// The name of the book [id] in this Bible ("Jean"), or its code.
  String nameOf(String id) => byId(id)?.name ?? id;
}

/// "Jean 3", "Jean 3:16", "Jean 3:16-18", "Jean 3:1, 16-18": [verses] of
/// one chapter, the book named as in [books].
String bibleLabel(
  BibleRef chapter,
  List<BibleBook> books, [
  Iterable<int> verses = const [],
]) {
  final name = '${books.nameOf(chapter.book)} ${chapter.chapter}';
  final sorted = verses.toSet().toList()..sort();
  if (sorted.isEmpty) {
    return name;
  }
  final runs = <String>[];
  var start = sorted.first;
  var end = start;
  for (final verse in sorted.skip(1)) {
    if (verse == end + 1) {
      end = verse;
      continue;
    }
    runs.add(start == end ? '$start' : '$start-$end');
    start = end = verse;
  }
  runs.add(start == end ? '$start' : '$start-$end');
  return '$name:${runs.join(', ')}';
}

/// For search and references: lower case, without accents (Latin) nor vowel
/// marks (Arabic), "2." read as "2", spaces simplified.
String normalizeBibleText(String text) {
  final buffer = StringBuffer();
  for (final rune in text.runes) {
    buffer.write(_plainChar(rune));
  }
  return buffer
      .toString()
      // "2. Korinther": an ordinal; "1.9" stays chapter and verse
      .replaceAllMapped(RegExp(r'(\d)\.(?=\s*[^\d\s])'), (m) => m[1]!)
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

/// One character as compared: lower case, without its accent; nothing for an
/// Arabic vowel mark.
String _plainChar(int rune) {
  // Arabic short vowels, shadda, sukun, dagger alef, Quranic marks, tatweel
  if ((rune >= 0x064B && rune <= 0x065F) ||
      rune == 0x0670 ||
      (rune >= 0x06D6 && rune <= 0x06ED) ||
      rune == 0x0640) {
    return '';
  }
  final char = String.fromCharCode(rune).toLowerCase();
  return _unaccented[char] ?? char;
}

/// Where the words of [query] are in [text], as [BibleText.search] finds
/// them: to show them in bold.
List<({int start, int end})> bibleMatches(String text, String query) {
  final words = normalizeBibleText(
    query,
  ).split(' ').where((word) => word.length > 1).toSet();
  if (words.isEmpty) {
    return const [];
  }
  // the text as compared, and where each of its characters comes from
  final plain = StringBuffer();
  final starts = <int>[];
  final ends = <int>[];
  var index = 0;
  for (final rune in text.runes) {
    final length = rune > 0xFFFF ? 2 : 1;
    for (final unit in _plainChar(rune).split('')) {
      plain.write(unit);
      starts.add(index);
      ends.add(index + length);
    }
    index += length;
  }
  final compared = plain.toString();
  final found = <({int start, int end})>[];
  for (final word in words) {
    var at = compared.indexOf(word);
    while (at >= 0) {
      found.add((start: starts[at], end: ends[at + word.length - 1]));
      at = compared.indexOf(word, at + word.length);
    }
  }
  found.sort((a, b) => a.start.compareTo(b.start));
  final merged = <({int start, int end})>[];
  for (final range in found) {
    if (merged.isNotEmpty && range.start <= merged.last.end) {
      final last = merged.removeLast();
      merged.add((start: last.start, end: max(last.end, range.end)));
    } else {
      merged.add(range);
    }
  }
  return merged;
}

const _unaccented = {
  'à': 'a', 'â': 'a', 'ä': 'a', 'á': 'a', 'ã': 'a', //
  'ç': 'c',
  'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
  'î': 'i', 'ï': 'i', 'í': 'i', 'ì': 'i',
  'ñ': 'n',
  'ô': 'o', 'ö': 'o', 'ó': 'o', 'ò': 'o', 'õ': 'o',
  'ù': 'u', 'û': 'u', 'ü': 'u', 'ú': 'u',
  'ÿ': 'y', 'ý': 'y',
  '’': "'", '‘': "'",
  'œ': 'oe', 'æ': 'ae', 'ß': 'ss',
  'أ': 'ا', 'إ': 'ا', 'آ': 'ا', 'ٱ': 'ا', 'ى': 'ي',
};

/// "Jean 3:16", "jean 3", "1 Jean 1.9", "Psaume 23", "2. Korinther 5,17":
/// a book of [books] (its name, the start of its name, or its code) then a
/// chapter, and maybe a verse. null when the query is not a reference, or the
/// chapter doesn't exist.
BibleRef? parseBibleReference(String query, List<BibleBook> books) {
  final match = RegExp(
    r'^(.+?)\s*(\d+)(?:\s*[:.,]\s*(\d+))?$',
  ).firstMatch(normalizeBibleText(query));
  if (match == null) {
    return null;
  }
  final name = match.group(1)!.trim();
  if (name.isEmpty || RegExp(r'^\d+$').hasMatch(name)) {
    return null;
  }
  final chapter = int.parse(match.group(2)!);
  final verse = match.group(3) == null ? null : int.parse(match.group(3)!);

  BibleBook? exact;
  BibleBook? start;
  for (final book in books) {
    final names = {normalizeBibleText(book.name), book.id.toLowerCase()};
    if (names.contains(name)) {
      exact = book;
      break;
    }
    if (start == null && names.any((candidate) => candidate.startsWith(name))) {
      start = book;
    }
  }
  final book = exact ?? start;
  if (book == null || chapter < 1 || chapter > book.chapters) {
    return null;
  }
  return BibleRef(book.id, chapter, verse == null || verse < 1 ? null : verse);
}

/// A downloaded Bible, every chapter of every book.
class BibleText {
  BibleText({required this.books, required this.chapters});

  /// From the API's complete.json: {translation, books: [{..., chapters:
  /// [{chapter: {number, content}}]}]}.
  factory BibleText.fromJson(Map<String, dynamic> json) {
    final books = <BibleBook>[];
    final chapters = <String, List<BibleChapter>>{};
    for (final raw in json['books'] as List<dynamic>) {
      final book = raw as Map<String, dynamic>;
      books.add(BibleBook.fromJson(book));
      chapters[book['id'] as String] = [
        for (final chapter in book['chapters'] as List<dynamic>)
          BibleChapter.fromJson(
            book['id'] as String,
            (chapter as Map<String, dynamic>)['chapter']
                as Map<String, dynamic>,
          ),
      ];
    }
    return BibleText(books: books, chapters: chapters);
  }

  final List<BibleBook> books;
  final Map<String, List<BibleChapter>> chapters;

  BibleChapter? chapter(String book, int number) =>
      chapters[book]?.where((chapter) => chapter.number == number).firstOrNull;

  /// Every verse with its words ready to compare: made once (call it where
  /// the Bible is read, off the main thread), searched many times.
  late final List<({BibleRef ref, String text, String plain})> searchIndex = [
    for (final book in books)
      for (final chapter in chapters[book.id] ?? const <BibleChapter>[])
        for (final verse in chapter.verses)
          if (verse.text case final text)
            (
              ref: BibleRef(book.id, chapter.number, verse.number),
              text: text,
              plain: normalizeBibleText(text),
            ),
  ];

  /// The verses that hold every word of [query], in the order of the Bible
  /// (at most [limit]).
  List<({BibleRef ref, String text})> search(String query, {int limit = 200}) {
    final words = normalizeBibleText(
      query,
    ).split(' ').where((word) => word.length > 1).toList();
    if (words.isEmpty) {
      return const [];
    }
    final found = <({BibleRef ref, String text})>[];
    for (final verse in searchIndex) {
      if (words.every(verse.plain.contains)) {
        found.add((ref: verse.ref, text: verse.text));
        if (found.length >= limit) {
          break;
        }
      }
    }
    return found;
  }
}
