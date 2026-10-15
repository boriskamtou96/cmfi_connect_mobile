import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../domain/hymn.dart';
import 'highlighted_text.dart';

/// A hymn in a list, like a track of an album: its number, title, a second
/// line (first line, matching words, book), then the star and the [menu].
/// [current] (the last one opened) takes the color of the hymns.
class HymnTile extends StatelessWidget {
  const HymnTile({
    required this.hymn,
    required this.onTap,
    this.subtitle,
    this.query = '',
    this.favorite = false,
    this.current = false,
    this.onToggleFavorite,
    this.menu,
    super.key,
  });

  final Hymn hymn;
  final VoidCallback onTap;

  /// Defaults to the first line.
  final String? subtitle;
  final String query;
  final bool favorite;
  final bool current;

  /// Turns the star into a button.
  final VoidCallback? onToggleFavorite;
  final Widget? menu;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final module = AppModule.hymns.tone(context);
    final second = subtitle ?? hymn.firstLine;
    final accent = current ? module.onSoft : null;

    final star = Icon(
      favorite ? AppIcons.starFilled : AppIcons.star,
      size: 22,
      color: favorite ? AppColors.gold : scheme.outline,
    );

    return Row(
      children: [
        Expanded(
          child: Semantics(
            button: true,
            label: '${t.hymns.number(number: hymn.number)}, ${hymn.title}',
            excludeSemantics: true,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.lg,
                  10,
                  AppSpacing.xs,
                  10,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        '${hymn.number}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: accent ?? scheme.onSurfaceVariant,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HighlightedText(
                            hymn.title,
                            query: query,
                            // the star and the menu leave less room
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: accent ?? scheme.onSurface,
                            ),
                          ),
                          if (second.isNotEmpty && second != hymn.title) ...[
                            const SizedBox(height: 2),
                            HighlightedText(
                              second,
                              query: query,
                              style: TextStyle(
                                fontSize: 13.5,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (favorite && onToggleFavorite == null) ...[
                      const SizedBox(width: AppSpacing.sm),
                      star,
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        if (onToggleFavorite != null)
          IconButton(
            tooltip: favorite
                ? t.hymns.reader.removeFavorite
                : t.hymns.reader.addFavorite,
            onPressed: onToggleFavorite,
            icon: star,
          ),
        ?menu,
        if (menu == null && onToggleFavorite == null)
          const SizedBox(width: AppSpacing.md),
      ],
    );
  }
}
