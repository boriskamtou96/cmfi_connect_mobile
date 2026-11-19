import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/dove_mascot.dart';
import '../../domain/flight_journey.dart';
import '../../domain/verse_flight.dart';

/// « Verset en vol », drawn with Flame: Zoé flies on the left, three lanes of
/// sky, the words of the verse coming from the right. A touch above Zoé
/// takes her up a lane, below down a lane (a drag moves her too). Each wave
/// carries the word expected and a few others: she must meet the right one.
/// The words on the screen and the hearts are told to the Flutter page
/// ([onFlight]), which draws the verse being built above the sky.
///
/// A stage of the journey (« La conquête de Canaan ») has its [scenery],
/// which scrolls under Zoé as she flies, and its [pace]: the words come
/// faster, and always three at a time from the middle of the journey.
class VerseFlightGame extends FlameGame with TapCallbacks, DragCallbacks {
  VerseFlightGame({
    required VerseFlight flight,
    required this.onFlight,
    required this.onCatch,
    this.scenery = FlightScenery.night,
    this.pace = 1,
    math.Random? random,
  }) : _flight = flight,
       _random = random ?? math.Random();

  VerseFlight _flight;
  final math.Random _random;

  /// What Zoé flies over, and how fast the words come (1: the free flight).
  final FlightScenery scenery;
  final double pace;

  /// Nothing moves any more once the flight is won or lost.
  bool get over => _flight.over;

  /// How fast the land goes by under Zoé.
  double get travelSpeed => size.x * 0.14 * pace;

  /// The flight after each word met.
  final ValueChanged<VerseFlight> onFlight;

  /// What a word met did (for the sounds and vibrations of the page).
  final ValueChanged<Catch> onCatch;

  late final _Dove _dove;
  var _lane = 1;
  var _sinceWave = 0.0;

  static const _lanes = 3;

  /// The sky under the verse of the page: the lanes from 34 % to 82 % high.
  double laneY(int lane) => size.y * (0.38 + lane * 0.2);

  /// Faster as the verse grows (up to its fourteenth word: a long verse of
  /// the journey does not end out of reach), and with the pace of the stage.
  double get _speed =>
      size.x * (0.26 + 0.012 * math.min(_flight.caught, 14)) * pace;

  @override
  Color backgroundColor() => AppColors.night;

  @override
  Future<void> onLoad() async {
    add(_Backdrop(_looks[scenery]!, scenery));
    _dove = _Dove()
      ..size = Vector2.all(86)
      ..anchor = Anchor.center
      ..position = Vector2(size.x * 0.2, laneY(_lane));
    add(_dove);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_flight.over) {
      return;
    }
    // Zoé glides to her lane
    final target = laneY(_lane);
    _dove.y += (target - _dove.y) * math.min(1, dt * 12);

