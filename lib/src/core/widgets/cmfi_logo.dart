import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../i18n/strings.g.dart';
import '../theme/app_colors.dart';

/// The CMFI emblem, redrawn from the community's logo without its letters: the
/// "C" around the globe, the cross standing on the open Bible, and the dove.
/// Drawn in code so it stays sharp at every size; the same drawing is in SVG
/// in the PDF export, the admin website and the landing page.
class CmfiLogo extends StatelessWidget {
  const CmfiLogo({this.size = 96, this.disc = false, super.key});

  /// On a white disc, for dark or coloured backgrounds (its blues would fade).
  const CmfiLogo.onDark({double size = 96, Key? key})
    : this(size: size, disc: true, key: key);

  final double size;
  final bool disc;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: context.t.app.name,
      image: true,
      child: CustomPaint(
        size: Size.square(size),
        // the globe's grid, the lines of the book and the dove vanish when small
        painter: CmfiLogoPainter(disc: disc, details: size >= 40),
      ),
    );
  }
}

class CmfiLogoPainter extends CustomPainter {
  const CmfiLogoPainter({this.disc = false, this.details = true});

  final bool disc;
  final bool details;

  // The colours of the logo, the same in light and dark mode
  static const _cDark = Color(0xFF0A4C92);
  static const _cMiddle = Color(0xFF0B6CB8);
  static const _cLight = Color(0xFF19A6E4);
  static const _globeLight = Color(0xFFF4FBFF);
  static const _globeMiddle = Color(0xFFBFE6F8);
  static const _globeEdge = Color(0xFF7CCAEE);
  static const _cross = Color(0xFF1A4FA0);
  static const _cover = Color(0xFFD88E74);
  static const _pageRight = Color(0xFFF3F8FC);
  static const _spine = Color(0xFFC9A08C);
  static const _textLine = Color(0xFF9DBCDD);
  static const _doveBack = Color(0xFF8FD0F2);
  static const _doveBody = Color(0xFF2E9BDA);
  static const _doveFront = Color(0xFF45AEE6);

  /// The globe, inside the "C".
  static const _globe = Offset(55.16, 47.2);
  static const _globeRadius = 35.0;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    // The emblem is designed on a 100×100 grid
    canvas.scale(size.width / 100, size.height / 100);
    if (disc) {
      canvas.drawCircle(
        const Offset(50, 50),
        50,
        Paint()..color = Colors.white,
      );
      // smaller and centred, so the dove stays inside the disc
      canvas
        ..translate(50, 50)
        ..scale(0.72)
        ..translate(-48.5, -50.8);
    }

    // The "C": the space between two circles, open on the right
    final c = Path()
      ..moveTo(60.45, 7.01)
      ..arcToPoint(
        const Offset(89.34, 68.97),
        radius: const Radius.circular(46),
        largeArc: true,
        clockwise: false,
      )
      ..arcToPoint(
        const Offset(60.45, 7.01),
        radius: const Radius.circular(40.53),
        largeArc: true,
      )
      ..close();
    canvas.drawPath(
      c,
      Paint()
        ..shader = ui.Gradient.linear(
          const Offset(10, 12),
          const Offset(86, 88),
          const [_cDark, _cMiddle, _cLight],
          const [0, 0.55, 1],
        ),
    );

    canvas.drawCircle(
      _globe,
      _globeRadius,
      Paint()
        ..shader = ui.Gradient.radial(
          _globe.translate(-10, -13),
          _globeRadius * 1.35,
          const [_globeLight, _globeMiddle, _globeEdge],
          const [0, 0.6, 1],
        ),
    );
    if (details) {
      _grid(canvas);
    }

    // The cross, standing on the Bible
    final cross = Paint()..color = _cross;
    canvas
      ..drawRRect(
        RRect.fromLTRBR(51.66, 10.5, 58.66, 62, const Radius.circular(1)),
        cross,
      )
      ..drawRRect(
        RRect.fromLTRBR(41.16, 22.5, 69.16, 29.5, const Radius.circular(1)),
        cross,
      );

