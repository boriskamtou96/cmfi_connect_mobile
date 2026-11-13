import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/coming_soon_view.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/tab_page.dart';
import '../../../routing/app_router.dart';
import '../application/game_downloads.dart';
import '../application/game_path.dart';
import '../domain/game.dart';
import 'widgets/game_chip.dart';
import 'widgets/game_widgets.dart';

/// The games, the tab in the middle (12/11/2026): the path of a course
/// (« Notre ministère », « La Bible »), its levels and their lessons as round
/// buttons along a winding line, in the manner of Duolingo with our colors
/// and Zoé. At the top, the streak of days, the points, the goal of the day
/// and the level of the player. « Bientôt disponible » while no course is
/// published. Spec: docs/specs/jeux.md.
@RoutePage()
class GamesScreen extends ConsumerWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final path = ref.watch(gamePathProvider);

    // the path stays on the screen while it is read again
    if (path.value case final value?) {
      return _Path(path: value);
    }
    if (path.hasError) {
      return TabPage(
        title: t.nav.games,
        child: ErrorView(
          error: path.error!,
          onRetry: () => ref.invalidate(gamePathProvider),
        ),
      );
    }
    if (path.isLoading) {
      return TabPage(
        title: t.nav.games,
        child: const Center(child: AppSpinner()),
      );
    }
    return TabPage(
      title: t.nav.games,
      child: ComingSoonView(
        module: AppModule.reports,
        icon: const Icon(AppIcons.gamesActive),
        title: t.games.soonTitle,
        message: t.games.soonText,
      ),
    );
  }
}

/// How far each lesson stands from the middle of the path, one after the
/// other: the road winds, and each title takes the side with more room.
const _wave = [0.0, -0.45, -0.6, -0.3, 0.15, 0.5, 0.6, 0.3];

class _Path extends ConsumerWidget {
  const _Path({required this.path});

  final GamePath path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final player = path.player;
    final goalReached =
        player.dailyGoal > 0 && player.pointsToday >= player.dailyGoal;

    void open(GameLessonSummary lesson) {
      if (lesson.state == LessonState.locked) {
        ref.read(toasterProvider).of(context).info(t.games.locked);
        return;
      }
      context.router.push(LessonRoute(lessonId: lesson.id));
    }

    final downloads = ref.watch(gameDownloadsProvider).value;
    final kept = downloads?.courses.contains(path.course) ?? false;
    final loading = downloads?.loading == path.course;
    final lessonCount = path.levels.fold(
      0,
      (sum, level) => sum + level.lessons.length,
    );

    Future<void> offline() async {
      if (loading) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final downloads = ref.read(gameDownloadsProvider.notifier);
      if (kept) {
        final choice = await showActionSheet<bool>(
          context,
          title: t.games.offlineKept,
          actions: [
            AdaptiveAction(
              value: true,
              label: t.games.offlineUpdate,
              icon: AppIcons.downloadOffline,
            ),
            AdaptiveAction(
              value: false,
              label: t.games.offlineRemove,
              icon: AppIcons.delete,
              destructive: true,
            ),
          ],
        );
        if (choice == false) {
          await downloads.remove(path.course);
          return;
        }
        if (choice == null) {
          return;
        }
      }
      try {
        await downloads.download(path.course);
        toast.success(t.games.offlineDone);
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      }
    }

