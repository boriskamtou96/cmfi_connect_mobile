import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../routing/app_router.dart';
import '../../prayer/application/retreats.dart';
import '../../prayer/presentation/prayer_screen.dart';
import '../application/land.dart';
import '../application/nations.dart';
import 'widgets/nation_globe.dart';

const _onNight = Colors.white;
const _onNightMuted = AppColors.onPrimaryMuted;

/// Notre ministère › Notre but: the three goals of the ministry, one screen
/// each, swiped. Each has its picture, drawn when its screen shows (once:
/// nothing moves on its own afterwards) and its numbers counting up.
@RoutePage()
class PurposeScreen extends HookWidget {
  const PurposeScreen({super.key});

  static const goals = 3;

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry;
    final controller = usePageController();
    final page = useState(0);

    void go(int index) => controller.animateToPage(
      index,
      duration: AppMotion.of(context, AppMotion.slow),
      curve: AppMotion.standard,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primaryDeep,
        body: Stack(
          children: [
            const Positioned.fill(
              child: RepaintBoundary(
                child: CustomPaint(painter: _SkyPainter()),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const IconTheme(
                        data: IconThemeData(color: _onNight),
                        child: AppBackButton(),
                      ),
                      Expanded(
                        child: Text(
                          t.goalOf(n: page.value + 1, total: goals),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.4,
                            color: AppColors.goldLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: controller,
                      onPageChanged: (index) => page.value = index,
                      children: [
                        _CrusadeGoal(active: page.value == 0),
                        _DisciplesGoal(active: page.value == 1),
                        _RevivalGoal(active: page.value == 2),
                      ],
                    ),
                  ),
                  _Footer(
                    page: page.value,
                    onPrevious: page.value == 0
                        ? null
                        : () => go(page.value - 1),
                    onNext: page.value == goals - 1
                        ? null
                        : () => go(page.value + 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The picture of a goal plays once each time its screen shows.
AnimationController _usePlayWhen(BuildContext context, {required bool active}) {
  final controller = useAnimationController(
    duration: const Duration(milliseconds: 2600),
  );
  useEffect(() {
    if (!active) {
      return null;
    }
    if (AppMotion.reduced(context)) {
      controller.value = 1;
    } else {
      controller.forward(from: 0);
    }
    return null;
  }, [active]);
  return controller;
}

/// What every goal shows: its picture, its numbers, its title and text, and
/// what can be touched.
class _GoalLayout extends StatelessWidget {
  const _GoalLayout({
    required this.art,
    required this.numbers,
    required this.title,
    required this.text,
    this.extra,
  });

  final Widget art;
  final Widget numbers;
  final String title;
  final String text;
  final Widget? extra;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.sm,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExcludeSemantics(child: AspectRatio(aspectRatio: 1.1, child: art)),
          const SizedBox(height: AppSpacing.md),
          numbers,
          const SizedBox(height: AppSpacing.lg),
          Semantics(
            header: true,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                height: 1.15,
                fontWeight: FontWeight.w800,
                color: _onNight,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              height: 1.55,
              color: _onNightMuted,
            ),
          ),
          if (extra case final extra?) ...[
            const SizedBox(height: AppSpacing.lg),
            extra,
          ],
        ],
      ),
    );
  }
}

/// A number counting up with the picture ("10 milliards"), and what it
/// counts.
class _Count extends StatelessWidget {
  const _Count({
    required this.value,
    required this.caption,
    required this.progress,
    this.big = true,
  });

  final double value;
  final String caption;
  final Animation<double> progress;
  final bool big;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return AnimatedBuilder(
      animation: progress,
      builder: (context, _) {
        final shown = value * Curves.easeOutCubic.transform(progress.value);
        final text = NumberFormat.compactLong(
          locale: locale,
        ).format(shown.round());
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.goldLight, AppColors.gold],
              ).createShader(bounds),
              // a long number shrinks rather than going on two lines
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: big ? 38 : 22,
                    height: 1.05,
                    fontWeight: FontWeight.w800,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ),
            Text(
              caption,
              style: TextStyle(
                fontSize: big ? 15 : 12,
                fontWeight: FontWeight.w600,
                color: _onNight,
              ),
            ),
          ],
        );
      },
    );
  }
}

