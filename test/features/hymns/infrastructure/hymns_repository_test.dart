import 'package:cmfi_connect/src/features/hymns/domain/hymn.dart';
import 'package:cmfi_connect/src/features/hymns/infrastructure/hymns_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fakes.dart';

void main() {
  test('offline: the books shipped with the app', () async {
    final repository = HymnsRepository(FakeHymnsApi(), FakeHymnBookStorage());

    final books = await repository.loadLocal();

    expect(books.map((b) => b.code), [
      'rendons-ministere-1',
      'christ-the-victor',
    ]);
  });

  test(
    'a downloaded copy wins when it is newer, the shipped one when the app is newer',
    () async {
      final storage = FakeHymnBookStorage();
      storage.saved['rendons-ministere-1'] = sampleHymnBook.copyWith(
        version: '20261101T000000.000000Z',
        title: 'New',
      );
      storage.saved['christ-the-victor'] = sampleEnglishBook.copyWith(
        version: '20200101T000000.000000Z',
        title: 'Old',
      );

      final books = await HymnsRepository(FakeHymnsApi(), storage).loadLocal();

      expect(books.first.title, 'New');
      expect(books.last.title, 'Christ the Victor');
    },
  );

  test('sync downloads only the books that changed, and saves them', () async {
    final updated = sampleHymnBook.copyWith(
      version: '20261101T000000.000000Z',
      title: 'Updated',
    );
    final api = FakeHymnsApi(books: [updated, sampleEnglishBook]);
    final storage = FakeHymnBookStorage();
    final repository = HymnsRepository(api, storage);

    final books = await repository.sync(await repository.loadLocal());

    expect(books!.first.title, 'Updated');
    expect(api.downloads, ['rendons-ministere-1']);
    expect(storage.saved.keys, ['rendons-ministere-1']);
  });

  test('sync says null when the phone is up to date', () async {
    final repository = HymnsRepository(FakeHymnsApi(), FakeHymnBookStorage());

    expect(await repository.sync(await repository.loadLocal()), isNull);
  });

  test('a book made in the back office shows once it has hymns', () async {
    const fresh = HymnBook(
      code: 'chants-edification-2',
      title: "Chants d'édification 2",
      version: '20261101T000000.000000Z',
    );
    final repository = HymnsRepository(
      FakeHymnsApi(books: [sampleHymnBook, sampleEnglishBook, fresh]),
      FakeHymnBookStorage(),
    );
    final local = await repository.loadLocal();

    // no hymn yet: not shown
    expect(await repository.sync(local), isNull);

    // its first hymn: it comes, in the order of the server
    final api = FakeHymnsApi(
      books: [
        sampleHymnBook,
        sampleEnglishBook,
        fresh.copyWith(hymns: sampleHymnBook.hymns),
      ],
    );
    final books = await HymnsRepository(api, FakeHymnBookStorage()).sync(local);
    expect(books!.map((book) => book.code), [
      'rendons-ministere-1',
      'christ-the-victor',
      'chants-edification-2',
    ]);
    expect(api.downloads, ['chants-edification-2']);
  });
}
