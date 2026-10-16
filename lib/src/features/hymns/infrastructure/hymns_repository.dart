import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/hymn.dart';
import 'hymn_book_storage.dart';
import 'hymns_api.dart';

part 'hymns_repository.g.dart';

/// The books come from the phone first (offline, instantly), then the server updates them.
class HymnsRepository {
  const HymnsRepository(this._api, this._storage);

  final HymnsApi _api;
  final HymnBookStorage _storage;

  /// The books on the phone: for each one, the most recent of the shipped and downloaded copies.
  Future<List<HymnBook>> loadLocal() async {
    final bundled = await _storage.bundledCodes();
    final order = await _storage.readOrder() ?? bundled;
    final codes = [...order, ...bundled.where((code) => !order.contains(code))];

    final books = <HymnBook>[];
    for (final code in codes) {
      final copies = [
        await _storage.readSaved(code),
        await _storage.readBundled(code),
      ].nonNulls.toList();
      if (copies.isEmpty) {
        continue;
      }
      // versions are timestamps written "20261008T224132.721494Z": they sort as text
      copies.sort((a, b) => b.version.compareTo(a.version));
      books.add(copies.first);
    }
    return books;
  }

  /// Downloads the books that changed on the server. Returns the new list of books,
  /// or null when the phone was already up to date. Throws an AppException when offline.
  Future<List<HymnBook>?> sync(List<HymnBook> local) async {
    final summaries = await _api.listBooks();
    if (summaries.isEmpty) {
      return null;
    }

    var changed = false;
    final books = <HymnBook>[];
    for (final summary in summaries) {
      // a book the admins just made, without hymns yet: not shown
      if (summary.hymnCount == 0) {
        continue;
      }
      final current = local
          .where((book) => book.code == summary.code)
          .firstOrNull;
      if (current != null && current.version == summary.version) {
        books.add(current);
        continue;
      }
      final downloaded = await _api.getBook(
        summary.code,
        version: current?.version,
      );
      if (downloaded == null) {
        books.add(current!); // 304: still current
        continue;
      }
      await _storage.save(downloaded);
      books.add(downloaded);
      changed = true;
    }

    final order = [for (final book in books) book.code];
    if (changed ||
        order.join(',') != local.map((book) => book.code).join(',')) {
      await _storage.saveOrder(order);
      return books;
    }
    return null;
  }
}

@Riverpod(keepAlive: true)
HymnsRepository hymnsRepository(Ref ref) => HymnsRepository(
  ref.watch(hymnsApiProvider),
  ref.watch(hymnBookStorageProvider),
);
