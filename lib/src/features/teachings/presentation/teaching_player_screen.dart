import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../application/listening.dart';
import '../application/now_playing.dart';
import '../domain/teaching.dart';
import 'widgets/teaching_widgets.dart';

/// The teaching heard now, full screen and night blue: the cover, the
/// title and the speaker, the bar to move in it, ±15 seconds, play / pause,
/// the speed, keep it on the phone, send it, and what the admins wrote
/// about it.
/// Under them: the message before and the next one, the sleep timer,
/// « Lecture en continu » and « À suivre » (the rest of the list it was
/// played from; a tap goes there).
/// Listening goes on when it is closed (the mini player, the lock screen).
@RoutePage()
class TeachingPlayerScreen extends HookConsumerWidget {
  const TeachingPlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    final now = ref.watch(nowPlayingProvider);
    final notifier = ref.read(nowPlayingProvider.notifier);
    final listening = ref.watch(listeningProvider);
    final sequence = ref.read(listeningProvider.notifier);
    // the player closed under the screen (nothing to hear without
    // network): the screen goes with it
    ref.listen(nowPlayingProvider, (before, now) {
      if (before?.teaching != null && now.teaching == null) {
        context.router.maybePop();
      }
    });
    final teaching = now.teaching;
    // the bar while it is dragged, then where the player is
    final dragging = useState<double?>(null);

    if (teaching == null) {
      return const Scaffold(
        backgroundColor: AppColors.primaryDeep,
        body: Center(child: AppSpinner(color: Colors.white)),
      );
    }
    final duration = now.duration ?? teaching.duration ?? Duration.zero;
    final total = duration.inMilliseconds.toDouble();
    final position =
        dragging.value ??
        now.position.inMilliseconds.clamp(0, total).toDouble();
    final language = TranslationProvider.of(context).locale.languageCode;
    final speed = NumberFormat('0.##', language).format(now.speed);
    final width = MediaQuery.sizeOf(context).width;
    final short = MediaQuery.sizeOf(context).height < 700;
    final queue = listening.queue;
    final toast = ref.read(toasterProvider).of(context);

    Future<void> guarded(Future<void> Function() action) async {
      try {
        await action();
      } on Object {
        toast.error(t.nextUnavailable);
      }
    }

