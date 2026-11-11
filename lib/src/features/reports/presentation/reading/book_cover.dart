import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/services/media_images.dart';
import '../../../../core/theme/app_colors.dart';

/// A book's cover: the one found for its title and author (kept on the phone
/// once downloaded, like the other images), else drawn in the colors of the
/// modules (the same for a title every time), with its spine and a line of
/// gold. [showTitle]: the title written on a drawn cover (big covers).
class BookCover extends ConsumerWidget {
  const BookCover({
    required this.title,
    this.coverUrl = '',
    this.width = 40,
    this.showTitle = false,
    super.key,
  });

  final String title;
  final String coverUrl;
  final double width;
  final bool showTitle;

  // night, prayer, hymns, reports, bible, events
  static const _colors = [
    Color(0xFF072D5A),
    Color(0xFF7A4A98),
    Color(0xFF0E7A72),
    Color(0xFF0A5EA8),
    Color(0xFF9A2E3D),
    Color(0xFFA85F1E),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = width * 1.42;
    final radius = BorderRadius.horizontal(
      left: Radius.circular(width * 0.08),
      right: Radius.circular(width * 0.16),
    );
    final color =
        _colors[title.runes.fold<int>(0, (sum, rune) => sum + rune) %
            _colors.length];

    final drawn = DecoratedBox(
      decoration: BoxDecoration(color: color, borderRadius: radius),
      child: Stack(
        children: [
          // the spine
          PositionedDirectional(
            start: 0,
            top: 0,
            bottom: 0,
            width: width * 0.09,
            child: ColoredBox(color: Colors.black.withValues(alpha: 0.2)),
          ),
          if (showTitle)
            PositionedDirectional(
              start: width * 0.16,
              end: width * 0.08,
              top: width * 0.14,
              child: Text(
                title,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width * 0.11,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
            ),
          PositionedDirectional(
            start: width * 0.2,
            bottom: width * 0.16,
            width: width * 0.42,
            height: 2,
            child: const ColoredBox(color: AppColors.goldLight),
          ),
        ],
      ),
    );

    return Semantics(
      excludeSemantics: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: AppColors.ink.withValues(alpha: 0.14),
              blurRadius: width * 0.18,
              offset: Offset(0, width * 0.06),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: coverUrl.isEmpty
              ? drawn
              : Image(
                  image: ref.watch(mediaImagesProvider).of(coverUrl),
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => drawn,
                  frameBuilder: (_, child, frame, synchronous) =>
                      frame == null && !synchronous ? drawn : child,
                ),
        ),
      ),
    );
  }
}
