import 'package:cmfi_connect/src/features/bible/application/bible_library.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible_version.dart';
import 'package:cmfi_connect/src/features/bible/infrastructure/bible_api.dart';
import 'package:cmfi_connect/src/features/bible/infrastructure/bible_storage.dart';
import 'package:cmfi_connect/src/features/bible/infrastructure/youversion_bible.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../helpers/bible_fakes.dart';

/// The YouVersion Platform, as the library uses it: one chapter under
/// licence (made-up words, the markup of the platform).
class FakeYouVersionBible implements YouVersionBible {
  final asked = <String>[];

  @override
  Future<List<BibleBook>> books(int bibleId) async => sampleBibleBooks;

  @override
  Future<({Map<String, dynamic> chapter, String copyright})> chapter(
    int bibleId,
    String book,
    int number,
  ) async {
    asked.add('$bibleId/$book.$number');
    return (
      chapter: youVersionChapter(
        number,
        '<div><div class="p"><span class="yv-v" v="16"></span>'
        '<span class="yv-vlbl">16</span>Un verset pour essayer.</div></div>',
      ),
      copyright: 'La Bible du Semeur® © Biblica',
    );
  }

  @override
  Future<Map<String, dynamic>> complete(
    int bibleId, {
    void Function(int done, int total)? onProgress,
  }) async {
    final books = await this.books(bibleId);
    final whole = {
      'books': [
        for (final book in books)
          {
            ...book.toJson(),
            'chapters': [
              for (var number = 1; number <= book.chapters; number++)
                {'chapter': (await chapter(bibleId, book.id, number)).chapter},
            ],
          },
      ],
    };
    onProgress?.call(1, 1);
    return whole;
  }
}

