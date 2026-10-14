import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// The four moods of Zoé, the CMFI Connect mascot. The body stays the same;
/// only the wings, the eye and the beak change.
enum DovePose {
  /// The usual face: a round, shining eye, rosy cheeks, the wing folded.
  joy,

  /// "You can do it!": a wing raised to wave, and an olive sprig in the beak,
  /// like Noah's dove (Genesis 8:11).
  cheer,

  /// Both wings up like the logo's dove, the beak open in song, gold sparkles.
  celebrate,

  /// Eyes closed, a crescent moon and two "z": calm, never sad.
  rest,
}

/// Zoé, the mascot: the dove of the CMFI emblem, perched and seen up close.
/// White with blue-grey shades, a night-blue outline so it stays visible on
/// white, and a gold beak (the gold of the app's small victories).
///
/// It faces left, like the logo's dove, and does not flip in right-to-left
/// languages: it is an illustration. It never moves by itself; animate it
/// from outside (`FadeSlideIn`, `AnimatedSwitcher` keyed on the pose…).
/// Decorative by default: give a [semanticLabel] when it says something the
/// text around it does not.
class DoveMascot extends StatelessWidget {
  const DoveMascot({
    this.pose = DovePose.joy,
    this.size = 120,
    this.semanticLabel,
    super.key,
  });

  final DovePose pose;
  final double size;

  /// What screen readers say; when null, the dove is left out of semantics.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final dove = CustomPaint(
      size: Size.square(size),
      painter: DovePainter(
        pose: pose,
        // the eye's glint, the cheeks and the feather lines vanish when small
        details: size >= 40,
        // 3 % of the size, thicker when small so the outline still reads
        outline: size < 40 ? 6 : (size < 64 ? 4 : 3),
      ),
    );
    final label = semanticLabel;
    if (label == null) {
      return ExcludeSemantics(child: dove);
    }
    return Semantics(label: label, image: true, child: dove);
  }
}

/// Draws Zoé on a 100×100 grid stretched to the canvas. Also paints the
/// mascot images of `assets/brand` (`tool/brand_assets_test.dart`).
class DovePainter extends CustomPainter {
  const DovePainter({
    this.pose = DovePose.joy,
    this.details = true,
    this.outline = 3,
  });

  final DovePose pose;

  /// The eye's glint, the cheeks and the feather and motion lines.
  final bool details;

  /// The width of the outline, on the 100×100 grid.
  final double outline;

  // The colours of the mascot, the same in light and dark mode
  static const _plume = Color(0xFFFFFFFF);
  static const _mist = Color(0xFFDDE8F4);
  static const _wing = Color(0xFFDCEEFB);
  static const _wingShade = Color(0xFFC6DFF2);
  static const _ink = Color(0xFF12355E);
  static const _gold = Color(0xFFE2A93B);
  static const _paleGold = Color(0xFFF6D27A);
  static const _twig = Color(0xFFB9832A);
  static const _blush = Color(0xFFF5B5A5);
  static const _mouth = Color(0xFFD9776A);
  static const _sky = Color(0xFF7FC0EC);
  static const _sleep = Color(0xFF7E9CC0);

