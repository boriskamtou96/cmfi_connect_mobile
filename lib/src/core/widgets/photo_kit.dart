import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// The photographic look of the app (validated on 18/10/2026): photos of
/// people praying, reading, singing, softly graded toward the night blue,
/// with frosted cards, stickers and faces over them.
///
/// The photos are stock photos (assets/photos, credits in CREDITS.md): they
/// set a mood and are never shown as members. A face that stands for a
/// member (a list, a topic, the ministry) is a real one: the member's photo
/// or the portraits of the ministry, never one of these.
abstract final class StockPhotos {
  static const reading = 'assets/photos/man_bench_book.jpg';
  static const prayingByWindow = 'assets/photos/pray_window.jpg';
  static const prayingHands = 'assets/photos/pray_hands.jpg';
  static const worship = 'assets/photos/worship_hands.jpg';
  static const womanWorshipping = 'assets/photos/woman_scarf.jpg';
  static const joyful = 'assets/photos/woman_red.jpg';
  static const family = 'assets/photos/family_grass.jpg';

  /// Decorative faces (welcome and sign-in illustrations only).
  static const FaceCrop manSmiling = (
    asset: 'assets/photos/man_smile2.jpg',
    aspect: 466 / 700,
    cx: 0.49,
    cy: 0.33,
    scale: 1.9,
  );
  static const FaceCrop womanLaughing = (
    asset: 'assets/photos/woman_ebony2.jpg',
    aspect: 700 / 525,
    cx: 0.69,
    cy: 0.42,
    scale: 4.4,
  );
  static const FaceCrop womanGlasses = (
    asset: 'assets/photos/woman_ebony.jpg',
    aspect: 700 / 525,
    cx: 0.475,
    cy: 0.46,
    scale: 4.0,
  );
  static const FaceCrop elder = (
    asset: 'assets/photos/man_beard_nappy.jpg',
    aspect: 700 / 466,
    cx: 0.42,
    cy: 0.31,
    scale: 4.4,
  );
}

/// How a photo is tinted: as it is, softly toward the night blue (calm
/// pages), or warmer and brighter (welcome).
enum PhotoGrade { none, night, warm }

ColorFilter _gradeFilter(PhotoGrade grade) {
  // a saturation, then a tint per channel and a lift
  final (s, r, g, b, lift) = switch (grade) {
    PhotoGrade.night => (0.78, 0.92, 0.96, 1.06, -4.0),
    PhotoGrade.warm => (1.12, 1.05, 1.0, 0.94, 4.0),
    PhotoGrade.none => (1.0, 1.0, 1.0, 1.0, 0.0),
  };
  const lr = 0.2126, lg = 0.7152, lb = 0.0722;
  return ColorFilter.matrix([
    (lr * (1 - s) + s) * r, lg * (1 - s) * r, lb * (1 - s) * r, 0, lift, //
    lr * (1 - s) * g, (lg * (1 - s) + s) * g, lb * (1 - s) * g, 0, lift,
    lr * (1 - s) * b, lg * (1 - s) * b, (lb * (1 - s) + s) * b, 0, lift,
    0, 0, 0, 1, 0,
  ]);
}

/// A photo filling its box ([alignment]: the part kept), graded. Decorative:
/// the words over it carry the meaning.
class GradedPhoto extends StatelessWidget {
  const GradedPhoto(
    this.asset, {
    this.alignment = Alignment.center,
    this.grade = PhotoGrade.none,
    super.key,
  });

  final String asset;
  final Alignment alignment;
  final PhotoGrade grade;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      asset,
      fit: BoxFit.cover,
      alignment: alignment,
      width: double.infinity,
      height: double.infinity,
      excludeFromSemantics: true,
      gaplessPlayback: true,
    );
    return ClipRect(
      child: grade == PhotoGrade.none
          ? image
          : ColorFiltered(colorFilter: _gradeFilter(grade), child: image),
    );
  }
}

/// A gradient over a photo, to keep the words on it readable.
class PhotoScrim extends StatelessWidget {
  const PhotoScrim({
    required this.colors,
    this.stops,
    this.begin = Alignment.topCenter,
    this.end = Alignment.bottomCenter,
    super.key,
  });

  final List<Color> colors;
  final List<double>? stops;
  final Alignment begin;
  final Alignment end;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: begin,
        end: end,
        colors: colors,
        stops: stops,
      ),
    ),
    child: const SizedBox.expand(),
  );
}

/// Frosted glass over a photo: what is behind is blurred and tinted.
class FrostedGlass extends StatelessWidget {
  const FrostedGlass({
    required this.child,
    this.radius = 20,
    this.padding = const EdgeInsets.all(14),
    this.tint = const Color(0x33061F40),
    super.key,
  });

  final Widget child;
  final double radius;
  final EdgeInsetsGeometry padding;
  final Color tint;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: BackdropFilter(
      filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
        ),
        child: child,
      ),
    ),
  );
}

