import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/bible.dart';

part 'cross_references.g.dart';

/// A passage linked to a verse: a verse, or a few that follow ("JHN.1.1-3").
@immutable
class CrossReference {
  const CrossReference(this.start, [this.last]);

  /// "JHN.1.1-3", "HEB.11.3"; null if it isn't one.
  static CrossReference? parse(String text) {
    final [first, ...rest] = text.split('-');
    final start = BibleRef.parse(first);
    if (start == null || start.verse == null) {
      return null;
    }
    return CrossReference(
      start,
      rest.isEmpty ? null : int.tryParse(rest.first),
    );
  }

  final BibleRef start;

  /// The last verse of the passage, null for one verse.
  final int? last;

  List<int> get verses => [
    for (var verse = start.verse!; verse <= (last ?? start.verse!); verse++)
      verse,
  ];

  @override
  bool operator ==(Object other) =>
      other is CrossReference && other.start == start && other.last == last;

  @override
  int get hashCode => Object.hash(start, last);
}

/// The cross references of the Bible (OpenBible.info, CC-BY): for a verse
/// ("GEN.1.1"), the passages that speak of the same thing, the most voted
/// first. Kept in the app (assets/bible/cross_references.tsv, about 20 000
/// verses): the same in every version and every language, without network.
class CrossReferences {
  CrossReferences(this._lines);

  /// "GEN.1.1" → "JHN.1.1-3;HEB.11.3;…", parsed when asked.
  final Map<String, String> _lines;

  static CrossReferences parse(String file) => CrossReferences({
    for (final line in file.split('\n'))
      if (line.isNotEmpty && !line.startsWith('#'))
        line.substring(0, line.indexOf('\t')): line.substring(
          line.indexOf('\t') + 1,
        ),
  });

  /// The passages linked to [verse].
  List<CrossReference> of(BibleRef verse) => [
    for (final text in (_lines[verse.key] ?? '').split(';'))
      ?CrossReference.parse(text),
  ];

  /// Those of [verses] together, each passage once, and none of [verses]
  /// themselves.
  List<CrossReference> ofAll(List<BibleRef> verses) {
    final seen = <CrossReference>{};
    return [
      for (final verse in verses)
        for (final reference in of(verse))
          if (!verses.contains(reference.start) && seen.add(reference))
            reference,
    ];
  }
}

@Riverpod(keepAlive: true)
Future<CrossReferences> crossReferences(Ref ref) async {
  final file = await rootBundle.loadString(
    'assets/bible/cross_references.tsv',
    cache: false,
  );
  // only cut in lines here; a verse's links are read when asked
  return CrossReferences.parse(file);
}
