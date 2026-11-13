import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/dove_mascot.dart';
import '../../domain/verse_flight.dart';

/// « Verset en vol », drawn with Flame: Zoé flies on the left, three lanes of
/// sky, the words of the verse coming from the right. A touch above Zoé
/// takes her up a lane, below down a lane (a drag moves her too). Each wave
/// carries the word expected and a few others: she must meet the right one.
/// The words on the screen and the hearts are told to the Flutter page
/// ([onFlight]), which draws the verse being built above the sky.
class VerseFlightGame extends FlameGame with TapCallbacks, DragCallbacks {
  VerseFlightGame({
    required VerseFlight flight,
    required this.onFlight,
    required this.onCatch,
    math.Random? random,
  }) : _flight = flight,
       _random = random ?? math.Random();

  VerseFlight _flight;
  final math.Random _random;

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

  /// Faster as the verse grows.
  double get _speed => size.x * (0.26 + 0.012 * _flight.caught);

  @override
  Color backgroundColor() => AppColors.night;

  @override
  Future<void> onLoad() async {
    add(_Sky());
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
    final decoys = math.min(others.length, 1 + _random.nextInt(2));
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

/// The night behind: a few stars drifting slowly, and a golden glow low on
/// the horizon.
class _Sky extends Component with HasGameReference<VerseFlightGame> {
  final _stars = <(Vector2, double)>[];
  final _random = math.Random(7);

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
  }

  @override
  void render(Canvas canvas) {
    final size = game.size;
    final rect = Offset.zero & size.toSize();
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0B3B70), AppColors.night],
        ).createShader(rect),
    );
    canvas.drawCircle(
      Offset(size.x * 0.5, size.y * 1.05),
      size.x * 0.7,
      Paint()
        ..shader =
            RadialGradient(
              colors: [
                AppColors.gold.withValues(alpha: 0.22),
                AppColors.gold.withValues(alpha: 0),
              ],
            ).createShader(
              Rect.fromCircle(
                center: Offset(size.x * 0.5, size.y * 1.05),
                radius: size.x * 0.7,
              ),
            ),
    );
    final star = Paint()..color = Colors.white.withValues(alpha: 0.7);
    for (final (position, depth) in _stars) {
      canvas.drawCircle(
        Offset(position.x * size.x, position.y * size.y),
        depth * 0.9,
        star,
      );
    }
  }
}