/// The shadow under a card floating over a photo or a page.
List<BoxShadow> floatingShadow([double strength = 1]) => [
  BoxShadow(
    color: AppColors.night.withValues(alpha: 0.10 * strength),
    blurRadius: 3,
    offset: const Offset(0, 1),
  ),
  BoxShadow(
    color: AppColors.night.withValues(alpha: 0.16 * strength),
    blurRadius: 30,
    offset: const Offset(0, 14),
  ),
];

/// A playful sticker: a white pill, a coloured round icon, a slight tilt.
/// White in both modes, like a printed sticker.
class Sticker extends StatelessWidget {
  const Sticker({
    required this.icon,
    required this.text,
    required this.color,
    this.angle = 0,
    this.big = false,
    super.key,
  });

  final IconData icon;
  final String text;
  final Color color;

  /// The tilt, in radians.
  final double angle;
  final bool big;

  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: angle,
    child: Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        big ? 8 : 6,
        big ? 8 : 6,
        big ? 16 : 13,
        big ? 8 : 6,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: const StadiumBorder(),
        shadows: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: big ? 30 : 24,
            height: big ? 30 : 24,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(icon, size: big ? 17 : 14, color: Colors.white),
          ),
          SizedBox(width: big ? 9 : 7),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: big ? 15 : 13,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.1,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Where a face is in a photo: the asset, its width / height, the centre of
/// the face (fractions of the photo) and how wide the photo is drawn, in
/// times the circle.
typedef FaceCrop = ({
  String asset,
  double aspect,
  double cx,
  double cy,
  double scale,
});

/// A face cut out of a photo, in a circle (decorative).
class CroppedFace extends StatelessWidget {
  const CroppedFace(this.crop, {this.size = 40, super.key});

  final FaceCrop crop;
  final double size;

  @override
  Widget build(BuildContext context) {
    final width = size * crop.scale;
    final height = width / crop.aspect;
    return ClipOval(
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          children: [
            Positioned(
              left: size / 2 - crop.cx * width,
              top: size / 2 - crop.cy * height,
              width: width,
              height: height,
              child: Image.asset(
                crop.asset,
                fit: BoxFit.fill,
                excludeFromSemantics: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A round face in a ring of [ring] (the colour behind it).
class RingedFace extends StatelessWidget {
  const RingedFace({
    required this.child,
    required this.size,
    required this.ring,
    this.ringWidth = 2,
    super.key,
  });

  /// The face, round, of `size - 2 * ringWidth`.
  final Widget child;
  final double size;
  final Color ring;
  final double ringWidth;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    padding: EdgeInsets.all(ringWidth),
    decoration: BoxDecoration(shape: BoxShape.circle, color: ring),
    child: ClipOval(child: child),
  );
}

/// Faces overlapping one another, the first one on top of the line.
class FaceStack extends StatelessWidget {
  const FaceStack({
    required this.faces,
    required this.ring,
    this.size = 30,
    this.overlap = 0.36,
    super.key,
  });

  /// Round faces of `size - 4` (the ring is 2 wide).
  final List<Widget> faces;
  final Color ring;
  final double size;
  final double overlap;

  @override
  Widget build(BuildContext context) {
    final step = size * (1 - overlap);
    return SizedBox(
      width: step * (faces.length - 1) + size,
      height: size,
      child: Stack(
        children: [
          for (final (i, face) in faces.indexed)
            PositionedDirectional(
              start: i * step,
              child: RingedFace(size: size, ring: ring, child: face),
            ),
        ],
      ),
    );
  }
}

/// A rounded arch: a half circle over a rectangle with rounded corners.
class ArchClipper extends CustomClipper<Path> {
  const ArchClipper();

  @override
  Path getClip(Size size) {
    final r = size.width / 2;
    const corner = 28.0;
    return Path()
      ..moveTo(0, r)
      ..arcToPoint(Offset(size.width, r), radius: Radius.circular(r))
      ..lineTo(size.width, size.height - corner)
      ..quadraticBezierTo(
        size.width,
        size.height,
        size.width - corner,
        size.height,
      )
      ..lineTo(corner, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - corner)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// A photo in an arch, a coloured arch offset behind it.
class ArchPhoto extends StatelessWidget {
  const ArchPhoto({
    required this.asset,
    required this.backdrop,
    this.alignment = Alignment.center,
    this.width = 250,
    this.height = 320,
    super.key,
  });

  final String asset;
  final Color backdrop;
  final Alignment alignment;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width + 16,
    height: height + 10,
    child: Stack(
      children: [
        // a decoration: physical, the same in both reading directions
        Positioned(
          left: 16,
          top: 0,
          width: width,
          height: height,
          child: ClipPath(
            clipper: const ArchClipper(),
            child: ColoredBox(color: backdrop),
          ),
        ),
        Positioned(
          left: 0,
          top: 10,
          width: width,
          height: height,
          child: ClipPath(
            clipper: const ArchClipper(),
            child: GradedPhoto(
              asset,
              alignment: alignment,
              grade: PhotoGrade.warm,
            ),
          ),
        ),
      ],
    ),
  );
}
