import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/bible.dart';

part 'youversion_bible.g.dart';

/// The YouVersion Platform: the Bibles under licence (La Bible du Semeur,
/// © Biblica, through Biblica's licence). Read with the network, a chapter
/// at a time, never kept on the phone; the platform counts the readings for
/// the publisher itself.
class YouVersionBible {
  YouVersionBible(this._dio);

  static const base = 'https://api.youversion.com/v1';

  final Dio _dio;
  final _notices = <int, Future<String>>{};

  Options get _key =>
      Options(headers: {'X-YVP-App-Key': AppConfig.youversionAppKey});

  /// The books of [bibleId], in order, with their chapters (an
  /// introduction left out).
  Future<List<BibleBook>> books(int bibleId) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$base/bibles/$bibleId/books',
      options: _key,
    );
    final books = response.data!['data'] as List<dynamic>;
    return [
      for (final (i, book) in books.indexed)
        if (book case {'id': final String id, 'title': final String title})
          BibleBook(
            id: id,
            name: title,
            order: i + 1,
            chapters: [
              for (final chapter in (book['chapters'] as List<dynamic>?) ?? [])
                if (int.tryParse('${(chapter as Map)['id']}') != null) chapter,
            ].length,
          ),
    ];
  });

  /// Chapter [number] of [book] (USFM, "JHN"), with its headings and notes,
  /// as the reader takes it; and the notice of its publisher.
  Future<({Map<String, dynamic> chapter, String copyright})> chapter(
    int bibleId,
    String book,
    int number,
  ) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '$base/bibles/$bibleId/passages/$book.$number',
      queryParameters: {
        'format': 'html',
        'include_headings': true,
        'include_notes': true,
      },
      options: _key,
    );
    return (
      chapter: youVersionChapter(number, response.data!['content'] as String),
      copyright: await _notice(bibleId),
    );
  });

  /// The copyright of [bibleId] as its publisher gives it (asked once).
  Future<String> _notice(int bibleId) =>
      _notices[bibleId] ??= apiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>(
          '$base/bibles/$bibleId',
          options: _key,
        );
        return ((response.data!['copyright'] as String?) ?? '').trim();
      });
}

/// The chapter of the YouVersion Platform (HTML: a div a paragraph, the
/// verses marked by a span "yv-v", the notes by "yv-n") in the shape of the
/// Free Use Bible API that the reader reads: {number, content: [heading,
/// verse…]}. A verse running over several paragraphs (poems) keeps a line
/// break between them; the words of Jesus (wj) stay marked; each note stays
/// where it is, with its text.
Map<String, dynamic> youVersionChapter(int number, String html) {
  final content = <Map<String, dynamic>>[];
  final verses = <int, List<Object>>{};
  int? current;

  // what the paragraph read so far holds: verse marks, words, notes
  var pieces = <({int? verse, String? words, bool jesus, String? note})>[];
  var paragraph = '';
  var marked = false;

  void close() {
    final style = paragraph;
    final heading =
        style.contains('yv-h') ||
        RegExp(r'^(s\d?|ms\d?|mr|sp|r|qa|cl)$').hasMatch(style) ||
        // a psalm's own title, when it is not a verse
        (style == 'd' && !marked);
    if (heading) {
      final title = pieces
          .map((piece) => piece.words ?? '')
          .join()
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
      if (title.isNotEmpty) {
        content.add({
          'type': 'heading',
          'content': [title],
        });
      }
    } else if (style == 'b') {
      content.add({'type': 'line_break'});
    } else {
      // a verse going on in this paragraph starts a new line
      var first = true;
      for (final piece in pieces) {
        if (piece.verse case final verse?) {
          current = verse;
          verses.putIfAbsent(verse, () {
            final parts = <Object>[];
            content.add({'type': 'verse', 'number': verse, 'content': parts});
            return parts;
          });
          first = false;
          continue;
        }
        final parts = verses[current];
        if (parts == null) {
          continue;
        }
        if (first && piece.words != null && piece.words!.trim().isNotEmpty) {
          parts.add({'lineBreak': true});
          first = false;
        }
        if (piece.note case final note?) {
          parts.add({'note': note});
        } else if (piece.words case final words?) {
          parts.add(
            piece.jesus ? {'text': words, 'wordsOfJesus': true} : words,
          );
        }
      }
    }
    pieces = [];
    paragraph = '';
    marked = false;
  }

  // the open elements: their classes, and the verse number of a mark
  final open = <({String tag, Set<String> classes})>[];
  final note = StringBuffer();
  final tokens = RegExp(
    r'<(/?)([a-zA-Z0-9]+)([^>]*)>|([^<]+)',
  ).allMatches(html);

  bool inside(String name) =>
      open.any((element) => element.classes.contains(name));

  for (final token in tokens) {
    if (token[4] case final text?) {
      final words = _entities(text);
      if (inside('yv-vlbl') || inside('fr')) {
        continue; // the verse number, the place a note is on
      }
      if (inside('yv-n')) {
        note.write(words);
        continue;
      }
      pieces.add((verse: null, words: words, jesus: inside('wj'), note: null));
      continue;
    }
    final closing = token[1] == '/';
    final tag = token[2]!.toLowerCase();
    if (closing) {
      final element = open.isEmpty ? null : open.removeLast();
      if (element == null) {
        continue;
      }
      if (element.classes.contains('yv-n')) {
        final text = note.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
        note.clear();
        if (text.isNotEmpty) {
          pieces.add((verse: null, words: null, jesus: false, note: text));
        }
      }
      if (tag == 'div' && element.classes.isNotEmpty) {
        close();
      }
      continue;
    }
    final attrs = token[3] ?? '';
    final classes = {
      ...?RegExp(r'class="([^"]*)"').firstMatch(attrs)?[1]?.split(' '),
    }..remove('');
    final selfClosing = attrs.trimRight().endsWith('/');
    if (tag == 'div' && classes.isNotEmpty) {
      // a paragraph left open by the markup ends where the next one starts
      if (paragraph.isNotEmpty || pieces.isNotEmpty) {
        close();
      }
      paragraph = classes.join(' ');
    }
    if (classes.contains('yv-v')) {
      final verse = int.tryParse(
        RegExp(r'\bv="(\d+)').firstMatch(attrs)?[1] ?? '',
      );
      if (verse != null) {
        pieces.add((verse: verse, words: null, jesus: false, note: null));
        marked = true;
      }
    }
    if (!selfClosing) {
      open.add((tag: tag, classes: classes));
    }
  }
  if (pieces.isNotEmpty) {
    close();
  }
  return {'number': number, 'content': content};
}

String _entities(String text) => text
    .replaceAll('&nbsp;', ' ')
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll('&quot;', '"')
    .replaceAll('&#39;', "'")
    .replaceAll('&apos;', "'")
    .replaceAllMapped(
      RegExp(r'&#(x?)([0-9a-fA-F]+);'),
      (m) =>
          String.fromCharCode(int.parse(m[2]!, radix: m[1]!.isEmpty ? 10 : 16)),
    )
    .replaceAll('&amp;', '&');

@Riverpod(keepAlive: true)
YouVersionBible youVersionBible(Ref ref) =>
    YouVersionBible(ref.watch(dioProvider));
