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
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/reminder_row.dart';
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
/// the late chapters (a sheet), the next days and the reminder. Each page
/// holds on one screen: it scrolls only when the text is very large.
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
      child: progress == null ? const _Setup() : _Progress(progress: progress),
    );
  }
}

/// The page: the night-blue [header], the [body] (scrolls only when it
/// doesn't fit) and the main button, always in sight at the bottom.
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
            child: FadeSlideIn(child: body),
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

/// The night-blue header of both pages: back, the title (and [action]) on
/// one line, then [child].
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

/// One choice among a few, as a tile: two side by side.
class _Option extends StatelessWidget {
  const _Option({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.bible.tone(context);
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? tone.soft : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(
            color: selected ? tone.onSoft : scheme.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      height: 1.25,
                      color: selected ? tone.onSoft : null,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  selected ? AppIcons.checkCircleFilled : AppIcons.checkCircle,
                  size: 20,
                  color: selected ? tone.onSoft : scheme.outlineVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// [children] two by two, each pair as tall as its tallest.
class _Grid extends StatelessWidget {
  const _Grid({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (var i = 0; i < children.length; i += 2) ...[
        if (i > 0) const SizedBox(height: AppSpacing.sm),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: children[i]),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: i + 1 < children.length
                    ? children[i + 1]
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ],
    ],
  );
}

// ----- making a plan -----

class _Setup extends HookConsumerWidget {
  const _Setup();

  static const _presets = [91, 182, 365];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.biblePlan;
    final preset = useState(2);
    final custom = useState(120);
    final scope = useState(PlanScope.bible);
    final order = useState(PlanOrder.canonical);
    final reminder = useState(true);
    final minutes = useState(7 * 60);
    final days = preset.value < _presets.length
        ? _presets[preset.value]
        : custom.value;
    final plan = ReadingPlan(
      scope: scope.value,
      order: scope.value == PlanScope.bible ? order.value : PlanOrder.canonical,
      days: days,
      start: today(),
      reminder: reminder.value,
      reminderMinutes: minutes.value,
    );
    final length = plan.schedule.length;
    final language = TranslationProvider.of(context).locale.languageCode;
    final perDay = NumberFormat('0.#', language).format(plan.total / length);
    // a small phone (iPhone SE): no intro, closer sections, still one page
    final small = MediaQuery.sizeOf(context).height < 700;
    final gap = small ? AppSpacing.md : AppSpacing.lg;

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
          SectionLabel(t.duration),
          const SizedBox(height: AppSpacing.sm),
          SegmentedTabs(
            labels: [t.months3, t.months6, t.year, t.custom],
            selectedIndex: preset.value,
            onChanged: (index) => preset.value = index,
          ),
          if (preset.value == _presets.length)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filledTonal(
                    tooltip: '−10',
                    visualDensity: VisualDensity.compact,
                    onPressed: custom.value > 20
                        ? () => custom.value -= 10
                        : null,
                    icon: const Icon(AppIcons.minus),
                  ),
                  SizedBox(
                    width: 112,
                    child: Text(
                      t.days(n: custom.value),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton.filledTonal(
                    tooltip: '+10',
                    visualDensity: VisualDensity.compact,
                    onPressed: custom.value < 730
                        ? () => custom.value += 10
                        : null,
                    icon: const Icon(AppIcons.plus),
                  ),
                ],
              ),
            ),
          SizedBox(height: gap),
          SectionLabel(t.scope),
          const SizedBox(height: AppSpacing.sm),
          _Grid(
            children: [
              for (final value in PlanScope.values)
                _Option(
                  label: t.scopes[value.name] ?? value.name,
                  selected: value == scope.value,
                  onTap: () => scope.value = value,
                ),
            ],
          ),
          if (scope.value == PlanScope.bible) ...[
            SizedBox(height: gap),
            SectionLabel(t.order),
            const SizedBox(height: AppSpacing.sm),
            SegmentedTabs(
              labels: [
                for (final value in PlanOrder.values)
                  t.orders[value.name] ?? value.name,
              ],
              selectedIndex: order.value.index,
              onChanged: (index) => order.value = PlanOrder.values[index],
            ),
          ],
          SizedBox(height: gap),
          ReminderRow(
            label: t.reminder,
            timeLabel: t.reminderAt,
            on: reminder.value,
            minutes: minutes.value,
            onChanged: (on) => reminder.value = on,
            onTime: (value) => minutes.value = value,
          ),
        ],
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Summary(
            text: t.summary(chapters: plan.total, days: length, perDay: perDay),
            end: t.endsOn(date: context.formatDate(plan.end, 'd MMMM y')),
          ),
          const SizedBox(height: AppSpacing.sm),
          FilledButton(
            onPressed: () => ref.read(biblePlanProvider.notifier).start(plan),
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

/// What the plan will be, above its button: two short lines.
class _Summary extends StatelessWidget {
  const _Summary({required this.text, required this.end});

  final String text;
  final String end;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.bible.tone(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(AppIcons.calendarCheck, color: tone.onSoft, size: 22),
        const SizedBox(width: AppSpacing.sm),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: tone.onSoft,
                  height: 1.3,
                ),
              ),
              Text(
                end,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ----- following a plan -----

class _Progress extends HookConsumerWidget {
  const _Progress({required this.progress});

  final PlanProgress progress;

  static const _upcomingDays = 3;

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

    return _Page(
      header: _Header(
        title: t.scopes[plan.scope.name] ?? t.title,
        action: AdaptiveMenuButton<int>(
          tooltip: context.t.bible.more,
          icon: const Icon(AppIcons.moreOptions, color: Colors.white),
          onSelected: (_) => stop(),
          actions: [
            AdaptiveAction(
              value: 0,
              label: t.stop,
              icon: AppIcons.delete,
              destructive: true,
            ),
          ],
        ),
        child: _ProgressSummary(progress: progress, index: index),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (behind > 0) ...[
            Material(
              color: AppColors.gold.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _showLate(context, progress, now),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      const Icon(AppIcons.countdown, color: AppColors.gold),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: t.behind(n: behind),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(text: ' · ${t.catchUp}'),
                            ],
                          ),
                          style: const TextStyle(height: 1.3),
                        ),
                      ),
                      const Icon(AppIcons.chevronRight),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          if (todayChapters.isNotEmpty) ...[
            SectionCard(
              header: t.today,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.xs,
                    AppSpacing.lg,
                    AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _ChapterDots(chapters: todayChapters, nameOf: nameOf),
                      if (progress.doneOn(now)) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          t.todayDone,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          if (index + 1 < progress.length) ...[
            SectionCard(
              header: t.upcoming,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    0,
                    AppSpacing.lg,
                    AppSpacing.md,
                  ),
                  child: Column(
                    children: [
                      for (var i = 1; i <= _upcomingDays; i++)
                        if (index + i >= 0 && index + i < progress.length)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.xs,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 72,
                                  child: Text(
                                    context.formatDate(
                                      now.add(Duration(days: i)),
                                      'EEE d',
                                    ),
                                    style: TextStyle(
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    readingLabel(
                                      progress.schedule[index + i],
                                      nameOf,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          ReminderRow(
            label: t.reminder,
            timeLabel: t.reminderAt,
            on: plan.reminder,
            minutes: plan.reminderMinutes,
            onChanged: (on) =>
                ref.read(biblePlanProvider.notifier).setReminder(on: on),
            onTime: (minutes) => ref
                .read(biblePlanProvider.notifier)
                .setReminder(minutes: minutes),
          ),
        ],
      ),
      bottom: next == null
          ? null
          : FilledButton.icon(
              onPressed: () => openPlanChapter(context, ref, next),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              icon: const Icon(AppIcons.bibleTile),
              label: Text('${t.read} · ${readingLabel([next], nameOf)}'),
            ),
    );
  }
}

/// The ring and the figures of the header.
class _ProgressSummary extends StatelessWidget {
  const _ProgressSummary({required this.progress, required this.index});

  final PlanProgress progress;
  final int index;

  @override
  Widget build(BuildContext context) {
    final t = context.t.biblePlan;
    return Row(
      children: [
        SizedBox.square(
          dimension: 64,
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
                  fontSize: 15,
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
              Text(
                t.chaptersRead(
                  read: progress.readCount,
                  total: progress.plan.total,
                ),
                style: const TextStyle(color: AppColors.onPrimaryMuted),
              ),
              Text(
                t.endsOn(
                  date: context.formatDate(progress.plan.end, 'd MMMM y'),
                ),
                style: const TextStyle(color: AppColors.goldLight),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The chapters not read of the days gone, in a sheet.
void _showLate(BuildContext context, PlanProgress progress, DateTime now) {
  final index = progress.indexOf(now);
  final late = [
    for (var i = 0; i < index.clamp(0, progress.length); i++)
      for (final chapter in progress.schedule[i])
        if (!progress.isRead(chapter)) chapter,
  ];
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheet) => SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(sheet).height * 0.7,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: HookConsumer(
            builder: (context, ref, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.t.biblePlan.late,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                _ChapterDots(chapters: late, nameOf: useBookNames(ref)),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

/// [chapters] by book: the name, then a round button per chapter to tick
/// (read, and counted in today's "Lecture biblique"). Small enough for a
/// day of 13 chapters to take a few lines.
class _ChapterDots extends StatelessWidget {
  const _ChapterDots({required this.chapters, required this.nameOf});

  final List<BibleRef> chapters;
  final String Function(String) nameOf;

  @override
  Widget build(BuildContext context) {
    final books = <String, List<BibleRef>>{};
    for (final chapter in chapters) {
      (books[chapter.book] ??= []).add(chapter);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final MapEntry(key: book, value: chapters) in books.entries) ...[
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.sm,
              bottom: AppSpacing.xs,
            ),
            child: Text(
              nameOf(book),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final chapter in chapters)
                _ChapterDot(chapter: chapter, nameOf: nameOf),
            ],
          ),
        ],
      ],
    );
  }
}

class _ChapterDot extends ConsumerWidget {
  const _ChapterDot({required this.chapter, required this.nameOf});

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

    return Tooltip(
      message: read ? t.uncheck(chapter: label) : t.check(chapter: label),
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        checked: read,
        label: label,
        child: Material(
          color: read ? AppColors.gold : scheme.surface,
          shape: CircleBorder(
            side: BorderSide(
              color: read ? AppColors.gold : scheme.outlineVariant,
              width: 1.5,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: toggle,
            child: SizedBox.square(
              dimension: 44,
              child: Center(
                child: read
                    ? const Icon(AppIcons.check, color: Colors.white, size: 20)
                    : Text(
                        '${chapter.chapter}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
