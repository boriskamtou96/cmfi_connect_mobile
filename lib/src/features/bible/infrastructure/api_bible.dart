import 'dart:math';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/storage/preferences.dart';
import '../domain/bible.dart';

part 'api_bible.g.dart';

/// api.bible (American Bible Society): the Bibles under licence (La Bible du
/// Semeur, © Biblica). Read with the network, a chapter at a time, never kept
/// on the phone; each chapter shown is told to api.bible (FUMS, its fair use
/// count), without anything that names the reader.
class ApiBible {
  ApiBible(this._dio, this._ids);

  static const base = 'https://rest.api.bible/v1';
  static const _fums = 'https://fums.api.bible/f3';

  final Dio _dio;
  final ({String device, String user}) _ids;

  /// One per launch of the app (FUMS' session).
  static final _session = _randomId();

  Options get _key => Options(headers: {'api-key': AppConfig.apiBibleKey});

  /// The books of [bibleId], in order, with their chapters (the introductions
  /// left out).
  Future<List<BibleBook>> books(String bibleId) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$base/bibles/$bibleId/books',
      queryParameters: {'include-chapters': true},
      options: _key,
    );
    final books = response.data!['data'] as List<dynamic>;
    return [
      for (final (i, book) in books.indexed)
        if (book case {'id': final String id, 'name': final String name})
          BibleBook(
            id: id,
            name: name,
            order: i + 1,
            chapters: [
              for (final chapter in (book['chapters'] as List<dynamic>?) ?? [])
                if (int.tryParse('${(chapter as Map)['number']}') != null)
                  chapter,
            ].length,
          ),
    ];
  });

  /// Chapter [number] of [book] (USFM, "JHN"): the chapter as the reader
  /// takes it, the notice of its publisher, and the token of its view.
  Future<({Map<String, dynamic> chapter, String copyright, String? fums})>
  chapter(String bibleId, String book, int number) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$base/bibles/$bibleId/chapters/$book.$number',
      queryParameters: {
        'content-type': 'json',
        'include-notes': false,
        'include-titles': true,
        'include-chapter-numbers': false,
        'include-verse-numbers': false,
        'fums-version': 3,
      },
      options: _key,
    );
    final data = response.data!['data'] as Map<String, dynamic>;
    final meta = response.data!['meta'] as Map<String, dynamic>?;
    return (
      chapter: apiBibleChapter(number, data['content'] as List<dynamic>),
      copyright: (data['copyright'] as String?)?.trim() ?? '',
      fums: meta?['fumsToken'] as String?,
    );
  });

  /// Tells api.bible the chapters shown ([tokens]). Never fails: a count
  /// lost is not worth an error on the screen.
  Future<void> viewed(List<String> tokens) async {
    if (tokens.isEmpty) {
      return;
    }
    try {
      final query = [
        for (final token in tokens) 't=${Uri.encodeQueryComponent(token)}',
        'dId=${_ids.device}',
        'sId=$_session',
        'uId=${_ids.user}',
      ].join('&');
      await _dio.get<void>('$_fums?$query');
    } on DioException {
      // offline: this view goes uncounted
    }
  }
}

String _randomId() {
  final random = Random.secure();
  return [
    for (var i = 0; i < 16; i++) random.nextInt(256).toRadixString(16),
  ].map((byte) => byte.padLeft(2, '0')).join();
}

/// api.bible's chapter (content-type=json: paragraphs of tags and texts, each
/// text with its verseId) in the shape of the Free Use Bible API that the
/// reader reads: {number, content: [heading, verse…]}. A verse running over
/// several paragraphs (poems) keeps a line break between them; the words of
/// Jesus (wj) stay marked.
Map<String, dynamic> apiBibleChapter(int number, List<dynamic> paragraphs) {
  final content = <Map<String, dynamic>>[];
  final verses = <String, List<Object>>{};
  String? current;

  void text(Map<String, dynamic> node, {required bool jesus}) {
    final id = (node['attrs'] as Map?)?['verseId'] as String?;
    final words = node['text'] as String?;
    if (id == null || words == null || words.trim().isEmpty) {
      return;
    }
    final parts = verses.putIfAbsent(id, () {
      final parts = <Object>[];
      content.add({
        'type': 'verse',
        'number': _verseNumber(id),
        'content': parts,
      });
      return parts;
    });
    parts.add(jesus ? {'text': words, 'wordsOfJesus': true} : words);
    current = id;
  }

  void walk(List<dynamic> items, {required bool jesus}) {
    for (final item in items) {
      if (item is! Map<String, dynamic>) {
        continue;
      }
      switch (item) {
        case {'type': 'text'}:
          text(item, jesus: jesus);
        // the verse number and the notes are not words of the text
        case {'name': 'verse' || 'note'}:
          break;
        case {'items': final List<dynamic> inner}:
          final style = (item['attrs'] as Map?)?['style'];
          walk(inner, jesus: jesus || style == 'wj');
      }
    }
  }

  for (final paragraph in paragraphs) {
    if (paragraph is! Map<String, dynamic>) {
      continue;
    }
    final style = '${(paragraph['attrs'] as Map?)?['style'] ?? ''}';
    final items = (paragraph['items'] as List<dynamic>?) ?? const [];
    // section titles, a psalm's own title
    if (RegExp(r'^(s\d?|ms\d?|mr|sp|d)$').hasMatch(style)) {
      final title = _words(items).trim();
      if (title.isNotEmpty) {
        content.add({
          'type': 'heading',
          'content': [title],
        });
      }
      continue;
    }
    // a blank line between stanzas
    if (style == 'b') {
      content.add({'type': 'line_break'});
      continue;
    }
    // a verse going on in this paragraph starts a new line
    final going = current;
    if (going != null) {
      verses[going]!.add({'lineBreak': true});
    }
    walk(items, jesus: false);
  }
  return {'number': number, 'content': content};
}

/// "JHN.3.16" -> 16 (the first of a span "JHN.3.16-17").
int _verseNumber(String verseId) =>
    int.tryParse(verseId.split('.').last.split('-').first) ?? 0;

String _words(List<dynamic> items) => [
  for (final item in items)
    if (item is Map<String, dynamic>)
      switch (item) {
        {'type': 'text', 'text': final String text} => text,
        {'name': 'note'} => '',
        {'items': final List<dynamic> inner} => _words(inner),
        _ => '',
      },
].join();

/// The ids FUMS wants: the device's, and the reader's (a random one of this
/// phone, the same at each launch, that says nothing of who reads).
@Riverpod(keepAlive: true)
ApiBible apiBible(Ref ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  String kept(String key) {
    final saved = preferences.getString(key);
    if (saved != null) {
      return saved;
    }
    final id = _randomId();
    preferences.setString(key, id);
    return id;
  }

  return ApiBible(ref.watch(dioProvider), (
    device: kept('api_bible_device'),
    user: kept('api_bible_reader'),
  ));
}
