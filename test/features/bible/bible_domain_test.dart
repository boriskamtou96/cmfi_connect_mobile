import 'package:cmfi_connect/src/features/bible/domain/bible.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible_version.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/bible_fakes.dart';

void main() {
  group('a chapter from the API', () {
    test('section titles, verses, the words of Jesus, notes left out', () {
      final chapter = BibleChapter.fromJson(
        'JHN',
        sampleBibleChapter('JHN', 3),
      );

      expect(chapter.items.first, isA<BibleHeading>());
      expect(
        (chapter.items.first as BibleHeading).text,
        'Entretien de Jésus avec Nicodème',
      );
      final verse3 = chapter.verse(3)!;
      // the API leaves the space out between two pieces of words
      expect(
        verse3.text,
        startsWith('Jésus lui répondit: En vérité, en vérité'),
      );
      expect(verse3.segments.first.jesus, isFalse);
      expect(verse3.segments.last.jesus, isTrue);
      // a note ({noteId}) is not part of the text
      expect(chapter.verse(16)!.segments, hasLength(1));
    });

    test('a poem keeps its lines, without a break at the start', () {
      final chapter = BibleChapter.fromJson(
        'PSA',
        sampleBibleChapter('PSA', 23),
      );

      final verse1 = chapter.verse(1)!;
      expect(verse1.segments.map((segment) => segment.isBreak), [
        false,
        true,
        false,
      ]);
      // verse 2 began with a line break in the API
      expect(chapter.verse(2)!.segments.first.isBreak, isFalse);
      expect(
        chapter.verse(2)!.text,
        'Il me fait reposer dans de verts pâturages, Il me dirige près des '
        'eaux paisibles.',
      );
    });

    test('Chinese pieces are joined without a space', () {
      final chapter = BibleChapter.fromJson('JHN', {
        'number': 3,
        'content': [
          {
            'type': 'verse',
            'number': 3,
            'content': [
              '耶稣回答说：',
              {'text': '我实实在在地告诉你。', 'wordsOfJesus': true},
            ],
          },
        ],
      });
      expect(chapter.verse(3)!.text, '耶稣回答说：我实实在在地告诉你。');
    });

    test('book names written in capitals read like titles', () {
      final book = BibleBook.fromJson(const {
        'id': '1JN',
        'name': '1 JEAN',
        'commonName': '1 JEAN',
        'order': 62,
        'numberOfChapters': 5,
      });
      expect(book.name, '1 Jean');
      expect(book.oldTestament, isFalse);
    });
  });

  group('a place in the Bible', () {
    test('its key is the same in every version', () {
      expect(BibleRef.parse('JHN.3.16'), const BibleRef('JHN', 3, 16));
      expect(BibleRef.parse('1JN.1'), const BibleRef('1JN', 1));
      expect(BibleRef.parse('Jean 3:16'), isNull);
      expect(const BibleRef('JHN', 3, 16).chapterRef.key, 'JHN.3');
    });

    test('written as people write it', () {
      BibleRef? read(String query) =>
          parseBibleReference(query, sampleBibleBooks);

      expect(read('Jean 3:16'), const BibleRef('JHN', 3, 16));
      expect(read('jean 3'), const BibleRef('JHN', 3));
      // the book of 1 Jean, not the Gospel
      expect(read('1 Jean 1.9'), const BibleRef('1JN', 1, 9));
      expect(read('1. Jean 1,9'), const BibleRef('1JN', 1, 9));
      // the start of a name, without its accents
      expect(read('Psaume 23'), const BibleRef('PSA', 23));
      expect(read('genese 1'), const BibleRef('GEN', 1));
      expect(read('JHN 3'), const BibleRef('JHN', 3));
      // a chapter that doesn't exist, or a word
      expect(read('Jean 22'), isNull);
      expect(read('amour'), isNull);
      expect(read('23'), isNull);
    });

    test('its label names the verses, in ranges', () {
      const chapter = BibleRef('JHN', 3);
      expect(bibleLabel(chapter, sampleBibleBooks), 'Jean 3');
      expect(bibleLabel(chapter, sampleBibleBooks, [16]), 'Jean 3:16');
      expect(
        bibleLabel(chapter, sampleBibleBooks, [17, 16, 18]),
        'Jean 3:16-18',
      );
      expect(
        bibleLabel(chapter, sampleBibleBooks, [1, 16, 17]),
        'Jean 3:1, 16-17',
      );
    });
  });

  group('search', () {
    final text = BibleText.fromJson(sampleCompleteBible());

    test('the verses holding every word, accents and case ignored', () {
      final found = text.search('MONDE eternelle');
      expect(found.map((verse) => verse.ref.key), ['JHN.3.16']);
      expect(text.search('monde').map((verse) => verse.ref.key), [
        'JHN.3.16',
        'JHN.3.17',
      ]);
      expect(text.search('xyz'), isEmpty);
    });

    test('the words found, to show in bold', () {
      const verse = 'Car Dieu a tant aimé le monde';
      final ranges = bibleMatches(verse, 'aime MONDE');
      expect(
        [for (final r in ranges) verse.substring(r.start, r.end)],
        ['aimé', 'monde'],
      );
    });

    test('Arabic is compared without its vowel marks', () {
      expect(normalizeBibleText('اللهُ'), normalizeBibleText('الله'));
      expect(normalizeBibleText('أحب'), normalizeBibleText('احب'));
    });
  });

  test('each language of the app has its Bible, the same as its verses', () {
    for (final language in ['fr', 'en', 'de', 'es', 'ar', 'zh', 'hi']) {
      expect(defaultBibleVersion(language).language, language);
    }
    expect(defaultBibleVersion('fr').id, 'fra_lsg');
    expect(defaultBibleVersion('pt').id, 'ENGWEBP');
    expect(bibleVersionOf('arb_vdv')!.rtl, isTrue);
  });
}