// ----- 1. The every-creature gospel crusade -----

enum _Media { books, tracts, magazines, cds, dvds, radio, tv, internet }

extension on _Media {
  IconData get icon => switch (this) {
    _Media.books => AppIcons.mediaBooks,
    _Media.tracts => AppIcons.mediaTracts,
    _Media.magazines => AppIcons.mediaMagazines,
    _Media.cds => AppIcons.mediaCds,
    _Media.dvds => AppIcons.mediaDvds,
    _Media.radio => AppIcons.mediaRadio,
    _Media.tv => AppIcons.mediaTv,
    _Media.internet => AppIcons.mediaInternet,
  };

  String label(Translations t) => t.ministry.media[name]!;
}

class _CrusadeGoal extends HookConsumerWidget {
  const _CrusadeGoal({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final play = _usePlayWhen(context, active: active);
    final pulse = useAnimationController(duration: AppMotion.celebration);
    final chosen = useState<_Media?>(null);
    final nations = ref.watch(nationsProvider).value ?? const [];
    final land = ref.watch(landDotsProvider).value ?? const [];

    void choose(_Media media) {
      chosen.value = media;
      if (AppMotion.reduced(context)) {
        pulse.value = 1;
      } else {
        pulse.forward(from: 0);
      }
    }

    return _GoalLayout(
      art: LayoutBuilder(
        builder: (context, constraints) {
          final size = constraints.biggest;
          final center = size.center(Offset.zero);
          final globe = size.shortestSide * 0.48;
          final orbit = size.shortestSide * 0.42;
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _WavesPainter(
                    play: play,
                    pulse: pulse,
                    from: chosen.value == null
                        ? null
                        : _orbitPoint(center, orbit, chosen.value!.index),
                  ),
                ),
              ),
              Positioned(
                left: center.dx - globe / 2,
                top: center.dy - globe / 2,
                width: globe,
                height: globe,
                child: AbsorbPointer(
                  child: NationGlobe(
                    nations: nations,
                    land: land,
                    selected: null,
                    onSelect: (_) {},
                    semanticLabel: '',
                  ),
                ),
              ),
              for (final media in _Media.values)
                _OrbitIcon(
                  media: media,
                  at: _orbitPoint(center, orbit, media.index),
                  play: play,
                  chosen: chosen.value == media,
                  onTap: () => choose(media),
                ),
            ],
          );
        },
      ),
      numbers: _Count(
        value: 10e9,
        caption: t.ministry.goals.crusade.reached,
        progress: play,
      ),
      title: t.ministry.goals.crusade.title,
      text: t.ministry.goals.crusade.text,
      extra: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final media in _Media.values)
            _Chip(
              icon: media.icon,
              label: media.label(t),
              selected: chosen.value == media,
              onTap: () => choose(media),
            ),
        ],
      ),
    );
  }
}

Offset _orbitPoint(Offset center, double radius, int index) {
  final angle = -math.pi / 2 + index * 2 * math.pi / _Media.values.length;
  return center + Offset(math.cos(angle), math.sin(angle)) * radius;
}

/// A means of communication on the orbit of the globe: it comes in its
/// turn, and grows when chosen.
class _OrbitIcon extends StatelessWidget {
  const _OrbitIcon({
    required this.media,
    required this.at,
    required this.play,
    required this.chosen,
    required this.onTap,
  });

  final _Media media;
  final Offset at;
  final Animation<double> play;
  final bool chosen;
  final VoidCallback onTap;

  static const size = 40.0;