    _bible(canvas);
    if (details) {
      _dove(canvas);
    }
    canvas.restore();
  }

  /// Two meridians and three parallels, in faint white.
  void _grid(Canvas canvas) {
    final line = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9;
    for (final width in [_globeRadius * 0.84, _globeRadius * 1.6]) {
      canvas.drawOval(
        Rect.fromCenter(center: _globe, width: width, height: _globeRadius * 2),
        line,
      );
    }
    canvas.drawPath(
      Path()
        ..moveTo(20.16, 47.2)
        ..quadraticBezierTo(55.16, 52.2, 90.16, 47.2)
        ..moveTo(24.85, 29.7)
        ..quadraticBezierTo(55.16, 33.7, 85.47, 29.7)
        ..moveTo(24.85, 64.7)
        ..quadraticBezierTo(55.16, 69.2, 85.47, 64.7),
      line,
    );
  }

  /// The open Bible: the cover, then a page on each side of the spine.
  void _bible(Canvas canvas) {
    canvas.drawPath(
      Path()
        ..moveTo(55.16, 64.5)
        ..cubicTo(48.16, 61, 40.16, 60.5, 34.16, 61.5)
        ..lineTo(34.16, 75)
        ..cubicTo(41.16, 74, 49.16, 75, 55.16, 78.5)
        ..cubicTo(61.16, 75, 69.16, 74, 76.16, 75)
        ..lineTo(76.16, 61.5)
        ..cubicTo(70.16, 60.5, 62.16, 61, 55.16, 64.5)
        ..close(),
      Paint()..color = _cover,
    );
    // the right page mirrors the left one around the spine
    for (final (side, color) in [(-1.0, Colors.white), (1.0, _pageRight)]) {
      double x(double dx) => 55.16 + side * dx;
      canvas.drawPath(
        Path()
          ..moveTo(55.16, 62.5)
          ..cubicTo(x(7), 59, x(14), 58.5, x(19.5), 59.5)
          ..lineTo(x(19.5), 72.5)
          ..cubicTo(x(13), 71.5, x(6), 72.5, 55.16, 76)
          ..close(),
        Paint()..color = color,
      );
      if (details) {
        final text = Paint()
          ..color = _textLine
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.7
          ..strokeCap = StrokeCap.round;
        for (final y in [63.2, 66.4, 69.6]) {
          canvas.drawPath(
            Path()
              ..moveTo(x(16.5), y)
              ..cubicTo(x(12), y - 0.6, x(7), y, x(3), y + 2),
            text,
          );
        }
      }
    }
    canvas.drawLine(
      const Offset(55.16, 62.5),
      const Offset(55.16, 76),
      Paint()
        ..color = _spine
        ..strokeWidth = 0.8,
    );
  }

  /// The dove, upper right, flying towards the cross.
  void _dove(Canvas canvas) {
    canvas
      ..save()
      ..translate(80.5, 4.5)
      ..drawPath(
        Path()
          ..moveTo(7.4, 9.2)
          ..cubicTo(6.2, 5.6, 6.8, 2.4, 9.4, 0)
          ..cubicTo(10.4, 3.2, 10.4, 6.4, 9.2, 9.4)
          ..close(),
        Paint()..color = _doveBack,
      )
      ..drawPath(
        Path()
          ..moveTo(1.4, 10.6)
          ..cubicTo(3.2, 8.4, 6.4, 7.6, 9.4, 8.4)
          ..cubicTo(11.6, 9, 13.6, 10.4, 15, 12.4)
          ..cubicTo(13.2, 12, 11.6, 12.2, 10.4, 13)
          ..cubicTo(8, 14.8, 4.4, 14.4, 1.4, 10.6)
          ..close()
          // the beak
          ..moveTo(1.4, 10.6)
          ..lineTo(0, 10.9)
          ..lineTo(1.6, 11.6)
          ..close(),
        Paint()..color = _doveBody,
      )
      ..drawPath(
        Path()
          ..moveTo(7, 10.2)
          ..cubicTo(7.6, 6.4, 10, 3.2, 13.8, 1.4)
          ..cubicTo(13.4, 5.2, 11.6, 8.6, 8.6, 10.8)
          ..close(),
        Paint()..color = _doveFront,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(CmfiLogoPainter oldDelegate) =>
      disc != oldDelegate.disc || details != oldDelegate.details;
}

/// "CMFI Connect" wordmark: the international name, in every language.
class CmfiWordmark extends StatelessWidget {
  const CmfiWordmark({this.fontSize = 30, this.onDark = false, super.key});

  final double fontSize;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'CMFI ',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: onDark ? Colors.white : AppColors.ink,
        ),
        children: [
          TextSpan(
            text: 'Connect',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: onDark ? AppColors.onPrimaryMuted : AppColors.primary,
            ),
          ),
        ],
      ),
      style: TextStyle(
        fontSize: fontSize,
        letterSpacing: -fontSize * 0.02,
        height: 1,
      ),
    );
  }
}

/// An open ring, like the "C" of the emblem, used as a large, faint decoration
/// (splash, welcome, highlighted cards).
class BrandRing extends StatelessWidget {
  const BrandRing({
    required this.size,
    required this.color,
    this.strokeWidth = 10,
    super.key,
  });

  final double size;
  final Color color;

  /// Stroke width in a 100×100 grid.
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: CustomPaint(
        size: Size.square(size),
        painter: _RingPainter(color: color, strokeWidth: strokeWidth),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.color, required this.strokeWidth});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..save()
      ..scale(size.width / 100, size.height / 100)
      // from the lower right, around the bottom, left and top, to the upper right
      ..drawArc(
        Rect.fromCircle(center: const Offset(50, 50), radius: 32),
        math.pi / 4,
        math.pi * 1.5,
        false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      color != oldDelegate.color || strokeWidth != oldDelegate.strokeWidth;
}
