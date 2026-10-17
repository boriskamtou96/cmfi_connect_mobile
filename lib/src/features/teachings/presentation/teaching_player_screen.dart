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
import '../../../core/widgets/app_back_button.dart';
import '../application/now_playing.dart';
import '../domain/teaching.dart';
import 'widgets/teaching_widgets.dart';

/// The teaching heard now, full screen and night blue: the cover, the
/// title and the speaker, the bar to move in it, ±15 seconds, play / pause,
/// the speed, keep it on the phone, and what the admins wrote about it.
/// Listening goes on when it is closed (the mini player, the lock screen).
@RoutePage()
class TeachingPlayerScreen extends HookConsumerWidget {
  const TeachingPlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.teachings;
    final now = ref.watch(nowPlayingProvider);
    final notifier = ref.read(nowPlayingProvider.notifier);
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primaryDeep,
        body: SafeArea(
          child: Column(
            children: [
              const Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: AppBackButton(),
                ),
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
                      teaching.title,
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
                        DownloadButton(teaching: teaching, color: Colors.white),
                      ],
                    ),
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