    _sinceWave += dt;
    final words = children.whereType<_Word>().toList();
    final clear = words.every((word) => word.x < size.x * 0.55);
    if (_sinceWave > 1.2 && clear) {
      _sinceWave = 0;
      _wave();
    }
    for (final word in words) {
      word.x -= _speed * dt;
      if (word.x < -word.size.x) {
        word.removeFromParent();
        continue;
      }
      final near = (word.x - _dove.x).abs() < word.size.x / 2 + 24;
      if (near && word.lane == _lane && !word.met) {
        _meet(word);
      }
    }
  }

  /// A wave: the word expected in a lane, others of the verse in some of
  /// the other lanes.
  void _wave() {
    final next = _flight.next;
    if (next == null) {
      return;
    }
    final lanes = List.generate(_lanes, (lane) => lane)..shuffle(_random);
    final others = [
      for (var i = 0; i < _flight.words.length; i++)
        if (_flight.words[i] != _flight.words[next]) i,
    ]..shuffle(_random);
    // one or two other words; always two from the middle of the journey
    final wanted = pace >= 1.15 ? 2 : 1 + _random.nextInt(2);
    final decoys = math.min(others.length, wanted);
    final indexes = [next, ...others.take(decoys)];
    for (var k = 0; k < indexes.length; k++) {
      add(
        _Word(
          index: indexes[k],
          text: _flight.words[indexes[k]],
          lane: lanes[k],
        )..position = Vector2(size.x + 60 + k * 18, laneY(lanes[k])),
      );
    }
  }

  void _meet(_Word word) {
    word.met = true;
    // the same text twice in a verse: either one is the right one
    final index = _flight.words[word.index] == _flight.words[_flight.caught]
        ? _flight.caught
        : word.index;
    final (after, result) = _flight.meet(index);
    _flight = after;
    word.removeFromParent();
    final right = result == Catch.right || result == Catch.won;
    add(_burst(word.position.clone(), right));
    if (!right) {
      _dove.hurt();
    }
    onFlight(after);
    onCatch(result);
    if (after.over) {
      for (final other in children.whereType<_Word>()) {
        other.removeFromParent();
      }
      _dove.pose = after.won ? DovePose.celebrate : DovePose.rest;
    }
  }

  ParticleSystemComponent _burst(Vector2 at, bool right) =>
      ParticleSystemComponent(
        position: at,
        particle: Particle.generate(
          count: right ? 18 : 8,
          lifespan: 0.6,
          generator: (i) {
            final angle = i / (right ? 18 : 8) * 2 * math.pi;
            final speed =
                Vector2(math.cos(angle), math.sin(angle)) * (right ? 140 : 70);
            return AcceleratedParticle(
              speed: speed,
              acceleration: -speed * 0.9,
              child: CircleParticle(
                radius: right ? 3.2 : 2.6,
                paint: Paint()
                  ..color = right
                      ? (i.isEven ? AppColors.gold : Colors.white)
                      : const Color(0xFFE07A5F),
              ),
            );
          },
        ),
      );

  void _move(int by) {
    if (_flight.over) {
      return;
    }
    _lane = (_lane + by).clamp(0, _lanes - 1);
  }

  @override
  void onTapDown(TapDownEvent event) {
    _move(event.localPosition.y < _dove.y ? -1 : 1);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (_flight.over) {
      return;
    }
    // the lane nearest to the finger
    final y = event.localEndPosition.y;
    var best = 0;
    for (var lane = 1; lane < _lanes; lane++) {
      if ((laneY(lane) - y).abs() < (laneY(best) - y).abs()) {
        best = lane;
      }
    }
    _lane = best;
  }
}

/// Zoé, drawn by the painter of the app, turned to fly right; red a moment
/// when she meets a wrong word.
class _Dove extends PositionComponent {
  DovePose pose = DovePose.cheer;
  var _time = 0.0;
  var _hurt = 0.0;

  void hurt() => _hurt = 0.35;

  @override
  void update(double dt) {
    _time = (_time + dt / 1.2) % 1;
    _hurt = math.max(0, _hurt - dt);
  }

  @override
  void render(Canvas canvas) {
    canvas
      ..save()
      // drawn facing left: turned around to fly towards the words
      ..translate(size.x, 0)
      ..scale(-1, 1);
    if (_hurt > 0) {
      canvas.saveLayer(
        Offset.zero & size.toSize(),
        Paint()
          ..colorFilter = const ColorFilter.mode(
            Color(0x88E07A5F),
            BlendMode.srcATop,
          ),
      );
    }
    DovePainter(
      pose: pose,
      motion: DoveMotion.at(pose, _time),
    ).paint(canvas, size.toSize());
    if (_hurt > 0) {
      canvas.restore();
    }
    canvas.restore();
  }
}

/// A word of the verse flying towards Zoé: a white pill with its text.
class _Word extends PositionComponent {
  _Word({required this.index, required this.text, required this.lane})
    : super(anchor: Anchor.center);

  /// Its place in the verse.
  final int index;
  final String text;
  final int lane;
  bool met = false;

  late final TextPainter _text;

  @override
  Future<void> onLoad() async {
    _text = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 17,
          fontWeight: FontWeight.w800,
          color: AppColors.night,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    size = Vector2(_text.width + 28, 40);
  }

  @override
  void render(Canvas canvas) {
    final pill = RRect.fromRectAndRadius(
      Offset.zero & size.toSize(),
      const Radius.circular(20),
    );
    canvas
      ..drawRRect(
        pill.shift(const Offset(0, 4)),
        Paint()..color = const Color(0xFF9DB4D1),
      )
      ..drawRRect(pill, Paint()..color = Colors.white);
    _text.paint(canvas, Offset(14, (size.y - _text.height) / 2));
  }
}