    // where each level starts on the road, for the wave to go on
    final firstOf = <int>[];
    var count = 0;
    for (final level in path.levels) {
      firstOf.add(count);
      count += level.lessons.length;
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // the player: streak, points, goal of the day, level
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 14, 20, 10),
              // on a narrow screen (or with big letters) the line shrinks
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.sizeOf(context).width - 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GameStat(
                        icon: AppIcons.streak,
                        color: player.playedToday
                            ? AppColors.gold
                            : scheme.onSurfaceVariant,
                        text: '${player.streakDays}',
                        label:
                            '${t.games.streakLabel} : '
                            '${t.games.streak(n: player.streakDays)}',
                      ),
                      const SizedBox(width: 14),
                      GameStat(
                        icon: AppIcons.starFilled,
                        color: AppColors.gold,
                        text: '${player.totalPoints}',
                        label: t.games.pointsLabel(n: player.totalPoints),
                      ),
                      const SizedBox(width: 14),
                      GameStat(
                        icon: goalReached
                            ? AppIcons.goalReached
                            : AppIcons.goal,
                        color: goalReached ? AppColors.gold : scheme.primary,
                        // past the goal, it stays « 50 sur 50 »: the points
                        // of the day are in the star next to it
                        text: t.games.goal(
                          done: goalReached
                              ? player.dailyGoal
                              : player.pointsToday,
                          goal: player.dailyGoal,
                        ),
                        label: t.games.goalLabel(
                          done: player.pointsToday,
                          goal: player.dailyGoal,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          t.games.level(n: player.level),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: scheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (path.courses.length > 1)
              _CourseChips(
                courses: path.courses,
                selected: path.course,
                onSelect: (code) =>
                    ref.read(selectedGameCourseProvider.notifier).select(code),
              ),
            if (path.offline)
              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
                padding: const EdgeInsetsDirectional.fromSTEB(12, 9, 12, 9),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      AppIcons.offline,
                      size: 18,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        t.games.offlineBanner,
                        style: TextStyle(
                          fontSize: 13,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: RefreshIndicator.adaptive(
                onRefresh: () => ref.refresh(gamePathProvider.future),
                child: ListView(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                  children: [
                    _Extras(
                      player: player,
                      onDaily: () {
                        if (player.dailyDone) {
                          ref
                              .read(toasterProvider)
                              .of(context)
                              .info(t.games.dailyDone);
                          return;
                        }
                        context.router.push(
                          LessonRoute(lessonId: dailyLessonId),
                        );
                      },
                      onBoard: () =>
                          context.router.push(const LeaderboardRoute()),
                      onFlight: () =>
                          context.router.push(const VerseFlightRoute()),
                      offline: (
                        kept: kept,
                        loading: loading,
                        lessons: lessonCount,
                        onTap: offline,
                      ),
                    ),
                    for (final (l, level) in path.levels.indexed) ...[
                      _LevelBanner(level: level),
                      for (final (i, lesson) in level.lessons.indexed)
                        _LessonRow(
                          lesson: lesson,
                          shift: _wave[(firstOf[l] + i) % _wave.length],
                          previous: i == 0
                              ? null
                              : (
                                  shift:
                                      _wave[(firstOf[l] + i - 1) %
                                          _wave.length],
                                  done:
                                      level.lessons[i - 1].state ==
                                      LessonState.done,
                                ),
                          nextShift: i == level.lessons.length - 1
                              ? null
                              : _wave[(firstOf[l] + i + 1) % _wave.length],
                          onTap: () => open(lesson),
                        ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// #RRGGBB as the server gives it; the night blue when it is not one.
Color _levelColor(String hex) {
  final value = int.tryParse(hex.replaceFirst('#', ''), radix: 16);
  return value == null || hex.length != 7
      ? const Color(0xFF0B3B70)
      : Color(0xFF000000 | value);
}

/// A level as a chapter of the journey, in its color: its number large in
/// Lora behind, where the member is, its title and what it is about, then a
/// segment per lesson (gold once done) and the stars won.
class _LevelBanner extends StatelessWidget {
  const _LevelBanner({required this.level});

  final GameLevel level;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final color = _levelColor(level.color);
    final lessons = level.lessons;
    final done = lessons
        .where((lesson) => lesson.state == LessonState.done)
        .length;
    final stars = lessons.fold(0, (sum, lesson) => sum + lesson.stars);
    final soft = Colors.white.withValues(alpha: 0.78);

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 14),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(color: gameEdge(color), offset: const Offset(0, 5)),
        ],
      ),
      child: Stack(
        children: [
          // the number of the chapter, large and faint
          PositionedDirectional(
            end: -6,
            top: -28,
            child: ExcludeSemantics(
              child: Text(
                '${level.position}',
                style: TextStyle(
                  fontFamily: 'Lora',
                  fontSize: 128,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(18, 16, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.games
                      .levelOf(
                        n: level.position,
                        done: done,
                        total: lessons.length,
                      )
                      .toUpperCase(),
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: soft,
                  ),
                ),
                const SizedBox(height: 4),
                Semantics(
                  header: true,
                  child: Text(
                    level.title,
                    style: const TextStyle(
                      fontFamily: 'Lora',
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                      color: Colors.white,
                    ),
                  ),
                ),
                if (level.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    level.description,
                    style: TextStyle(fontSize: 13.5, height: 1.3, color: soft),
                  ),
                ],
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: ExcludeSemantics(
                        child: Row(
                          children: [
                            for (final (i, lesson) in lessons.indexed) ...[
                              if (i > 0) const SizedBox(width: 4),
                              Expanded(
                                child: Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: lesson.state == LessonState.done
                                        ? AppColors.gold
                                        : Colors.white.withValues(alpha: 0.22),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Semantics(
                      label: t.games.levelStars(
                        stars: stars,
                        total: lessons.length * 3,
                      ),
                      excludeSemantics: true,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            AppIcons.starFilled,
                            size: 15,
                            color: AppColors.gold,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$stars/${lessons.length * 3}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The lesson before on the road: where it stands, and whether it is done.
typedef _Neighbour = ({double shift, bool done});

/// The square a lesson's button sits in, on the road.
const _nodeBox = 96.0;

/// A lesson on the road: its round button, and its title on the side with
/// more room (with its stars once done). The road comes from the lesson
/// before and goes on to the next one: gold where it has been walked,
/// dotted where it has not. On the one to play, Zoé says « Commencer ».
class _LessonRow extends StatelessWidget {
  const _LessonRow({
    required this.lesson,
    required this.shift,
    required this.previous,
    required this.nextShift,
    required this.onTap,
  });

  final GameLessonSummary lesson;

  /// From -1 (the left edge) to 1.
  final double shift;
  final _Neighbour? previous;
  final double? nextShift;
  final VoidCallback onTap;

  static const _side = 20.0;

  /// The middle of the button for [shift], in a row [width] wide.
  static double _center(double width, double shift) =>
      _side + (width - 2 * _side - _nodeBox) / 2 * (1 + shift) + _nodeBox / 2;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final done = lesson.state == LessonState.done;
    final open = lesson.state == LessonState.open;
    final locked = lesson.state == LessonState.locked;
    final label = switch (lesson.state) {
      LessonState.done => '${lesson.title}, ${t.games.lessonDone}',
      LessonState.open => '${lesson.title}, ${t.games.start}',
      LessonState.locked => '${lesson.title}, ${t.games.lessonLocked}',
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final x = _center(width, shift);
        // the title on the side with more room
        final titleAfter = x <= width / 2;
        final gap = _nodeBox / 2 + 4;

        final title = Column(
          crossAxisAlignment: titleAfter
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (open)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                // in a narrow place, « Commencer » goes under Zoé
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  runSpacing: 2,
                  children: [
                    const ExcludeSemantics(
                      child: DoveMascot(pose: DovePose.cheer, size: 40),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        t.games.start.toUpperCase(),
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                          color: scheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Text(
              lesson.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: titleAfter ? TextAlign.start : TextAlign.end,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                height: 1.25,
                color: locked ? scheme.onSurfaceVariant : scheme.onSurface,
              ),
            ),
            if (done) ...[
              const SizedBox(height: 3),
              GameStars(stars: lesson.stars, size: 14),
            ],
          ],
        );

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _RoadPainter(
                    x: x,
                    previousX: switch (previous) {
                      final before? => _center(width, before.shift),
                      null => null,
                    },
                    nextX: switch (nextShift) {
                      final after? => _center(width, after),
                      null => null,
                    },
                    walkedIn: previous?.done ?? false,
                    walkedOut: done,
                    walked: AppColors.gold,
                    ahead: scheme.outlineVariant,
                  ),
                ),
              ),
              // the title gives the row its height (at least the button's)
              Padding(
                padding: EdgeInsets.only(
                  left: titleAfter ? x + gap : _side,
                  right: titleAfter ? _side : width - x + gap,
                  top: 6,
                  bottom: 6,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: _nodeBox),
                  child: Align(
                    alignment: titleAfter
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: ExcludeSemantics(child: title),
                  ),
                ),
              ),
              Positioned(
                left: x - _nodeBox / 2,
                width: _nodeBox,
                top: 0,
                bottom: 0,
                child: Center(
                  child: PathNode(
                    state: lesson.state,
                    stars: lesson.stars,
                    label: label,
                    withStars: false,
                    onTap: onTap,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// The road through a row: from halfway to the lesson before, down to the
/// button, on to halfway to the next one. Walked: gold and full; ahead:
/// dotted and pale.
class _RoadPainter extends CustomPainter {
  const _RoadPainter({
    required this.x,
    required this.previousX,
    required this.nextX,
    required this.walkedIn,
    required this.walkedOut,
    required this.walked,
    required this.ahead,
  });

  final double x;
  final double? previousX;
  final double? nextX;

  /// The part coming in was walked (the lesson before is done), and the part
  /// going out (this one is).
  final bool walkedIn;
  final bool walkedOut;
  final Color walked;
  final Color ahead;

  static const _width = 9.0;

  @override
  void paint(Canvas canvas, Size size) {
    final middle = size.height / 2;
    if (previousX case final before?) {
      final from = Offset((before + x) / 2, 0);
      _draw(
        canvas,
        Path()
          ..moveTo(from.dx, from.dy)
          ..quadraticBezierTo(x, 0, x, middle),
        walkedIn,
      );
    }
    if (nextX case final after?) {
      final to = Offset((after + x) / 2, size.height);
      _draw(
        canvas,
        Path()
          ..moveTo(x, middle)
          ..quadraticBezierTo(x, size.height, to.dx, to.dy),
        walkedOut,
      );
    }
  }

  void _draw(Canvas canvas, Path path, bool done) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = _width
      ..color = done ? walked : ahead;
    if (done) {
      canvas.drawPath(path, paint);
      return;
    }
    // dotted: short dashes along the way
    for (final metric in path.computeMetrics()) {
      for (var at = 0.0; at < metric.length; at += 18) {
        canvas.drawPath(
          metric.extractPath(at, (at + 2).clamp(0, metric.length)),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_RoadPainter old) =>
      old.x != x ||
      old.previousX != previousX ||
      old.nextX != nextX ||
      old.walkedIn != walkedIn ||
      old.walkedOut != walkedOut ||
      old.walked != walked ||
      old.ahead != ahead;
}

/// Above the path: the challenge of the day (once a first lesson is done)
/// and the way to the leaderboard, with the rank of the week when the
/// member is in it.
class _Extras extends StatelessWidget {
  const _Extras({
    required this.player,
    required this.onDaily,
    required this.onBoard,
    required this.onFlight,
    required this.offline,
  });

  final GamePlayer player;
  final VoidCallback onDaily;
  final VoidCallback onBoard;

  /// « Verset en vol », the bonus game.
  final VoidCallback onFlight;

  /// « Jouer hors ligne »: the course is kept on the phone, or being
  /// downloaded; its number of lessons.
  final ({bool kept, bool loading, int lessons, VoidCallback onTap}) offline;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final rank = player.weekRank;

    Widget row({
      required IconData icon,
      required Color color,
      required String title,
      required String text,
      required VoidCallback onTap,
    }) => Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(14, 11, 10, 11),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(AppIcons.chevronRight, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(16, 2, 16, 14),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant, width: 2),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            // the challenge draws from the lessons done: none before the first
            if (player.totalPoints > 0) ...[
              row(
                icon: player.dailyDone
                    ? AppIcons.lessonDone
                    : AppIcons.lessonOpen,
                color: AppColors.gold,
                title: t.games.dailyTitle,
                text: player.dailyDone ? t.games.dailyDone : t.games.dailyText,
                onTap: onDaily,
              ),
              Divider(height: 2, thickness: 2, color: scheme.outlineVariant),
            ],
            // three tiles side by side: less height before the path
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _Tile(
                      icon: AppIcons.leaderboard,
                      color: scheme.primary,
                      title: t.games.leaderboard,
                      text: rank == null
                          ? t.games.seeBoard
                          : t.games.rank(n: rank),
                      onTap: onBoard,
                    ),
                  ),
                  VerticalDivider(
                    width: 2,
                    thickness: 2,
                    color: scheme.outlineVariant,
                  ),
                  Expanded(
                    child: _Tile(
                      icon: AppIcons.verseFlight,
                      color: AppColors.gold,
                      title: t.games.flightTitle,
                      text: t.games.flightShort,
                      label: t.games.flightText,
                      onTap: onFlight,
                    ),
                  ),
                  VerticalDivider(
                    width: 2,
                    thickness: 2,
                    color: scheme.outlineVariant,
                  ),
                  Expanded(
                    child: _Tile(
                      icon: offline.kept
                          ? AppIcons.downloaded
                          : AppIcons.downloadOffline,
                      color: offline.kept
                          ? AppColors.success
                          : scheme.onSurfaceVariant,
                      title: t.games.offlineTitle,
                      text: offline.loading
                          ? t.games.offlineLoading
                          : offline.kept
                          ? t.games.offlineKeptShort
                          : t.games.offlineShort(n: offline.lessons),
                      label: offline.loading
                          ? t.games.offlineLoading
                          : offline.kept
                          ? t.games.offlineKept
                          : t.games.offlineText(n: offline.lessons),
                      onTap: offline.onTap,
                    ),
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

/// The courses at the top of the path, in a row that scrolls sideways: each
/// title stays whole, however many courses there are (five squeezed into the
/// width only showed « Notr… »). The chosen one is brought into view.
class _CourseChips extends HookWidget {
  const _CourseChips({
    required this.courses,
    required this.selected,
    required this.onSelect,
  });

  final List<GameCourse> courses;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final chosen = useMemoized(GlobalKey.new);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final target = chosen.currentContext;
        if (target == null || !target.mounted) return;
        Scrollable.ensureVisible(
          target,
          alignment: 0.5,
          duration: AppMotion.of(context, AppMotion.medium),
          curve: AppMotion.standard,
        );
      });
      return null;
    }, [selected]);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
      child: Row(
        children: [
          for (final course in courses) ...[
            GameChip(
              key: course.code == selected ? chosen : null,
              title: course.title,
              selected: course.code == selected,
              onTap: () => onSelect(course.code),
            ),
            if (course != courses.last) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

/// A tile of the card above the path: its icon on a tint, its name, a short
/// line (the full sentence for screen readers, [label]).
class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.color,
    required this.title,
    required this.text,
    required this.onTap,
    this.label,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String text;
  final String? label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: '$title, ${label ?? text}',
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
          child: Column(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(icon, size: 19, color: color),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.5,
                  height: 1.2,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
