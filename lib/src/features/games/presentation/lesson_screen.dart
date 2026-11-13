import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../application/lesson_controller.dart';
import '../application/lesson_play.dart';
import '../domain/game.dart';
import 'widgets/game_widgets.dart';

/// A lesson of the games, full screen: one question at a time, asked by
/// Zoé; a choice, « VÉRIFIER », the answer explained (right or to see again,
/// which comes back once at the end), « CONTINUER ». Then the lesson is sent
/// and the end shows what it gave. No lives, no clock. Leaving on the way
/// asks first: nothing is sent.
@RoutePage()
class LessonScreen extends ConsumerWidget {
  const LessonScreen({
    @PathParam('lessonId') required this.lessonId,
    super.key,
  });

  final int lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final session = ref.watch(lessonControllerProvider(lessonId));
    final controller = ref.read(lessonControllerProvider(lessonId).notifier);

    Future<void> quit() async {
      final leave = await showConfirmDialog(
        context,
        title: t.games.quitTitle,
        text: t.games.quitText,
        confirmLabel: t.games.quitConfirm,
        destructive: true,
      );
      if (leave && context.mounted) {
        Navigator.of(context).pop();
      }
    }

    return switch (session) {
      AsyncData(:final value) when value.result != null => _End(
        lesson: value.play.lesson,
        daily: lessonId == dailyLessonId,
        result: value.result!,
      ),
      AsyncData(:final value) => PopScope(
        // leaving a lesson under way (or not sent yet) asks first
        canPop: value.kept,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) {
            quit();
          }
        },
        child: value.play.finished
            ? _Sending(
                session: value,
                onRetry: controller.send,
                // a play kept leaves without a question: nothing is lost
                onQuit: value.kept ? () => Navigator.of(context).pop() : quit,
              )
            : _Question(
                play: value.play,
                tag: lessonId == dailyLessonId
                    ? t.games.dailyTitle
                    : value.play.lesson.levelTitle,
                onChoose: controller.choose,
                onCheck: controller.check,
                onNext: controller.next,
                onQuit: quit,
              ),
      ),
      AsyncError(:final error) => SubPage(
        title: t.nav.games,
        child: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(lessonControllerProvider(lessonId)),
        ),
      ),
      _ => const Scaffold(body: Center(child: AppSpinner())),
    };
  }
}

/// The page of Notre ministère a question comes from ("ministry:founder"),
/// null for the other sources.
PageRouteInfo<Object?>? _sourceRoute(String source) => switch (source) {
  'ministry:founder' => const FounderRoute(),
  'ministry:leader' => const LeaderRoute(),
  'ministry:purpose' => const PurposeRoute(),
  'ministry:nations' => const NationsRoute(),
  _ => null,
};

class _Question extends StatelessWidget {
  const _Question({
    required this.play,
    required this.tag,
    required this.onChoose,
    required this.onCheck,
    required this.onNext,
    required this.onQuit,
  });

  final LessonPlay play;

  /// Above the question: the level of the lesson, or the challenge.
  final String tag;
  final ValueChanged<String> onChoose;
  final VoidCallback onCheck;
  final VoidCallback onNext;
  final VoidCallback onQuit;