  /// Head and body in one shape, a drop with a tail, facing left.
  static final _body = Path()
    ..moveTo(37, 16.5)
    ..cubicTo(29, 16.5, 22.5, 23, 22.5, 31)
    ..cubicTo(22.5, 35.5, 24.3, 39.5, 27.2, 42.3)
    ..cubicTo(21.5, 47.5, 18.5, 55, 18.5, 62.5)
    ..cubicTo(18.5, 75.5, 30, 85, 44.5, 85)
    ..cubicTo(56, 85, 64.5, 80.5, 70.5, 74)
    // the tail
    ..lineTo(86, 67.5)
    ..cubicTo(90, 66, 91.5, 61.5, 88.5, 59)
    ..lineTo(72, 55.5)
    ..cubicTo(63, 52, 55.5, 46, 52.3, 38.5)
    ..cubicTo(51.8, 36.3, 51.5, 33.7, 51.5, 31)
    ..cubicTo(51.5, 23, 45, 16.5, 37, 16.5)
    ..close();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    // Zoé is designed on a 100×100 grid, like the logo
    canvas.scale(size.width / 100, size.height / 100);
    // back to front: what sticks out from behind the body (beak, sprig, far
    // wing) comes first, so the body covers its root
    switch (pose) {
      case DovePose.joy:
        _beak(canvas);
        _dove(canvas);
        _foldedWing(canvas);
        _openEye(canvas);
        _cheek(canvas);
      case DovePose.cheer:
        _sprig(canvas);
        _beak(canvas);
        _dove(canvas);
        _wavingWing(canvas);
        _smilingEye(canvas);
        _cheek(canvas);
      case DovePose.celebrate:
        _farWing(canvas);
        _singingBeak(canvas);
        _dove(canvas);
        _raisedWing(canvas);
        _smilingEye(canvas);
        _cheek(canvas);
        _sparkles(canvas);
      case DovePose.rest:
        _beak(canvas);
        _dove(canvas);
        _foldedWing(canvas);
        _closedEye(canvas);
        _cheek(canvas, opacity: 0.7);
        _night(canvas);
    }
    canvas.restore();
  }

  /// The night-blue outline around the body, the wings and the beak.
  Paint get _outline => Paint()
    ..color = _ink
    ..style = PaintingStyle.stroke
    ..strokeWidth = outline
    ..strokeJoin = StrokeJoin.round
    ..strokeCap = StrokeCap.round;

  /// Fills [path] with [color], then draws the outline around it.
  void _outlined(Canvas canvas, Path path, Color color) {
    canvas
      ..drawPath(path, Paint()..color = color)
      ..drawPath(path, _outline);
  }

  /// A thin, round-ended line: the feather lines, the eyes, the "z".
  void _line(Canvas canvas, Path path, Color color, double width) {
    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round,
    );
  }

  /// A faint line of feathers along a wing.
  void _feather(Canvas canvas, Path path, {double opacity = 0.4}) {
    if (details) {
      _line(canvas, path, _ink.withValues(alpha: opacity), 2);
    }
  }

  /// Draws [draw] turned by [degrees] around [center], given in its own axes.
  void _turned(
    Canvas canvas,
    Offset center,
    double degrees,
    void Function() draw,
  ) {
    canvas
      ..save()
      ..translate(center.dx, center.dy)
      ..rotate(degrees * math.pi / 180);
    draw();
    canvas.restore();
  }

  /// The white body with its blue-grey belly.
  void _dove(Canvas canvas) {
    canvas
      ..drawPath(_body, Paint()..color = _plume)
      ..save()
      ..clipPath(_body)
      ..drawOval(
        Rect.fromCenter(center: const Offset(48, 99), width: 88, height: 48),
        Paint()..color = _mist,
      )
      ..restore()
      ..drawPath(_body, _outline);
  }

  void _beak(Canvas canvas) {
    _outlined(
      canvas,
      Path()
        ..moveTo(24, 27.6)
        ..quadraticBezierTo(16.5, 30.6, 12.5, 33.2)
        ..quadraticBezierTo(16.5, 35.8, 24, 38)
        ..close(),
      _gold,
    );
  }

  /// The beak open in song: two halves around a pink mouth.
  void _singingBeak(Canvas canvas) {
    canvas.drawPath(
      Path()
        ..moveTo(24, 31)
        ..lineTo(13, 34)
        ..lineTo(24, 37)
        ..close(),
      Paint()..color = _mouth,
    );
    _outlined(
      canvas,
      Path()
        ..moveTo(24, 27.4)
        ..quadraticBezierTo(16, 28.2, 11.5, 31)
        ..quadraticBezierTo(17, 33, 24, 32.8)
        ..close(),
      _gold,
    );
    _outlined(
      canvas,
      Path()
        ..moveTo(24, 35.4)
        ..quadraticBezierTo(18, 36.4, 15, 39.6)
        ..quadraticBezierTo(19.5, 40.6, 24, 38.6)
        ..close(),
      _gold,
    );
  }

  /// The folded wing: a leaf whose end splits into three feathers.
  void _foldedWing(Canvas canvas) {
    _outlined(
      canvas,
      Path()
        ..moveTo(36, 55)
        ..cubicTo(41, 43, 62, 42, 80, 56)
        ..quadraticBezierTo(82.5, 62.5, 75.5, 62)
        ..quadraticBezierTo(76, 68, 69, 66.5)
        ..quadraticBezierTo(68, 71.5, 61, 69)
        ..cubicTo(49, 70, 39, 65, 36, 55)
        ..close(),
      _wing,
    );
    _feather(
      canvas,
      Path()
        ..moveTo(44, 58)
        ..cubicTo(52, 53, 62, 53, 70, 57),
    );
  }

  /// One wing raised to wave, with two motion lines.
  void _wavingWing(Canvas canvas) {
    _outlined(
      canvas,
      Path()
        ..moveTo(45, 59)
        ..cubicTo(44, 46, 47, 33, 55, 22)
        ..quadraticBezierTo(56.5, 15.5, 62, 17)
        ..quadraticBezierTo(65, 11, 70.5, 15)
        ..quadraticBezierTo(75.5, 12, 78, 18.5)
        ..quadraticBezierTo(83, 18.5, 81.5, 25)
        ..cubicTo(77, 40, 68, 51, 56, 61)
        ..close(),
      _wing,
    );
    _feather(
      canvas,
      Path()
        ..moveTo(54, 52)
        ..cubicTo(57, 42, 62, 33, 69, 25),
    );
    _feather(
      canvas,
      Path()
        ..moveTo(87, 17)
        ..quadraticBezierTo(91, 21.5, 89, 28)
        ..moveTo(92, 11)
        ..quadraticBezierTo(98.5, 18.5, 94.5, 28.5),
      opacity: 0.55,
    );
  }

  /// The far wing of the celebration, behind the body and a shade darker.
  void _farWing(Canvas canvas) {
    _outlined(
      canvas,
      Path()
        ..moveTo(54, 50)
        ..cubicTo(52, 37, 54, 23, 61, 12)
        ..quadraticBezierTo(62.5, 6.5, 67, 8.5)
        ..quadraticBezierTo(70, 4, 73.5, 8.5)
        ..quadraticBezierTo(78, 7.5, 77, 13)
        ..cubicTo(75, 27, 69, 41, 62, 51)
        ..close(),
      _wingShade,
    );
  }

  /// The near wing of the celebration, raised high like on the emblem.
  void _raisedWing(Canvas canvas) {
    _outlined(
      canvas,
      Path()
        ..moveTo(43, 58)
        ..cubicTo(45, 42, 57, 27, 74, 17)
        ..quadraticBezierTo(77, 12, 81.5, 15)
        ..quadraticBezierTo(85.5, 12, 88, 17)
        ..quadraticBezierTo(93, 17.5, 91.5, 23)
        ..quadraticBezierTo(95, 26, 91, 29.5)
        ..cubicTo(82, 41, 68, 52, 53, 61)
        ..close(),
      _wing,
    );
    _feather(
      canvas,
      Path()
        ..moveTo(51, 51)
        ..cubicTo(58, 41, 68, 32, 80, 25),
    );
  }

  /// A round eye with a glint.
  void _openEye(Canvas canvas) {
    canvas.drawOval(
      Rect.fromCenter(
        center: const Offset(33.5, 29.5),
        width: 6.2,
        height: 7.4,
      ),
      Paint()..color = _ink,
    );
    if (details) {
      canvas.drawCircle(const Offset(34.6, 28), 1.2, Paint()..color = _plume);
    }
  }

  /// A happy eye, closed in an upturned arc.
  void _smilingEye(Canvas canvas) {
    _line(
      canvas,
      Path()
        ..moveTo(30.4, 30.8)
        ..quadraticBezierTo(33.5, 25.8, 36.6, 30.8),
      _ink,
      2.6,
    );
  }

  /// A sleeping eye, closed in a downturned arc.
  void _closedEye(Canvas canvas) {
    _line(
      canvas,
      Path()
        ..moveTo(30.4, 29.5)
        ..quadraticBezierTo(33.5, 33.9, 36.6, 29.5),
      _ink,
      2.6,
    );
  }

  void _cheek(Canvas canvas, {double opacity = 1}) {
    if (details) {
      canvas.drawOval(
        Rect.fromCenter(
          center: const Offset(38.5, 38.5),
          width: 7.2,
          height: 4.4,
        ),
        Paint()..color = _blush.withValues(alpha: opacity),
      );
    }
  }

  /// The olive sprig in the beak: a stem and three leaves.
  void _sprig(Canvas canvas) {
    _line(
      canvas,
      Path()
        ..moveTo(15.5, 34.5)
        ..cubicTo(12.5, 39, 10.5, 44, 10, 51),
      _twig,
      1.8,
    );
    for (final (center, width, height, degrees, color) in const [
      (Offset(7.6, 41.5), 8.8, 4.2, -40.0, _gold),
      (Offset(14.6, 46), 8.8, 4.2, 35.0, _gold),
      (Offset(9.4, 54.5), 8.0, 4.0, -75.0, _paleGold),
    ]) {
      _turned(
        canvas,
        center,
        degrees,
        () => canvas.drawOval(
          Rect.fromCenter(center: Offset.zero, width: width, height: height),
          Paint()..color = color,
        ),
      );
    }
  }

  /// Gold stars, confetti and dots around the celebration.
  void _sparkles(Canvas canvas) {
    canvas
      ..drawPath(
        _star(const Offset(13, 12), 6, 7, 1, 1),
        Paint()..color = _gold,
      )
      ..drawPath(
        _star(const Offset(94, 43), 4.4, 5, 0.8, 0.6),
        Paint()..color = _gold,
      )
      ..drawPath(
        _star(const Offset(8, 66), 3.4, 4, 0.6, 0.6),
        Paint()..color = _paleGold,
      );
    for (final (center, degrees, color) in const [
      (Offset(34.5, 6.3), 25.0, _sky),
      (Offset(46.5, 11.3), -30.0, _paleGold),
    ]) {
      _turned(
        canvas,
        center,
        degrees,
        () => canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset.zero, width: 5, height: 2.6),
            const Radius.circular(1.3),
          ),
          Paint()..color = color,
        ),
      );
    }
    canvas
      ..drawCircle(const Offset(96, 55), 1.5, Paint()..color = _sky)
      ..drawCircle(const Offset(12, 80), 1.5, Paint()..color = _gold);
  }

  /// A four-pointed star around [center], its tips [halfWidth] and
  /// [halfHeight] away, its sides pulled in towards ([pinchX], [pinchY]).
  Path _star(
    Offset center,
    double halfWidth,
    double halfHeight,
    double pinchX,
    double pinchY,
  ) {
    final Offset(dx: x, dy: y) = center;
    return Path()
      ..moveTo(x, y - halfHeight)
      ..quadraticBezierTo(x + pinchX, y - pinchY, x + halfWidth, y)
      ..quadraticBezierTo(x + pinchX, y + pinchY, x, y + halfHeight)
      ..quadraticBezierTo(x - pinchX, y + pinchY, x - halfWidth, y)
      ..quadraticBezierTo(x - pinchX, y - pinchY, x, y - halfHeight)
      ..close();
  }

  /// Two "z" rising from the dove, and a crescent moon.
  void _night(Canvas canvas) {
    _line(
      canvas,
      Path()
        ..moveTo(60, 19)
        ..lineTo(66, 19)
        ..lineTo(60, 26)
        ..lineTo(66, 26),
      _sleep,
      2.2,
    );
    _line(
      canvas,
      Path()
        ..moveTo(70, 5)
        ..lineTo(78, 5)
        ..lineTo(70, 14.5)
        ..lineTo(78, 14.5),
      _sleep,
      2.6,
    );
    canvas.drawPath(
      Path()
        ..moveTo(90, 22)
        ..arcToPoint(
          const Offset(96, 37),
          radius: const Radius.circular(9),
          largeArc: true,
          clockwise: false,
        )
        ..arcToPoint(
          const Offset(90, 22),
          radius: const Radius.circular(7),
          largeArc: true,
        )
        ..close(),
      Paint()..color = _gold,
    );
  }

  @override
  bool shouldRepaint(DovePainter oldDelegate) =>
      pose != oldDelegate.pose ||
      details != oldDelegate.details ||
      outline != oldDelegate.outline;
}