void main() {
  group('a chapter of the YouVersion Platform, as the reader reads it', () {
    test('titles, verses, words of Jesus, notes where they are', () {
      final chapter = BibleChapter.fromJson(
        'JHN',
        youVersionChapter(
          3,
          '<div>'
          '<div class="s1 yv-h">Un titre de section</div>'
          '<div class="p"><span class="yv-v" v="1"></span>'
          '<span class="yv-vlbl">1</span>Premiers mots du verset'
          '<span class="yv-n f"><span class="fr">3.1</span>'
          '<span class="ft">Le texte de la note</span></span> et la suite.'
          '<span class="yv-v" v="2"></span><span class="yv-vlbl">2</span>'
          'Il dit : <span class="wj">Des paroles de Jésus.</span></div>'
          '</div>',
        ),
      );

      expect((chapter.items.first as BibleHeading).text, 'Un titre de section');
      expect(chapter.verses.map((verse) => verse.number), [1, 2]);
      final first = chapter.verse(1)!;
      // the note: after its word, its place ("3.1") left out; not in the words
      expect(
        first.segments.where((part) => part.isNote).single.note,
        'Le texte de la note',
      );
      expect(first.text, 'Premiers mots du verset et la suite.');
      expect(chapter.verse(2)!.text, 'Il dit : Des paroles de Jésus.');
      expect(chapter.verse(2)!.segments.last.jesus, isTrue);
    });

    test('a verse over the lines of a poem; a psalm title; a stanza', () {
      final chapter = BibleChapter.fromJson(
        'PSA',
        youVersionChapter(
          3,
          '<div>'
          '<div class="d">Psaume de quelqu’un.</div>'
          '<div class="q1"><span class="yv-v" v="1"></span>'
          '<span class="yv-vlbl">1</span>Une première ligne,</div>'
          '<div class="q2">une deuxième &amp; dernière.</div>'
          '<div class="b"></div>'
          '<div class="q1"><span class="yv-v" v="2"></span>'
          '<span class="yv-vlbl">2</span>Une autre strophe.</div>'
          '</div>',
        ),
      );

      expect(
        (chapter.items.first as BibleHeading).text,
        'Psaume de quelqu’un.',
      );
      final first = chapter.verse(1)!;
      expect(first.segments.where((part) => part.isBreak), hasLength(1));
      expect(first.text, 'Une première ligne, une deuxième & dernière.');
      expect(chapter.items.whereType<BibleBreak>(), hasLength(1));
      expect(chapter.verse(2)!.segments.any((part) => part.isBreak), isFalse);
    });

    test(
      'no space added where the source has none (a note before a comma)',
      () {
        final verse = BibleChapter.fromJson(
          'JHN',
          youVersionChapter(
            1,
            '<div><div class="p"><span class="yv-v" v="4"></span>'
            '<span class="yv-vlbl">4</span>En lui était la vie'
            '<span class="yv-n f"><span class="ft">une note</span></span>'
            ', et la suite.</div></div>',
          ),
        ).verse(4)!;
        expect(verse.text, 'En lui était la vie, et la suite.');
        expect(verse.segments.last.text, ', et la suite.');
      },
    );

    test("a psalm's title that is its first verse stays a verse", () {
      final chapter = BibleChapter.fromJson(
        'PSA',
        youVersionChapter(
          23,
          '<div><div class="d"><span class="yv-v" v="1"></span>'
          '<span class="yv-vlbl">1</span>Psaume de David.</div>'
          '<div class="q1">La suite du verset.</div></div>',
        ),
      );
      expect(chapter.items.whereType<BibleHeading>(), isEmpty);
      expect(chapter.verse(1)!.text, 'Psaume de David. La suite du verset.');
    });
  });

  group('La Bible du Semeur, under licence', () {
    late FakeYouVersionBible platform;
    late FakeBibleApi free;
    late FakeBibleStorage storage;
    late ProviderContainer container;

    setUp(() {
      platform = FakeYouVersionBible();
      free = FakeBibleApi();
      storage = FakeBibleStorage();
      container = ProviderContainer(
        overrides: [
          youVersionBibleProvider.overrideWithValue(platform),
          bibleApiProvider.overrideWithValue(free),
          bibleStorageProvider.overrideWithValue(storage),
        ],
      );
      addTearDown(container.dispose);
    });

    test(
      'read from the platform (Bible 21), with its notice, never kept',
      () async {
        final chapter = await container.read(
          bibleChapterProvider(semeurVersion.id, 'JHN', 3).future,
        );

        expect(chapter.verse(16)!.text, 'Un verset pour essayer.');
        expect(chapter.copyright, 'La Bible du Semeur® © Biblica');
        expect(platform.asked, ['21/JHN.3']);
        // nothing on the phone, nothing asked of the free API
        expect(storage.files, isEmpty);
        expect(free.chaptersAsked, isEmpty);
      },
    );

    test('its books from the platform until it is downloaded', () async {
      expect(
        await container.read(bibleBooksProvider(semeurVersion.id).future),
        sampleBibleBooks,
      );
      expect(storage.files, isEmpty);
    });

    test('downloaded whole, then read without the platform', () async {
      await container
          .read(bibleDownloadProvider(semeurVersion.id).notifier)
          .download();

      // the whole Bible, from the platform, kept as one file
      expect(storage.files.keys, ['fra_bds/complete.json']);
      expect(free.downloads, isEmpty);
      expect(container.read(bibleDownloadProvider(semeurVersion.id)).value, (
        downloaded: true,
        progress: null,
      ));

      platform.asked.clear();
      final chapter = await container.read(
        bibleChapterProvider(semeurVersion.id, 'JHN', 3).future,
      );
      expect(chapter.verse(16)!.text, 'Un verset pour essayer.');
      expect(platform.asked, isEmpty);
    });

    test('a free version still reads as before, and is kept', () async {
      await container.read(bibleChapterProvider('fra_lsg', 'JHN', 3).future);
      expect(free.chaptersAsked, ['fra_lsg/JHN.3']);
      expect(storage.files.keys, contains('fra_lsg/JHN.3.json'));
      expect(platform.asked, isEmpty);
    });
  });

  test(
    'without its key and its switch, La Bible du Semeur stays on Bibleserver',
    () {
      expect(bibleVersionOf(semeurVersion.id), isNull);
      expect(externalBibles.map((bible) => bible.abbreviation), ['BDS']);
    },
  );
}
