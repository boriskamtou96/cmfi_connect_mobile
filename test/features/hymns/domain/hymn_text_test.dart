import 'package:cmfi_connect/src/features/hymns/domain/hymn.dart';
import 'package:cmfi_connect/src/features/hymns/domain/hymn_text.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fakes.dart';

void main() {
  final hymn = sampleHymnBook.hymn(1)!;

  test('as printed: the chorus once', () {
    final parts = sungParts(hymn, repeatChorus: false);
    expect(parts.map((p) => p.part.kind), [
      HymnPartKind.verse,
      HymnPartKind.chorus,
      HymnPartKind.verse,
    ]);
  });

  test('the chorus comes back after each verse, marked as repeated', () {
    final parts = sungParts(hymn, repeatChorus: true);
    expect(parts.map((p) => (p.part.kind, p.repeated)), [
      (HymnPartKind.verse, false),
      (HymnPartKind.chorus, false),
      (HymnPartKind.verse, false),
      (HymnPartKind.chorus, true),
    ]);
  });

  test('a hymn without chorus is left as it is', () {
    final noChorus = sampleHymnBook.hymn(2)!;
    expect(sungParts(noChorus, repeatChorus: true), hasLength(1));
  });

  test('copied text keeps numbers, chorus and repeats', () {
    final text = hymnAsText(
      hymn,
      chorusLabel: 'Refrain',
      bookTitle: 'Rendons ministère',
    );
    expect(
      text,
      startsWith(
        '1. A Toi la gloire\n\n1. À toi la gloire\nÔ Ressuscité\n\nRefrain (x2)\nÀ toi la victoire',
      ),
    );
    expect(text, endsWith('Rendons ministère'));
  });

  test('hymn references round trip through their key', () {
    const ref = HymnRef(bookCode: 'christ-est-vainqueur', number: 12);
    expect(HymnRef.parse(ref.key), ref);
  });
}