/// The colors of a sky: its gradient, the glow low on the horizon, the land
/// far away, nearer, and under Zoé. The top stays dark in every one: the
/// page writes the verse there, in white.
class _Look {
  const _Look({
    required this.top,
    required this.bottom,
    required this.glow,
    this.far = Colors.transparent,
    this.near = Colors.transparent,
    this.ground = Colors.transparent,
  });

  final Color top;
  final Color bottom;
  final Color glow;
  final Color far;
  final Color near;
  final Color ground;
}

const _looks = {
  FlightScenery.night: _Look(
    top: Color(0xFF0B3B70),
    bottom: AppColors.night,
    glow: AppColors.gold,
  ),
  FlightScenery.egypt: _Look(
    top: Color(0xFF10233F),
    bottom: Color(0xFF8A5A32),
    glow: Color(0xFFF2B544),
    far: Color(0xFF9C6B38),
    near: Color(0xFF5E3B1E),
    ground: Color(0xFF3F2713),
  ),
  FlightScenery.sea: _Look(
    top: Color(0xFF0B2545),
    bottom: Color(0xFF1B6C8C),
    glow: Color(0xFF7FD1E0),
    far: Color(0xFF1F7FA3),
    near: Color(0xFF145A78),
    ground: Color(0xFF0E4560),
  ),
  FlightScenery.oasis: _Look(
    top: Color(0xFF0E2A47),
    bottom: Color(0xFF2F7A6B),
    glow: Color(0xFFF2B544),
    far: Color(0xFF1F5A4E),
    near: Color(0xFF7A5A30),
    ground: Color(0xFF4D3A1F),
  ),
  FlightScenery.desert: _Look(
    top: Color(0xFF13233F),
    bottom: Color(0xFF9A6A3A),
    glow: Color(0xFFF2B544),
    far: Color(0xFF7A5230),
    near: Color(0xFF5E3B1E),
    ground: Color(0xFF3F2713),
  ),
  FlightScenery.mountain: _Look(
    top: Color(0xFF0C1E3C),
    bottom: Color(0xFF5A3A52),
    glow: Color(0xFFFF9F45),
    far: Color(0xFF3A2A45),
    near: Color(0xFF2A1E33),
    ground: Color(0xFF1E1626),
  ),
  FlightScenery.camp: _Look(
    top: Color(0xFF0F2140),
    bottom: Color(0xFF6B4A3A),
    glow: Color(0xFFF2B544),
    far: Color(0xFF8C7A5C),
    near: Color(0xFF5A4630),
    ground: Color(0xFF3A2C1E),
  ),
  FlightScenery.river: _Look(
    top: Color(0xFF0D2747),
    bottom: Color(0xFF2E7FA0),
    glow: Color(0xFF9AD9E8),
    far: Color(0xFF2F6B4F),
    near: Color(0xFF1D6A8A),
    ground: Color(0xFF134B63),
  ),
  FlightScenery.walls: _Look(
    top: Color(0xFF121F3A),
    bottom: Color(0xFFA86F3D),
    glow: Color(0xFFF2B544),
    far: Color(0xFF7D5630),
    near: Color(0xFF5C3D20),
    ground: Color(0xFF3D2814),
  ),
  FlightScenery.canaan: _Look(
    top: Color(0xFF103052),
    bottom: Color(0xFF5FA55A),
    glow: Color(0xFFFFE08A),
    far: Color(0xFF3F8A4F),
    near: Color(0xFF2C6B3C),
    ground: Color(0xFF1F4D2B),
  ),
};

/// What is behind Zoé: the sky of the stage, a few stars drifting slowly, a
/// glow low on the horizon, and (on the journey) the land that goes by under
/// her, the far things slower than the near ones. All drawn in code.
class _Backdrop extends Component with HasGameReference<VerseFlightGame> {
  _Backdrop(this.look, this.scenery);

  final _Look look;
  final FlightScenery scenery;

  final _stars = <(Vector2, double)>[];
  final _random = math.Random(7);

  /// How far Zoé has flown, in pixels of the ground.
  var _travel = 0.0;