  ChoiceLook _look(GameQuestion question, GameChoice choice) {
    if (!play.checked) {
      return choice.id == play.selected ? ChoiceLook.selected : ChoiceLook.idle;
    }
    if (choice.id == question.answer) {
      return ChoiceLook.right;
    }
    return choice.id == play.selected ? ChoiceLook.wrong : ChoiceLook.faded;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final question = play.current!;
    final missing = AppTones.of(context).missing;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(4, 6, 16, 4),
              child: Row(
                children: [
                  IconButton(
                    tooltip: t.games.quit,
                    onPressed: onQuit,
                    icon: const Icon(AppIcons.close),
                  ),
                  Expanded(child: _ProgressBar(value: play.progress)),
                  // right answers in a row, from two
                  if (play.run >= 2) ...[
                    const SizedBox(width: 12),
                    const Icon(
                      AppIcons.streak,
                      size: 20,
                      color: AppColors.gold,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '${play.run}',
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.primaryContainer,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        (play.isRetry ? t.games.retry : tag).toUpperCase(),
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: scheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Zoé asks
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ExcludeSemantics(
                        child: DoveMascot(
                          pose: !play.checked
                              ? DovePose.joy
                              : play.isRight
                              ? DovePose.celebrate
                              : DovePose.cheer,
                          size: 68,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: scheme.outlineVariant,
                              width: 2,
                            ),
                          ),
                          child: Semantics(
                            header: true,
                            child: Text(
                              question.prompt,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  for (final choice in question.choices) ...[
                    ChoiceCard(
                      text: choice.text,
                      look: _look(question, choice),
                      onTap: play.checked ? null : () => onChoose(choice.id),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
            // what the check said, then the way on
            AnimatedSize(
              duration: const Duration(milliseconds: 180),
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                color: !play.checked
                    ? null
                    : (play.isRight ? AppColors.success : missing).withValues(
                        alpha: 0.14,
                      ),
                padding: EdgeInsets.fromLTRB(
                  20,
                  play.checked ? 16 : 8,
                  20,
                  MediaQuery.paddingOf(context).bottom + 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (play.checked) ...[
                      Semantics(
                        liveRegion: true,
                        child: Row(
                          children: [
                            Icon(
                              play.isRight ? AppIcons.right : AppIcons.wrong,
                              color: play.isRight ? AppColors.success : missing,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                play.isRight ? t.games.right : t.games.wrong,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                  color: play.isRight
                                      ? AppColors.success
                                      : missing,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!play.isRight) ...[
                        const SizedBox(height: 6),
                        Text(
                          t.games.rightAnswer(
                            answer: question.choices
                                .firstWhere(
                                  (choice) => choice.id == question.answer,
                                  orElse: () => question.choices.first,
                                )
                                .text,
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                      if (question.explanation.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          question.explanation,
                          style: TextStyle(
                            fontSize: 14.5,
                            height: 1.35,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      if (_sourceRoute(question.source) case final route?)
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: TextButton(
                            onPressed: () => context.router.push(route),
                            child: Text(
                              t.games.readIn(place: t.ministry.title),
                            ),
                          ),
                        ),
                      const SizedBox(height: 14),
                      GameButton(
                        label: t.games.next,
                        color: play.isRight ? AppColors.success : null,
                        foreground: play.isRight ? Colors.white : null,
                        onPressed: onNext,
                      ),
                    ] else
                      GameButton(
                        label: t.games.check,
                        onPressed: play.selected == null ? null : onCheck,
                      ),
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

/// The bar of the lesson: gold, thick, it fills as the questions are settled.
class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) => Semantics(
    value: '${(value * 100).round()} %',
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: value),
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        builder: (context, shown, _) => LinearProgressIndicator(
          value: shown,
          minHeight: 14,
          color: AppColors.gold,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest,
        ),
      ),
    ),
  );
}

/// The lesson is over and goes to the server; when the network fails, it
/// waits: « Réessayer » sends the same play.
class _Sending extends StatelessWidget {
  const _Sending({
    required this.session,
    required this.onRetry,
    required this.onQuit,
  });

  final LessonSession session;
  final VoidCallback onRetry;
  final VoidCallback onQuit;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final error = session.sendError;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExcludeSemantics(
                child: Center(
                  child: DoveMascot(
                    pose: error == null ? DovePose.joy : DovePose.rest,
                    size: 110,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (error == null) ...[
                const Center(child: AppSpinner()),
                const SizedBox(height: AppSpacing.md),
                Text(t.games.sending, textAlign: TextAlign.center),
              ] else ...[
                Text(
                  t.games.sendFailed,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, height: 1.35),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  session.kept ? t.games.sendLater : userMessageFor(error, t),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpacing.xl),
                GameButton(label: t.games.sendRetry, onPressed: onRetry),
                const SizedBox(height: AppSpacing.sm),
                TextButton(onPressed: onQuit, child: Text(t.games.quit)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The end of a lesson, on night blue: Zoé celebrates, the points, the
/// answers right at once, the stars, the streak of days, a new level.
class _End extends StatelessWidget {
  const _End({required this.lesson, required this.result, this.daily = false});

  final GameLesson lesson;
  final GameResult result;

  /// The challenge of the day, not a lesson of the path.
  final bool daily;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final title = daily
        ? t.games.dailyEnd
        : result.replay
        ? t.games.replayDone
        : result.perfect
        ? t.games.perfect
        : t.games.done;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0B3B70), AppColors.night],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 22, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
                  const ExcludeSemantics(
                    child: Center(
                      child: DoveMascot(pose: DovePose.celebrate, size: 132),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Semantics(
                    header: true,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    daily ? t.games.dailyTitle : lesson.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withValues(alpha: 0.78),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _EndCard(
                          label: t.games.points,
                          color: AppColors.gold,
                          child: Text('+${result.points}'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _EndCard(
                          label: t.games.firstTry,
                          color: AppColors.success,
                          child: Text('${result.firstTry} / ${result.total}'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _EndCard(
                          label: t.games.stars,
                          color: AppColors.primary,
                          child: GameStars(
                            stars: result.stars,
                            size: 22,
                            empty: AppColors.line,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (result.player.streakDays > 0) ...[
                    const SizedBox(height: 16),
                    _EndLine(
                      icon: AppIcons.streak,
                      text: t.games.streak(n: result.player.streakDays),
                    ),
                  ],
                  if (result.levelUp) ...[
                    const SizedBox(height: 10),
                    _EndLine(
                      icon: AppIcons.starFilled,
                      text: t.games.levelUp(n: result.player.level),
                    ),
                  ],
                  const Spacer(flex: 2),
                  GameButton(
                    label: t.games.next,
                    color: AppColors.gold,
                    foreground: AppColors.ink,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A number of the end: its name on its color, the value under it.
class _EndCard extends StatelessWidget {
  const _EndCard({
    required this.label,
    required this.color,
    required this.child,
  });

  final String label;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          // a long name shrinks rather than being cut
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label.toUpperCase(),
              maxLines: 1,
              style: const TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // a white card on the night blue, in both modes
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(13),
          ),
          child: DefaultTextStyle.merge(
            style: const TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
            child: child,
          ),
        ),
      ],
    ),
  );
}

/// A line of the end, in a frosted band: the streak, the new level.
class _EndLine extends StatelessWidget {
  const _EndLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Icon(icon, size: 20, color: AppColors.goldLight),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
