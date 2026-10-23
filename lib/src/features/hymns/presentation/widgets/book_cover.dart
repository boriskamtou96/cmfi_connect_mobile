import 'package:flutter/material.dart';

import '../../../../core/widgets/cmfi_logo.dart';
import '../../domain/hymn.dart';

/// The colors of the covers, by the place of the book in the library: the
/// first one takes the teal of the hymns.
const _coverColors = [
  [Color(0xFF18A091), Color(0xFF0A4E48)],
  [Color(0xFF3B6FD8), Color(0xFF1A2F6E)],
  [Color(0xFFB94A6C), Color(0xFF5A1D33)],
  [Color(0xFF8E5BC2), Color(0xFF3B2160)],
  [Color(0xFFD08A2C), Color(0xFF7A4210)],
  [Color(0xFF2E9E62), Color(0xFF0F4A2E)],
];

List<Color> bookCoverColors(int index) =>
    _coverColors[index % _coverColors.length];

/// "Chants d'édification, volume 1": the name on the cover, and "VOLUME 1"
/// under it; a book without a volume shows its language.
({String name, String label}) bookCoverText(HymnBook book) {
  final match = RegExp(
    r'^(.*?),?\s+(volume|vol\.)\s*(\d+)$',
    caseSensitive: false,
  ).firstMatch(book.title.trim());
  if (match != null) {
    return (
      name: match.group(1)!,
      label: '${match.group(2)!.toUpperCase()} ${match.group(3)}',
    );
  }
  return (
    name: book.title,
    label: switch (book.language) {
      'fr' => 'FRANÇAIS',
      'en' => 'ENGLISH',
      final code => code.toUpperCase(),
    },
  );
}

/// A hymn book like an album: its color, the emblem, the name in Lora italic,
/// the open ring of the emblem behind.
class BookCover extends StatelessWidget {
  const BookCover({
    required this.book,
    required this.colors,
    required this.size,
    super.key,
  });

  final HymnBook book;
  final List<Color> colors;
  final double size;

  @override
  Widget build(BuildContext context) {
    final text = bookCoverText(book);
    // an illustration of a set size: its words don't follow the phone's
    // text size (they would run out of the cover)
    return MediaQuery.withNoTextScaling(child: _cover(text));
  }

  Widget _cover(({String name, String label}) text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.08),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
        ),
        child: Stack(
          children: [
            PositionedDirectional(
              end: -size * 0.28,
              bottom: -size * 0.28,
              child: BrandRing(
                size: size * 1.05,
                color: Colors.white.withValues(alpha: 0.14),
                strokeWidth: 8,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size * 0.09),
              // the books are in French and English
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox.square(
                      dimension: size * 0.17,
                      child: const CustomPaint(
                        painter: CmfiLogoPainter(disc: true, details: false),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      text.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Lora',
                        fontStyle: FontStyle.italic,
                        fontSize: size * 0.12,
                        height: 1.08,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: size * 0.04),
                    Text(
                      text.label,
                      style: TextStyle(
                        fontSize: size * 0.055,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