  @override
  Future<void> onLoad() async {
    for (var i = 0; i < 46; i++) {
      _stars.add((
        Vector2(_random.nextDouble(), _random.nextDouble()),
        0.6 + _random.nextDouble() * 1.6,
      ));
    }
  }

  @override
  void update(double dt) {
    for (final (position, depth) in _stars) {
      position.x -= dt * 0.012 * depth;
      if (position.x < 0) {
        position.x += 1;
      }
    }
    if (!game.over) {
      _travel += dt * game.travelSpeed;
    }
  }

  @override
  void render(Canvas canvas) {
    final size = game.size.toSize();
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [look.top, look.top, look.bottom],
          stops: const [0, 0.35, 1],
        ).createShader(rect),
    );
    final glowAt = Offset(size.width * 0.5, size.height * 1.05);
    canvas.drawCircle(
      glowAt,
      size.width * 0.7,
      Paint()
        ..shader =
            RadialGradient(
              colors: [
                look.glow.withValues(alpha: 0.22),
                look.glow.withValues(alpha: 0),
              ],
            ).createShader(
              Rect.fromCircle(center: glowAt, radius: size.width * 0.7),
            ),
    );
    // the stars: everywhere at night, only high in the sky of a stage
    final night = scenery == FlightScenery.night;
    final star = Paint()..color = Colors.white.withValues(alpha: 0.7);
    for (final (position, depth) in _stars) {
      if (night || position.y < 0.45) {
        canvas.drawCircle(
          Offset(position.x * size.width, position.y * size.height),
          depth * 0.9,
          star,
        );
      }
    }
    if (!night) {
      _land(canvas, size);
    }
  }

  /// The land of the stage, from the farthest to the nearest.
  void _land(Canvas canvas, Size size) {
    final unit = size.height / 800;
    final far = Paint()..color = look.far;
    final near = Paint()..color = look.near;
    final ground = Paint()..color = look.ground;
    final farBase = size.height * 0.9;

    // far away: what names the place, one group per stretch of land
    final stretch = size.width * 0.9;
    final shift = (_travel * 0.3) % stretch;
    for (var i = -1; i <= 2; i++) {
      final x = i * stretch - shift + stretch / 2;
      switch (scenery) {
        case FlightScenery.egypt:
          _pyramids(canvas, x, farBase, unit, far);
        case FlightScenery.oasis:
          _palms(canvas, x, farBase, unit, far);
        case FlightScenery.desert:
          _rocks(canvas, x, farBase, unit, far);
        case FlightScenery.mountain:
          _mountain(canvas, x, farBase, unit, far);
        case FlightScenery.camp:
          _tents(canvas, x, farBase, unit, far);
        case FlightScenery.walls:
          _tower(canvas, x, farBase, unit, far);
        case FlightScenery.canaan:
          _trees(canvas, x, farBase, unit, far);
        case FlightScenery.river:
          _reeds(canvas, x, farBase, unit, far);
        case FlightScenery.sea || FlightScenery.night:
          break;
      }
    }
    if (scenery == FlightScenery.walls) {
      _wall(canvas, size, farBase, unit, far);
    }
    if (scenery == FlightScenery.sea || scenery == FlightScenery.canaan) {
      canvas.drawPath(
        _band(size, size.height * 0.86, 14 * unit, 260 * unit, _travel * 0.3),
        far,
      );
    }

    // nearer, then right under Zoé: two waves of land (or of water)
    final water =
        scenery == FlightScenery.sea || scenery == FlightScenery.river;
    canvas
      ..drawPath(
        _band(
          size,
          size.height * 0.91,
          (water ? 7 : 12) * unit,
          (water ? 120 : 340) * unit,
          _travel * 0.65,
        ),
        near,
      )
      ..drawPath(
        _band(
          size,
          size.height * 0.955,
          (water ? 5 : 8) * unit,
          (water ? 90 : 230) * unit,
          _travel + 60,
        ),
        ground,
      );
    if (water) {
      // the light on the water
      final crest = Paint()
        ..color = Colors.white.withValues(alpha: 0.28)
        ..strokeWidth = 2 * unit
        ..strokeCap = StrokeCap.round;
      final gap = 70 * unit;
      final slide = _travel % gap;
      for (var x = -slide; x < size.width; x += gap) {
        canvas.drawLine(
          Offset(x, size.height * 0.935),
          Offset(x + 22 * unit, size.height * 0.935),
          crest,
        );
      }
    }
  }

  /// A band of land from [base] down to the bottom, its top a slow wave.
  Path _band(Size size, double base, double height, double length, double at) {
    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, base);
    for (var x = 0.0; x <= size.width + 8; x += 8) {
      path.lineTo(x, base - height * math.sin((x + at) / length * 2 * math.pi));
    }
    return path
      ..lineTo(size.width, size.height)
      ..close();
  }

  void _pyramids(Canvas canvas, double x, double base, double u, Paint paint) {
    final shade = Paint()..color = Colors.black.withValues(alpha: 0.16);
    for (final (dx, width, height) in [
      (0.0, 190.0, 130.0),
      (150.0, 130.0, 88.0),
    ]) {
      final left = x + (dx - width / 2) * u;
      final right = x + (dx + width / 2) * u;
      final top = Offset(x + dx * u, base - height * u);
      canvas
        ..drawPath(
          Path()
            ..moveTo(left, base)
            ..lineTo(top.dx, top.dy)
            ..lineTo(right, base)
            ..close(),
          paint,
        )
        // the side away from the light
        ..drawPath(
          Path()
            ..moveTo(top.dx, top.dy)
            ..lineTo(right, base)
            ..lineTo(x + (dx + width * 0.12) * u, base)
            ..close(),
          shade,
        );
    }
  }

  void _palms(Canvas canvas, double x, double base, double u, Paint paint) {
    final stroke = Paint()
      ..color = paint.color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (final (dx, height) in [(-60.0, 120.0), (10.0, 150.0), (80.0, 105.0)]) {
      final foot = Offset(x + dx * u, base);
      final head = Offset(x + (dx + 14) * u, base - height * u);
      canvas.drawPath(
        Path()
          ..moveTo(foot.dx, foot.dy)
          ..quadraticBezierTo(
            foot.dx - 8 * u,
            base - height * 0.5 * u,
            head.dx,
            head.dy,
          ),
        stroke..strokeWidth = 7 * u,
      );
      for (var k = 0; k < 6; k++) {
        final angle = -math.pi * (0.08 + k * 0.17);
        final tip = head + Offset(math.cos(angle), math.sin(angle)) * (46 * u);
        canvas.drawPath(
          Path()
            ..moveTo(head.dx, head.dy)
            ..quadraticBezierTo(
              (head.dx + tip.dx) / 2,
              math.min(head.dy, tip.dy) - 16 * u,
              tip.dx,
              tip.dy + 16 * u,
            ),
          stroke..strokeWidth = 5 * u,
        );
      }
    }
  }

  void _rocks(Canvas canvas, double x, double base, double u, Paint paint) {
    canvas
      ..drawPath(
        Path()
          ..moveTo(x - 130 * u, base)
          ..lineTo(x - 96 * u, base - 74 * u)
          ..lineTo(x - 40 * u, base - 96 * u)
          ..lineTo(x + 6 * u, base - 58 * u)
          ..lineTo(x + 30 * u, base)
          ..close(),
        paint,
      )
      ..drawPath(
        Path()
          ..moveTo(x + 70 * u, base)
          ..lineTo(x + 96 * u, base - 44 * u)
          ..lineTo(x + 140 * u, base - 52 * u)
          ..lineTo(x + 168 * u, base)
          ..close(),
        paint,
      );
  }

  void _mountain(Canvas canvas, double x, double base, double u, Paint paint) {
    final top = Offset(x, base - 300 * u);
    // the fire and the cloud on the top of Sinai
    canvas
      ..drawCircle(
        top,
        120 * u,
        Paint()
          ..shader = RadialGradient(
            colors: [
              look.glow.withValues(alpha: 0.5),
              look.glow.withValues(alpha: 0),
            ],
          ).createShader(Rect.fromCircle(center: top, radius: 120 * u)),
      )
      ..drawPath(
        Path()
          ..moveTo(x - 260 * u, base)
          ..lineTo(x - 150 * u, base - 150 * u)
          ..lineTo(x - 110 * u, base - 130 * u)
          ..lineTo(x - 30 * u, base - 280 * u)
          ..lineTo(top.dx, top.dy)
          ..lineTo(x + 50 * u, base - 250 * u)
          ..lineTo(x + 120 * u, base - 160 * u)
          ..lineTo(x + 160 * u, base - 175 * u)
          ..lineTo(x + 270 * u, base)
          ..close(),
        paint,
      )
      ..drawOval(
        Rect.fromCenter(
          center: top + Offset(0, 14 * u),
          width: 190 * u,
          height: 40 * u,
        ),
        Paint()..color = Colors.white.withValues(alpha: 0.2),
      );
  }

  void _tents(Canvas canvas, double x, double base, double u, Paint paint) {
    // the pillar of cloud over the camp
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(x - 150 * u, base - 330 * u, x - 96 * u, base - 40 * u),
        Radius.circular(27 * u),
      ),
      Paint()..color = Colors.white.withValues(alpha: 0.16),
    );
    final door = Paint()..color = Colors.black.withValues(alpha: 0.28);
    for (final (dx, width, height) in [
      (-70.0, 96.0, 62.0),
      (30.0, 120.0, 80.0),
      (140.0, 90.0, 56.0),
    ]) {
      final center = x + dx * u;
      canvas
        ..drawPath(
          Path()
            ..moveTo(center - width / 2 * u, base)
            ..lineTo(center, base - height * u)
            ..lineTo(center + width / 2 * u, base)
            ..close(),
          paint,
        )
        ..drawPath(
          Path()
            ..moveTo(center - 9 * u, base)
            ..lineTo(center, base - height * 0.55 * u)
            ..lineTo(center + 9 * u, base)
            ..close(),
          door,
        );
    }
  }

  /// The wall of Jericho, all along, with its battlements.
  void _wall(Canvas canvas, Size size, double base, double u, Paint paint) {
    final top = base - 96 * u;
    canvas.drawRect(Rect.fromLTRB(0, top, size.width, base), paint);
    final step = 34 * u;
    final slide = (_travel * 0.3) % step;
    for (var x = -slide; x < size.width; x += step) {
      canvas.drawRect(
        Rect.fromLTWH(x, top - 14 * u, step * 0.55, 15 * u),
        paint,
      );
    }
  }

  void _tower(Canvas canvas, double x, double base, double u, Paint paint) {
    final tower = Rect.fromLTRB(x - 34 * u, base - 168 * u, x + 34 * u, base);
    canvas.drawRect(tower, paint);
    for (var k = 0; k < 3; k++) {
      canvas.drawRect(
        Rect.fromLTWH(
          tower.left - 4 * u + k * 28 * u,
          tower.top - 14 * u,
          16 * u,
          15 * u,
        ),
        paint,
      );
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x - 7 * u, tower.top + 30 * u, 14 * u, 26 * u),
        Radius.circular(7 * u),
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.3),
    );
  }

  void _trees(Canvas canvas, double x, double base, double u, Paint paint) {
    final trunk = Paint()
      ..color = look.near
      ..strokeWidth = 6 * u
      ..strokeCap = StrokeCap.round;
    for (final (dx, height, crown) in [
      (-90.0, 70.0, 34.0),
      (0.0, 96.0, 44.0),
      (100.0, 64.0, 30.0),
    ]) {
      final foot = Offset(x + dx * u, base - 30 * u);
      final head = foot - Offset(0, height * u);
      canvas
        ..drawLine(foot, head, trunk)
        ..drawCircle(head, crown * u, paint);
    }
  }

  void _reeds(Canvas canvas, double x, double base, double u, Paint paint) {
    final stroke = Paint()
      ..color = paint.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 * u
      ..strokeCap = StrokeCap.round;
    for (var k = 0; k < 7; k++) {
      final foot = Offset(x + (k * 26 - 80) * u, base);
      canvas.drawPath(
        Path()
          ..moveTo(foot.dx, foot.dy)
          ..quadraticBezierTo(
            foot.dx + 4 * u,
            base - 50 * u,
            foot.dx + (k.isEven ? 16 : -12) * u,
            base - (80 + k % 3 * 18) * u,
          ),
        stroke,
      );
    }
  }
}
