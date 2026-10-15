import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../../profile/application/current_profile.dart';
import '../application/report_files.dart';
import '../application/report_goals.dart';
import '../application/reports_providers.dart';
import '../domain/daily_report.dart';
import '../domain/report_export.dart';

/// The periods offered, from the most asked.
enum ExportPeriod {
  thisWeek,
  lastWeek,
  thisMonth,
  lastMonth,
  thisYear,
  custom;

  /// The dates of the period seen on [today] (custom: none).
  ({DateTime from, DateTime to})? rangeOn(DateTime today) {
    final monday = today.startOfWeek;
    return switch (this) {
      thisWeek => (from: monday, to: today),
      lastWeek => (
        from: DateTime(monday.year, monday.month, monday.day - 7),
        to: DateTime(monday.year, monday.month, monday.day - 1),
      ),
      thisMonth => (from: today.startOfMonth, to: today),
      lastMonth => (
        from: DateTime(today.year, today.month - 1),
        to: DateTime(today.year, today.month, 0),
      ),
      thisYear => (from: DateTime(today.year), to: today),
      custom => null,
    };
  }
}

/// Export the report of a period: PDF, spreadsheet (CSV) or a message.
@RoutePage()
class ExportReportScreen extends HookConsumerWidget {
  const ExportReportScreen({super.key});

  /// The API gives one year of history at most in one call.
  static const maxDays = 366;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final now = today();
    final period = useState(ExportPeriod.thisMonth);
    final custom = useState<({DateTime from, DateTime to})?>(null);
    final format = useState(ReportFormat.pdf);
    final busy = useState(false);

    final range = period.value.rangeOn(now) ?? custom.value;
    final history = range == null
        ? null
        : ref.watch(reportHistoryProvider(from: range.from, to: range.to));
    final activities = ref.watch(activitiesProvider);

