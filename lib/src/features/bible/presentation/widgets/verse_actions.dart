import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/reader/reader_palette.dart';
import 'chapter_view.dart';

/// What the bar does with the verses selected.
sealed class VerseAction {
  const VerseAction();
}

/// [color]: an index of [highlightColors]; null removes the highlight.
class HighlightVerses extends VerseAction {
  const HighlightVerses(this.color);

  final int? color;
}

class BookmarkVerses extends VerseAction {
  const BookmarkVerses({required this.add});

  final bool add;
}

class CopyVerses extends VerseAction {
  const CopyVerses();
}

class ShareVerses extends VerseAction {
  const ShareVerses();
}

/// The concordance of a word of the verses.
class ConcordanceVerses extends VerseAction {
  const ConcordanceVerses();
}

/// Learn the verses by heart (Mémorisation).
class MemorizeVerses extends VerseAction {
  const MemorizeVerses();
}

/// Under the selected verses: their reference, the concordance, the
/// highlight colors, keep, copy and share; memorize them. [anchor] (share) is where the iPad sheet points from.
class VerseActions extends StatelessWidget {
  const VerseActions({
    required this.label,
    required this.palette,
    required this.colors,
    required this.bookmarked,
    required this.onAction,
    required this.onClose,
    super.key,
  });

  /// "Jean 3:16-17".
  final String label;
  final ReaderPalette palette;

  /// The highlight colors of the verses selected (null: one isn't).
  final Set<int?> colors;

  /// All of them are kept already.
  final bool bookmarked;
  final void Function(VerseAction action, [BuildContext? anchor]) onAction;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final swatches = highlightColors(palette.brightness);
    final names = [
      t.bible.colors.yellow,
      t.bible.colors.green,
      t.bible.colors.blue,
      t.bible.colors.pink,
    ];
    final surface = Color.alphaBlend(
      palette.text.withValues(
        alpha: palette.brightness == Brightness.dark ? 0.08 : 0.02,
      ),
      palette.background,
    );
    // one color for all of them: it is the one marked
    final shared = colors.length == 1 ? colors.single : null;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          0,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: palette.text.withValues(alpha: 0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.14),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 6, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: palette.text,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: t.memorize.memorize,
                      onPressed: () => onAction(const MemorizeVerses()),
                      color: palette.text,
                      icon: const Icon(AppIcons.memorize, size: 22),
                    ),
                    IconButton(
                      tooltip: t.bible.concordance,
                      onPressed: () => onAction(const ConcordanceVerses()),
                      color: palette.text,
                      icon: const Icon(AppIcons.concordance, size: 22),
                    ),
                    IconButton(
                      tooltip: t.bible.closeSelection,
                      onPressed: onClose,
                      color: palette.muted,
                      icon: const Icon(AppIcons.close, size: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    for (var index = 0; index < swatches.length; index++)
                      _Swatch(
                        color: swatches[index],
                        ring: palette.text,
                        selected: shared == index,
                        tooltip: t.bible.highlight(color: names[index]),
                        onTap: () => onAction(HighlightVerses(index)),
                      ),
                    if (colors.any((color) => color != null))
                      _Swatch(
                        ring: palette.text,
                        tooltip: t.bible.removeHighlight,
                        onTap: () => onAction(const HighlightVerses(null)),
                      ),
                    const Spacer(),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      tooltip: bookmarked
                          ? t.bible.removeFavorite
                          : t.bible.addFavorite,
                      color: palette.text,
                      onPressed: () =>
                          onAction(BookmarkVerses(add: !bookmarked)),
                      icon: Icon(
                        bookmarked
                            ? AppIcons.bookmarkFilled
                            : AppIcons.bookmark,
                        color: bookmarked ? palette.accent : null,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      tooltip: t.bible.copy,
                      color: palette.text,
                      onPressed: () => onAction(const CopyVerses()),
                      icon: const Icon(AppIcons.copy),
                    ),
                    Builder(
                      builder: (anchor) => IconButton(
                        visualDensity: VisualDensity.compact,
                        tooltip: t.bible.share,
                        color: palette.text,
                        onPressed: () => onAction(const ShareVerses(), anchor),
                        icon: const Icon(AppIcons.share),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A round highlight color; without [color], "no color" (a crossed circle).
class _Swatch extends StatelessWidget {
  const _Swatch({
    required this.ring,
    required this.tooltip,
    required this.onTap,
    this.color,
    this.selected = false,
  });

  final Color? color;
  final Color ring;
  final bool selected;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Semantics(
        button: true,
        selected: selected,
        child: InkResponse(
          onTap: onTap,
          radius: 24,
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: AnimatedContainer(
              duration: AppMotion.of(context, AppMotion.fast),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(
                  color: selected || color == null
                      ? ring.withValues(alpha: selected ? 0.9 : 0.3)
                      : ring.withValues(alpha: 0.08),
                  width: selected ? 2.5 : 1.5,
                ),
              ),
              child: color == null
                  ? Icon(
                      AppIcons.close,
                      size: 16,
                      color: ring.withValues(alpha: 0.6),
                    )
                  : selected
                  ? Icon(AppIcons.check, size: 16, color: ring)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
