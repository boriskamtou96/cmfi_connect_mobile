import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/app_log.dart';
import '../../../core/services/chime.dart';
import '../../../core/services/screen_awake.dart';
import '../../../core/services/voice_reader.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/text_direction.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../routing/app_router.dart';
import '../application/retreats.dart';
import '../domain/prayer.dart';
import '../domain/retreat.dart';
import 'retreat_screen.dart';
import 'widgets/prayer_look.dart';

/// A retreat prayed point by point: one minute each when [timed] (a soft
/// sound moves to the next one), at the user's pace otherwise. The end adds
/// the retreat to the day and its minutes to the report.
@RoutePage()
class RetreatSessionScreen extends HookConsumerWidget {
  const RetreatSessionScreen({
    required this.moment,
    this.timed = true,
    super.key,
  });

  final RetreatMoment moment;
  final bool timed;

  static const secondsPerPoint = 60;
  static const _soundKey = 'retreat_sound';

  /// Each point read aloud (key `retreat_voice`, off until turned on).
  static const voiceKey = 'retreat_voice';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final language = TranslationProvider.of(context).locale.languageCode;
    final plan = ref.watch(retreatPlanProvider(moment, language));
    final index = useState(0);
    final remaining = useState(secondsPerPoint);
    final paused = useState(false);
    final finished = useState(false);
    final preferences = ref.read(sharedPreferencesProvider);
    final sound = useState(preferences.getBool(_soundKey) ?? true);
    final voice = useState(preferences.getBool(voiceKey) ?? false);
    final reader = ref.read(voiceReaderProvider);
    // a retreat made again today doesn't add its minutes twice
    final alreadyDone = useMemoized(
      () => ref.read(retreatsTodayProvider).contains(moment),
    );

    // the screen stays on while praying
    final awake = ref.read(screenAwakeProvider);
    useEffect(() {
      unawaited(awake.keepOn(on: true));
      return () => unawaited(awake.keepOn(on: false));
    }, const []);

    final points = plan.value ?? const <PlannedPoint>[];

    void finish() {
      if (finished.value) {
        return;
      }
      finished.value = true;
      unawaited(HapticFeedback.mediumImpact());
    }

    void goTo(int next, {bool chime = false}) {
      if (next >= retreatPoints || points.isNotEmpty && next >= points.length) {
        finish();
        return;
      }
      index.value = next.clamp(0, retreatPoints - 1);
      remaining.value = secondsPerPoint;
      if (chime && sound.value) {
        unawaited(ref.read(chimeProvider).play());
      }
      unawaited(HapticFeedback.selectionClick());
    }