    Future<void> chooseSleep() async {
      // minutes; 0: at the end of this message; -1: off
      final choice = await showActionSheet<int>(
        context,
        title: t.sleepTimer,
        actions: [
          for (final minutes in const [15, 30, 45])
            AdaptiveAction(
              value: minutes,
              label: t.sleepIn(n: minutes),
            ),
          AdaptiveAction(value: 60, label: t.sleepInHour),
          AdaptiveAction(
            value: 0,
            label: t.sleepAtEnd,
            selected: listening.sleepAtEnd,
          ),
          if (listening.sleeping)
            AdaptiveAction(value: -1, label: t.sleepOff, destructive: true),
        ],
      );
      switch (choice) {
        case null:
          return;
        case -1:
          sequence.cancelSleep();
        case 0:
          sequence.sleepAtEnd();
        case final minutes:
          sequence.sleepIn(Duration(minutes: minutes));
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primaryDeep,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  const IconTheme(
                    data: IconThemeData(color: Colors.white),
                    child: AppBackButton(),
                  ),
                  const Spacer(),
                  ShareTeachingButton(teaching: teaching, color: Colors.white),
                  const SizedBox(width: AppSpacing.sm),
                ],
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  children: [
                    Center(
                      child: TeachingCover(
                        teaching: teaching,
                        size: (width - 2 * AppSpacing.xl).clamp(
                          0,
                          short ? 200 : 300,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      teachingTitle(context, teaching),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (teaching.speaker.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        teaching.speaker,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Lora',
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          color: AppColors.goldLight,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AppColors.goldLight,
                        inactiveTrackColor: Colors.white24,
                        thumbColor: AppColors.goldLight,
                        overlayColor: AppColors.goldLight.withValues(
                          alpha: 0.2,
                        ),
                        trackHeight: 4,
                      ),
                      child: Slider(
                        value: total == 0 ? 0 : position,
                        max: total == 0 ? 1 : total,
                        semanticFormatterCallback: (value) =>
                            formatClock(Duration(milliseconds: value.round())),
                        onChanged: total == 0
                            ? null
                            : (value) => dragging.value = value,
                        onChangeEnd: (value) async {
                          await notifier.seek(
                            Duration(milliseconds: value.round()),
                          );
                          dragging.value = null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      child: Row(
                        children: [
                          Text(
                            formatClock(
                              Duration(milliseconds: position.round()),
                            ),
                            style: const TextStyle(
                              color: AppColors.onPrimaryMuted,
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            total == 0
                                ? '--:--'
                                : '-${formatClock(Duration(milliseconds: (total - position).round()))}',
                            style: const TextStyle(
                              color: AppColors.onPrimaryMuted,
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          tooltip: t.previousMessage,
                          onPressed: () => guarded(sequence.previous),
                          iconSize: 28,
                          color: Colors.white,
                          icon: const Icon(AppIcons.previousTrack),
                        ),
                        _Skip(
                          icon: AppIcons.back15,
                          tooltip: t.back15,
                          onPressed: () => notifier.skip(-NowPlaying.step),
                        ),
                        _PlayButton(
                          playing: now.playing,
                          loading: now.loading && !now.playing,
                          tooltip: now.playing ? t.pause : t.play,
                          onPressed: notifier.toggle,
                        ),
                        _Skip(
                          icon: AppIcons.forward15,
                          tooltip: t.forward15,
                          onPressed: () => notifier.skip(NowPlaying.step),
                        ),
                        IconButton(
                          tooltip: t.nextMessage,
                          onPressed: queue.hasNext || queue.hasMorePages
                              ? () async {
                                  if (!await sequence.next()) {
                                    toast.error(t.nextUnavailable);
                                  }
                                }
                              : null,
                          iconSize: 28,
                          color: Colors.white,
                          disabledColor: Colors.white30,
                          icon: const Icon(AppIcons.nextTrack),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: notifier.nextSpeed,
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            minimumSize: const Size(56, 48),
                          ),
                          child: Text(
                            '$speed×',
                            semanticsLabel: t.speed(speed: speed),
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                        IconButton(
                          tooltip: t.sleepTimer,
                          onPressed: chooseSleep,
                          color: listening.sleeping
                              ? AppColors.goldLight
                              : Colors.white,
                          icon: Icon(
                            listening.sleeping
                                ? AppIcons.sleepTimerOn
                                : AppIcons.sleepTimer,
                          ),
                        ),
                        DownloadButton(teaching: teaching, color: Colors.white),
                      ],
                    ),
                    if (listening.sleeping)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.xs),
                        child: Text(
                          switch (listening.sleepUntil) {
                            final until? => t.sleepUntil(
                              time: context.formatDate(until, 'HH:mm'),
                            ),
                            null => t.sleepAfterThis,
                          },
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.goldLight,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    const SizedBox(height: AppSpacing.md),
                    SwitchListTile.adaptive(
                      contentPadding: EdgeInsets.zero,
                      activeTrackColor: AppColors.gold,
                      title: Text(
                        t.continuous,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      value: listening.continuous,
                      onChanged: (on) => sequence.setContinuous(on: on),
                    ),
                    if (queue.upcoming.isNotEmpty) ...[
                      Text(
                        t.upNext.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.goldLight,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      for (final one in queue.upcoming.take(_upNextShown))
                        _UpNext(
                          teaching: one,
                          onTap: () => guarded(() => sequence.jumpTo(one)),
                        ),
                    ],
                    if (teaching.category.isNotEmpty ||
                        teaching.recordedDay != null) ...[
                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        [
                          if (teaching.category.isNotEmpty) teaching.category,
                          if (teaching.recordedDay case final day?)
                            t.recordedOn(
                              date: context.formatDate(day, 'd MMMM yyyy'),
                            ),
                        ].join(' · '),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.onPrimaryMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    if (teaching.description.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        teaching.description,
                        style: const TextStyle(
                          color: Colors.white,
                          height: 1.5,
                          fontSize: 15,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// How many messages « À suivre » lists.
const _upNextShown = 10;

/// A message to come: its title, who speaks and how long; a tap plays it.
class _UpNext extends StatelessWidget {
  const _UpNext({required this.teaching, required this.onTap});

  final Teaching teaching;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final facts = [
      if (teaching.speaker.isNotEmpty) teaching.speaker,
      if (teaching.duration case final duration?)
        durationLabel(context, duration),
    ].join(' · ');
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teachingTitle(context, teaching),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  if (facts.isNotEmpty)
                    Text(
                      facts,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.onPrimaryMuted,
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Icon(AppIcons.play, color: Colors.white70, size: 18),
          ],
        ),
      ),
    );
  }
}

class _Skip extends StatelessWidget {
  const _Skip({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: tooltip,
    onPressed: onPressed,
    iconSize: 30,
    color: Colors.white,
    icon: Stack(
      alignment: Alignment.center,
      children: [
        Icon(icon, size: 34),
        const Text(
          '15',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({
    required this.playing,
    required this.loading,
    required this.tooltip,
    required this.onPressed,
  });

  final bool playing;
  final bool loading;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    excludeFromSemantics: true,
    child: Semantics(
      button: true,
      label: tooltip,
      child: Material(
        color: AppColors.gold,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: loading ? null : onPressed,
          child: SizedBox.square(
            dimension: 76,
            child: Center(
              child: loading
                  ? const AppSpinner(size: 30, color: Colors.white)
                  : Icon(
                      playing ? AppIcons.pause : AppIcons.play,
                      color: Colors.white,
                      size: 34,
                    ),
            ),
          ),
        ),
      ),
    ),
  );
}
