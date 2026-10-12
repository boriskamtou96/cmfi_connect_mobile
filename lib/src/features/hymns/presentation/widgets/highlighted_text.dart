import 'package:flutter/material.dart';

import '../../domain/hymn_search.dart';

/// [text] with the words of [query] emphasized (accents and case ignored).
class HighlightedText extends StatelessWidget {
  const HighlightedText(
    this.text, {
    required this.query,
    required this.style,
    this.highlight,
    this.maxLines = 1,
    super.key,
  });

  final String text;
  final String query;
  final TextStyle style;
  final TextStyle? highlight;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final ranges = query.trim().isEmpty
        ? const <({int start, int end})>[]
        : matchRanges(text, query);
    final emphasis =
        highlight ??
        TextStyle(
          fontWeight: FontWeight.w800,
          color: Theme.of(context).colorScheme.primary,
        );
    final spans = <TextSpan>[];
    var cursor = 0;
    for (final range in ranges) {
      if (range.start > cursor) {
        spans.add(TextSpan(text: text.substring(cursor, range.start)));
      }
      spans.add(
        TextSpan(text: text.substring(range.start, range.end), style: emphasis),
      );
      cursor = range.end;
    }
    if (cursor < text.length) {
      spans.add(TextSpan(text: text.substring(cursor)));
    }
    return Text.rich(
      TextSpan(style: style, children: spans),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
