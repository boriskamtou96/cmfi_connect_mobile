import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/services/media_images.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../events/domain/event.dart';

/// A member in a circle: their profile photo, or their initials when they
/// have none (and while it can't be loaded). Decorative: the name is next to
/// it.
class MemberAvatar extends ConsumerWidget {
  const MemberAvatar({
    required this.initials,
    this.photo,
    this.size = 46,
    this.background,
    this.foreground,
    super.key,
  });

  final String initials;
  final EventImage? photo;
  final double size;

  /// The colors of the initials (the brand blue by default).
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialsAvatar = InitialsAvatar(
      initials: initials,
      size: size,
      background: background,
      foreground: foreground,
    );
    final photo = this.photo;
    if (photo == null) {
      return initialsAvatar;
    }
    final argb = photo.argb;

    return SizedBox.square(
      dimension: size,
      child: ClipOval(
        child: ColoredBox(
          color: argb == null
              ? Theme.of(context).colorScheme.surfaceContainerHighest
              : Color(argb),
          child: Image(
            image: ref.watch(mediaImagesProvider).of(photo.url),
            fit: BoxFit.cover,
            excludeFromSemantics: true,
            gaplessPlayback: true,
            errorBuilder: (context, error, stack) => initialsAvatar,
          ),
        ),
      ),
    );
  }
}
