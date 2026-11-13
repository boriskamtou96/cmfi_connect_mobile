import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/coming_soon_view.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/tab_page.dart';
import '../../../routing/app_router.dart';
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
/// other: the line winds.
const _wave = [0.0, -0.42, -0.62, -0.42, 0.0, 0.42, 0.62, 0.42];

class _Path extends ConsumerWidget {
  const _Path({required this.path});

  final GamePath path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final player = path.player;

    void open(GameLessonSummary lesson) {
      if (lesson.state == LessonState.locked) {
        ref.read(toasterProvider).of(context).info(t.games.locked);
        return;
      }
      context.router.push(LessonRoute(lessonId: lesson.id));
    }

    var index = 0;
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
                        icon: AppIcons.goal,
                        color: scheme.primary,
                        text: t.games.goal(
                          done: player.pointsToday,
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
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 10),
                child: Row(
                  children: [
                    for (final course in path.courses) ...[
                      Expanded(
                        child: GameChip(
                          title: course.title,
                          selected: course.code == path.course,
                          onTap: () => ref
                              .read(selectedGameCourseProvider.notifier)
                              .select(course.code),
                        ),
                      ),
                      if (course != path.courses.last) const SizedBox(width: 8),
                    ],
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
                    ),
                    for (final level in path.levels) ...[
                      _LevelBanner(level: level),
                      for (final lesson in level.lessons)
                        _LessonRow(
                          lesson: lesson,
                          shift: _wave[index++ % _wave.length],
                          onTap: () => open(lesson),
                        ),
                      const SizedBox(height: AppSpacing.md),
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

/// The banner of a level, in its color: where the member is in it, its
/// title, what it is about.
class _LevelBanner extends StatelessWidget {
  const _LevelBanner({required this.level});

  final GameLevel level;

  /// #RRGGBB as the server gives it; the night blue when it is not one.
  static Color _color(String hex) {
    final value = int.tryParse(hex.replaceFirst('#', ''), radix: 16);
    return value == null || hex.length != 7
        ? const Color(0xFF0B3B70)
        : Color(0xFF000000 | value);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final color = _color(level.color);
    final done = level.lessons
        .where((lesson) => lesson.state == LessonState.done)
        .length;

    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 18),
      padding: const EdgeInsetsDirectional.fromSTEB(18, 14, 18, 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: gameEdge(color), offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.games
                .levelOf(
                  n: level.position,
                  done: done,
                  total: level.lessons.length,
                )
                .toUpperCase(),
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
              color: Colors.white.withValues(alpha: 0.78),
            ),
          ),
          const SizedBox(height: 3),
          Semantics(
            header: true,
            child: Text(
              level.title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
                color: Colors.white,
              ),
            ),
          ),
          if (level.description.isNotEmpty) ...[
            const SizedBox(height: 3),
            Text(
              level.description,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.3,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A lesson on the winding line. The one to play has « COMMENCER » above it
/// and Zoé on the other side, who cheers.
class _LessonRow extends StatelessWidget {
  const _LessonRow({
    required this.lesson,
    required this.shift,
    required this.onTap,
  });

  final GameLessonSummary lesson;

  /// From -1 (the left edge) to 1.
  final double shift;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final open = lesson.state == LessonState.open;
    final label = switch (lesson.state) {
      LessonState.done => '${lesson.title}, ${t.games.lessonDone}',
      LessonState.open => '${lesson.title}, ${t.games.start}',
      LessonState.locked => '${lesson.title}, ${t.games.lessonLocked}',
    };

    final node = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (open)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: scheme.outlineVariant, width: 2),
              boxShadow: [
                BoxShadow(
                  color: scheme.outlineVariant,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              t.games.start.toUpperCase(),
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                color: scheme.primary,
              ),
            ),
          ),
        PathNode(
          state: lesson.state,
          stars: lesson.stars,
          label: label,
          onTap: onTap,
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 28),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (open)
            Align(
              alignment: Alignment(shift > 0 ? -0.9 : 0.9, 0),
              child: const ExcludeSemantics(
                child: DoveMascot(pose: DovePose.cheer, size: 84),
              ),
            ),
          Align(alignment: Alignment(shift, 0), child: node),
        ],
      ),
    );
  }
}

/// Above the path: the challenge of the day (once a first lesson is done)
/// and the way to the leaderboard, with the rank of the week when the
/// member is in it.
class _Extras extends StatelessWidget {
  const _Extras({
    required this.player,
    required this.onDaily,
    required this.onBoard,
  });

  final GamePlayer player;
  final VoidCallback onDaily;
  final VoidCallback onBoard;

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
            row(
              icon: AppIcons.leaderboard,
              color: scheme.primary,
              title: t.games.leaderboard,
              text: rank == null ? t.games.seeBoard : t.games.rank(n: rank),
              onTap: onBoard,
            ),
          ],
        ),
      ),
    );
  }
}
