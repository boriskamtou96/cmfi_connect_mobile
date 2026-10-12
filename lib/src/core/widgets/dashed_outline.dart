import 'package:flutter/material.dart';

/// Dashed border around [child]: a circle, or a rounded rectangle of [radius].
/// The design uses it for "nothing here yet" (day without report, item preview).
class DashedOutline extends StatelessWidget {
  const DashedOutline({
    required this.child,
    required this.color,
    this.radius,
    this.strokeWidth = 1.5,
    this.dash = 4,
    this.gap = 3,
    super.key,
  });

  final Widget child;
  final Color color;

  /// null draws a circle.
  final double? radius;
  final double strokeWidth;
  final double dash;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _DashedPainter(
        color: color,
        radius: radius,
        strokeWidth: strokeWidth,
        dash: dash,
        gap: gap,
      ),
      child: child,
    );
  }
}

class _DashedPainter extends CustomPainter {
  const _DashedPainter({
    required this.color,
    required this.radius,
    required this.strokeWidth,
    required this.dash,
    required this.gap,
  });

  final Color color;
  final double? radius;
  final double strokeWidth;
  final double dash;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(strokeWidth / 2);
    final outline = switch (radius) {
      null => Path()..addOval(rect),
      final r =>
        Path()..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(r))),
    };

    final dashed = Path();
    for (final metric in outline.computeMetrics()) {
      for (
        var distance = 0.0;
        distance < metric.length;
        distance += dash + gap
      ) {
        dashed.addPath(
          metric.extractPath(distance, distance + dash),
          Offset.zero,
        );
      }
    }

    canvas.drawPath(
      dashed,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
  }

  @override
  bool shouldRepaint(_DashedPainter oldDelegate) =>
      color != oldDelegate.color ||
      radius != oldDelegate.radius ||
      strokeWidth != oldDelegate.strokeWidth ||
      dash != oldDelegate.dash ||
      gap != oldDelegate.gap;
}
