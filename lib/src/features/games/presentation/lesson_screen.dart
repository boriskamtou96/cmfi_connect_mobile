import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/game_sounds.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
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
import 'widgets/arrange_boards.dart';
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
    // the end of the lesson is heard and felt: more when a level is finished
    ref.listen(lessonControllerProvider(lessonId), (previous, next) {
      final result = next.value?.result;
      if (result != null && previous?.value?.result == null) {
        final level = result.levelCompleted || result.levelUp;
        // felt too: a firm tap, a heavier one for a level
        if (level) {
          HapticFeedback.heavyImpact();
        } else {
          HapticFeedback.mediumImpact();
        }
        ref.read(gameSoundsProvider).lessonDone(level: level);
      }
    });

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

class _Question extends HookWidget {
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
    final letters = t.games.letters.characters.toList();
    // a right answer is felt lightly, a missed one a little more
    useEffect(() {
      if (play.checked) {
        play.isRight
            ? HapticFeedback.lightImpact()
            : HapticFeedback.mediumImpact();
      }
      return null;
    }, [play.checked, play.index]);
    final combo = play.checked && play.isRight && _combos.contains(play.run);

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
                  Expanded(
                    child: _Segments(
                      marks: play.marks,
                      current: play.isRetry ? null : play.index,
                      progress: play.progress,
                    ),
                  ),
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
                  if (question.isOrder)
                    OrderBoard(
                      key: ValueKey(play.index),
                      question: question,
                      checked: play.checked,
                      onChanged: onChoose,
                    )
                  else if (question.isMatch)
                    MatchBoard(
                      key: ValueKey(play.index),
                      question: question,
                      checked: play.checked,
                      onChanged: onChoose,
                    )
                  else
                    for (final (i, choice) in question.choices.indexed) ...[
                      ChoiceCard(
                        letter: i < letters.length ? letters[i] : null,
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
              // the sparks of a right answer may go past its top
              clipBehavior: Clip.none,
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
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                // centred on the 24 px icon
                                if (play.isRight)
                                  Positioned(
                                    left: -78,
                                    top: -78,
                                    width: 180,
                                    height: 180,
                                    child: SparkBurst(
                                      key: ValueKey(play.index),
                                      size: 180,
                                    ),
                                  ),
                                Icon(
                                  play.isRight
                                      ? AppIcons.right
                                      : AppIcons.wrong,
                                  color: play.isRight
                                      ? AppColors.success
                                      : missing,
                                ),
                              ],
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
                      if (combo) ...[
                        const SizedBox(height: 6),
                        _Combo(text: t.games.combo(n: play.run)),
                      ],
                      if (!play.isRight) ...[
                        const SizedBox(height: 6),
                        Text(
                          t.games.rightAnswer(answer: question.answerText),
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
                        // an order or a match not finished: an empty answer
                        onPressed: (play.selected ?? '').isEmpty
                            ? null
                            : onCheck,
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

/// Right answers in a row that are cheered (« 3 d'affilée ! »).
const _combos = {3, 5, 8};

/// The bar of the lesson: a box per question, in the order they are asked.
/// Green right at once, gold the second time, amber while it waits to come
/// back; the one asked has a ring. Read as the share settled.
class _Segments extends StatelessWidget {
  const _Segments({
    required this.marks,
    required this.current,
    required this.progress,
  });

  final List<QuestionMark> marks;

  /// The box of the question asked, null when one comes back.
  final int? current;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final missing = AppTones.of(context).missing;
    final duration = AppMotion.of(context, AppMotion.medium);
    return Semantics(
      value: '${(progress * 100).round()} %',
      child: ExcludeSemantics(
        child: Row(
          children: [
            for (final (i, mark) in marks.indexed) ...[
              if (i > 0) const SizedBox(width: 4),
              Expanded(
                child: AnimatedContainer(
                  duration: duration,
                  curve: AppMotion.standard,
                  height: 14,
                  decoration: BoxDecoration(
                    color: switch (mark) {
                      QuestionMark.waiting => scheme.surfaceContainerHighest,
                      QuestionMark.right => AppColors.success,
                      QuestionMark.second => AppColors.gold,
                      QuestionMark.again => missing.withValues(alpha: 0.55),
                      QuestionMark.missed => missing,
                    },
                    borderRadius: BorderRadius.circular(7),
                    border: i == current
                        ? Border.all(color: scheme.primary, width: 2)
                        : null,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// « 3 d'affilée ! »: the flame and the words, in gold, popping in.
class _Combo extends StatelessWidget {
  const _Combo({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(AppIcons.streak, size: 18, color: AppColors.gold),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: AppColors.gold,
          ),
        ),
      ],
    );
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: AppMotion.reduced(context)
          ? row
          : TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.6, end: 1),
              duration: AppMotion.slow,
              curve: AppMotion.pop,
              builder: (context, scale, child) =>
                  Transform.scale(scale: scale, child: child),
              child: row,
            ),
    );
  }
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
                          child: _CountUp(points: result.points),
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
                          child: _StarsIn(stars: result.stars),
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

/// The points of the end, counting up to their value (« +80 »).
class _CountUp extends StatelessWidget {
  const _CountUp({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    if (AppMotion.reduced(context)) {
      return Text('+$points');
    }
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: points.toDouble()),
      duration: const Duration(milliseconds: 900),
      curve: AppMotion.standard,
      builder: (context, value, _) =>
          Text('+${value.round()}', semanticsLabel: '+$points'),
    );
  }
}

/// The stars of the end, coming in one after the other with a little pop.
class _StarsIn extends StatelessWidget {
  const _StarsIn({required this.stars});

  final int stars;

  @override
  Widget build(BuildContext context) {
    final reduced = AppMotion.reduced(context);
    return Semantics(
      label: '$stars / 3',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 1; i <= 3; i++)
            reduced || i > stars
                ? _star(i <= stars)
                : TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    // each star waits for the one before it
                    duration: Duration(milliseconds: 380 + i * 220),
                    curve: Interval(
                      (i * 220) / (380 + i * 220),
                      1,
                      curve: AppMotion.pop,
                    ),
                    builder: (context, scale, child) =>
                        Transform.scale(scale: scale, child: child),
                    child: _star(true),
                  ),
        ],
      ),
    );
  }

  static Widget _star(bool won) => Icon(
    won ? AppIcons.starFilled : AppIcons.star,
    size: 22,
    color: won ? AppColors.gold : AppColors.line,
  );
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
