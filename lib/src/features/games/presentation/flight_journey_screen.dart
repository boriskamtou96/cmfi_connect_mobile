import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/animated_progress_bar.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../application/flight_journey.dart';
import '../domain/flight_journey.dart';
import '../domain/verse_flight.dart';
import 'widgets/game_widgets.dart';

/// « La conquête de Canaan » (18/11/2026): the map of the journey of
/// « Verset en vol », from Egypt to Canaan. A road goes down through the
/// twelve stages: gold where the player has been, dotted ahead, Zoé standing
/// on the stage to play. A stage opens once the one before is won; the
/// hearts kept at each one stay under its name. The free flight (a verse at
/// random) is one touch away.
@RoutePage()
class FlightJourneyScreen extends HookConsumerWidget {
  const FlightJourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final language = LocaleSettings.currentLocale.languageCode;
    final verses = ref.watch(journeyVersesProvider(language));
    final progress = ref.watch(flightJourneyProvider);

    return switch (verses) {
      AsyncData(:final value) => _Map(verses: value.verses, progress: progress),
      AsyncError(:final error) => SubPage(
        title: t.games.journey.title,
        child: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(journeyVersesProvider(language)),
        ),
      ),
      _ => const Scaffold(
        backgroundColor: AppColors.night,
        body: Center(child: AppSpinner(color: Colors.white)),
      ),
    };
  }
}

class _Map extends HookWidget {
  const _Map({required this.verses, required this.progress});

  final List<FlightVerse> verses;
  final JourneyProgress progress;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final texts = t.games.journey;
    final current = progress.current;
    final currentKey = useMemoized(GlobalKey.new);

