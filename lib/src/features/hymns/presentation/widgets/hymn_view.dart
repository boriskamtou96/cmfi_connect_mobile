import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/reader/joined_selection.dart';
import '../../../../core/widgets/reader/reader_palette.dart';
import '../../application/hymn_reader_settings.dart';
import '../../domain/hymn.dart';
import '../../domain/hymn_text.dart';

/// Size of the lyrics at scale 1.
const hymnBaseFontSize = 19.0;

String hymnFontFamily(HymnReaderSettings settings) =>
    settings.usesSerif ? 'Lora' : AppTheme.fontFamily;

/// A whole hymn as read: number, title, author, then verses and choruses. Under a
/// [SelectionArea], the words copy as they are sung: a line break between the lines,
/// a blank line between the parts, without the numbers and labels.
class HymnView extends StatelessWidget {
  const HymnView({
    required this.hymn,
    required this.settings,
    required this.palette,
    this.bookTitle,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.xl,
      AppSpacing.sm,
      AppSpacing.xl,
      96,
    ),
    super.key,
  });

  final Hymn hymn;
  final String? bookTitle;
  final HymnReaderSettings settings;
  final ReaderPalette palette;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final size = hymnBaseFontSize * settings.textScale;
    final family = hymnFontFamily(settings);
    final serif = settings.usesSerif;

    // the hymn books are in French and English: read left to right, even
    // when the app is in Arabic
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ListView(
        padding: padding,
        children: [
          if (bookTitle != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: SelectionContainer.disabled(
                child: Text(
                  bookTitle!,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 13,
                    color: palette.muted,
                  ),
                ),
              ),
            ),
          // a blank line between the title and each part, once copied
          JoinedSelection(
            separator: '\n\n',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    hymn.title,
                    style: TextStyle(
                      fontFamily: family,
                      fontSize: size * 1.3,
                      fontWeight: serif ? FontWeight.w600 : FontWeight.w800,
                      height: 1.2,
                      letterSpacing: serif ? 0 : -0.3,
                      color: palette.text,
                    ),
                  ),
                ),
                if (hymn.author case final author?) ...[
                  const SizedBox(height: 6),
                  Text(
                    author,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 13,
                      color: palette.muted,
                    ),
                  ),
                ],
                SizedBox(height: size * 1.2),
                for (final sung in sungParts(
                  hymn,
                  repeatChorus: settings.repeatChorus,
                ))
                  Padding(
                    padding: EdgeInsets.only(bottom: size * 1.1),
                    child: _PartView(
                      sung: sung,
                      size: size,
                      family: family,
                      serif: serif,
                      palette: palette,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PartView extends StatelessWidget {
  const _PartView({
    required this.sung,
    required this.size,
    required this.family,
    required this.serif,
    required this.palette,
  });

  final SungPart sung;
  final double size;
  final String family;
  final bool serif;
  final ReaderPalette palette;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final part = sung.part;
    final isChorus = part.kind == HymnPartKind.chorus;
    final color = sung.repeated ? palette.muted : palette.text;
    final style = TextStyle(
      fontFamily: family,
      fontSize: size,
      height: 1.3,
      fontStyle: isChorus && serif ? FontStyle.italic : FontStyle.normal,
      color: color,
    );
    // one paragraph per line, a little apart: a long line that wraps stays tight,
    // so it can't be taken for the next line of the song
    final lines = JoinedSelection(
      separator: '\n',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < part.lines.length; i++)
            Padding(
              padding: EdgeInsets.only(top: i == 0 ? 0 : size * 0.32),
              child: Text(part.lines[i], style: style),
            ),
        ],
      ),
    );

    if (!isChorus) {
      final gutter = (size * 1.3).clamp(26.0, 40.0);
      return Semantics(
        label: part.label == null ? null : t.hymns.verse(label: part.label!),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: gutter,
              child: part.label == null
                  ? null
                  : Padding(
                      padding: EdgeInsets.only(top: size * 0.2),
                      child: SelectionContainer.disabled(
                        child: Text(
                          part.label!,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontSize: size * 0.72,
                            fontWeight: FontWeight.w800,
                            color: palette.accent,
                          ),
                        ),
                      ),
                    ),
            ),
            Expanded(child: lines),
          ],
        ),
      );
    }

    final label = [
      if (part.label != null)
        t.hymns.chorusNumber(label: part.label!)
      else
        t.hymns.chorus,
      if (part.repeat > 1) t.hymns.times(n: part.repeat),
    ].join(' ');
    return Container(
      margin: EdgeInsets.only(left: size * 0.55),
      padding: EdgeInsets.only(left: size * 0.9),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: palette.chorusBar, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectionContainer.disabled(
            child: Text(
              label.toUpperCase(),
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: sung.repeated ? palette.muted : palette.accent,
              ),
            ),
          ),
          const SizedBox(height: 4),
          lines,
        ],
      ),
    );
  }
}