  @override
  Widget build(BuildContext context) {
    final start = 0.25 + media.index * 0.06;
    final appear = CurvedAnimation(
      parent: play,
      curve: Interval(start, math.min(1, start + 0.25), curve: AppMotion.pop),
    );
    return Positioned(
      left: at.dx - size / 2,
      top: at.dy - size / 2,
      child: ScaleTransition(
        scale: appear,
        child: AnimatedScale(
          scale: chosen ? 1.3 : 1,
          duration: AppMotion.of(context, AppMotion.medium),
          curve: AppMotion.pop,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              width: size,
              height: size,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: chosen ? AppColors.gold : const Color(0xFF0E3566),
                border: Border.all(
                  color: AppColors.gold.withValues(alpha: chosen ? 1 : 0.6),
                ),
              ),
              child: PhosphorIcon(
                media.icon,
                size: 22,
                color: chosen ? AppColors.ink : AppColors.goldLight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The gospel going out: golden waves from the globe; a chosen means sends
/// its own.
class _WavesPainter extends CustomPainter {
  _WavesPainter({required this.play, required this.pulse, required this.from})
    : super(repaint: Listenable.merge([play, pulse]));

  final Animation<double> play;
  final Animation<double> pulse;
  final Offset? from;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final reach = size.shortestSide * 0.55;
    final ring = Paint()..style = PaintingStyle.stroke;
    for (var i = 0; i < 3; i++) {
      final t = ((play.value - i * 0.18) / 0.7).clamp(0.0, 1.0);
      if (t == 0) {
        continue;
      }
      final radius =
          size.shortestSide * 0.24 +
          (reach - size.shortestSide * 0.24) * Curves.easeOut.transform(t);
      ring
        ..strokeWidth = 2.4 * (1 - t) + 0.6
        ..color = AppColors.gold.withValues(alpha: 0.55 * (1 - t) + 0.08);
      canvas.drawCircle(center, radius, ring);
    }
    // a glow under the globe
    canvas.drawCircle(
      center,
      size.shortestSide * 0.3,
      Paint()
        ..shader =
            RadialGradient(
              colors: [
                AppColors.gold.withValues(alpha: 0.28 * play.value),
                AppColors.gold.withValues(alpha: 0),
              ],
            ).createShader(
              Rect.fromCircle(center: center, radius: size.shortestSide * 0.3),
            ),
    );
    if (from case final origin? when pulse.value > 0 && pulse.value < 1) {
      for (var i = 0; i < 2; i++) {
        final t = ((pulse.value - i * 0.2) / 0.8).clamp(0.0, 1.0);
        ring
          ..strokeWidth = 2 * (1 - t) + 0.5
          ..color = AppColors.goldLight.withValues(alpha: 0.8 * (1 - t));
        canvas.drawCircle(origin, 20 + 80 * Curves.easeOut.transform(t), ring);
      }
    }
  }

  @override
  bool shouldRepaint(_WavesPainter old) => old.from != from;
}

// ----- 2. The training of disciples -----

enum _Figure { people, nations, churches }

class _DisciplesGoal extends HookWidget {
  const _DisciplesGoal({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry.goals.disciples;
    final play = _usePlayWhen(context, active: active);
    final focus = useState<_Figure?>(null);

    Widget figure(_Figure which, double value, String caption) => Expanded(
      child: GestureDetector(
        onTap: () => focus.value = focus.value == which ? null : which,
        child: AnimatedContainer(
          duration: AppMotion.of(context, AppMotion.fast),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            color: Colors.white.withValues(
              alpha: focus.value == which ? 0.16 : 0.07,
            ),
            border: Border.all(
              color: focus.value == which
                  ? AppColors.gold
                  : Colors.white.withValues(alpha: 0.16),
            ),
          ),
          child: _Count(
            value: value,
            caption: caption,
            progress: play,
            big: false,
          ),
        ),
      ),
    );

    return _GoalLayout(
      art: CustomPaint(
        painter: _HousesPainter(play: play, focus: focus.value),
      ),
      numbers: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                figure(_Figure.people, 1e9, t.people),
                const SizedBox(width: AppSpacing.sm),
                figure(_Figure.nations, 250, t.nations),
                const SizedBox(width: AppSpacing.sm),
                figure(_Figure.churches, 25e6, t.churches),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _Timeline(play: play, label: t.by(year: 2065)),
        ],
      ),
      title: t.title,
      text: t.text,
    );
  }
}

/// From today to 2065.
class _Timeline extends StatelessWidget {
  const _Timeline({required this.play, required this.label});

  final Animation<double> play;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: play,
      builder: (context, _) {
        final t = Curves.easeInOut.transform(play.value);
        return Row(
          children: [
            Text(
              '${DateTime.now().year}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _onNightMuted,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) => Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * t,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.gold,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Positioned(
                      left: (constraints.maxWidth - 12) * t,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.goldLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.goldLight,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// One house church, then rings of others born from it, linked, full of
/// people.
class _HousesPainter extends CustomPainter {
  _HousesPainter({required this.play, required this.focus})
    : super(repaint: play);

  final Animation<double> play;
  final _Figure? focus;

  static const _rings = [6, 12, 22];

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final unit = size.shortestSide;
    final radii = [unit * 0.18, unit * 0.32, unit * 0.46];
    final random = math.Random(5);
    final link = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    // the nations: a faint ring around everything
    final nationsGlow = focus == _Figure.nations ? 0.9 : 0.25;
    canvas.drawCircle(
      center,
      unit * 0.5,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = focus == _Figure.nations ? 2.4 : 1
        ..color = AppColors.goldLight.withValues(
          alpha: nationsGlow * play.value,
        ),
    );

    var previous = <Offset>[center];
    for (var r = 0; r < _rings.length; r++) {
      final t = ((play.value - 0.15 - r * 0.22) / 0.35).clamp(0.0, 1.0);
      if (t == 0) {
        break;
      }
      final count = _rings[r];
      final points = [
        for (var i = 0; i < count; i++)
          center +
              Offset.fromDirection(
                -math.pi / 2 + (i + r * 0.5) * 2 * math.pi / count,
                radii[r],
              ),
      ];
      for (final point in points) {
        final parent = previous.reduce(
          (a, b) => (a - point).distance < (b - point).distance ? a : b,
        );
        link.color = AppColors.gold.withValues(alpha: 0.35 * t);
        canvas.drawLine(parent, Offset.lerp(parent, point, t)!, link);
      }
      final churchesGlow = focus == _Figure.churches;
      for (final point in points) {
        _house(
          canvas,
          point,
          unit * (0.05 - r * 0.01) * t,
          fill: (churchesGlow ? AppColors.goldLight : Colors.white).withValues(
            alpha: 0.9 * t,
          ),
        );
        // the people of each house
        final people = focus == _Figure.people;
        for (var p = 0; p < 4 - r; p++) {
          final dot =
              point +
              Offset.fromDirection(
                random.nextDouble() * 2 * math.pi,
                unit * 0.035,
              );
          canvas.drawCircle(
            dot,
            (people ? 2.4 : 1.4) * t,
            Paint()
              ..color = (people ? AppColors.goldLight : _onNightMuted)
                  .withValues(alpha: t),
          );
        }
      }
      previous = points;
    }
    // the first house, with its cross
    final first = Curves.easeOutBack.transform(
      (play.value / 0.25).clamp(0.0, 1.0),
    );
    _house(
      canvas,
      center,
      unit * 0.075 * first,
      fill: AppColors.gold,
      cross: true,
    );
  }

  static void _house(
    Canvas canvas,
    Offset at,
    double size, {
    required Color fill,
    bool cross = false,
  }) {
    if (size <= 0) {
      return;
    }
    final body = Rect.fromCenter(
      center: at + Offset(0, size * 0.35),
      width: size * 1.4,
      height: size * 0.95,
    );
    final roof = Path()
      ..moveTo(body.left - size * 0.15, body.top)
      ..lineTo(at.dx, body.top - size * 0.8)
      ..lineTo(body.right + size * 0.15, body.top)
      ..close();
    final paint = Paint()..color = fill;
    canvas
      ..drawRRect(
        RRect.fromRectAndRadius(body, Radius.circular(size * 0.08)),
        paint,
      )
      ..drawPath(roof, paint);
    if (cross) {
      final ink = Paint()..color = AppColors.primaryDeep;
      canvas
        ..drawRect(
          Rect.fromCenter(
            center: body.center,
            width: size * 0.16,
            height: size * 0.62,
          ),
          ink,
        )
        ..drawRect(
          Rect.fromCenter(
            center: body.center - Offset(0, size * 0.1),
            width: size * 0.46,
            height: size * 0.14,
          ),
          ink,
        );
    }
  }

  @override
  bool shouldRepaint(_HousesPainter old) => old.focus != focus;
}

// ----- 3. Hastening the global revival -----

class _RevivalGoal extends HookWidget {
  const _RevivalGoal({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry.goals.revival;
    final play = _usePlayWhen(context, active: active);

    return _GoalLayout(
      art: CustomPaint(painter: _RevivalPainter(play: play)),
      numbers: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _Chip(icon: AppIcons.fasting, label: t.fasting),
          _Chip(icon: AppIcons.intercession, label: t.intercession),
        ],
      ),
      title: t.title,
      text: t.text,
      extra: const _PrayNow(),
    );
  }
}

/// The retreat of the moment: praying for the revival now.
class _PrayNow extends ConsumerWidget {
  const _PrayNow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moment = nextRetreat(
      ref.watch(retreatsTodayProvider),
      DateTime.now(),
    );
    return FilledButton.icon(
      onPressed: () => moment == null
          ? context.navigateTo(const PrayerRoute())
          : context.router.push(RetreatRoute(moment: moment)),
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.ink,
        minimumSize: const Size.fromHeight(52),
        textStyle: const TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
      icon: const PhosphorIcon(AppIcons.prayNow, size: 20),
      label: Text(context.t.ministry.goals.revival.pray),
    );
  }
}

/// The heavens torn open: light pouring down, the earth shaken once, and
/// the lamp of the Bride, ready.
class _RevivalPainter extends CustomPainter {
  _RevivalPainter({required this.play}) : super(repaint: play);

  final Animation<double> play;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final t = play.value;
    final open = Curves.easeInOutCubic.transform(
      ((t - 0.05) / 0.45).clamp(0.0, 1.0),
    );
    final top = Offset(w / 2, h * 0.08);

    // the rays, fanning down from the tear
    final rays = Paint();
    for (var i = -4; i <= 4; i++) {
      final angle = math.pi / 2 + i * 0.16;
      final end = top + Offset.fromDirection(angle, h * 1.1);
      final spread = 0.035;
      final path = Path()
        ..moveTo(top.dx, top.dy)
        ..lineTo(
          top.dx + math.cos(angle - spread) * h * 1.1,
          top.dy + math.sin(angle - spread) * h * 1.1,
        )
        ..lineTo(end.dx, end.dy)
        ..lineTo(
          top.dx + math.cos(angle + spread) * h * 1.1,
          top.dy + math.sin(angle + spread) * h * 1.1,
        )
        ..close();
      rays.shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.goldLight.withValues(alpha: 0.38 * open),
          AppColors.goldLight.withValues(alpha: 0),
        ],
      ).createShader(Rect.fromLTWH(0, top.dy, w, h));
      canvas.drawPath(path, rays);
    }

    // the tear in the sky: a lens of light widening
    final lens = Path()
      ..moveTo(top.dx, top.dy - h * 0.06)
      ..quadraticBezierTo(
        top.dx + w * 0.18 * open,
        top.dy,
        top.dx,
        top.dy + h * 0.06,
      )
      ..quadraticBezierTo(
        top.dx - w * 0.18 * open,
        top.dy,
        top.dx,
        top.dy - h * 0.06,
      )
      ..close();
    canvas
      ..drawPath(
        lens,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.9 * open)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      )
      ..drawPath(lens, Paint()..color = Colors.white.withValues(alpha: open));

    // light falling like rain
    final random = math.Random(9);
    final drop = Paint();
    for (var i = 0; i < 60; i++) {
      final x = w * (0.15 + random.nextDouble() * 0.7);
      final speed = 0.6 + random.nextDouble() * 0.6;
      final y =
          top.dy +
          (h * 0.75) *
              (((t - 0.3) * speed + random.nextDouble() * 0.4).clamp(0.0, 1.0));
      final alpha = (open * (1 - (y - top.dy) / (h * 0.85))).clamp(0.0, 1.0);
      drop.color = AppColors.goldLight.withValues(alpha: alpha * 0.9);
      canvas.drawCircle(Offset(x, y), 1.2 + random.nextDouble() * 1.6, drop);
    }

    // the earth, shaken once
    final shakeT = ((t - 0.45) / 0.3).clamp(0.0, 1.0);
    final shake = shakeT > 0 && shakeT < 1
        ? math.sin(shakeT * math.pi * 10) * 6 * (1 - shakeT)
        : 0.0;
    final earth = Rect.fromCenter(
      center: Offset(w / 2 + shake, h * 1.55),
      width: w * 2.2,
      height: h * 1.4,
    );
    canvas
      ..drawOval(earth, Paint()..color = const Color(0xFF0B2E58))
      ..drawOval(
        earth,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = AppColors.gold.withValues(alpha: 0.5 + 0.5 * open),
      );

    // the lamp of the Bride, lit
    final lit = Curves.easeOut.transform(((t - 0.6) / 0.4).clamp(0.0, 1.0));
    final base = Offset(w / 2 + shake, h * 0.8);
    final lamp = Path()
      ..moveTo(base.dx - w * 0.09, base.dy)
      ..quadraticBezierTo(
        base.dx,
        base.dy + h * 0.09,
        base.dx + w * 0.09,
        base.dy,
      )
      ..lineTo(base.dx + w * 0.14, base.dy - h * 0.015)
      ..lineTo(base.dx + w * 0.07, base.dy - h * 0.012)
      ..quadraticBezierTo(
        base.dx,
        base.dy - h * 0.03,
        base.dx - w * 0.07,
        base.dy - h * 0.012,
      )
      ..close();
    canvas.drawPath(lamp, Paint()..color = AppColors.gold);
    if (lit > 0) {
      final flame = Offset(base.dx - w * 0.07, base.dy - h * 0.05);
      canvas
        ..drawCircle(
          flame,
          h * 0.11 * lit,
          Paint()
            ..shader = RadialGradient(
              colors: [
                AppColors.goldLight.withValues(alpha: 0.55 * lit),
                AppColors.goldLight.withValues(alpha: 0),
              ],
            ).createShader(Rect.fromCircle(center: flame, radius: h * 0.11)),
        )
        ..drawPath(
          Path()
            ..moveTo(flame.dx, flame.dy - h * 0.05 * lit)
            ..quadraticBezierTo(
              flame.dx + w * 0.025 * lit,
              flame.dy,
              flame.dx,
              flame.dy + h * 0.02,
            )
            ..quadraticBezierTo(
              flame.dx - w * 0.025 * lit,
              flame.dy,
              flame.dx,
              flame.dy - h * 0.05 * lit,
            ),
          Paint()..color = Colors.white,
        );
    }
  }

