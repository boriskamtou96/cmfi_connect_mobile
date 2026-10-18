import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/adaptive_pickers.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/progress_ring.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/segmented_tabs.dart';
import '../application/fasts.dart';
import '../domain/fast.dart';

/// "5 h 12", "42 min": what is left of a day of fasting.
String fastLeft(BuildContext context, Duration left) {
  final t = context.t.fasts;
  final minutes = left.inMinutes.clamp(0, 1 << 30);
  return minutes >= 60
      ? t.hoursLeft(
          h: minutes ~/ 60,
          m: (minutes % 60).toString().padLeft(2, '0'),
        )
      : t.minutesLeft(m: minutes);
}

/// Plus › Compte rendu › Mes jeûnes (and the home screen while one is under
/// way): a full or partial fast of 1 to 40 days, what it is for, the time
/// left in the day, the days kept (each one added to JC or JP of the
/// report), « Rompre le jeûne »; the last fasts below.
@RoutePage()
class FastsScreen extends HookConsumerWidget {
  const FastsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fastsProvider);
    final notifier = ref.read(fastsProvider.notifier);
    final tick = useState(0);
    final toast = ref.read(toasterProvider).of(context);
    final t = context.t.fasts;

    // the days kept since the last time go to the report; the countdown
    // moves every 30 seconds
    useEffect(() {
      Future<void> count() async {
        final added = await notifier.catchUp();
        if (added > 0) {
          toast.success(t.counted(n: added));
        }
      }

      // after the first frame: the state changes, not while building
      WidgetsBinding.instance.addPostFrameCallback((_) => count());
      final timer = Timer.periodic(const Duration(seconds: 30), (_) {
        tick.value++;
        final current = ref.read(fastsProvider).current;
        if (current != null && current.toCountAt(DateTime.now()).isNotEmpty) {
          unawaited(count());
        }
      });
      return timer.cancel;
    }, const []);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: state.current == null
          ? _Setup(history: state.history)
          : _Progress(fast: state.current!),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.child, this.action});

  final String title;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Container(
    decoration: const BoxDecoration(
      color: AppColors.primaryDeep,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(AppRadius.xxl),
      ),
    ),
    child: SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xs,
          0,
          AppSpacing.xs,
          AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconTheme(
              data: const IconThemeData(color: Colors.white),
              child: Row(
                children: [
                  const AppBackButton(),
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  ?action,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: child,
            ),
          ],
        ),
      ),
    ),
  );
}

/// The page: the header, the body (scrolls only when it doesn't fit), the
/// main button at the bottom.
class _Page extends StatelessWidget {
  const _Page({required this.header, required this.body, this.bottom});

  final Widget header;
  final Widget body;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Column(
      children: [
        header,
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: body,
          ),
        ),
      ],
    ),
    bottomNavigationBar: bottom == null
        ? null
        : SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xs,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: bottom,
            ),
          ),
  );
}

/// What the fast is for: a field to add one, the list (a tap removes).
class _Topics extends HookWidget {
  const _Topics({required this.topics, required this.onChanged});

  final List<String> topics;
  final ValueChanged<List<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t.fasts;
    final controller = useTextEditingController();
    final typed = useValueListenable(controller).text.trim();

