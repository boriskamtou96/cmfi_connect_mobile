import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/adaptive_pickers.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/segmented_tabs.dart';
import '../../../core/widgets/tab_page.dart';
import '../../../routing/app_router.dart';
import '../application/pending_reports.dart';
import '../application/reports_providers.dart';
import 'widgets/history_view.dart';
import 'widgets/summary_view.dart';
import 'widgets/today_view.dart';

/// Reports tab: Today | History | Summary.
@RoutePage()
class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final view = ref.watch(selectedReportsViewProvider);
    final pending = ref.watch(pendingReportsProvider);
    final day = ref.watch(selectedReportDayProvider) ?? today();
    final duration = AppMotion.of(context, AppMotion.medium);

    void openDay(DateTime date) {
      ref.read(selectedReportDayProvider.notifier).select(date);
      ref.read(selectedReportsViewProvider.notifier).select(ReportsView.today);
    }

    Future<void> pickDay() async {
      final picked = await showAppDatePicker(
        context,
        initialDate: day,
        firstDate: DateTime(2020),
        lastDate: today(),
        helpText: t.reports.pickDay,
      );
      if (picked != null) {
        openDay(picked);
      }
    }

    final squareStyle = IconButton.styleFrom(
      fixedSize: const Size.square(44),
      backgroundColor: scheme.surface,
      side: BorderSide(color: scheme.outlineVariant),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md),
      ),
    );

    return TabPage(
      title: t.reports.title,
      actions: [
        if (view == ReportsView.today) ...[
          IconButton.outlined(
            tooltip: t.reports.pickDay,
            style: squareStyle,
            onPressed: pickDay,
            icon: const Icon(AppIcons.calendar, size: 22),
          ),
          const SizedBox(width: AppSpacing.sm),
        ] else ...[
          IconButton.outlined(
            tooltip: t.reports.export,
            style: squareStyle,
            onPressed: () => context.router.push(const ExportReportRoute()),
            icon: const Icon(AppIcons.share, size: 21),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        IconButton.outlined(
          tooltip: t.reports.myItems,
          style: squareStyle,
          onPressed: () => context.router.push(const ItemsRoute()),
          icon: const Icon(AppIcons.items, size: 22),
        ),
      ],
      bottom: AnimatedSwitcher(
        duration: duration,
        switchInCurve: AppMotion.emphasized,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) => SizeTransition(
          sizeFactor: animation,
          axisAlignment: 1,
          child: child,
        ),
        child: view == ReportsView.today
            ? SaveDayBar(day: day)
            : const SizedBox.shrink(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.xs,
              AppSpacing.lg,
              0,
            ),
            child: SegmentedTabs(
              labels: [
                t.reports.tabs.today,
                t.reports.tabs.history,
                t.reports.tabs.summary,
              ],
              selectedIndex: view.index,
              onChanged: (index) => ref
                  .read(selectedReportsViewProvider.notifier)
                  .select(ReportsView.values[index]),
            ),
          ),
          // days saved offline: said once here, sent by themselves
          AnimatedSize(
            duration: duration,
            curve: AppMotion.standard,
            child: pending.isEmpty
                ? const SizedBox(width: double.infinity)
                : _PendingBanner(
                    count: pending.length,
                    onRetry: ref.read(pendingReportsProvider.notifier).send,
                  ),
          ),
          Expanded(
            // the tabs sit side by side: the view slides in from the tab tapped
            child: SharedAxisSwitcher(
              index: view.index,
              child: switch (view) {
                ReportsView.today => TodayView(day: day),
                ReportsView.history => HistoryView(onOpenDay: openDay),
                ReportsView.summary => const SummaryView(),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingBanner extends StatelessWidget {
  const _PendingBanner({required this.count, required this.onRetry});

  final int count;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        0,
      ),
      child: Semantics(
        liveRegion: true,
        child: Container(
          padding: const EdgeInsetsDirectional.fromSTEB(14, 4, 4, 4),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              Icon(AppIcons.offline, size: 18, color: scheme.onSurfaceVariant),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  t.reports.pendingBanner(n: count),
                  style: TextStyle(
                    fontSize: 13,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              TextButton(onPressed: onRetry, child: Text(t.common.retry)),
            ],
          ),
        ),
      ),
    );
  }
}
