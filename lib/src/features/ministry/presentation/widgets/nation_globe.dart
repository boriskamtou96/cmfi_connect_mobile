import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_motion.dart';
import '../../domain/globe_math.dart';
import '../../domain/nation.dart';

/// The nations on a globe: the land in dots, each nation a light, linked to
/// Yaoundé (the first nation) by an arc. Turned with a finger; a touch on a
/// nation picks it, and [selected] turns the globe to it.
class NationGlobe extends HookWidget {
  const NationGlobe({
    required this.nations,
    required this.land,
    required this.selected,
    required this.onSelect,
    required this.semanticLabel,
    this.onDrag,
    super.key,
  });

  final List<Nation> nations;
  final List<SpherePoint> land;

  /// Index in [nations], null for none.
  final int? selected;
  final ValueChanged<int> onSelect;

  /// The user turns the globe (a journey stops then).
  final VoidCallback? onDrag;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final points = useMemoized(
      () => [
        for (final nation in nations)
          spherePoint(nation.latitude, nation.longitude),
      ],
      [nations],
    );
    // Cameroon, a little turned to show Africa and Europe
    final view = useState<GlobeView>(
      nations.isEmpty
          ? (latitude: 10, longitude: 12)
          : viewOn(nations.first.latitude + 8, nations.first.longitude),
    );
    final travel = useAnimationController();
    final from = useRef(view.value);
    final to = useRef(view.value);

    useEffect(() {
      void step() {
        final t = AppMotion.emphasized.transform(travel.value);
        view.value = (
          latitude: ui.lerpDouble(from.value.latitude, to.value.latitude, t)!,
          longitude: ui.lerpDouble(
            from.value.longitude,
            to.value.longitude,
            t,
          )!,
        );
      }

      travel.addListener(step);
      return () => travel.removeListener(step);
    }, [travel]);

    // a nation picked: the globe turns to it
    final index = selected;
    useEffect(() {
      if (index == null || index >= nations.length) {
        return null;
      }
      final nation = nations[index];
      from.value = view.value;
      to.value = shortestTarget(
        view.value,
        viewOn(nation.latitude, nation.longitude),
      );
      travel.duration = AppMotion.of(
        context,
        const Duration(milliseconds: 900),
      );
      if (travel.duration == Duration.zero) {
        view.value = to.value;
      } else {
        travel.forward(from: 0);
      }
      return null;
    }, [index, nations]);

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = math.min(constraints.maxWidth, constraints.maxHeight);
        final radius = size / 2 * 0.86;

        void turnBy(Offset delta) {
          travel.stop();
          final degrees = 180 / (math.pi * radius);
          final current = view.value;
          view.value = (
            latitude: (current.latitude + delta.dy * degrees).clamp(-70, 70),
            longitude: current.longitude - delta.dx * degrees,
          );
        }

        // the nearest nation on the visible face, within a finger's reach
        void pick(Offset position) {
          final center = Offset(size / 2, size / 2);
          int? best;
          var bestDistance = 24.0;
          for (var i = 0; i < points.length; i++) {
            final p = turned(points[i], view.value);
            if (p.z <= 0) {
              continue;
            }
            final distance =
                (center + Offset(p.x * radius, -p.y * radius) - position)
                    .distance;
            if (distance < bestDistance) {
              best = i;
              bestDistance = distance;
            }
          }
          if (best != null) {
            onSelect(best);
          }
        }

        return Semantics(
          label: semanticLabel,
          image: true,
          child: GestureDetector(
            onPanStart: (_) => onDrag?.call(),
            onPanUpdate: (details) => turnBy(details.delta),
            onTapUp: (details) => pick(details.localPosition),
            child: SizedBox.square(
              dimension: size,
              child: CustomPaint(
                painter: _GlobePainter(
                  view: view.value,
                  land: land,
                  nations: points,
                  selected: index,
                  radius: radius,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GlobePainter extends CustomPainter {
  _GlobePainter({
    required this.view,
    required this.land,
    required this.nations,
    required this.selected,
    required this.radius,
  });

  final GlobeView view;
  final List<SpherePoint> land;
  final List<SpherePoint> nations;
  final int? selected;
  final double radius;

  static const _ocean = Color(0xFF0B3B70);
  static const _oceanEdge = Color(0xFF041C3A);
  static const _landColor = Color(0xFFB8D6F2);
  static const _arcSegments = 18;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    Offset at(SpherePoint p) => center + Offset(p.x * radius, -p.y * radius);
    final scale = radius / 150;

    // a halo around, then the sea, lit from the top left
    canvas.drawCircle(
      center,
      radius * 1.14,
      Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.45),
            AppColors.primary.withValues(alpha: 0),
          ],
          stops: const [0.75, 1],
        ).createShader(Rect.fromCircle(center: center, radius: radius * 1.14)),
    );
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(-0.35, -0.4),
          radius: 1.1,
          colors: const [_ocean, _oceanEdge],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );

    // the land, brighter towards the middle of the face
    final buckets = List.generate(4, (_) => <Offset>[]);
    for (final dot in land) {
      final p = turned(dot, view);
      if (p.z <= 0.02) {
        continue;
      }
      buckets[math.min(3, (p.z * 4).floor())].add(at(p));
    }
    for (var b = 0; b < buckets.length; b++) {
      canvas.drawPoints(
        ui.PointMode.points,
        buckets[b],
        Paint()
          ..color = _landColor.withValues(alpha: 0.22 + 0.16 * b)
          ..strokeWidth = 2.1 * scale
          ..strokeCap = StrokeCap.round,
      );
    }

    // the arcs from Yaoundé, on the visible face only (behind the earth, an
    // arc would loop around the globe)
    if (nations.isNotEmpty) {
      final home = nations.first;
      for (var i = 1; i < nations.length; i++) {
        final chosen = i == selected;
        final path = Path();
        var drawing = false;
        for (var s = 0; s <= _arcSegments; s++) {
          final p = turned(
            arcPoint(home, nations[i], s / _arcSegments, 0.25),
            view,
          );
          final visible = p.z > 0;
          final point = at(p);
          if (visible && drawing) {
            path.lineTo(point.dx, point.dy);
          } else if (visible) {
            path.moveTo(point.dx, point.dy);
          }
          drawing = visible;
        }
        canvas.drawPath(
          path,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = (chosen ? 2 : 0.8) * scale
            ..color = AppColors.gold.withValues(alpha: chosen ? 0.95 : 0.16),
        );
      }
    }

    // the nations: a gold light, Yaoundé in white
    for (var i = 0; i < nations.length; i++) {
      final p = turned(nations[i], view);
      if (p.z <= 0) {
        continue;
      }
      final point = at(p);
      final fade = 0.35 + 0.65 * p.z;
      final color = i == 0 ? Colors.white : AppColors.gold;
      canvas
        ..drawCircle(
          point,
          6 * scale,
          Paint()..color = color.withValues(alpha: 0.18 * fade),
        )
        ..drawCircle(
          point,
          2.6 * scale,
          Paint()..color = color.withValues(alpha: fade),
        );
      if (i == selected) {
        canvas.drawCircle(
          point,
          10 * scale,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2 * scale
            ..color = Colors.white,
        );
      }
    }

    // the edge of the sphere
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = Colors.white.withValues(alpha: 0.18),
    );
  }

  @override
  bool shouldRepaint(_GlobePainter old) =>
      old.view != view ||
      old.selected != selected ||
      old.land != land ||
      old.nations != nations ||
      old.radius != radius;
}