    void add() {
      if (typed.isEmpty) {
        return;
      }
      onChanged([...topics, typed]);
      controller.clear();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => add(),
          decoration: InputDecoration(
            hintText: t.topicHint,
            suffixIcon: IconButton(
              tooltip: t.addTopic,
              onPressed: typed.isEmpty ? null : add,
              icon: const Icon(AppIcons.addCircle),
            ),
          ),
        ),
        if (topics.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final (index, topic) in topics.indexed)
                InputChip(
                  label: Text(topic),
                  deleteButtonTooltipMessage: t.removeTopic,
                  onDeleted: () => onChanged([...topics]..removeAt(index)),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

// ----- starting a fast -----

class _Setup extends HookConsumerWidget {
  const _Setup({required this.history});

  final List<PastFast> history;

  static const _lengths = [1, 3, 7, 21, 40];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.fasts;
    final kind = useState(FastKind.full);
    final length = useState(1);
    final endMinutes = useState(18 * 60);
    final topics = useState<List<String>>(const []);
    final small = MediaQuery.sizeOf(context).height < 700;
    final preview = Fast(
      kind: kind.value,
      start: DateTime.now(),
      days: _lengths[length.value],
      endMinutes: endMinutes.value,
    );
    final endTime = TimeOfDay(
      hour: endMinutes.value ~/ 60,
      minute: endMinutes.value % 60,
    );

    return _Page(
      header: _Header(
        title: t.title,
        child: small
            ? const SizedBox()
            : Text(
                t.intro,
                style: const TextStyle(
                  color: AppColors.onPrimaryMuted,
                  height: 1.35,
                ),
              ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionLabel(t.kind),
          const SizedBox(height: AppSpacing.sm),
          SegmentedTabs(
            labels: [
              for (final value in FastKind.values) t.kinds[value.name] ?? '',
            ],
            selectedIndex: kind.value.index,
            onChanged: (index) => kind.value = FastKind.values[index],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            t.kindTexts[kind.value.name] ?? '',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SectionLabel(t.length),
          const SizedBox(height: AppSpacing.sm),
          SegmentedTabs(
            labels: [for (final days in _lengths) t.days(n: days)],
            selectedIndex: length.value,
            onChanged: (index) => length.value = index,
          ),
          if (kind.value == FastKind.partial) ...[
            const SizedBox(height: AppSpacing.md),
            SectionCard(
              children: [
                ListTile(
                  leading: const Icon(AppIcons.time),
                  title: Text(t.endEachDay),
                  trailing: Text(
                    endTime.format(context),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onTap: () async {
                    final picked = await showAppTimePicker(
                      context,
                      initialTime: endTime,
                      use24h: true,
                    );
                    if (picked != null) {
                      endMinutes.value = picked.hour * 60 + picked.minute;
                    }
                  },
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          SectionLabel(t.topics),
          const SizedBox(height: AppSpacing.sm),
          _Topics(
            topics: topics.value,
            onChanged: (value) => topics.value = value,
          ),
          if (history.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            SectionCard(
              header: t.history,
              children: [
                for (final past in history.take(5))
                  ListTile(
                    dense: true,
                    title: Text(
                      '${t.kinds[past.kind.name]} · ${t.days(n: past.days)}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      context.formatDate(past.start, 'd MMMM yyyy'),
                    ),
                    trailing: Text(
                      t.kept(kept: past.kept, days: past.days),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: past.kept == past.days ? AppColors.gold : null,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.until(
              date: context.formatDate(preview.end, 'EEEE d MMMM, HH:mm'),
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppModule.prayer.tone(context).onSoft,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          FilledButton(
            onPressed: () => ref
                .read(fastsProvider.notifier)
                .start(
                  kind: kind.value,
                  days: _lengths[length.value],
                  endMinutes: endMinutes.value,
                  topics: topics.value,
                ),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
            child: Text(t.start),
          ),
        ],
      ),
    );
  }
}

// ----- a fast under way -----

class _Progress extends ConsumerWidget {
  const _Progress({required this.fast});

  final Fast fast;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.fasts;
    final scheme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final day = fast.dayAt(now).clamp(0, fast.days - 1);
    final dayEnd = fast.endOfDay(day);
    final dayStart = day == 0
        ? fast.start
        : fast.kind == FastKind.full
        ? fast.endOfDay(day - 1)
        : DateTime(dayEnd.year, dayEnd.month, dayEnd.day);
    final span = dayEnd.difference(dayStart).inSeconds;
    final done = span <= 0
        ? 1.0
        : (now.difference(dayStart).inSeconds / span).clamp(0.0, 1.0);
    final notifier = ref.read(fastsProvider.notifier);

    Future<void> stop() async {
      final yes = await showConfirmDialog(
        context,
        title: t.stopTitle,
        text: t.stopText,
        confirmLabel: t.stop,
        destructive: true,
      );
      if (yes) {
        await notifier.stop();
      }
    }

    return _Page(
      header: _Header(
        title: t.kinds[fast.kind.name] ?? t.title,
        action: AdaptiveMenuButton<int>(
          tooltip: context.t.bible.more,
          icon: const Icon(AppIcons.moreOptions, color: Colors.white),
          onSelected: (_) => stop(),
          actions: [
            AdaptiveAction(
              value: 0,
              label: t.stop,
              icon: AppIcons.close,
              destructive: true,
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox.square(
              dimension: 96,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: CustomPaint(
                      painter: ProgressRingPainter(
                        progress: done,
                        color: AppColors.goldLight,
                        track: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: FittedBox(
                      child: Text(
                        fastLeft(context, dayEnd.difference(now)),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.dayOf(day: day + 1, total: fast.days),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    t.dayEnds(time: context.formatDate(dayEnd, 'HH:mm')),
                    style: const TextStyle(color: AppColors.onPrimaryMuted),
                  ),
                  Text(
                    t.until(
                      date: context.formatDate(fast.end, 'EEEE d MMMM, HH:mm'),
                    ),
                    style: const TextStyle(color: AppColors.goldLight),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // the days: kept (gold), under way, to come
          Wrap(
            spacing: 6,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: [
              for (var i = 0; i < fast.days; i++)
                Container(
                  width: fast.days > 21 ? 22 : 30,
                  height: fast.days > 21 ? 22 : 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i < fast.dayAt(now) ? AppColors.gold : null,
                    border: Border.all(
                      color: i == day ? AppColors.gold : scheme.outlineVariant,
                      width: i == day ? 2 : 1,
                    ),
                  ),
                  child: i < fast.dayAt(now)
                      ? const Icon(
                          AppIcons.check,
                          size: 14,
                          color: Colors.white,
                        )
                      : Text(
                          '${i + 1}',
                          style: TextStyle(
                            fontSize: fast.days > 21 ? 10 : 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SectionLabel(t.topics),
          const SizedBox(height: AppSpacing.sm),
          _Topics(topics: fast.topics, onChanged: notifier.setTopics),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppModule.prayer.tone(context).soft,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              children: [
                Icon(
                  AppIcons.calendarCheck,
                  color: AppModule.prayer.tone(context).onSoft,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    t.reportNote(item: t.items[fast.kind.name] ?? ''),
                    style: TextStyle(
                      color: AppModule.prayer.tone(context).onSoft,
                      height: 1.35,
                    ),
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