    useEffect(() {
      if (!timed || paused.value || finished.value || plan.value == null) {
        return null;
      }
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (remaining.value > 1) {
          remaining.value--;
        } else {
          goTo(index.value + 1, chime: true);
        }
      });
      return timer.cancel;
    }, [timed, paused.value, finished.value, plan.value == null]);

    if (finished.value) {
      return _RetreatDone(
        moment: moment,
        alreadyDone: alreadyDone,
        prayedFor: [for (final point in points) ...point.people],
      );
    }

    Future<void> quit() async {
      final navigator = Navigator.of(context);
      final confirmed = await showConfirmDialog(
        context,
        title: t.prayer.session.quitTitle,
        text: t.prayer.session.quitText,
        cancelLabel: t.prayer.session.keepPraying,
        confirmLabel: t.prayer.session.quit,
      );
      if (confirmed) {
        navigator.pop();
      }
    }

    final point = points.isEmpty ? null : points[index.value];

    // read aloud: each point as it comes (the minute begins, or a tap moves
    // on), silent while paused, and when the retreat ends or is left
    final spoken = point == null ? null : _spokenText(context, point);
    useEffect(() {
      if (voice.value && !paused.value && !finished.value && spoken != null) {
        unawaited(reader.speak(spoken, language));
      } else {
        unawaited(reader.stop());
      }
      return null;
    }, [index.value, voice.value, paused.value, finished.value, spoken]);
    useEffect(
      () =>
          () => unawaited(reader.stop()),
      const [],
    );
    final accent = moment.colors.first;
    final white60 = Colors.white.withValues(alpha: 0.65);
    final last = index.value == retreatPoints - 1;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          unawaited(quit());
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: const Color(0xFF151227),
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -1.1),
                radius: 1.3,
                colors: [
                  Color.lerp(moment.colors.last, Colors.black, 0.35)!,
                  const Color(0xFF241D38),
                  const Color(0xFF111426),
                ],
                stops: const [0, 0.5, 1],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          tooltip: MaterialLocalizations.of(
                            context,
                          ).closeButtonTooltip,
                          onPressed: quit,
                          icon: const Icon(
                            AppIcons.close,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(moment.icon, size: 16, color: accent),
                                  const SizedBox(width: 6),
                                  Flexible(
                                    child: Text(
                                      moment.retreat(t),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                t.prayer.session.point(n: index.value + 1),
                                style: TextStyle(fontSize: 13, color: white60),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: voice.value
                              ? t.prayer.session.voiceOn
                              : t.prayer.session.voiceOff,
                          onPressed: () {
                            voice.value = !voice.value;
                            unawaited(
                              preferences.setBool(voiceKey, voice.value),
                            );
                          },
                          icon: Icon(
                            voice.value ? AppIcons.voiceOn : AppIcons.voiceOff,
                            color: voice.value ? accent : Colors.white,
                            size: 24,
                          ),
                        ),
                        IconButton(
                          tooltip: sound.value
                              ? t.prayer.session.soundOn
                              : t.prayer.session.soundOff,
                          onPressed: () {
                            sound.value = !sound.value;
                            unawaited(
                              preferences.setBool(_soundKey, sound.value),
                            );
                          },
                          icon: Icon(
                            sound.value ? AppIcons.soundOn : AppIcons.soundOff,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _PointsBar(
                      current: index.value,
                      progress: timed
                          ? 1 - remaining.value / secondsPerPoint
                          : 0,
                      color: accent,
                    ),
                    Expanded(
                      // a long point scrolls instead of overflowing on a small phone
                      child: LayoutBuilder(
                        builder: (context, constraints) => SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: AppSpacing.lg),
                                if (timed)
                                  SizedBox.square(
                                    dimension: 168,
                                    child: CustomPaint(
                                      painter: ProgressRingPainter(
                                        progress:
                                            1 -
                                            remaining.value / secondsPerPoint,
                                        color: accent,
                                        track: Colors.white.withValues(
                                          alpha: 0.12,
                                        ),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${remaining.value ~/ 60}:${(remaining.value % 60).toString().padLeft(2, '0')}',
                                              style: const TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                                height: 1,
                                                fontFeatures: [
                                                  FontFeature.tabularFigures(),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              paused.value
                                                  ? t.prayer.session.paused
                                                  : t.prayer.session.remaining,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: white60,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 28),
                                if (point != null)
                                  AnimatedSwitcher(
                                    duration: AppMotion.of(
                                      context,
                                      AppMotion.medium,
                                    ),
                                    child: _PointView(
                                      key: ValueKey(index.value),
                                      point: point,
                                    ),
                                  )
                                else if (plan.hasError)
                                  Text(
                                    userMessageFor(plan.error!, t),
                                    style: const TextStyle(color: Colors.white),
                                  )
                                else
                                  const AppSpinner(color: Colors.white),
                                const SizedBox(height: AppSpacing.lg),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _RoundButton(
                          icon: AppIcons.previous,
                          label: t.prayer.session.previous,
                          onPressed: index.value == 0
                              ? null
                              : () => goTo(index.value - 1),
                        ),
                        const SizedBox(width: 28),
                        if (timed)
                          _RoundButton(
                            icon: paused.value ? AppIcons.play : AppIcons.pause,
                            label: paused.value
                                ? t.prayer.session.resume
                                : t.prayer.session.pause,
                            size: 76,
                            filled: true,
                            onPressed: () => paused.value = !paused.value,
                          )
                        else
                          _RoundButton(
                            icon: last ? AppIcons.done : AppIcons.next,
                            label: last
                                ? t.prayer.session.finish
                                : t.prayer.session.next,
                            size: 76,
                            filled: true,
                            onPressed: () => goTo(index.value + 1),
                          ),
                        const SizedBox(width: 28),
                        _RoundButton(
                          icon: last ? AppIcons.done : AppIcons.next,
                          label: last
                              ? t.prayer.session.finish
                              : t.prayer.session.next,
                          onPressed: () => goTo(index.value + 1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (timed)
                      Text(
                        t.prayer.session.footer,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13, color: white60),
                      ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// What the voice reads of a point: its text, what the app adds (the
/// assembly, the authorities, the nation of the day…) and the people of the
/// list.
String _spokenText(BuildContext context, PlannedPoint point) {
  final extra = point.hint is ListHint ? null : pointHintText(context, point);
  return [
    point.text,
    ?extra,
    if (point.people.isNotEmpty)
      point.people.map((person) => person.name).join(', '),
  ].join('. ');
}

/// Fifteen short bars: the points prayed, the current one filling up.
class _PointsBar extends StatelessWidget {
  const _PointsBar({
    required this.current,
    required this.progress,
    required this.color,
  });

  final int current;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final track = Colors.white.withValues(alpha: 0.2);
    return Row(
      children: [
        for (var i = 0; i < retreatPoints; i++) ...[
          if (i > 0) const SizedBox(width: 3),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: SizedBox(
                height: 4,
                child: LinearProgressIndicator(
                  value: i < current ? 1 : (i == current ? progress : 0),
                  color: color,
                  backgroundColor: track,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// The text of a point, big, and what the app adds: the names of the list,
/// the country of the day…
class _PointView extends StatelessWidget {
  const _PointView({required this.point, super.key});

  final PlannedPoint point;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final white60 = Colors.white.withValues(alpha: 0.65);
    final hint = point.hint;
    final extra = hint is ListHint ? null : pointHintText(context, point);

    return Column(
      children: [
        Text(
          point.text,
          textAlign: TextAlign.center,
          textDirection: contentDirection(point.text),
          style: const TextStyle(
            fontFamily: 'Lora',
            fontSize: 25,
            height: 1.35,
            color: Colors.white,
          ),
        ),
        if (hint is ListHint) ...[
          const SizedBox(height: 22),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.prayer.session
                      .inYourList(list: hint.list.label(t))
                      .toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: white60,
                  ),
                ),
                const SizedBox(height: 10),
                if (point.people.isEmpty)
                  Text(
                    t.prayer.retreat.hints.listEmpty(list: hint.list.label(t)),
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  )
                else
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final person in point.people)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            person.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                if (point.people.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    t.prayer.session.tomorrow,
                    style: TextStyle(fontSize: 13, color: white60),
                  ),
                ],
              ],
            ),
          ),
        ] else if (extra != null && hint is! HymnHint) ...[
          const SizedBox(height: 18),
          Text(
            extra,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ],
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.size = 56,
    this.filled = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final double size;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Tooltip(
      message: label,
      child: Material(
        color: filled
            ? Colors.white
            : Colors.white.withValues(alpha: enabled ? 0.12 : 0.05),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Semantics(
            button: true,
            label: label,
            excludeSemantics: true,
            child: SizedBox.square(
              dimension: size,
              child: Icon(
                icon,
                size: filled ? 32 : 24,
                color: filled
                    ? const Color(0xFF151227)
                    : Colors.white.withValues(alpha: enabled ? 1 : 0.35),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The end: the retreat counted in the day, its minutes in the report.
class _RetreatDone extends HookConsumerWidget {
  const _RetreatDone({
    required this.moment,
    required this.alreadyDone,
    required this.prayedFor,
  });

  final RetreatMoment moment;
  final bool alreadyDone;
  final List<PrayerPerson> prayedFor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final reports = AppModule.reports.tone(context);
    final addition = useState<ReportAddition?>(null);
    final undone = useState(false);
    final doneToday = ref.watch(retreatsTodayProvider);

    // once: the retreat is counted, the report gets its minutes
    useEffect(() {
      Future<void> save() async {
        try {
          await ref
              .read(retreatLogProvider.notifier)
              .markDone(moment, prayedFor: prayedFor);
        } on Object catch (error, stack) {
          // its minutes still go to the report
          AppLog.error(error, stack, reason: 'retreat not marked done');
        }
        if (alreadyDone) {
          return;
        }
        try {
          final added = await ref
              .read(retreatReportProvider.notifier)
              .add(retreatMinutes);
          if (context.mounted) {
            addition.value = added;
          }
        } on Object {
          // the retreat is counted; the report can be filled by hand
        }
      }

      // after this frame: the day can't change while the screen builds
      unawaited(Future(save));
      return null;
    }, const []);

    Future<void> undo() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      try {
        await ref.read(retreatLogProvider.notifier).undo(moment);
        if (addition.value case final added?) {
          await ref.read(retreatReportProvider.notifier).add(-added.added);
        }
        undone.value = true;
        addition.value = null;
        toast.info(messages.prayer.done.undone);
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      }
    }

    return Scaffold(
      body: SafeArea(
        // scrolls on a small phone or with a big text size
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 36,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const Spacer(),
                    Container(
                      width: 112,
                      height: 112,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: moment.colors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(
                        AppIcons.done,
                        color: Colors.white,
                        size: 54,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      t.prayer.done.title(retreat: moment.retreat(t)),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.prayer.done.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 26),
                    if (addition.value case final added?) ...[
                      _DoneCard(
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: reports.soft,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                AppIcons.reports,
                                color: reports.onSoft,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t.prayer.done.report,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    t.prayer.done.reportDetail(
                                      added: added.added,
                                      total: added.total,
                                    ),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: undo,
                              child: Text(t.prayer.done.undo),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                    _DoneCard(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  t.prayer.done.today,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text(
                                t.prayer.done.count(n: doneToday.length),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              for (final other in RetreatMoment.values)
                                Column(
                                  children: [
                                    Container(
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: doneToday.contains(other)
                                            ? LinearGradient(
                                                colors: other.colors,
                                              )
                                            : null,
                                        color: doneToday.contains(other)
                                            ? null
                                            : scheme.surfaceContainerHighest,
                                      ),
                                      child: Icon(
                                        doneToday.contains(other)
                                            ? AppIcons.done
                                            : other.icon,
                                        size: 20,
                                        color: doneToday.contains(other)
                                            ? Colors.white
                                            : tones.disabled,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      other.label(t),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: scheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      t.prayer.done.verse,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lora',
                        fontStyle: FontStyle.italic,
                        fontSize: 19,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t.prayer.done.reference,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(54),
                      ),
                      child: Text(t.prayer.done.finish),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    TextButton.icon(
                      onPressed: () =>
                          context.router.navigate(const HymnsRoute()),
                      icon: const Icon(AppIcons.hymns, size: 18),
                      label: Text(t.prayer.done.hymn),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DoneCard extends StatelessWidget {
  const _DoneCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: child,
    );
  }
}
