import 'dart:math' as math;
import 'dart:ui';

/// The size of a profile photo, in pixels: a square the server keeps as is.
const photoSide = 512;

/// The scale that makes a picture of [image] pixels cover a square of
/// [viewport] points: the short side fills it, the long side overflows.
double coverScale(Size image, double viewport) =>
    math.max(viewport / image.width, viewport / image.height);

/// The part of the picture (in its pixels) seen in the square viewport of
/// [viewport] points, once the user has zoomed by [zoom] and moved it by
/// [offset] (the translation of the viewer, ≤ 0). The picture is laid out at
/// [coverScale] before the zoom.
Rect visiblePart({
  required Size image,
  required double viewport,
  required double zoom,
  required Offset offset,
}) {
  final scale = coverScale(image, viewport) * zoom;
  final side = viewport / scale;
  final left = math.min(
    math.max(0.0, -offset.dx / scale),
    math.max(0.0, image.width - side),
  );
  final top = math.min(
    math.max(0.0, -offset.dy / scale),
    math.max(0.0, image.height - side),
  );
  return Rect.fromLTWH(left, top, side, side);
}