    Future<void> pickDates() async {
      final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: now,
        initialDateRange: switch (range) {
          (:final from, :final to) => DateTimeRange(start: from, end: to),
          null => null,
        },
        helpText: t.export.customPick,
      );
      if (picked == null) {
        return;
      }
      if (picked.duration.inDays + 1 > maxDays) {
        if (context.mounted) {
          ref.read(toasterProvider).of(context).error(t.export.tooLong);
        }
        return;
      }
      custom.value = (from: picked.start.dateOnly, to: picked.end.dateOnly);
      period.value = ExportPeriod.custom;
    }

    Future<void> export(Rect? origin) async {
      final days = history?.value;
      final items = activities.value;
      if (range == null || days == null || items == null) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final share = ref.read(shareServiceProvider);
      final profile = ref.read(currentProfileProvider).value;
      final owner = (name: profile?.fullName ?? '', church: profile?.church);
      final data = ReportExport.build(
        from: range.from,
        to: range.to,
        history: days,
        activities: items,
        goals: ref.read(reportGoalsProvider),
      );
      final subject = t.export.subject(
        period: exportPeriodLabel(t, locale, range.from, range.to),
      );
      final fileName =
          '${t.export.fileName}_${range.from.toApiDate()}_${range.to.toApiDate()}';

      busy.value = true;
      try {
        switch (format.value) {
          case ReportFormat.text:
            await share.shareText(
              reportAsText(data, t: t, locale: locale, owner: owner),
              subject: subject,
              origin: origin,
            );
          case ReportFormat.csv:
            await share.shareFile(
              reportAsCsv(data, t: t, locale: locale),
              name: '$fileName.csv',
              mimeType: 'text/csv',
              subject: subject,
              origin: origin,
            );
          case ReportFormat.pdf:
            await share.shareFile(
              await reportAsPdf(data, t: t, locale: locale, owner: owner),
              name: '$fileName.pdf',
              mimeType: 'application/pdf',
              subject: subject,
              origin: origin,
            );
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    final ready =
        range != null && history?.value != null && activities.value != null;

    return SubPage(
      title: t.reports.export,
      bottom: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(top: BorderSide(color: scheme.outlineVariant)),
        ),
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: Builder(
          builder: (context) => AppButton(
            label: format.value == ReportFormat.text
                ? t.export.shareButton
                : t.export.button,
            isLoading: busy.value,
            onPressed: ready
                ? () {
                    // the iPad share sheet points at the button
                    final box = context.findRenderObject() as RenderBox?;
                    export(
                      box == null
                          ? null
                          : box.localToGlobal(Offset.zero) & box.size,
                    );
                  }
                : null,
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          FadeSlideIn(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionLabel(t.export.period),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final option in ExportPeriod.values)
                      ChoiceChip(
                        label: Text(switch (option) {
                          ExportPeriod.thisWeek => t.export.thisWeek,
                          ExportPeriod.lastWeek => t.export.lastWeek,
                          ExportPeriod.thisMonth => t.export.thisMonth,
                          ExportPeriod.lastMonth => t.export.lastMonth,
                          ExportPeriod.thisYear => t.export.thisYear,
                          ExportPeriod.custom => t.export.custom,
                        }),
                        avatar: option == ExportPeriod.custom
                            ? const Icon(AppIcons.dateRange, size: 18)
                            : null,
                        selected: period.value == option,
                        showCheckmark: false,
                        onSelected: (_) => option == ExportPeriod.custom
                            ? pickDates()
                            : period.value = option,
                      ),
                  ],
                ),
                if (range != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                    ),
                    child: Text(
                      exportPeriodLabel(t, locale, range.from, range.to),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  switch ((history, activities)) {
                    (AsyncValue(value: final days?), AsyncValue(value: _?)) =>
                      _Preview(days: days, range: range),
                    (AsyncError(:final error), _) ||
                    (_, AsyncError(:final error)) => ErrorView(
                      error: error,
                      onRetry: () => ref
                        ..invalidate(activitiesProvider)
                        ..invalidate(
                          reportHistoryProvider(from: range.from, to: range.to),
                        ),
                    ),
                    // the preview of the period
                    _ => const Shimmer(
                      child: SkeletonBox(height: 68, radius: AppRadius.lg),
                    ),
                  },
                ],
              ],
            ),
          ),
          const SizedBox(height: 22),
          FadeSlideIn(
            index: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionLabel(t.export.format),
                const SizedBox(height: AppSpacing.md),
                SectionCard(
                  children: [
                    for (final (value, icon, title, hint) in [
                      (
                        ReportFormat.pdf,
                        AppIcons.pdf,
                        t.export.pdf,
                        t.export.pdfHint,
                      ),
                      (
                        ReportFormat.csv,
                        AppIcons.csv,
                        t.export.csv,
                        t.export.csvHint,
                      ),
                      (
                        ReportFormat.text,
                        AppIcons.message,
                        t.export.text,
                        t.export.textHint,
                      ),
                    ])
                      _FormatTile(
                        icon: icon,
                        title: title,
                        hint: hint,
                        selected: format.value == value,
                        onTap: () => format.value = value,
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

/// "6 jours remplis sur 9 · 3 éléments", or that the period is empty.
class _Preview extends StatelessWidget {
  const _Preview({required this.days, required this.range});

  final List<DailyReport> days;
  final ({DateTime from, DateTime to}) range;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final total = range.from.daysUntil(range.to).length;
    final items = {
      for (final day in days)
        for (final entry in day.entries)
          if (entry.isFilled) entry.activityTypeId,
    };

    return AnimatedSwitcher(
      duration: AppMotion.of(context, AppMotion.medium),
      child: Container(
        key: ValueKey((range, days.length)),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: scheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Row(
          children: [
            Icon(
              days.isEmpty ? AppIcons.info : AppIcons.calendarCheck,
              color: scheme.onPrimaryContainer,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                days.isEmpty
                    ? t.export.empty
                    : t.export.preview(
                        filled: days.length,
                        total: total,
                        items: t.export.previewItems(n: items.length),
                      ),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: scheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormatTile extends StatelessWidget {
  const _FormatTile({
    required this.icon,
    required this.title,
    required this.hint,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String hint;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: selected
                ? scheme.primaryContainer
                : scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 21,
            color: selected ? scheme.primary : scheme.onSurfaceVariant,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          hint,
          style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
        ),
        trailing: Icon(
          selected ? AppIcons.radioOn : AppIcons.radioOff,
          color: selected ? scheme.primary : scheme.outline,
        ),
      ),
    );
  }
}
