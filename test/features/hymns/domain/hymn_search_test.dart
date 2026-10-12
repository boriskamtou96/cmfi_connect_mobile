import 'package:cmfi_connect/src/features/hymns/domain/hymn_search.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fakes.dart';

void main() {
  final index = HymnSearchIndex(sampleHymnBook);

  test('normalizing drops case, accents and punctuation', () {
    expect(
      normalizeForSearch("Saint ! Saint ! est l'Éternel").text,
      'saint saint est l eternel',
    );
    expect(normalizeForSearch('Cœur').text, 'coeur');
  });

  test('a number finds that hymn first, then those starting with it', () {
    expect(index.search('2').map((r) => r.hymn.number), [2]);
    expect(index.search('n° 3').single.hymn.number, 3);
    expect(index.search('9'), isEmpty);
  });

  test('words match without accents, titles before lyrics', () {
    final results = index.search('eternel');
    expect(results.single.hymn.number, 2);
    expect(results.single.match, HymnMatch.firstLine);

    final croix = index.search('maitre croix');
    expect(croix.single.hymn.number, 3);
    expect(croix.single.match, HymnMatch.title);
  });

  test('a match in the lyrics shows the line it is in', () {
    final result = index.search('ressuscite').single;
    expect(result.match, HymnMatch.lyrics);
    expect(result.snippet, 'Ô Ressuscité');
  });

  test('every word of the query must be found', () {
    expect(index.search('gloire croix'), isEmpty);
  });

  test('match ranges point into the original text', () {
    const text = "Saint ! Saint ! est l'Éternel";
    final ranges = matchRanges(text, 'eternel');
    expect(text.substring(ranges.single.start, ranges.single.end), 'Éternel');
    expect(
      matchRanges(
        'Mon cœur',
        'coeur',
      ).map((r) => 'Mon cœur'.substring(r.start, r.end)),
      ['cœur'],
    );
  });
}
