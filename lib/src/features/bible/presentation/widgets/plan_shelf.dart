import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_tones.dart';
import '../../application/bible_plan.dart';
import '../../domain/bible.dart';
import '../../domain/reading_plan.dart';

/// For each of the 66 books ([planBooks]), whether [scope] reads it.
List<bool> scopeBooks(PlanScope scope) => [
  for (final (i, (book, _)) in planBooks.indexed)
    switch (scope) {
      PlanScope.bible => true,
      PlanScope.oldTestament => i < oldTestamentBooks,
      PlanScope.newTestament => i >= oldTestamentBooks,
      PlanScope.psalmsProverbs => book == 'PSA' || book == 'PRO',
    },
];

/// For each of the 66 books, how much of it [progress] has read (0 to 1).
List<double> readShares(PlanProgress progress) => [
  for (final (book, chapters) in planBooks)
    [
          for (var chapter = 1; chapter <= chapters; chapter++)
            if (progress.isRead(BibleRef(book, chapter))) chapter,
        ].length /
        chapters,
];

/// The colours of the spines on the night blue: the Old Testament in the
/// bordeaux of the Bible (lightened), the New in gold, the books left out
/// faint. The same in light and dark mode, like the night-blue header.
({Color old, Color fresh, Color off}) _spineColors(BuildContext context) => (
  old: Color.lerp(AppModule.bible.tone(context).color, Colors.white, 0.25)!,
  fresh: AppColors.gold,
  off: Colors.white.withValues(alpha: 0.14),
);

/// The reading plan's shelf (« Livre ouvert », validated on 19/10/2026): the
/// 66 books as spines, each as tall as its chapters, in the order of the
/// Bible; the books of the plan in colour, the others faint. While reading,
/// each spine fills with gold as its chapters are read, and a bookmark
/// stands on the book of the day. Under it, where each Testament starts.
/// Decorative: the figures of the page say the same in words. Always left
/// to right, as the books follow one another.
class PlanShelf extends StatelessWidget {
  const PlanShelf({
    required this.inScope,
    this.read = const [],
    this.bookmark,
    this.height = 84,
    super.key,
  });

  /// For each book, whether the plan reads it ([scopeBooks]).
  final List<bool> inScope;

  /// For each book, how much is read ([readShares]); empty: a plan to make.
  final List<double> read;

  /// The index of the book of the day in [planBooks].
  final int? bookmark;

  /// The height of the spines (the labels add about 16).
  final double height;

  @override
  Widget build(BuildContext context) {
    final t = context.t.biblePlan;
    final colors = _spineColors(context);
    const label = TextStyle(
      fontSize: 9.5,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w800,
      color: Color(0x99FFFFFF),
    );
    return ExcludeSemantics(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: height,
              child: CustomPaint(
                painter: _ShelfPainter(
                  inScope: inScope,
                  read: read,
                  bookmark: bookmark,
                  old: colors.old,
                  fresh: colors.fresh,
                  off: colors.off,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                // as wide as their spines: 39 books, then 27
                Expanded(
                  flex: oldTestamentBooks,
                  child: Text(
                    t.oldTestament.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: label,
                  ),
                ),
                Expanded(
                  flex: planBooks.length - oldTestamentBooks,
                  child: Text(
                    t.newTestament.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: label,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ShelfPainter extends CustomPainter {
  const _ShelfPainter({
    required this.inScope,
    required this.read,
    required this.bookmark,
    required this.old,
    required this.fresh,
    required this.off,
  });

  final List<bool> inScope;
  final List<double> read;
  final int? bookmark;
  final Color old;
  final Color fresh;
  final Color off;

  @override
  void paint(Canvas canvas, Size size) {
    const gap = 1.3;
    const testamentGap = 6.0;
    // room above the tallest spine for the bookmark
    const top = 14.0;
    final count = planBooks.length;
    final width = (size.width - gap * (count - 2) - testamentGap) / count;
    final shelf = size.height - 3;
    var x = 0.0;
    for (var i = 0; i < count; i++) {
      final chapters = planBooks[i].$2;
      // Psalms (150) the tallest, Obadiah (1) still a spine
      final height = (shelf - top) * (0.28 + 0.72 * math.sqrt(chapters / 150));
      final spine = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, shelf - height, width, height),
        const Radius.circular(1.2),
      );
      final color = !inScope[i]
          ? off
          : i < oldTestamentBooks
          ? old
          : fresh;
      // while reading, the spines are dim until their chapters fill them
      canvas.drawRRect(
        spine,
        Paint()
          ..color = read.isEmpty || !inScope[i]
              ? color
              : color.withValues(alpha: 0.35),
      );
      final share = read.isEmpty ? 0.0 : read[i];
      if (share > 0) {
        canvas
          ..save()
          ..clipRRect(spine)
          ..drawRect(
            Rect.fromLTWH(x, shelf - height * share, width, height * share),
            Paint()..color = AppColors.goldLight,
          )
          ..restore();
      }
      if (i == bookmark) {
        // a ribbon with a notch, standing on the book
        final ribbon = Path()
          ..moveTo(x - 1.5, shelf - height - 12)
          ..lineTo(x + width + 1.5, shelf - height - 12)
          ..lineTo(x + width + 1.5, shelf - height + 10)
          ..lineTo(x + width / 2, shelf - height + 6)
          ..lineTo(x - 1.5, shelf - height + 10)
          ..close();
        canvas.drawPath(ribbon, Paint()..color = Colors.white);
      }
      x += width + (i == oldTestamentBooks - 1 ? testamentGap : gap);
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(-4, shelf, size.width + 8, 3),
        const Radius.circular(2),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.28),
    );
  }

  @override
  bool shouldRepaint(_ShelfPainter previous) =>
      previous.inScope != inScope ||
      previous.read != read ||
      previous.bookmark != bookmark ||
      previous.old != old ||
      previous.fresh != fresh;
}

/// A tiny shelf for a choice of what to read: 11 spines, each for 6 books,
/// full when the scope reads one of them.
class MiniShelf extends StatelessWidget {
  const MiniShelf({required this.books, required this.color, super.key});

  final List<bool> books;
  final Color color;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox(
      width: 34,
      height: 30,
      child: CustomPaint(
        painter: _MiniShelfPainter(books: books, color: color),
      ),
    ),
  );
}

class _MiniShelfPainter extends CustomPainter {
  const _MiniShelfPainter({required this.books, required this.color});

  final List<bool> books;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const count = 11;
    final width = size.width / count - 1;
    for (var i = 0; i < count; i++) {
      final some = books.skip(i * 6).take(6).any((inside) => inside);
      // uneven heights, like books
      final height = size.height * (0.55 + 0.45 * ((i * 7) % 5) / 4);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(i * (width + 1), size.height - height, width, height),
          const Radius.circular(1),
        ),
        Paint()..color = color.withValues(alpha: some ? 1 : 0.2),
      );
    }
  }

  @override
  bool shouldRepaint(_MiniShelfPainter previous) =>
      previous.books != books || previous.color != color;
}
