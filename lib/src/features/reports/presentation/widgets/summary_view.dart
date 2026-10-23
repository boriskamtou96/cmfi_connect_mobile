import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/services/premium_store.dart';
import '../../../../core/services/share_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/utils/date_extensions.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/animated_progress_bar.dart';
import '../../../../core/widgets/cmfi_logo.dart';
import '../../../../core/widgets/code_chip.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/goal_ring.dart';
import '../../../../core/widgets/rolling_text.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../routing/app_router.dart';
import '../../../profile/application/current_profile.dart';
import '../../application/report_files.dart';
import '../../application/report_goals.dart';
import '../../application/report_item_texts.dart';
import '../../application/reports_providers.dart';
import '../../domain/activity_type.dart';
import '../../domain/daily_report.dart';
import '../../domain/measure_format.dart';
import '../../domain/report_export.dart';
import '../../domain/report_goal.dart';
import '../../domain/report_summary.dart';
import '../../domain/time_with_god.dart';

/// "Summary" view: regularity and totals per item over the week, month or year.
class SummaryView extends HookConsumerWidget {
  const SummaryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final period = useState(SummaryPeriod.month);
    final range = period.value.rangeEnding(today());
    final summaryProvider = reportSummaryProvider(period.value);
    final historyProvider = reportHistoryProvider(
      from: range.from,
      to: range.to,
    );
    final summary = ref.watch(summaryProvider);
    // the totals come from the summary; the bars need the values day by day
    final history = ref.watch(historyProvider).value;
    final activities =
        ref.watch(activitiesProvider).value ?? const <ActivityType>[];
    final standardIds = {
      for (final activity in activities)
        if (activity.isStandard) activity.id,
    };
    final goals = ref.watch(reportGoalsProvider);
    final premium = ref.watch(premiumProvider).value ?? false;

    Future<void> share(Rect? origin) async {
      final days = history;
      if (days == null) {
        return;
      }
      final locale = Localizations.localeOf(context).toLanguageTag();
      final profile = ref.read(currentProfileProvider).value;
      final export = ReportExport.build(
        from: range.from,
        to: range.to,
        history: days,
        activities: activities,
        goals: goals,
      );
      await ref
          .read(shareServiceProvider)
          .shareText(
            reportAsText(
              export,
              t: t,
              locale: locale,
              owner: (name: profile?.fullName ?? '', church: profile?.church),
            ),
            subject: t.export.subject(
              period: exportPeriodLabel(t, locale, range.from, range.to),
            ),
            origin: origin,
          );
    }

