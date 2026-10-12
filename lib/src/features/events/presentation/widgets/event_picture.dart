import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/media_picture.dart';
import '../../domain/event.dart';

/// An image of the server, drawn in its average color until it arrives, then
/// faded in. [image] null: a tinted poster with the events icon.
class EventPicture extends StatelessWidget {
  const EventPicture(
    this.image, {
    this.fit = BoxFit.cover,
    this.semanticLabel,
    super.key,
  });

  final EventImage? image;
  final BoxFit fit;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final image = this.image;
    if (image == null) {
      return const _NoPoster();
    }
    return MediaPicture(
      url: image.url,
      argb: image.argb,
      fit: fit,
      semanticLabel: semanticLabel,
    );
  }
}

/// The poster shown whole over a blurred, enlarged copy of itself: nothing of
/// it is cut, whatever the box's shape.
class PosterBackdrop extends StatelessWidget {
  const PosterBackdrop(this.image, {this.semanticLabel, super.key});

  final EventImage? image;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return const _NoPoster();
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
          child: EventPicture(image),
        ),
        ColoredBox(color: Colors.black.withValues(alpha: 0.12)),
        EventPicture(image, fit: BoxFit.contain, semanticLabel: semanticLabel),
      ],
    );
  }
}

class _NoPoster extends StatelessWidget {
  const _NoPoster();

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.events.tone(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [tone.soft, Color.lerp(tone.soft, tone.color, 0.35)!],
        ),
      ),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.35,
          child: FittedBox(
            child: PhosphorIcon(AppIcons.eventsTile, color: tone.onSoft),
          ),
        ),
      ),
    );
  }
}

/// Opens [images] full screen from [initial]: pinch to zoom, swipe to the
/// next one. [heroTags] give the thumbnails that grow into the viewer.
/// [onDelete] (admins) removes the photo shown.
Future<void> showImageViewer(
  BuildContext context, {
  required List<EventImage> images,
  int initial = 0,
  List<Object>? heroTags,
  List<String>? captions,
  Future<bool> Function(int index)? onDelete,
}) => Navigator.of(context).push(
  PageRouteBuilder<void>(
    opaque: false,
    barrierColor: Colors.black,
    transitionDuration: AppMotion.of(context, AppMotion.slow),
    reverseTransitionDuration: AppMotion.of(context, AppMotion.medium),
    pageBuilder: (context, animation, secondary) => FadeTransition(
      opacity: animation,
      child: _ImageViewer(
        images: images,
        initial: initial,
        heroTags: heroTags,
        captions: captions,
        onDelete: onDelete,
      ),
    ),
  ),
);

class _ImageViewer extends HookWidget {
  const _ImageViewer({
    required this.images,
    required this.initial,
    this.heroTags,
    this.captions,
    this.onDelete,
  });

  final List<EventImage> images;
  final int initial;
  final List<Object>? heroTags;
  final List<String>? captions;
  final Future<bool> Function(int index)? onDelete;

  @override
  Widget build(BuildContext context) {
    final pages = usePageController(initialPage: initial);
    final index = useState(initial);
    // two fingers on the image: zoom, not the next page
    final zooming = useState(false);
    final l10n = MaterialLocalizations.of(context);
    final caption = captions?.elementAtOrNull(index.value) ?? '';

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: pages,
            physics: zooming.value
                ? const NeverScrollableScrollPhysics()
                : const PageScrollPhysics(),
            itemCount: images.length,
            onPageChanged: (page) => index.value = page,
            itemBuilder: (context, page) {
              final image = images[page];
              final picture = InteractiveViewer(
                maxScale: 4,
                onInteractionStart: (details) =>
                    zooming.value = details.pointerCount > 1,
                onInteractionEnd: (_) => zooming.value = false,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: image.aspectRatio,
                    child: EventPicture(image, fit: BoxFit.contain),
                  ),
                ),
              );
              final tag = heroTags?.elementAtOrNull(page);
              return tag == null ? picture : Hero(tag: tag, child: picture);
            },
          ),
          SafeArea(
            child: Row(
              children: [
                IconButton(
                  tooltip: l10n.closeButtonTooltip,
                  color: Colors.white,
                  icon: const Icon(AppIcons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Spacer(),
                if (images.length > 1)
                  Text(
                    '${index.value + 1} / ${images.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                const Spacer(),
                if (onDelete != null)
                  IconButton(
                    tooltip: l10n.deleteButtonTooltip,
                    color: Colors.white,
                    icon: const Icon(AppIcons.delete),
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      if (await onDelete!(index.value)) {
                        navigator.pop();
                      }
                    },
                  )
                else
                  const SizedBox(width: 48),
              ],
            ),
          ),
          if (caption.isNotEmpty)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    caption,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
