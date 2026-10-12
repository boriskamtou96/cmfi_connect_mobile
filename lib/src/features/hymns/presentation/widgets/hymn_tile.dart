import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../domain/hymn.dart';
import 'highlighted_text.dart';

/// A hymn in a list: its number, title, and a second line (first line, matching words, book).
class HymnTile extends StatelessWidget {
  const HymnTile({
    required this.hymn,
    required this.onTap,
    this.subtitle,
    this.query = '',
    this.favorite = false,
    super.key,
  });

  final Hymn hymn;
  final VoidCallback onTap;

  /// Defaults to the first line.
  final String? subtitle;
  final String query;
  final bool favorite;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final module = AppModule.hymns.tone(context);
    final second = subtitle ?? hymn.firstLine;

    return Semantics(
      button: true,
      label: '${context.t.hymns.number(number: hymn.number)}, ${hymn.title}',
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: 10,
          ),
          child: Row(
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 46),
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: module.soft,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Text(
                  '${hymn.number}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: module.onSoft,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HighlightedText(
                      hymn.title,
                      query: query,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    if (second.isNotEmpty && second != hymn.title) ...[
                      const SizedBox(height: 2),
                      HighlightedText(
                        second,
                        query: query,
                        style: TextStyle(
                          fontSize: 13,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (favorite) ...[
                const SizedBox(width: AppSpacing.sm),
                const Icon(
                  AppIcons.starFilled,
                  size: 20,
                  color: AppColors.gold,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
