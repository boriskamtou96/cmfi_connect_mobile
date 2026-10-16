import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/bible.dart';
import '../infrastructure/bible_api.dart';
import '../infrastructure/bible_storage.dart';

part 'bible_library.g.dart';

const _complete = 'complete.json';
const _books = 'books.json';

/// The whole of [version] once downloaded (read off the main thread), or
/// null.
@Riverpod(keepAlive: true)
Future<BibleText?> bibleText(Ref ref, String version) async {
  final raw = await ref.watch(bibleStorageProvider).read(version, _complete);
  if (raw == null) {
    return null;
  }
  try {
    // a whole Bible (megabytes) is read off the main thread
    return raw.length > 200000
        ? await compute(_parseText, raw)
        : _parseText(raw);
  } on Object {
    return null; // a broken file: the download can be made again
  }
}

BibleText _parseText(String raw) {
  final text = BibleText.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  // built here, off the main thread, for the searches to come
  text.searchIndex.length;
  return text;
}

/// The books of [version]: from the downloaded Bible, the list kept on the
/// phone, or the API (then kept).
@Riverpod(keepAlive: true)
Future<List<BibleBook>> bibleBooks(Ref ref, String version) async {
  final text = await ref.watch(bibleTextProvider(version).future);
  if (text != null) {
    return text.books;
  }
  final storage = ref.watch(bibleStorageProvider);
  final kept = await storage.read(version, _books);
  if (kept != null) {
    return [
      for (final book in jsonDecode(kept) as List<dynamic>)
        BibleBook.fromJson(book as Map<String, dynamic>),
    ];
  }
  final books = await ref.watch(bibleApiProvider).books(version);
  await storage.write(
    version,
    _books,
    utf8.encode(jsonEncode([for (final book in books) book.toJson()])),
  );
  return books;
}

/// A chapter of [version]: from the downloaded Bible, the copy kept when it
/// was read, or the API (then kept: it reads again without network).
@riverpod
Future<BibleChapter> bibleChapter(
  Ref ref,
  String version,
  String book,
  int number,
) async {
  final text = await ref.watch(bibleTextProvider(version).future);
  if (text?.chapter(book, number) case final chapter?) {
    return chapter;
  }
  final storage = ref.watch(bibleStorageProvider);
  final name = '$book.$number.json';
  final kept = await storage.read(version, name);
  if (kept != null) {
    return BibleChapter.fromJson(
      book,
      jsonDecode(kept) as Map<String, dynamic>,
    );
  }
  final json = await ref.watch(bibleApiProvider).chapter(version, book, number);
  await storage.write(version, name, utf8.encode(jsonEncode(json)));
  return BibleChapter.fromJson(book, json);
}

/// Whether [BibleDownload] has the whole version, and how far a download got
/// (0 to 1) while it runs.
typedef BibleDownloadState = ({bool downloaded, double? progress});

/// The whole of a version on the phone (about 7 MB): to read and search
/// without network.
@Riverpod(keepAlive: true)
class BibleDownload extends _$BibleDownload {
  @override
  Future<BibleDownloadState> build(String version) async => (
    downloaded: await ref.watch(bibleStorageProvider).has(version, _complete),
    progress: null,
  );

  Future<void> download() async {
    state = const AsyncData((downloaded: false, progress: 0));
    try {
      final bytes = await ref
          .read(bibleApiProvider)
          .complete(
            version,
            onProgress: (received, total) {
              if (total > 0 && ref.mounted) {
                state = AsyncData((
                  downloaded: false,
                  progress: received / total,
                ));
              }
            },
          );
      await ref.read(bibleStorageProvider).write(version, _complete, bytes);
      ref
        ..invalidate(bibleTextProvider(version))
        ..invalidate(bibleBooksProvider(version));
      state = const AsyncData((downloaded: true, progress: null));
    } on Object {
      state = const AsyncData((downloaded: false, progress: null));
      rethrow;
    }
  }

  /// Frees the space; the chapters read stay.
  Future<void> remove() async {
    await ref.read(bibleStorageProvider).remove(version, _complete);
    ref
      ..invalidate(bibleTextProvider(version))
      ..invalidate(bibleBooksProvider(version));
    state = const AsyncData((downloaded: false, progress: null));
  }
}

/// What a search finds: the place written ("Jean 3:16"), and the verses with
/// those words when the version is downloaded.
typedef BibleSearch = ({
  BibleRef? reference,
  List<({BibleRef ref, String text})> verses,
  bool downloaded,
});

@riverpod
Future<BibleSearch> bibleSearch(Ref ref, String version, String query) async {
  final books = await ref.watch(bibleBooksProvider(version).future);
  final text = await ref.watch(bibleTextProvider(version).future);
  final reference = parseBibleReference(query, books);
  return (
    reference: reference,
    verses: reference != null || text == null
        ? const <({BibleRef ref, String text})>[]
        : text.search(query),
    downloaded: text != null,
  );
}

/// The concordance of [word] in the downloaded [version]; null when it is
/// not on the phone.
@riverpod
Future<Concordance?> bibleConcordance(
  Ref ref,
  String version,
  String word, {
  bool prefix = false,
}) async {
  final text = await ref.watch(bibleTextProvider(version).future);
  return text?.concordance(word, prefix: prefix);
}
