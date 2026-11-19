import 'dart:convert';
import 'dart:io';

import 'package:cmfi_connect/src/features/hymns/domain/hymn.dart';
import 'package:flutter_test/flutter_test.dart';

/// The books shipped with the app (assets/hymns): every one in index.json
/// reads, has the hymns it announces, numbered once each, with words.
void main() {
  final codes =
      (jsonDecode(File('assets/hymns/index.json').readAsStringSync())
              as List<dynamic>)
          .cast<String>();

  test('the index lists every shipped book once', () {
    final files = Directory('assets/hymns')
        .listSync()
        .map((file) => file.uri.pathSegments.last)
        .where((name) => name.endsWith('.json') && name != 'index.json')
        .map((name) => name.replaceAll('.json', ''))
        .toSet();
    expect(codes.toSet(), files);
    expect(codes.toSet(), hasLength(codes.length));
  });

  for (final code in codes) {
    test('the shipped book $code reads whole', () {
      final book = HymnBook.fromJson(
        jsonDecode(File('assets/hymns/$code.json').readAsStringSync())
            as Map<String, dynamic>,
      );
      expect(book.code, code);
      expect(book.hymns, hasLength(book.hymnCount), reason: code);
      final numbers = [for (final hymn in book.hymns) hymn.number];
      expect(numbers.toSet(), hasLength(numbers.length), reason: code);
      for (final hymn in book.hymns) {
        expect(hymn.title.trim(), isNotEmpty, reason: '$code ${hymn.number}');
        expect(hymn.parts, isNotEmpty, reason: '$code ${hymn.number}');
        for (final part in hymn.parts) {
          expect(part.lines, isNotEmpty, reason: '$code ${hymn.number}');
        }
      }
    });
  }

  test('« Ministering to the Lord » has its 255 hymns, in English', () {
    final book = HymnBook.fromJson(
      jsonDecode(
            File(
              'assets/hymns/ministering-to-the-lord.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>,
    );
    expect(book.title, 'Ministering to the Lord');
    expect(book.language, 'en');
    expect(
      [for (final hymn in book.hymns) hymn.number],
      [for (var n = 1; n <= 255; n++) n],
    );
    expect(book.hymns.first.title, 'Thine Is the Glory');
  });
}
