import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/document_picking.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/utils/xlsx.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../application/report_item_texts.dart';
import '../application/reports_providers.dart';
import '../domain/activity_type.dart';
import '../domain/daily_report.dart';
import '../domain/report_import.dart';
import '../infrastructure/reports_api.dart';

const _sheetType =
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';

/// A file read and compared with what the account already has.
typedef _Plan = ({
  String name,
  ReportImport read,

  /// The days to fill, the oldest first, and those left as they are.
  List<DateTime> toFill,
  int alreadyFilled,
});

/// « Importer depuis Excel » (13/11/2026): past days filled from a sheet
/// instead of one by one. Three steps on one page: get the model (the
/// member's own items as columns), choose the file filled, see what it would
/// do, import. A day that already has a report is never replaced.
@RoutePage()
class ImportReportScreen extends HookConsumerWidget {
  const ImportReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final activities = ref.watch(activitiesProvider);
    final plan = useState<_Plan?>(null);
    final reading = useState(false);
    // days sent so far, null when no import runs
    final sent = useState<int?>(null);
    final done = useState<({int saved, int failed})?>(null);

    String header(ActivityType item, {required bool duration}) => importHeader(
      item,
      duration: duration,
      label: t.itemLabel(item.code, item.label, standard: item.isStandard),
      unit: t
          .itemUnit(item.code, item.quantityUnit, standard: item.isStandard)
          ?.symbol,
    );

    Future<void> shareModel(List<ActivityType> items, Rect? origin) async {
      final yesterday = today().subtract(const Duration(days: 1));
      final columns = [
        for (final item in items) ...[
          if (item.tracksQuantity) header(item, duration: false),
          if (item.tracksDuration) header(item, duration: true),
        ],
      ];
      final bytes = writeXlsx([
        [t.sheetImport.dateColumn, ...columns],
        // two days to show how a row is written
        [yesterday.toApiDate()],
        [yesterday.subtract(const Duration(days: 1)).toApiDate()],
      ], sheet: t.reports.title);
      await ref
          .read(shareServiceProvider)
          .shareFile(
            bytes,
            name: '${t.sheetImport.modelName}.xlsx',
            mimeType: _sheetType,
            origin: origin,
          );
    }

    Future<void> choose(List<ActivityType> items) async {
      final toast = ref.read(toasterProvider).of(context);
      final file = await ref
          .read(documentPickingProvider)
          .pickOne(among: DocumentPicking.sheets);
      if (file == null) {
        return;
      }
      reading.value = true;
      done.value = null;
      try {
        final read = ReportImport.read(
          readXlsx(file.bytes),
          items: items,
          now: today(),
          fromSerial: excelDate,
        );
        // the days that already have a report are left as they are
        final filled = <DateTime>{};
        final days = read.days.keys.toList()..sort();
        if (days.isNotEmpty) {
          final api = ref.read(reportsApiProvider);
          // the server gives 366 days at most at once
          for (
            var from = days.first;
            !from.isAfter(days.last);
            from = from.add(const Duration(days: 366))
          ) {
            final to = from.add(const Duration(days: 365));
            final history = await api.history(
              from: from,
              to: to.isAfter(days.last) ? days.last : to,
            );
            filled.addAll(history.map((day) => day.date.dateOnly));
          }
        }
        if (context.mounted) {
          plan.value = (
            name: file.name,
            read: read,
            toFill: [
              for (final day in days)
                if (!filled.contains(day)) day,
            ],
            alreadyFilled: days.where(filled.contains).length,
          );
        }
      } on FormatException {
        toast.error(t.sheetImport.notExcel);
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      } finally {
        if (context.mounted) {
          reading.value = false;
        }
      }
    }

    Future<void> run(_Plan current) async {
      final api = ref.read(reportsApiProvider);
      var saved = 0;
      var failed = 0;
      sent.value = 0;
      for (final day in current.toFill) {
        try {
          await api.saveDay(
            day,
            note: '',
            entries: current.read.days[day] ?? const <ReportEntry>[],
          );
          saved++;
        } on NetworkException {
          // no network: the rest would fail the same way
          failed = current.toFill.length - saved;
          break;
        } on Object {
          failed++;
        }
        if (!context.mounted) {
          return;
        }
        sent.value = saved + failed;
      }
      // the history, the summary and the streak count the new days
      ref
        ..invalidate(lastHistoryProvider)
        ..invalidate(reportHistoryProvider)
        ..invalidate(reportSummaryProvider)
        ..invalidate(reportStreakDetailProvider)
        ..invalidate(reportedDaysOfWeekProvider);
      if (context.mounted) {
        sent.value = null;
        plan.value = null;
        done.value = (saved: saved, failed: failed);
      }
    }

