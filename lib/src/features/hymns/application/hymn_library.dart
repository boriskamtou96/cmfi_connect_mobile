import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/storage/preferences.dart';
import '../domain/hymn.dart';
import '../domain/hymn_search.dart';
import '../infrastructure/hymns_repository.dart';

part 'hymn_library.g.dart';

/// Every hymn book on the phone. Shown at once from the local copies; the server is asked
/// for newer versions in the background (at most every few hours, or on pull to refresh).
@Riverpod(keepAlive: true)
class HymnLibrary extends _$HymnLibrary {
  static const _syncedAtKey = 'hymns_synced_at';
  static const _syncEvery = Duration(hours: 6);

  bool _syncing = false;

  @override
  Future<List<HymnBook>> build() async {
    final books = await ref.watch(hymnsRepositoryProvider).loadLocal();
    final syncedAt = DateTime.tryParse(
      ref.read(sharedPreferencesProvider).getString(_syncedAtKey) ?? '',
    );
    if (syncedAt == null || DateTime.now().difference(syncedAt) > _syncEvery) {
      Future.microtask(() => refresh().then((_) {}, onError: (_) {}));
    }
    return books;
  }

  /// Asks the server for newer books. Returns true when something was updated;
  /// throws an AppException (offline...) only so pull to refresh can say it.
  Future<bool> refresh() async {
    final local = state.value;
    if (_syncing || local == null) {
      return false;
    }
    _syncing = true;
    try {
      final updated = await ref.read(hymnsRepositoryProvider).sync(local);
      await ref
          .read(sharedPreferencesProvider)
          .setString(_syncedAtKey, DateTime.now().toIso8601String());
      if (updated != null && ref.mounted) {
        state = AsyncData(updated);
      }
      return updated != null;
    } on AppException {
      rethrow;
    } finally {
      _syncing = false;
    }
  }
}

/// The book chosen in the Hymns tab, remembered.
@Riverpod(keepAlive: true)
class SelectedHymnBookCode extends _$SelectedHymnBookCode {
  static const _key = 'hymn_book';

  @override
  String? build() => ref.watch(sharedPreferencesProvider).getString(_key);

  Future<void> select(String code) async {
    await ref.read(sharedPreferencesProvider).setString(_key, code);
    state = code;
  }
}

/// The chosen book; by default the first one in the app's language.
@riverpod
HymnBook? selectedHymnBook(Ref ref) {
  final books = ref.watch(hymnLibraryProvider).value ?? const <HymnBook>[];
  if (books.isEmpty) {
    return null;
  }
  final code = ref.watch(selectedHymnBookCodeProvider);
  final language = LocaleSettings.currentLocale.languageCode;
  return books.where((book) => book.code == code).firstOrNull ??
      books.where((book) => book.language == language).firstOrNull ??
      books.first;
}

/// A book by its code, or null while the library loads.
@riverpod
HymnBook? hymnBook(Ref ref, String code) => ref
    .watch(hymnLibraryProvider)
    .value
    ?.where((book) => book.code == code)
    .firstOrNull;

/// The search index of a book, built once per version of the book.
@riverpod
HymnSearchIndex hymnSearchIndex(Ref ref, String code) {
  final book = ref.watch(hymnBookProvider(code));
  return HymnSearchIndex(
    book ?? const HymnBook(code: '', title: '', version: ''),
  );
}
