import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/reader/reader_palette.dart';
import '../../application/bible_marks.dart';
import '../../application/bible_settings.dart';
import '../../domain/bible.dart';
import '../../domain/bible_version.dart';

/// Size of the text at scale 1.
const bibleBaseFontSize = 18.0;

/// The highlight colors (yellow, green, blue, pink), soft on a light page,
/// deep on a dark one so the words stay readable.
List<Color> highlightColors(Brightness brightness) =>
    brightness == Brightness.dark
    ? const [
        Color(0xFF6B5A14),
        Color(0xFF2E5A2B),
        Color(0xFF244B6E),
        Color(0xFF6E2C46),
      ]
    : const [
        Color(0xFFFFE680),
        Color(0xFFC6EDB6),
        Color(0xFFC2E1FF),
        Color(0xFFFFCADB),
      ];

/// The red of the words of Jesus on [palette].
Color jesusColor(ReaderPalette palette) => palette.brightness == Brightness.dark
    ? const Color(0xFFF28B82)
    : const Color(0xFFB3261E);

/// A chapter as read: the book and the big chapter number, the section
/// titles, the verses (numbered, highlighted, kept), then [footer]. A tap on
/// a verse selects it; [focus] is brought into view and lit a moment.
class ChapterView extends HookConsumerWidget {
  const ChapterView({
    required this.version,
    required this.chapter,
    required this.bookName,
    required this.settings,
    required this.palette,
    required this.selected,
    required this.onTapVerse,
    this.focus,
    this.onFocused,
    this.footer,
    super.key,
  });

  final BibleVersion version;
  final BibleChapter chapter;
  final String bookName;
  final BibleSettings settings;
  final ReaderPalette palette;

  /// The numbers of the verses selected.
  final Set<int> selected;
  final ValueChanged<BibleVerse> onTapVerse;

  /// A verse to show, then [onFocused] is called.
  final int? focus;
  final VoidCallback? onFocused;
  final Widget? footer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = bibleBaseFontSize * settings.textScale;
    final family = settings.serif ? 'Lora' : AppTheme.fontFamily;
    final marks = ref.watch(bibleMarksProvider);
    final colors = highlightColors(palette.brightness);
    final keys = useMemoized(
      () => {for (final verse in chapter.verses) verse.number: GlobalKey()},
      [chapter],
    );
    // the verse lit last, and how many times a verse was lit (to light the
    // same one again)
    final lit = useState<({int verse, int times})?>(null);

    // the verse asked for: brought into view, then lit a moment
    useEffect(() {
      final verse = focus;
      if (verse == null) {
        return null;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) {
          return;
        }
        if (keys[verse]?.currentContext case final target?) {
          unawaited(
            Scrollable.ensureVisible(
              target,
              alignment: 0.2,
              duration: AppMotion.of(context, AppMotion.slow),
              curve: AppMotion.standard,
            ),
          );
        }
        lit.value = (verse: verse, times: (lit.value?.times ?? 0) + 1);
        onFocused?.call();
      });
      return null;
    }, [focus, chapter]);

    return Directionality(
      textDirection: version.rtl ? TextDirection.rtl : TextDirection.ltr,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              bookName.toUpperCase(),
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
                color: palette.muted,
              ),
            ),
            Semantics(
              header: true,
              label: '$bookName ${chapter.number}',
              excludeSemantics: true,
              child: Text(
                '${chapter.number}',
                style: TextStyle(
                  fontFamily: 'Lora',
                  fontSize: (size * 2.6).clamp(40, 72),
                  fontWeight: FontWeight.w600,
                  height: 1.15,
                  color: palette.accent,
                ),
              ),
            ),
            SizedBox(height: size * 0.4),
            for (final item in chapter.items)
              switch (item) {
                BibleHeading(:final text) => Padding(
                  padding: EdgeInsets.only(top: size * 0.8, bottom: size * 0.3),
                  child: Semantics(
                    header: true,
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: size * 0.86,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                        color: palette.text,
                      ),
                    ),
                  ),
                ),
                BibleBreak() => SizedBox(height: size * 0.6),
                final BibleVerse verse => _VerseLine(
                  key: keys[verse.number],
                  verse: verse,
                  size: size,
                  family: family,
                  palette: palette,
                  highlight: switch (marks[BibleRef(
                        chapter.bookId,
                        chapter.number,
                        verse.number,
                      ).key]
                      ?.color) {
                    final index? when index >= 0 && index < colors.length =>
                      colors[index],
                    _ => null,
                  },
                  bookmarked:
                      marks[BibleRef(
                            chapter.bookId,
                            chapter.number,
                            verse.number,
                          ).key]
                          ?.bookmarked ??
                      false,
                  selected: selected.contains(verse.number),
                  lit: lit.value?.verse == verse.number
                      ? lit.value?.times
                      : null,
                  jesus: settings.jesusInRed ? jesusColor(palette) : null,
                  onTap: () => onTapVerse(verse),
                ),
              },
            ?footer,
          ],
        ),
      ),
    );
  }
}

class _VerseLine extends StatelessWidget {
  const _VerseLine({
    required this.verse,
    required this.size,
    required this.family,
    required this.palette,
    required this.highlight,
    required this.bookmarked,
    required this.selected,
    required this.lit,
    required this.jesus,
    required this.onTap,
    super.key,
  });

  final BibleVerse verse;
  final double size;
  final String family;
  final ReaderPalette palette;
  final Color? highlight;
  final bool bookmarked;
  final bool selected;

  /// Just opened from elsewhere: lit a moment (the how-many-th time).
  final int? lit;

  /// The color of the words of Jesus; null: as the others.
  final Color? jesus;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: family,
      fontSize: size,
      height: 1.65,
      color: palette.text,
      backgroundColor: highlight,
      decoration: selected ? TextDecoration.underline : null,
      decorationStyle: TextDecorationStyle.dotted,
      decorationColor: palette.accent,
      decorationThickness: 2.2,
    );

    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        // the light of a verse just opened goes a little beyond its words
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (lit != null)
              PositionedDirectional(
                start: -6,
                end: -6,
                top: 0,
                bottom: 0,
                child: TweenAnimationBuilder<double>(
                  key: ValueKey(lit),
                  tween: Tween(begin: 1, end: 0),
                  duration: const Duration(milliseconds: 2400),
                  // lit a moment, then it fades
                  curve: const Interval(0.45, 1, curve: Curves.easeOut),
                  builder: (context, light, _) => DecoratedBox(
                    decoration: BoxDecoration(
                      color: palette.accent.withValues(alpha: 0.18 * light),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${verse.number} ',
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: size * 0.62,
                        fontWeight: FontWeight.w800,
                        color: palette.accent,
                      ),
                    ),
                    for (final segment in verse.segments)
                      TextSpan(
                        text: segment.text,
                        style: segment.jesus && jesus != null
                            ? TextStyle(color: jesus)
                            : null,
                      ),
                    if (bookmarked)
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 4),
                          child: Icon(
                            AppIcons.bookmarkFilled,
                            size: size * 0.8,
                            color: palette.accent,
                          ),
                        ),
                      ),
                  ],
                ),
                style: style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