    final header = Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(AppSpacing.xs, 0, 0, 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _rangeLabel(context, range.from, range.to),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          for (final (value, label) in [
            (SummaryPeriod.week, t.reports.summary.week),
            (SummaryPeriod.month, t.reports.summary.month),
            (SummaryPeriod.year, t.reports.summary.year),
          ]) ...[
            const SizedBox(width: 6),
            _PeriodPill(
              label: label,
              selected: period.value == value,
              // the year comes with Premium
              locked: value == SummaryPeriod.year && !premium,
              onTap: value == SummaryPeriod.year && !premium
                  ? () => context.router.push(const PremiumRoute())
                  : () => period.value = value,
            ),
          ],
        ],
      ),
    );

    return RefreshIndicator.adaptive(
      onRefresh: () async {
        ref.invalidate(historyProvider);
        await ref.refresh(summaryProvider.future).then((_) {}, onError: (_) {});
      },
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          header,
          ...switch (summary) {
            AsyncValue(value: final data?) => _content(
              context,
              data,
              period.value,
              history,
              standardIds,
              goals,
              premium: premium,
              onShare: history == null ? null : share,
            ),
            AsyncError(:final error) => [
              ErrorView(
                error: error,
                onRetry: () => ref.invalidate(summaryProvider),
              ),
            ],
            // the regularity, then a card per item
            _ => [const Shimmer(child: SkeletonCards(height: 150))],
          },
        ],
      ),
    );
  }

  List<Widget> _content(
    BuildContext context,
    ReportSummary summary,
    SummaryPeriod period,
    List<DailyReport>? history,
    Set<int> standardIds,
    Map<int, ReportGoal> goals, {
    required bool premium,
    required Future<void> Function(Rect? origin)? onShare,
  }) {
    final t = context.t;
    final filled = summary.items.where((item) => item.daysCount > 0).toList();
    final empty = summary.items.where((item) => item.daysCount == 0).toList();
    final goalsOfPeriod = history == null
        ? null
        : periodGoals(
            goals,
            itemIds: summary.items.map((item) => item.activityTypeId),
            history: history,
            from: summary.from,
            to: summary.to,
            today: today(),
          );

    return [
      FadeSlideIn(
        child: _RegularityCard(
          summary: summary,
          period: period,
          history: history,
        ),
      ),
      const SizedBox(height: 14),
      // the time with God over the period, and what it was spent on
      FadeSlideIn(
        key: ValueKey(('time', period)),
        index: 1,
        child: _TimeCard(summary: summary, standardIds: standardIds),
      ),
      const SizedBox(height: 14),
      // the week, told as "Ta semaine avec Dieu"; the past ones too
      if (period == SummaryPeriod.week) ...[
        const FadeSlideIn(index: 1, child: _WeekStories()),
        const SizedBox(height: 14),
      ],
      if (goalsOfPeriod != null) ...[
        FadeSlideIn(
          key: ValueKey(('goals', period)),
          index: 1,
          child: _GoalsCard(total: goalsOfPeriod.total),
        ),
        const SizedBox(height: 14),
        FadeSlideIn(index: 1, child: _EvolutionCard(premium: premium)),
        const SizedBox(height: 14),
      ],
      if (summary.daysReported == 0)
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Text(t.reports.summary.empty, textAlign: TextAlign.center),
        ),
      for (final (index, item) in filled.indexed) ...[
        // keyed by period: the bars grow again when the period changes
        FadeSlideIn(
          key: ValueKey((period, item.activityTypeId)),
          index: index + 1,
          child: _ItemCard(
            item: item,
            personal: !standardIds.contains(item.activityTypeId),
            period: period,
            from: summary.from,
            to: summary.to,
            history: history,
            goal: goals[item.activityTypeId],
            goalShare: goalsOfPeriod?.byItem[item.activityTypeId],
            daysInRange: summary.daysInRange,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
      if (empty.isNotEmpty) ...[
        const SizedBox(height: AppSpacing.xs),
        FadeSlideIn(
          index: filled.length + 1,
          child: SectionCard(
            header: t.reports.summary.notFilled,
            children: [
              for (final item in empty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      CodeChip(
                        code: item.code,
                        personal: !standardIds.contains(item.activityTypeId),
                        filled: false,
                        minWidth: 48,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          t.itemLabel(item.code, item.label),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // not filled in: counts 0, with its unit
                      Text(
                        MeasureFormat.zero(
                          quantity: item.tracksQuantity,
                          duration: item.tracksDuration,
                          unit: t.itemUnit(
                            item.code,
                            item.quantityUnit,
                            standard: standardIds.contains(item.activityTypeId),
                          ),
                        ),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
      if (summary.daysReported > 0) ...[
        const SizedBox(height: AppSpacing.lg),
        Builder(
          builder: (context) => OutlinedButton.icon(
            onPressed: onShare == null
                ? null
                : () {
                    // the iPad share sheet points at the button
                    final box = context.findRenderObject() as RenderBox?;
                    onShare(
                      box == null
                          ? null
                          : box.localToGlobal(Offset.zero) & box.size,
                    );
                  },
            icon: const Icon(AppIcons.share, size: 20),
            label: Text(t.reports.summary.share),
          ),
        ),
      ],
    ];
  }

  /// "Du 1 au 9 octobre", "Du 29 septembre au 5 octobre", "Du 1 janvier au 9 octobre".
  static String _rangeLabel(BuildContext context, DateTime from, DateTime to) {
    final sameMonth = from.year == to.year && from.month == to.month;
    return context.t.reports.summary.range(
      from: context.formatDate(from, sameMonth ? 'd' : 'd MMMM'),
      to: context.formatDate(to, 'd MMMM'),
    );
  }
}

/// "Ta semaine avec Dieu": this week, and the four before.
class _WeekStories extends StatelessWidget {
  const _WeekStories();

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final monday = today().startOfWeek;
    void open(DateTime week) =>
        context.router.push(WeekStoryRoute(monday: week.toApiDate()));
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () => open(monday),
              child: Ink(
                padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2F6BFF), Color(0xFF6A2FB8)],
                  ),
                ),
                child: Row(
                  children: [
                    const CmfiLogo(size: 30, disc: true),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.weekStory.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            t.weekStory.thisWeek,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xE6FFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(AppIcons.play, color: Colors.white, size: 22),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.weekStory.pastWeeks,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (var i = 1; i <= 4; i++)
                      ActionChip(
                        label: Text(
                          t.weekStory.weekOf(
                            date: context.formatDate(
                              DateTime(
                                monday.year,
                                monday.month,
                                monday.day - 7 * i,
                              ),
                              'd MMM',
                            ),
                          ),
                        ),
                        onPressed: () => open(
                          DateTime(
                            monday.year,
                            monday.month,
                            monday.day - 7 * i,
                          ),
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

class _PeriodPill extends StatelessWidget {
  const _PeriodPill({
    required this.label,
    required this.selected,
    required this.onTap,
    this.locked = false,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  /// Premium only: a padlock, and the Premium page on tap.
  final bool locked;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final duration = AppMotion.of(context, AppMotion.fast);

    return Semantics(
      selected: selected,
      button: true,
      child: AnimatedContainer(
        duration: duration,
        curve: AppMotion.standard,
        decoration: ShapeDecoration(
          color: selected ? scheme.primary : scheme.surface,
          shape: StadiumBorder(
            side: BorderSide(
              color: selected ? scheme.primary : scheme.outlineVariant,
            ),
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: onTap,
            // 1 px less on each side: the border of the decoration takes it
            child: Container(
              constraints: const BoxConstraints(minHeight: 34, minWidth: 46),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md - 1,
              ),
              alignment: Alignment.center,
              child: AnimatedDefaultTextStyle(
                duration: duration,
                curve: AppMotion.standard,
                style: DefaultTextStyle.of(context).style.merge(
                  TextStyle(
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    color: selected
                        ? scheme.onPrimary
                        : scheme.onSurfaceVariant,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (locked) ...[
                      Icon(
                        AppIcons.premiumLock,
                        size: 12,
                        semanticLabel: context.t.premium.pill,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(label),
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

/// « Temps avec Dieu » over the period: the total, the mean of a day, then
/// each item measured in minutes with its share.
class _TimeCard extends StatelessWidget {
  const _TimeCard({required this.summary, required this.standardIds});

  final ReportSummary summary;
  final Set<int> standardIds;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final s = t.reports.summary.time;
    final scheme = Theme.of(context).colorScheme;
    final total = minutesOfItems(summary.items);
    final items = [
      for (final item in summary.items)
        if (item.tracksDuration && item.totalMinutes > 0) item,
    ]..sort((a, b) => b.totalMinutes.compareTo(a.totalMinutes));
    final perDay = summary.daysInRange == 0
        ? 0
        : (total / summary.daysInRange).round();

    return SectionCard(
      header: s.title,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(AppIcons.stopwatch, color: AppColors.gold),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    total.toDurationLabel(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                total == 0 ? s.none : s.perDay(time: perDay.toDurationLabel()),
                style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
              ),
              for (final item in items) ...[
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        t.itemLabel(item.code, item.label),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      item.totalMinutes.toDurationLabel(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                AnimatedProgressBar(
                  value: item.totalMinutes / total,
                  minHeight: 6,
                  color: standardIds.contains(item.activityTypeId)
                      ? AppColors.gold
                      : AppTones.of(context).personal,
                  backgroundColor: scheme.surfaceContainerHighest,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _RegularityCard extends StatelessWidget {
  const _RegularityCard({
    required this.summary,
    required this.period,
    required this.history,
  });

  final ReportSummary summary;
  final SummaryPeriod period;
  final List<DailyReport>? history;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    const onCard = Color(0xFFDCE9F7);
    final ratio = summary.daysInRange == 0
        ? 0.0
        : summary.daysReported / summary.daysInRange;

    String? missingText() {
      final missingCount = summary.daysInRange - summary.daysReported;
      if (missingCount <= 0) {
        return t.reports.summary.noMissing;
      }
      final reported = {
        for (final report in history ?? const <DailyReport>[]) report.date,
      };
      final missing = summary.from
          .daysUntil(summary.to)
          .where((day) => !reported.contains(day))
          .toList();
      if (history == null ||
          period == SummaryPeriod.year ||
          missing.length > 5) {
        return t.reports.summary.missingCount(n: missingCount);
      }
      final numbers = [for (final day in missing) '${day.day}'];
      final days = numbers.length == 1
          ? numbers.single
          : '${numbers.sublist(0, numbers.length - 1).join(', ')} ${t.common.and} ${numbers.last}';
      return t.reports.summary.missingDays(n: missing.length, days: days);
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50,
            bottom: -70,
            child: BrandRing(
              size: 170,
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.reports.summary.regularity.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: AppColors.onPrimaryMuted,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: AppSpacing.sm,
                  children: [
                    RollingText(
                      '${summary.daysReported} / ${summary.daysInRange}',
                      value: summary.daysReported,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      t.reports.summary.daysFilled,
                      style: const TextStyle(fontSize: 15, color: onCard),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                AnimatedProgressBar(
                  value: ratio,
                  minHeight: 8,
                  color: AppColors.gold,
                  backgroundColor: Colors.white.withValues(alpha: 0.22),
                ),
                if (missingText() case final text?) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 14, color: onCard),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The goals week after week (Premium); a padlock and the Premium page
/// otherwise.
class _EvolutionCard extends ConsumerWidget {
  const _EvolutionCard({required this.premium});

  final bool premium;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final weeks = premium ? ref.watch(goalsEvolutionProvider()).value : null;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  t.reports.summary.evolution,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (!premium)
                StatusPill(
                  t.premium.pill,
                  background: AppColors.gold,
                  foreground: AppColors.ink,
                ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            premium
                ? t.reports.summary.evolutionHint
                : t.reports.summary.premiumYear,
            style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
          if (!premium)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: OutlinedButton.icon(
                onPressed: () => context.router.push(const PremiumRoute()),
                icon: const Icon(AppIcons.premiumLock, size: 16),
                label: Text(t.premium.unlock),
              ),
            )
          else if (weeks != null)
            _Bars(
              values: [
                for (final week in weeks) ((week.progress ?? 0) * 100).round(),
              ],
              labels: [
                for (final (i, week) in weeks.indexed)
                  // the first, the middle and the last weeks are enough
                  i == 0 || i == weeks.length ~/ 2 || i == weeks.length - 1
                      ? context.formatDate(week.monday, 'd/M')
                      : '',
              ],
              color: scheme.primary,
              scale: 100,
            )
          else
            // the 12 weeks, as bars
            Shimmer(
              child: SizedBox(
                height: 56,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final (i, height) in const [
                      18.0,
                      30.0,
                      24.0,
                      40.0,
                      34.0,
                      46.0,
                      28.0,
                      38.0,
                      50.0,
                      32.0,
                      44.0,
                      36.0,
                    ].indexed) ...[
                      if (i > 0) const SizedBox(width: 6),
                      Expanded(child: SkeletonBox(height: height, radius: 4)),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// The goals over the period: the mean of every item with a goal.
class _GoalsCard extends StatelessWidget {
  const _GoalsCard({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          GoalRing(value: total, label: t.reports.summary.goalsAverage),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.reports.summary.goals.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  t.reports.summary.goalsAverage,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  t.reports.summary.goalsHint,
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
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

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    required this.item,
    required this.personal,
    required this.period,
    required this.from,
    required this.to,
    required this.history,
    required this.daysInRange,
    this.goal,
    this.goalShare,
  });

  final SummaryItem item;
  final bool personal;
  final SummaryPeriod period;
  final DateTime from;
  final DateTime to;
  final List<DailyReport>? history;
  final int daysInRange;

  /// The item's daily goal: on how many days it was reached.
  final ReportGoal? goal;

  /// How far the goal was reached over the period, from 0 to 1.
  final double? goalShare;

  /// Bars show the quantity when the item counts one, else the duration.
  bool get _barsShowQuantity => item.tracksQuantity;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final unit = t.itemUnit(item.code, item.quantityUnit);

    // rounded as written, so that "1 chapter" is singular
    final quantityAverage = double.parse(
      (item.totalQuantity / item.daysCount).toStringAsFixed(1),
    );
    final averageQuantity = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: 1,
    ).format(quantityAverage).replaceFirst(RegExp(r'[.,]0$'), '');
    final average = [
      if (item.tracksQuantity)
        unit == null
            ? averageQuantity
            : unit.count(quantityAverage, number: averageQuantity),
      if (item.tracksDuration)
        (item.totalMinutes / item.daysCount).round().toDurationLabel(),
    ].join(' · ');

    final bars = history == null ? null : _bars(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CodeChip(code: item.code, personal: personal, minWidth: 48),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  t.itemLabel(item.code, item.label),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                t.reports.summary.days(n: item.daysCount),
                style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.xs,
            children: [
              Text(
                MeasureFormat.value(
                  quantity: item.tracksQuantity ? item.totalQuantity : null,
                  minutes: item.tracksDuration ? item.totalMinutes : null,
                  unit: unit,
                ),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
              Text(
                t.reports.summary.perDay(value: average),
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
          if (goal case final goal? when history != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Icon(
                  AppIcons.goal,
                  size: 16,
                  color: personal
                      ? AppTones.of(context).personal
                      : scheme.primary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    t.reports.summary.goalDays(
                      n: goal.daysReached(history!, item.activityTypeId),
                      total: daysInRange,
                    ),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (goalShare case final share?)
                  Text(
                    context.formatPercent(share),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: personal
                          ? AppTones.of(context).personal
                          : scheme.primary,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
              ],
            ),
          ],
          if (bars != null && bars.values.any((value) => value > 0)) ...[
            const SizedBox(height: AppSpacing.md),
            _Bars(
              values: bars.values,
              labels: bars.labels,
              color: personal ? AppTones.of(context).personal : scheme.primary,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              period == SummaryPeriod.year
                  ? t.reports.summary.barsCaptionMonthly(
                      max: _format(bars.max, unit),
                    )
                  : t.reports.summary.barsCaption(max: _format(bars.max, unit)),
              style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
            ),
          ],
        ],
      ),
    );
  }

  String _format(int value, ItemUnit? unit) => _barsShowQuantity
      ? MeasureFormat.value(quantity: value, unit: unit)
      : value.toDurationLabel();

  /// One bar per day (week, month) or per month (year).
  ({List<int> values, List<String> labels, int max}) _bars(
    BuildContext context,
  ) {
    int valueOf(ReportEntry entry) =>
        (_barsShowQuantity ? entry.quantity : entry.durationMinutes) ?? 0;

    final byDay = <DateTime, int>{};
    for (final report in history!) {
      for (final entry in report.entries.where(
        (entry) => entry.activityTypeId == item.activityTypeId,
      )) {
        byDay[report.date] = (byDay[report.date] ?? 0) + valueOf(entry);
      }
    }

    final List<int> values;
    final List<String> labels;
    if (period == SummaryPeriod.year) {
      final months = [for (var m = 1; m <= to.month; m++) DateTime(to.year, m)];
      values = [
        for (final month in months)
          byDay.entries
              .where((day) => day.key.month == month.month)
              .fold<int>(0, (sum, day) => sum + day.value),
      ];
      labels = [
        for (final month in months)
          context.formatDate(month, 'MMMMM').toUpperCase(),
      ];
    } else {
      final days = from.daysUntil(to);
      values = [for (final day in days) byDay[day] ?? 0];
      labels = [
        for (final day in days)
          if (period == SummaryPeriod.week)
            context.formatDate(day, 'EEEEE').toUpperCase()
          else if (day.day == 1 || day.day % 5 == 0)
            '${day.day}'
          else
            '',
      ];
    }
    return (
      values: values,
      labels: labels,
      max: values.fold(0, (max, value) => value > max ? value : max),
    );
  }
}

class _Bars extends StatelessWidget {
  const _Bars({
    required this.values,
    required this.labels,
    required this.color,
    this.scale,
  });

  final List<int> values;
  final List<String> labels;
  final Color color;

  /// The value of a full bar; the highest value when null.
  final int? scale;

  /// Height factor of bar [i] when the whole animation is at [progress]:
  /// each bar starts a little after the previous one.
  static double _grow(double progress, int i, int count) {
    final start = count < 2 ? 0.0 : 0.35 * i / (count - 1);
    final t = ((progress - start) / 0.65).clamp(0.0, 1.0);
    return AppMotion.emphasized.transform(t);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final max =
        scale ?? values.fold<int>(0, (max, value) => value > max ? value : max);
    final gap = values.length > 15 ? 2.0 : 6.0;

    return ExcludeSemantics(
      child: Column(
        children: [
          Container(
            height: 56,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: scheme.outlineVariant)),
            ),
            // the bars grow from the axis, left to right, when they appear
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: AppMotion.of(context, AppMotion.slow),
              builder: (context, progress, _) => Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var i = 0; i < values.length; i++) ...[
                    if (i > 0) SizedBox(width: gap),
                    Expanded(
                      child: values[i] == 0
                          ? Container(height: 3, color: scheme.outlineVariant)
                          : Container(
                              height:
                                  56 *
                                  values[i] /
                                  max *
                                  _grow(progress, i, values.length),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(4),
                                ),
                              ),
                            ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              for (var i = 0; i < labels.length; i++) ...[
                if (i > 0) SizedBox(width: gap),
                Expanded(
                  child: Text(
                    labels[i],
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 11,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
