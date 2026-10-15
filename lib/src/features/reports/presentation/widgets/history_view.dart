import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/utils/date_extensions.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/dashed_outline.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/rolling_text.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../application/day_report_controller.dart';
import '../../application/reports_providers.dart';
import '../../domain/activity_type.dart';
import '../../domain/daily_report.dart';
import '../../domain/measure_format.dart';

/// "History" view: a month calendar, then the days of that month, newest first.
class HistoryView extends HookConsumerWidget {
  const HistoryView({required this.onOpenDay, super.key});

  /// Opens a day in the "Today" view.
  final ValueChanged<DateTime> onOpenDay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = today();
    final month = useState(now.startOfMonth);
    final from = month.value;
    final lastOfMonth = DateTime(from.year, from.month + 1, 0);
    final to = lastOfMonth.isAfter(now) ? now : lastOfMonth;
    final provider = reportHistoryProvider(from: from, to: to);
    final history = ref.watch(provider);
    final standardIds = {
      for (final activity
          in ref.watch(activitiesProvider).value ?? const <ActivityType>[])
        if (activity.isStandard) activity.id,
    };

    final days = {
      for (final report in history.value ?? const <DailyReport>[])
        report.date: report,
    };

    return RefreshIndicator.adaptive(
      onRefresh: () =>
          ref.refresh(provider.future).then((_) {}, onError: (_) {}),
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          _MonthCalendar(
            month: from,
            lastDay: to,
            reported: days.keys.toSet(),
            onPrevious: () => month.value = DateTime(from.year, from.month - 1),
            onNext: from.isSameDay(now.startOfMonth)
                ? null
                : () => month.value = DateTime(from.year, from.month + 1),
            onOpenDay: onOpenDay,
          ),
          const SizedBox(height: 14),
          switch (history) {
            AsyncError(:final error) when !history.hasValue => ErrorView(
              error: error,
              onRetry: () => ref.invalidate(provider),
            ),
            // the cards of the days
            AsyncValue(hasValue: false) => const Shimmer(
              child: SkeletonCards(count: 4, height: 84),
            ),
            _ => Column(
              children: [
                for (final (index, day)
                    in from.daysUntil(to).reversed.indexed) ...[
                  FadeSlideIn(
                    key: ValueKey(day),
                    index: index,
                    child: switch (days[day]) {
                      final report? => _DayCard(
                        report: report,
                        standardIds: standardIds,
                        onTap: () => onOpenDay(day),
                      ),
                      null => _MissingDayCard(
                        day: day,
                        onFill: () => onOpenDay(day),
                      ),
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          },
        ],
      ),
    );
  }
}

class _MonthCalendar extends StatelessWidget {
  const _MonthCalendar({
    required this.month,
    required this.lastDay,
    required this.reported,
    required this.onPrevious,
    required this.onNext,
    required this.onOpenDay,
  });

  final DateTime month;

  /// Today for the current month, else the month's last day.
  final DateTime lastDay;
  final Set<DateTime> reported;
  final VoidCallback onPrevious;
  final VoidCallback? onNext;
  final ValueChanged<DateTime> onOpenDay;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final now = today();
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final elapsed = lastDay.day;
    final filled = reported.where((day) => !day.isAfter(lastDay)).length;
    final leadingBlanks = month.weekday - DateTime.monday;
    final monday = month.startOfWeek;

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        14,
        AppSpacing.md,
        14,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                tooltip: t.reports.history.previousMonth,
                onPressed: onPrevious,
                icon: const Icon(AppIcons.chevronLeft),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      context.formatDate(month, 'MMMM y').capitalized,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    RollingText(
                      t.reports.history.daysFilled(
                        filled: filled,
                        total: elapsed,
                      ),
                      value: filled,
                      alignment: Alignment.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: t.reports.history.nextMonth,
                onPressed: onNext,
                icon: const Icon(AppIcons.chevronRight),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ExcludeSemantics(
            child: Row(
              children: [
                for (var i = 0; i < 7; i++)
                  Expanded(
                    child: Text(
                      context
                          .formatDate(monday.add(Duration(days: i)), 'EEEEE')
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.05,
            children: [
              for (var i = 0; i < leadingBlanks; i++) const SizedBox.shrink(),
              for (var d = 1; d <= daysInMonth; d++)
                _DayCell(
                  key: ValueKey(DateTime(month.year, month.month, d)),
                  day: DateTime(month.year, month.month, d),
                  isToday: DateTime(month.year, month.month, d).isSameDay(now),
                  isFuture: DateTime(month.year, month.month, d).isAfter(now),
                  done: reported.contains(DateTime(month.year, month.month, d)),
                  onTap: onOpenDay,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              const SizedBox(width: AppSpacing.xs),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                t.reports.history.legendFilled,
                style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(width: AppSpacing.lg),
              DashedOutline(
                color: AppTones.of(context).missingDash,
                dash: 2.5,
                gap: 2,
                child: SizedBox.square(dimension: 12),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  t.reports.history.legendMissing,
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.isToday,
    required this.isFuture,
    required this.done,
    required this.onTap,
    super.key,
  });

  final DateTime day;
  final bool isToday;
  final bool isFuture;
  final bool done;
  final ValueChanged<DateTime> onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final Color textColor;
    final Color? fill;
    if (isToday) {
      (textColor, fill) = (scheme.onPrimary, scheme.primary);
    } else if (done) {
      (textColor, fill) = (scheme.onPrimaryContainer, scheme.primaryContainer);
    } else if (isFuture) {
      (textColor, fill) = (tones.disabled, null);
    } else {
      (textColor, fill) = (scheme.onSurfaceVariant, null);
    }

    final label = Center(
      child: Text(
        '${day.day}',
        style: TextStyle(
          fontSize: 14,
          fontWeight: isToday
              ? FontWeight.w800
              : (done ? FontWeight.w700 : FontWeight.w500),
          color: textColor,
        ),
      ),
    );
    final circle = fill != null
        ? DecoratedBox(
            decoration: BoxDecoration(color: fill, shape: BoxShape.circle),
            child: label,
          )
        : isFuture
        ? label
        : DashedOutline(color: tones.missingDash, child: label);

    return Semantics(
      button: !isFuture,
      label: context.formatDate(day, 'EEEE d MMMM'),
      excludeSemantics: true,
      child: InkResponse(
        onTap: isFuture ? null : () => onTap(day),
        radius: 22,
        child: Center(
          child: SizedBox.square(
            dimension: 36,
            // a filled day pops in when the month's reports arrive
            child: AnimatedSwitcher(
              duration: AppMotion.of(context, AppMotion.medium),
              switchInCurve: AppMotion.pop,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation.drive(Tween(begin: 0.6, end: 1)),
                  child: child,
                ),
              ),
              child: KeyedSubtree(
                key: ValueKey((isToday, done, isFuture)),
                child: circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  const _DayCard({
    required this.report,
    required this.standardIds,
    required this.onTap,
  });

  final DailyReport report;
  final Set<int> standardIds;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: 14,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.formatDate(report.date, 'EEE d MMMM').capitalized,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (report.date.isSameDay(today()))
                    _TodayPill(day: report.date),
                ],
              ),
              if (report.entries.isNotEmpty) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final entry in report.entries)
                      _ValueChip(
                        entry: entry,
                        personal: !standardIds.contains(entry.activityTypeId),
                      ),
                  ],
                ),
              ],
              if (report.note case final note? when note.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  note,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// "En cours" on today's card while it has unsaved changes.
class _TodayPill extends ConsumerWidget {
  const _TodayPill({required this.day});

  final DateTime day;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tones = AppTones.of(context);
    final dirty =
        ref.watch(dayReportControllerProvider(day)).value?.dirty ?? false;
    if (!dirty) {
      return const SizedBox.shrink();
    }
    return StatusPill(
      context.t.reports.history.inProgress,
      background: tones.personalSoft,
      foreground: tones.personal,
    );
  }
}

class _ValueChip extends StatelessWidget {
  const _ValueChip({required this.entry, required this.personal});

  final ReportEntry entry;
  final bool personal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final value = MeasureFormat.value(
      quantity: entry.quantity,
      minutes: entry.durationMinutes,
      withUnit: false,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: personal ? tones.personalSoft : scheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        '${entry.code} $value',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: personal ? tones.personal : scheme.primary,
        ),
      ),
    );
  }
}

class _MissingDayCard extends StatelessWidget {
  const _MissingDayCard({required this.day, required this.onFill});

  final DateTime day;
  final VoidCallback onFill;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;

    return DashedOutline(
      color: scheme.outline,
      radius: 18,
      dash: 6,
      gap: 4,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.formatDate(day, 'EEE d MMMM').capitalized,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    t.reports.history.none,
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: onFill,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 44),
                foregroundColor: scheme.primary,
                backgroundColor: scheme.surface,
                side: BorderSide(color: scheme.outlineVariant),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                textStyle: const TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Text(t.reports.history.fill),
            ),
          ],
        ),
      ),
    );
  }
}