  @override
  bool shouldRepaint(_RevivalPainter old) => false;
}

// ----- shared -----

/// A small pill on the night: a means, a way of praying.
class _Chip extends StatelessWidget {
  const _Chip({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.gold : Colors.white.withValues(alpha: 0.08),
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.gold.withValues(alpha: selected ? 1 : 0.4),
        ),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PhosphorIcon(
                icon,
                size: 16,
                color: selected ? AppColors.ink : AppColors.goldLight,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: selected ? AppColors.ink : _onNight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The dots of the three goals, and the buttons to go from one to the next.
class _Footer extends StatelessWidget {
  const _Footer({
    required this.page,
    required this.onPrevious,
    required this.onNext,
  });

  final int page;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final t = context.t.ministry;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        0,
        AppSpacing.sm,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: t.previousGoal,
            color: _onNight,
            onPressed: onPrevious,
            icon: const Icon(AppIcons.chevronLeft),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < PurposeScreen.goals; i++)
                  AnimatedContainer(
                    duration: AppMotion.of(context, AppMotion.fast),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == page ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == page
                          ? AppColors.gold
                          : Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            tooltip: t.nextGoal,
            color: _onNight,
            onPressed: onNext,
            icon: const Icon(AppIcons.chevronRight),
          ),
        ],
      ),
    );
  }
}

/// Stars, a little gold, thicker at the top.
class _SkyPainter extends CustomPainter {
  const _SkyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(21);
    final paint = Paint();
    for (var i = 0; i < 90; i++) {
      final y = math.pow(random.nextDouble(), 1.8) * size.height;
      final bright = random.nextDouble();
      paint.color = (bright > 0.9 ? AppColors.goldLight : Colors.white)
          .withValues(
            alpha: (0.1 + 0.45 * bright) * (1 - 0.7 * y / size.height),
          );
      canvas.drawCircle(
        Offset(random.nextDouble() * size.width, y.toDouble()),
        0.5 + bright,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_SkyPainter old) => false;
}
