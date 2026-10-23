import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../i18n/strings.g.dart';
import '../theme/app_colors.dart';

/// The mark of CMFI Connect (validated on 23/10/2026): the open ring of the
/// CMFI emblem around a gold cross, flat, like a modern app icon. Drawn in code
/// so it stays sharp at every size; the same drawing is in SVG in the PDF
/// export, the admin website, the landing page and the notification icon.
class CmfiLogo extends StatelessWidget {
  const CmfiLogo({this.size = 96, this.disc = false, super.key});

  /// In its night medallion, for dark or coloured backgrounds.
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
        // the glowing edge of the medallion only when it can be seen
        painter: CmfiLogoPainter(disc: disc, details: size >= 40),
      ),
    );
  }
}

/// The mark on a 100 × 100 grid: the ring (blue on a light background), the
/// cross in gold. [disc]: in the night medallion, the ring white, with a thin
/// gold-to-blue edge when [details].
class CmfiLogoPainter extends CustomPainter {
  const CmfiLogoPainter({this.disc = false, this.details = true});

  final bool disc;
  final bool details;

  /// The night of the icon: lighter in the middle.
  static const night = [
    Color(0xFF0F2A52),
    Color(0xFF081830),
    Color(0xFF040B18),
  ];

  /// The glowing edge of the icon, from the gold of CMFI to the sky blue of the
  /// emblem.
  static const edge = [Color(0xFFF6D27A), Color(0xFF7FC8F0), Color(0xFF1F6FE0)];

  static const _goldLight = [Color(0xFFFBE2A0), Color(0xFFE2A93B)];
  static const _goldOnWhite = [Color(0xFFE8B348), Color(0xFFC08A1E)];

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..save()
      ..scale(size.width / 100, size.height / 100);
    if (disc) {
      canvas.drawCircle(
        const Offset(50, 50),
        50,
        Paint()
          ..shader = ui.Gradient.radial(const Offset(50, 40), 62, night, const [
            0,
            0.6,
            1,
          ]),
      );
      if (details) {
        canvas.drawCircle(
          const Offset(50, 50),
          48.6,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.6
            ..shader = ui.Gradient.linear(
              const Offset(10, 10),
              const Offset(90, 90),
              edge,
              const [0, 0.45, 1],
            ),
        );
      }
      // a little smaller, inside the medallion
      canvas
        ..translate(50, 50)
        ..scale(0.92)
        ..translate(-50, -50);
    }
    paintMark(canvas, onDark: disc);
    canvas.restore();
  }

  /// The ring and the cross alone, on the 100 × 100 grid: the ring white
  /// [onDark], CMFI blue otherwise.
  static void paintMark(Canvas canvas, {required bool onDark}) {
    // open at the upper right, like the "C" of the emblem
    canvas.drawArc(
      Rect.fromCircle(center: const Offset(50, 50), radius: 26.2),
      -38 * math.pi / 180,
      (316 * math.pi) / 180,
      false,
      Paint()
        ..color = onDark ? Colors.white : AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8.2
        ..strokeCap = StrokeCap.round,
    );
    final gold = Paint()
      ..shader = ui.Gradient.linear(
        const Offset(40, 35),
        const Offset(60, 65),
        onDark ? _goldLight : _goldOnWhite,
      );
    canvas
      ..drawRRect(
        RRect.fromLTRBR(46.5, 35.35, 53.5, 64.65, const Radius.circular(3.5)),
        gold,
      )
      ..drawRRect(
        RRect.fromLTRBR(40.45, 43.55, 59.55, 50.55, const Radius.circular(3.5)),
        gold,
      );
  }

  @override
  bool shouldRepaint(CmfiLogoPainter oldDelegate) =>
      disc != oldDelegate.disc || details != oldDelegate.details;
}

/// The app icon, a full square (the stores round its corners): the night
/// tile, its glowing gold-to-blue edge, the mark in the middle with a soft
/// light. [dev]: on the CMFI blue, to tell the test app apart.
class AppIconPainter extends CustomPainter {
  const AppIconPainter({this.dev = false});

  final bool dev;

  @override
  void paint(Canvas canvas, Size size) {
    final full = size.width;
    final square = Offset.zero & size;
    canvas.drawRect(
      square,
      Paint()
        ..shader = dev
            ? ui.Gradient.linear(Offset.zero, Offset(full, full), const [
                Color(0xFF1A7BD0),
                AppColors.primaryDeep,
              ])
            : ui.Gradient.radial(
                Offset(full / 2, full * 0.38),
                full * 0.75,
                CmfiLogoPainter.night,
                const [0, 0.6, 1],
              ),
    );
    // the glowing edge, as in the presentation
    final frame = RRect.fromRectAndRadius(
      square.deflate(full * 0.043),
      Radius.circular(full * 0.195),
    );
    final edge = ui.Gradient.linear(
      Offset.zero,
      Offset(full, full),
      CmfiLogoPainter.edge,
      const [0, 0.45, 1],
    );
    canvas
      ..drawRRect(
        frame,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = full * 0.022
          ..shader = edge
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, full * 0.018),
      )
      ..drawRRect(
        frame,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = full * 0.01
          ..shader = edge,
      );
    canvas
      ..save()
      ..scale(full / 100);
    // a soft light behind the mark
    canvas.saveLayer(
      const Rect.fromLTWH(0, 0, 100, 100),
      Paint()
        ..color = Colors.white.withValues(alpha: 0.35)
        ..imageFilter = ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
    );
    CmfiLogoPainter.paintMark(canvas, onDark: true);
    canvas.restore();
    CmfiLogoPainter.paintMark(canvas, onDark: true);
    canvas.restore();
  }

  @override
  bool shouldRepaint(AppIconPainter oldDelegate) => dev != oldDelegate.dev;
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
