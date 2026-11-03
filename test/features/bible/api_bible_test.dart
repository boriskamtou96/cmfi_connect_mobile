import 'package:cmfi_connect/src/features/bible/application/bible_library.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible_version.dart';
import 'package:cmfi_connect/src/features/bible/infrastructure/api_bible.dart';
import 'package:cmfi_connect/src/features/bible/infrastructure/bible_api.dart';
import 'package:cmfi_connect/src/features/bible/infrastructure/bible_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../helpers/bible_fakes.dart';

/// A text of api.bible (content-type=json), in its verse.
Map<String, dynamic> _text(String verseId, String text) => {
  'text': text,
  'type': 'text',
  'attrs': {'verseId': verseId},
};

Map<String, dynamic> _para(String style, List<Map<String, dynamic>> items) => {
  'name': 'para',
  'type': 'tag',
  'attrs': {'style': style},
  'items': items,
};

Map<String, dynamic> _verseMark(String number) => {
  'name': 'verse',
  'type': 'tag',
  'attrs': {'number': number, 'style': 'v'},
  'items': [
    {'text': number, 'type': 'text'},
  ],
};

/// api.bible, as the library uses it: one chapter of John 3 under licence,
/// and the views told.
class FakeApiBible implements ApiBible {
  final asked = <String>[];
  final views = <String>[];

  @override
  Future<List<BibleBook>> books(String bibleId) async => sampleBibleBooks;

  @override
  Future<({Map<String, dynamic> chapter, String copyright, String? fums})>
  chapter(String bibleId, String book, int number) async {
    asked.add('$book.$number');
    return (
      chapter: apiBibleChapter(number, [
        _para('p', [
          _verseMark('16'),
          _text('$book.$number.16', 'Oui, Dieu a tant aimé le monde.'),
        ]),
      ]),
      copyright: 'Bible du Semeur © Biblica',
      fums: 'token-$book.$number',
    );
  }

  @override
  Future<void> viewed(List<String> tokens) async => views.addAll(tokens);
}

void main() {
  group('a chapter of api.bible, in the shape the reader reads', () {
    test('titles, verses, the words of Jesus; no verse number nor note', () {
      final chapter = BibleChapter.fromJson(
        'JHN',
        apiBibleChapter(3, [
          _para('s1', [
            {'text': 'Entretien avec Nicodème', 'type': 'text'},
          ]),
          _para('p', [
            _verseMark('1'),
            _text('JHN.3.1', 'Il y avait un pharisien nommé Nicodème.'),
            _verseMark('2'),
            _text('JHN.3.2', 'Il vint trouver Jésus.'),
            {
              'name': 'note',
              'type': 'tag',
              'attrs': {'style': 'f'},
              'items': [_text('JHN.3.2', 'une note')],
            },
            {
              'name': 'char',
              'type': 'tag',
              'attrs': {'style': 'wj'},
              'items': [_text('JHN.3.2', 'Je te le dis.')],
            },
          ]),
        ]),
      );

      expect(chapter.number, 3);
      expect(chapter.items.first, isA<BibleHeading>());
      expect(
        (chapter.items.first as BibleHeading).text,
        'Entretien avec Nicodème',
      );
      expect(chapter.verses.map((verse) => verse.number), [1, 2]);
      expect(chapter.verse(1)!.text, 'Il y avait un pharisien nommé Nicodème.');
      expect(chapter.verse(2)!.text, 'Il vint trouver Jésus. Je te le dis.');
      expect(chapter.verse(2)!.segments.last.jesus, isTrue);
    });

    test('a verse over the lines of a poem keeps them; a stanza ends', () {
      final chapter = BibleChapter.fromJson(
        'PSA',
        apiBibleChapter(23, [
          _para('d', [
            {'text': 'Psaume de David.', 'type': 'text'},
          ]),
          _para('q1', [
            _verseMark('1'),
            _text('PSA.23.1', "L'Eternel est mon berger :"),
          ]),
          _para('q2', [_text('PSA.23.1', 'je ne manquerai de rien.')]),
          _para('b', const []),
          _para('q1', [
            _verseMark('2'),
            _text('PSA.23.2', 'Il me fait reposer.'),
          ]),
        ]),
      );

      expect((chapter.items.first as BibleHeading).text, 'Psaume de David.');
      final first = chapter.verse(1)!;
      expect(first.segments.where((part) => part.isBreak), hasLength(1));
      expect(first.text, "L'Eternel est mon berger : je ne manquerai de rien.");
      expect(chapter.items.whereType<BibleBreak>(), hasLength(1));
      expect(chapter.verse(2)!.segments.any((part) => part.isBreak), isFalse);
    });
  });

  group('La Bible du Semeur, under licence', () {
    late FakeApiBible api;
    late FakeBibleApi free;
    late FakeBibleStorage storage;
    late ProviderContainer container;

    setUp(() {
      api = FakeApiBible();
      free = FakeBibleApi();
      storage = FakeBibleStorage();
      container = ProviderContainer(
        overrides: [
          apiBibleProvider.overrideWithValue(api),
          bibleApiProvider.overrideWithValue(free),
          bibleStorageProvider.overrideWithValue(storage),
        ],
      );
      addTearDown(container.dispose);
    });

    test('read from api.bible, never kept, each view told', () async {
      final chapter = await container.read(
        bibleChapterProvider(semeurVersion.id, 'JHN', 3).future,
      );

      expect(chapter.verse(16)!.text, 'Oui, Dieu a tant aimé le monde.');
      expect(chapter.copyright, 'Bible du Semeur © Biblica');
      expect(api.asked, ['JHN.3']);
      expect(api.views, ['token-JHN.3']);
      // nothing on the phone, nothing asked of the free API
      expect(storage.files, isEmpty);
      expect(free.chaptersAsked, isEmpty);
    });

    test('its books from api.bible; no download', () async {
      final books = await container.read(
        bibleBooksProvider(semeurVersion.id).future,
      );
      expect(books, sampleBibleBooks);

      await container
          .read(bibleDownloadProvider(semeurVersion.id).notifier)
          .download();
      expect(free.downloads, isEmpty);
      expect(storage.files, isEmpty);
    });

    test('a free version still reads as before, and is kept', () async {
      await container.read(bibleChapterProvider('fra_lsg', 'JHN', 3).future);
      expect(free.chaptersAsked, ['fra_lsg/JHN.3']);
      expect(storage.files.keys, contains('fra_lsg/JHN.3.json'));
      expect(api.asked, isEmpty);
    });
  });

  test('the views told to FUMS: tokens, device, session, reader', () async {
    final asked = <Uri>[];
    final dio = Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            asked.add(options.uri);
            handler.resolve(Response(requestOptions: options, statusCode: 200));
          },
        ),
      );
    await ApiBible(dio, (device: 'd1', user: 'u1')).viewed(['a', 'b']);

    expect(asked.single.host, 'fums.api.bible');
    expect(asked.single.queryParametersAll['t'], ['a', 'b']);
    expect(asked.single.queryParameters['dId'], 'd1');
    expect(asked.single.queryParameters['uId'], 'u1');
    expect(asked.single.queryParameters['sId'], isNotEmpty);
  });

  test('without its keys, La Bible du Semeur stays on Bibleserver', () {
    expect(bibleVersionOf(semeurVersion.id), isNull);
    expect(externalBibles.map((bible) => bible.abbreviation), ['BDS']);
  });
}
