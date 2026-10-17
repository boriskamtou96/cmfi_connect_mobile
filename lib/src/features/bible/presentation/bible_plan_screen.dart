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
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/adaptive_pickers.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/segmented_tabs.dart';
import '../../../routing/app_router.dart';
import '../../prayer/presentation/widgets/prayer_look.dart';
import '../application/bible_library.dart';
import '../application/bible_plan.dart';
import '../application/bible_position.dart';
import '../application/bible_reading.dart';
import '../application/bible_settings.dart';
import '../domain/bible.dart';
import '../domain/reading_plan.dart';

/// The names of the books in the Bible read, the codes while they load.
String Function(String) useBookNames(WidgetRef ref) {
  final version = ref.watch(bibleVersionProvider);
  final books = ref.watch(bibleBooksProvider(version.id)).value ?? const [];
  final names = {for (final book in books) book.id: book.name};
  return (book) => names[book] ?? book;
}

/// Opens [chapter] in the Bible tab.
Future<void> openPlanChapter(
  BuildContext context,
  WidgetRef ref,
  BibleRef chapter,
) async {
  await ref.read(bibleFocusProvider.notifier).show(chapter);
  if (context.mounted) {
    context.router.root.popUntilRouteWithName(AppShellRoute.name);
    context.navigateTo(const BibleRoute());
  }
}

/// Bible › ⋮ › Plan de lecture (and the home screen): a plan made on the
/// phone, the chapters shared out over 3, 6 or 12 months (or any number of
/// days). Without a plan, its settings; with one, today's reading to tick,
/// the late chapters, the next days and the reminder.
@RoutePage()
class BiblePlanScreen extends HookConsumerWidget {
  const BiblePlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(biblePlanProvider);
    // kept alive while the chapters are ticked here
    ref.watch(bibleReadingProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: progress == null ? const _Setup() : _Progress(progress: progress),
      ),
    );
  }
}

/// The night-blue header of both pages.
class _Header extends StatelessWidget {
  const _Header({required this.title, required this.child});

