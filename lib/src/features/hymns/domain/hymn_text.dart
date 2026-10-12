import 'hymn.dart';

/// A part as it is shown: [repeated] when it is a chorus sung again after a verse.
typedef SungPart = ({HymnPart part, bool repeated});

/// The parts in singing order. With [repeatChorus], the chorus is shown again after each
/// verse that is not already followed by one (books print it once): the last chorus met,
/// or the first one of the hymn.
List<SungPart> sungParts(Hymn hymn, {required bool repeatChorus}) {
  final parts = hymn.parts;
  final choruses = parts
      .where((part) => part.kind == HymnPartKind.chorus)
      .toList();
  if (!repeatChorus || choruses.isEmpty) {
    return [for (final part in parts) (part: part, repeated: false)];
  }

  final result = <SungPart>[];
  HymnPart? lastChorus;
  for (var i = 0; i < parts.length; i++) {
    final part = parts[i];
    result.add((part: part, repeated: false));
    if (part.kind == HymnPartKind.chorus) {
      lastChorus = part;
      continue;
    }
    final next = i + 1 < parts.length ? parts[i + 1] : null;
    if (next?.kind != HymnPartKind.chorus) {
      result.add((part: lastChorus ?? choruses.first, repeated: true));
    }
  }
  return result;
}

/// The words of a hymn as plain text, to copy: title, then each part separated by a blank line.
String hymnAsText(Hymn hymn, {required String chorusLabel, String? bookTitle}) {
  final buffer = StringBuffer('${hymn.number}. ${hymn.title}\n');
  for (final part in hymn.parts) {
    buffer.writeln();
    if (part.kind == HymnPartKind.chorus) {
      buffer.writeln(
        part.repeat > 1 ? '$chorusLabel (x${part.repeat})' : chorusLabel,
      );
    }
    for (var i = 0; i < part.lines.length; i++) {
      final prefix =
          i == 0 && part.kind == HymnPartKind.verse && part.label != null
          ? '${part.label}. '
          : '';
      buffer.writeln('$prefix${part.lines[i]}');
    }
  }
  if (hymn.author != null) {
    buffer
      ..writeln()
      ..writeln(hymn.author);
  }
  if (bookTitle != null) {
    buffer
      ..writeln()
      ..writeln(bookTitle);
  }
  return buffer.toString().trimRight();
}
