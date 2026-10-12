import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/media_images.dart';
import '../theme/app_icons.dart';
import '../theme/app_motion.dart';

/// An image stored by the server ([url]: "/v1/media/…"), drawn in its
/// average color ([argb]) until it arrives, then faded in.
class MediaPicture extends ConsumerWidget {
  const MediaPicture({
    required this.url,
    this.argb,
    this.fit = BoxFit.cover,
    this.semanticLabel,
    super.key,
  });

  final String url;
  final int? argb;
  final BoxFit fit;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = AppMotion.of(context, AppMotion.medium);

    return ColoredBox(
      color: argb == null
          ? Theme.of(context).colorScheme.surfaceContainerHighest
          : Color(argb!),
      child: Image(
        image: ref.watch(mediaImagesProvider).of(url),
        fit: fit,
        width: double.infinity,
        height: double.infinity,
        semanticLabel: semanticLabel,
        excludeFromSemantics: semanticLabel == null,
        gaplessPlayback: true,
        frameBuilder: (context, child, frame, synchronous) => synchronous
            ? child
            : AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: duration,
                curve: AppMotion.standard,
                child: child,
              ),
        errorBuilder: (context, error, stack) => Center(
          child: Icon(
            AppIcons.imageBroken,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}