    Widget step(int number, String title, String text, Widget action) =>
        SectionCard(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$number',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: scheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  action,
                ],
              ),
            ),
          ],
        );

    return SubPage(
      title: t.sheetImport.title,
      child: switch (activities) {
        AsyncData(value: final items) => ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              t.sheetImport.intro,
              style: TextStyle(
                fontSize: 14.5,
                height: 1.4,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            step(
              1,
              t.sheetImport.modelTitle,
              t.sheetImport.modelText,
              Builder(
                builder: (context) => OutlinedButton.icon(
                  onPressed: () {
                    final box = context.findRenderObject() as RenderBox?;
                    shareModel(
                      items,
                      box == null
                          ? null
                          : box.localToGlobal(Offset.zero) & box.size,
                    );
                  },
                  icon: const Icon(AppIcons.download, size: 20),
                  label: Text(t.sheetImport.modelButton),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            step(
              2,
              t.sheetImport.fileTitle,
              t.sheetImport.fileText,
              OutlinedButton.icon(
                onPressed: reading.value || sent.value != null
                    ? null
                    : () => choose(items),
                icon: reading.value
                    ? const AppSpinner(size: 18)
                    : const Icon(AppIcons.spreadsheet, size: 20),
                label: Text(
                  plan.value == null
                      ? t.sheetImport.fileButton
                      : plan.value!.name,
                ),
              ),
            ),
            if (plan.value case final current?) ...[
              const SizedBox(height: AppSpacing.md),
              _Preview(plan: current),
              const SizedBox(height: AppSpacing.lg),
              if (sent.value case final count?)
                Column(
                  children: [
                    LinearProgressIndicator(
                      value: current.toFill.isEmpty
                          ? null
                          : count / current.toFill.length,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      t.sheetImport.progress(
                        done: count,
                        total: current.toFill.length,
                      ),
                    ),
                  ],
                )
              else
                AppButton(
                  label: t.sheetImport.run(n: current.toFill.length),
                  onPressed: current.toFill.isEmpty ? null : () => run(current),
                ),
            ],
            if (done.value case final result?) ...[
              const SizedBox(height: AppSpacing.md),
              Semantics(
                liveRegion: true,
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: Color.alphaBlend(
                      AppColors.success.withValues(alpha: 0.12),
                      scheme.surface,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      const Icon(AppIcons.right, color: AppColors.success),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          [
                            t.sheetImport.saved(n: result.saved),
                            if (result.failed > 0)
                              t.sheetImport.failed(n: result.failed),
                          ].join(' '),
                          style: const TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(activitiesProvider),
        ),
        _ => const LoadingList(),
      },
    );
  }
}

/// What the file chosen would do, before anything is sent.
class _Preview extends StatelessWidget {
  const _Preview({required this.plan});

  final _Plan plan;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final read = plan.read;
    final locale = LocaleSettings.currentLocale.languageCode;

    Widget line(IconData icon, Color color, String text) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(text, style: const TextStyle(height: 1.35))),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          line(
            AppIcons.right,
            AppColors.success,
            plan.toFill.isEmpty
                ? t.sheetImport.nothing
                : '${t.sheetImport.toFill(n: plan.toFill.length)} '
                      '(${context.formatDate(plan.toFill.first, 'd MMM y')} – '
                      '${context.formatDate(plan.toFill.last, 'd MMM y')})',
          ),
          if (plan.alreadyFilled > 0)
            line(
              AppIcons.info,
              scheme.onSurfaceVariant,
              t.sheetImport.alreadyFilled(n: plan.alreadyFilled),
            ),
          if (read.future > 0)
            line(
              AppIcons.info,
              scheme.onSurfaceVariant,
              t.sheetImport.future(n: read.future),
            ),
          if (read.badRows.isNotEmpty)
            line(
              AppIcons.wrong,
              scheme.error,
              t.sheetImport.badRows(
                n: read.badRows.length,
                rows: read.badRows.take(8).join(locale == 'ar' ? '، ' : ', '),
              ),
            ),
          if (read.unknownColumns.isNotEmpty)
            line(
              AppIcons.wrong,
              scheme.error,
              t.sheetImport.unknownColumns(
                columns: read.unknownColumns.take(4).join(' · '),
              ),
            ),
        ],
      ),
    );
  }
}