  final String title;
  final Widget child;

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
          AppSpacing.xs,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IconTheme(
              data: IconThemeData(color: Colors.white),
              child: AppBackButton(),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      title,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  child,
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ----- making a plan -----

class _Setup extends HookConsumerWidget {
  const _Setup();

  static const _presets = [91, 182, 365];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.biblePlan;
    final scheme = Theme.of(context).colorScheme;
    final preset = useState(2);
    final custom = useState(120);
    final scope = useState(PlanScope.bible);
    final order = useState(PlanOrder.canonical);
    final reminder = useState(true);
    final time = useState(const TimeOfDay(hour: 7, minute: 0));
    final days = preset.value < _presets.length
        ? _presets[preset.value]
        : custom.value;
    final plan = ReadingPlan(
      scope: scope.value,
      order: scope.value == PlanScope.bible ? order.value : PlanOrder.canonical,
      days: days,
      start: today(),
      reminder: reminder.value,
      reminderMinutes: time.value.hour * 60 + time.value.minute,
    );
    final length = plan.schedule.length;
    final language = TranslationProvider.of(context).locale.languageCode;
    final perDay = NumberFormat('0.#', language).format(plan.total / length);

    Widget choice<T>(T value, T group, String label, ValueChanged<T> onTap) =>
        ListTile(
          title: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          trailing: value == group
              ? Icon(AppIcons.checkCircleFilled, color: scheme.primary)
              : Icon(AppIcons.checkCircle, color: scheme.outlineVariant),
          selected: value == group,
          onTap: () => onTap(value),
        );

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _Header(
          title: t.title,
          child: Text(
            t.intro,
            style: const TextStyle(
              color: AppColors.onPrimaryMuted,
              height: 1.4,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: FadeSlideIn(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionLabel(t.duration),
                const SizedBox(height: AppSpacing.sm),
                SegmentedTabs(
                  labels: [t.months3, t.months6, t.year, t.custom],
                  selectedIndex: preset.value,
                  onChanged: (index) => preset.value = index,
                ),
                if (preset.value == _presets.length) ...[
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton.filledTonal(
                        tooltip: '−10',
                        onPressed: custom.value > 20
                            ? () => custom.value -= 10
                            : null,
                        icon: const Icon(AppIcons.minus),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          t.days(n: custom.value),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      IconButton.filledTonal(
                        tooltip: '+10',
                        onPressed: custom.value < 730
                            ? () => custom.value += 10
                            : null,
                        icon: const Icon(AppIcons.plus),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                SectionLabel(t.scope),
                const SizedBox(height: AppSpacing.sm),
                SectionCard(
                  children: [
                    for (final value in PlanScope.values)
                      choice(
                        value,
                        scope.value,
                        t.scopes[value.name] ?? value.name,
                        (value) => scope.value = value,
                      ),
                  ],
                ),
                if (scope.value == PlanScope.bible) ...[
                  const SizedBox(height: AppSpacing.xl),
                  SectionLabel(t.order),
                  const SizedBox(height: AppSpacing.sm),
                  SectionCard(
                    children: [
                      for (final value in PlanOrder.values)
                        choice(
                          value,
                          order.value,
                          t.orders[value.name] ?? value.name,
                          (value) => order.value = value,
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                SectionCard(
                  children: [
                    SwitchListTile.adaptive(
                      value: reminder.value,
                      onChanged: (on) => reminder.value = on,
                      title: Text(
                        t.reminder,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (reminder.value)
                      ListTile(
                        title: Text(t.reminderAt),
                        trailing: Text(
                          time.value.format(context),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: scheme.primary,
                          ),
                        ),
                        onTap: () async {
                          final picked = await showAppTimePicker(
                            context,
                            initialTime: time.value,
                            use24h: true,
                          );
                          if (picked != null) {
                            time.value = picked;
                          }
                        },
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                _SummaryCard(
                  text: t.summary(
                    chapters: plan.total,
                    days: length,
                    perDay: perDay,
                  ),
                  end: t.endsOn(date: context.formatDate(plan.end, 'd MMMM y')),
                ),
                const SizedBox(height: AppSpacing.lg),
                FilledButton(
                  onPressed: () =>
                      ref.read(biblePlanProvider.notifier).start(plan),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                  child: Text(t.start),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.text, required this.end});

  final String text;
  final String end;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.bible.tone(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: tone.soft,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        children: [
          Icon(AppIcons.calendarCheck, color: tone.onSoft, size: 28),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: tone.onSoft,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 2),
                Text(end, style: TextStyle(color: tone.onSoft)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----- following a plan -----

class _Progress extends HookConsumerWidget {
  const _Progress({required this.progress});

  final PlanProgress progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.biblePlan;
    final scheme = Theme.of(context).colorScheme;
    final nameOf = useBookNames(ref);
    final now = today();
    final plan = progress.plan;
    final index = progress.indexOf(now);
    final todayChapters = progress.chaptersOf(now);
    final behind = progress.behindOn(now);
    final late = [
      for (var i = 0; i < index.clamp(0, progress.length); i++)
        for (final chapter in progress.schedule[i])
          if (!progress.isRead(chapter)) chapter,
    ];
    final next = progress.nextOn(now);

    Future<void> stop() async {
      final yes = await showConfirmDialog(
        context,
        title: t.stopTitle,
        text: t.stopText,
        confirmLabel: t.stop,
        destructive: true,
      );
      if (yes) {
        await ref.read(biblePlanProvider.notifier).stop();
      }
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _Header(
          title: t.scopes[plan.scope.name] ?? t.title,
          child: Row(
            children: [
              SizedBox.square(
                dimension: 84,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CustomPaint(
                        painter: ProgressRingPainter(
                          progress: progress.progress,
                          color: AppColors.goldLight,
                          track: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                    ),
                    Text(
                      context.formatPercent(progress.progress),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
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
                      progress.finished
                          ? t.finished
                          : t.dayOf(
                              day: (index + 1).clamp(1, progress.length),
                              total: progress.length,
                            ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t.chaptersRead(
                        read: progress.readCount,
                        total: plan.total,
                      ),
                      style: const TextStyle(color: AppColors.onPrimaryMuted),
                    ),
                    Text(
                      t.endsOn(date: context.formatDate(plan.end, 'd MMMM y')),
                      style: const TextStyle(color: AppColors.goldLight),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: FadeSlideIn(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (behind > 0) ...[
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Text(
                      '${t.behind(n: behind)} · ${t.catchUp}',
                      style: const TextStyle(height: 1.35),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
                if (todayChapters.isNotEmpty) ...[
                  SectionCard(
                    header: t.today,
                    children: [
                      for (final chapter in todayChapters)
                        _ChapterRow(chapter: chapter, nameOf: nameOf),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (progress.doneOn(now))
                    Text(
                      t.todayDone,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: scheme.primary,
                      ),
                    ),
                ],
                if (next != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  FilledButton.icon(
                    onPressed: () => openPlanChapter(context, ref, next),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                    ),
                    icon: const Icon(AppIcons.bibleTile),
                    label: Text('${t.read} · ${readingLabel([next], nameOf)}'),
                  ),
                ],
                if (late.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  SectionCard(
                    header: t.late,
                    children: [
                      for (final chapter in late.take(30))
                        _ChapterRow(chapter: chapter, nameOf: nameOf),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                SectionCard(
                  header: t.upcoming,
                  children: [
                    for (var i = 1; i <= 5; i++)
                      if (index + i >= 0 && index + i < progress.length)
                        ListTile(
                          title: Text(
                            readingLabel(progress.schedule[index + i], nameOf),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            '${t.dayNumber(n: index + i + 1)} · '
                            '${context.formatDate(now.add(Duration(days: i)), 'EEE d MMM')}',
                          ),
                        ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                SectionCard(
                  children: [
                    SwitchListTile.adaptive(
                      value: plan.reminder,
                      onChanged: (on) => ref
                          .read(biblePlanProvider.notifier)
                          .setReminder(on: on),
                      title: Text(
                        t.reminder,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    if (plan.reminder)
                      ListTile(
                        title: Text(t.reminderAt),
                        trailing: Text(
                          TimeOfDay(
                            hour: plan.reminderMinutes ~/ 60,
                            minute: plan.reminderMinutes % 60,
                          ).format(context),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: scheme.primary,
                          ),
                        ),
                        onTap: () async {
                          final picked = await showAppTimePicker(
                            context,
                            initialTime: TimeOfDay(
                              hour: plan.reminderMinutes ~/ 60,
                              minute: plan.reminderMinutes % 60,
                            ),
                            use24h: true,
                          );
                          if (picked != null) {
                            await ref
                                .read(biblePlanProvider.notifier)
                                .setReminder(
                                  minutes: picked.hour * 60 + picked.minute,
                                );
                          }
                        },
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: scheme.error),
                  onPressed: stop,
                  child: Text(t.stop),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A chapter of the plan: a tick (read, and counted in today's "Lecture
/// biblique"), its name, and the arrow that opens it.
class _ChapterRow extends ConsumerWidget {
  const _ChapterRow({required this.chapter, required this.nameOf});

  final BibleRef chapter;
  final String Function(String) nameOf;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.biblePlan;
    final scheme = Theme.of(context).colorScheme;
    final read = ref.watch(biblePlanProvider)?.isRead(chapter) ?? false;
    final label = readingLabel([chapter], nameOf);

    Future<void> toggle() async {
      final reading = ref.read(bibleReadingProvider.notifier);
      if (!read) {
        await reading.markRead(chapter);
      } else if (ref
          .read(bibleReadingProvider)
          .contains(chapter.chapterRef.key)) {
        // ticked today: out of today's report too
        await reading.unmark(chapter);
      } else {
        await ref.read(biblePlanProvider.notifier).unmark(chapter);
      }
    }

    return ListTile(
      leading: IconButton(
        tooltip: read ? t.uncheck(chapter: label) : t.check(chapter: label),
        onPressed: toggle,
        icon: Icon(
          read ? AppIcons.checkCircleFilled : AppIcons.checkCircle,
          color: read ? AppColors.gold : scheme.outline,
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          decoration: read ? TextDecoration.lineThrough : null,
          color: read ? scheme.onSurfaceVariant : null,
        ),
      ),
      trailing: const Icon(AppIcons.chevronRight),
      onTap: () => openPlanChapter(context, ref, chapter),
    );
  }
}