    // the stage to play comes into view when the map opens, and when it
    // changes (back from a stage won)
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final target = currentKey.currentContext;
        if (target != null && target.mounted) {
          Scrollable.ensureVisible(
            target,
            alignment: 0.4,
            duration: AppMotion.of(context, AppMotion.medium),
          );
        }
      });
      return null;
    }, [current]);

    void play(int stage) => context.router.push(VerseFlightRoute(stage: stage));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.night,
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0B3B70), AppColors.night],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Header(progress: progress),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      child: _Road(
                        width: constraints.maxWidth,
                        verses: verses,
                        progress: progress,
                        currentKey: currentKey,
                        onPlay: play,
                      ),
                    ),
                  ),
                ),
                if (!progress.finished)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
                    child: Text(
                      texts.stories[current],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.3,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 10, 24, 4),
                  child: GameButton(
                    label: progress.finished
                        ? texts.free
                        : '${texts.play} · ${texts.places[current]}',
                    color: AppColors.gold,
                    foreground: AppColors.ink,
                    onPressed: progress.finished
                        ? () => context.router.push(VerseFlightRoute())
                        : () => play(current),
                  ),
                ),
                if (!progress.finished)
                  TextButton(
                    onPressed: () => context.router.push(VerseFlightRoute()),
                    child: Text(
                      '${texts.free} · ${texts.freeText}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                else
                  const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The way out, the name of the journey, and how far the player is: the
/// stage, the hearts kept, a golden bar.
class _Header extends StatelessWidget {
  const _Header({required this.progress});

  final JourneyProgress progress;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final texts = t.games.journey;
    final total = progress.length;
    final stage = math.min(progress.reached + 1, total);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                tooltip: t.games.flightDone,
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(AppIcons.close, color: Colors.white),
              ),
              Expanded(
                child: Text(
                  t.games.flightTitle.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    color: AppColors.gold.withValues(alpha: 0.9),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    texts.title,
                    style: const TextStyle(
                      fontFamily: 'Lora',
                      fontSize: 28,
                      height: 1.15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  texts.subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        texts.stage(n: stage, total: total),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Semantics(
                      label: t.games.flightHearts(n: progress.total),
                      excludeSemantics: true,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            AppIcons.heartFilled,
                            size: 16,
                            color: AppColors.gold,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            texts.kept(
                              n: progress.total,
                              total: total * JourneyProgress.maxHearts,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.gold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ExcludeSemantics(
                  child: AnimatedProgressBar(
                    value: progress.reached / total,
                    minHeight: 8,
                    color: AppColors.gold,
                    backgroundColor: Colors.white.withValues(alpha: 0.16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The road and its stages, one under the other, swaying from side to side.
/// A drawing: its sides do not turn with the reading direction.
class _Road extends StatelessWidget {
  const _Road({
    required this.width,
    required this.verses,
    required this.progress,
    required this.currentKey,
    required this.onPlay,
  });

  final double width;
  final List<FlightVerse> verses;
  final JourneyProgress progress;
  final GlobalKey currentKey;
  final ValueChanged<int> onPlay;

  static const _rowHeight = 118.0;
  static const _side = 56.0;

  /// The middle of the stop of [stage]: the road sways like a slow wave.
  Offset _center(int stage) => Offset(
    _side + (width - 2 * _side) * (0.5 + 0.5 * math.sin(stage * 1.25 + 0.6)),
    _rowHeight * (stage + 0.5),
  );

  @override
  Widget build(BuildContext context) {
    final count = progress.length;
    final centers = [for (var i = 0; i < count; i++) _center(i)];
    return SizedBox(
      width: width,
      height: _rowHeight * count,
      child: Stack(
        children: [
          Positioned.fill(
            child: ExcludeSemantics(
              child: CustomPaint(
                painter: _RoadPainter(
                  centers: centers,
                  walked: progress.reached,
                ),
              ),
            ),
          ),
          for (var i = 0; i < count; i++) _stage(context, i, centers[i]),
        ],
      ),
    );
  }

  Widget _stage(BuildContext context, int stage, Offset center) {
    final texts = context.t.games.journey;
    final place = texts.places[stage];
    final won = progress.isWon(stage);
    final open = progress.isOpen(stage);
    final current = stage == progress.current && !progress.finished;
    final labelAfter = center.dx < width / 2;
    final gap = _Stop.size / 2 + 14;
    return Positioned(
      key: current ? currentKey : null,
      top: center.dy - _rowHeight / 2,
      left: 0,
      right: 0,
      height: _rowHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: center.dx - _Stop.size / 2,
            top: (_rowHeight - _Stop.size) / 2,
            child: _Stop(
              label: won
                  ? texts.done(place: place)
                  : open
                  ? texts.open(place: place)
                  : texts.locked(place: place),
              won: won,
              open: open,
              current: current,
              onTap: open ? () => onPlay(stage) : null,
            ),
          ),
          if (current)
            Positioned(
              left:
                  center.dx +
                  (labelAfter ? -_Stop.size / 2 - 38 : _Stop.size / 2 - 6),
              top: (_rowHeight - _Stop.size) / 2 - 26,
              child: const ExcludeSemantics(
                child: IgnorePointer(
                  child: DoveMascot(pose: DovePose.cheer, size: 46),
                ),
              ),
            ),
          Positioned(
            left: labelAfter ? center.dx + gap : 16,
            right: labelAfter ? 16 : width - center.dx + gap,
            top: 0,
            bottom: 0,
            child: ExcludeSemantics(
              child: Align(
                alignment: labelAfter
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: _StageLabel(
                  place: place,
                  reference: verses[stage].reference,
                  hearts: progress.heartsOf(stage),
                  open: open,
                  alignEnd: !labelAfter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A stop of the road, a round button in relief: gold and checked once won,
/// white with a « play » when it is the one to play, dim and locked ahead.
class _Stop extends StatelessWidget {
  const _Stop({
    required this.label,
    required this.won,
    required this.open,
    required this.current,
    required this.onTap,
  });

  final String label;
  final bool won;
  final bool open;
  final bool current;
  final VoidCallback? onTap;

  static const size = 64.0;
  static const _depth = 5.0;

  @override
  Widget build(BuildContext context) {
    final (face, edge, ink, icon) = won
        ? (
            AppColors.gold,
            const Color(0xFFA9761C),
            AppColors.ink,
            AppIcons.lessonDone,
          )
        : open
        ? (
            Colors.white,
            const Color(0xFF9DB4D1),
            AppColors.primaryDeep,
            AppIcons.journeyPlay,
          )
        : (
            const Color(0xFF24456F),
            const Color(0xFF16304F),
            Colors.white.withValues(alpha: 0.45),
            AppIcons.lessonLocked,
          );
    return Semantics(
      button: open,
      enabled: open,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap == null
            ? null
            : () {
                HapticFeedback.selectionClick();
                onTap!();
              },
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              // the edge under the face: the relief of the games
              Positioned(
                left: 0,
                right: 0,
                top: _depth,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: edge,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: _depth,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: face,
                    shape: BoxShape.circle,
                    border: current
                        ? Border.all(color: AppColors.gold, width: 4)
                        : null,
                  ),
                  child: Icon(icon, size: 26, color: ink),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Beside a stop: the place, the verse flown there and the hearts kept.
class _StageLabel extends StatelessWidget {
  const _StageLabel({
    required this.place,
    required this.reference,
    required this.hearts,
    required this.open,
    required this.alignEnd,
  });

  final String place;
  final String reference;
  final int? hearts;
  final bool open;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    final align = alignEnd ? TextAlign.right : TextAlign.left;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          place,
          textAlign: align,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            height: 1.2,
            fontWeight: FontWeight.w800,
            color: Colors.white.withValues(alpha: open ? 1 : 0.45),
          ),
        ),
        if (open) ...[
          const SizedBox(height: 2),
          Text(
            reference,
            textAlign: align,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: AppColors.gold.withValues(alpha: 0.95),
            ),
          ),
        ],
        if (hearts case final kept?) ...[
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < JourneyProgress.maxHearts; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Icon(
                    AppIcons.heartFilled,
                    size: 14,
                    color: i < kept
                        ? AppColors.gold
                        : Colors.white.withValues(alpha: 0.2),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

/// The road from stop to stop: gold and full as far as the player has been,
/// dotted and pale ahead.
class _RoadPainter extends CustomPainter {
  const _RoadPainter({required this.centers, required this.walked});

  final List<Offset> centers;

  /// How many stages are won: the road is gold up to the stop of that index.
  final int walked;

  @override
  void paint(Canvas canvas, Size size) {
    final gold = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 9
      ..color = AppColors.gold;
    final ahead = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7
      ..color = Colors.white.withValues(alpha: 0.28);
    for (var i = 0; i + 1 < centers.length; i++) {
      final from = centers[i];
      final to = centers[i + 1];
      final middle = (from.dy + to.dy) / 2;
      final path = Path()
        ..moveTo(from.dx, from.dy)
        ..cubicTo(from.dx, middle, to.dx, middle, to.dx, to.dy);
      if (i < walked) {
        canvas.drawPath(path, gold);
        continue;
      }
      for (final metric in path.computeMetrics()) {
        for (var at = 0.0; at < metric.length; at += 18) {
          canvas.drawPath(
            metric.extractPath(at, math.min(at + 2, metric.length)),
            ahead,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(_RoadPainter old) =>
      old.walked != walked ||
      old.centers.length != centers.length ||
      (centers.isNotEmpty && old.centers.first != centers.first);
}
