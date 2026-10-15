import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/code_chip.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../application/report_goals.dart';
import '../application/report_item_texts.dart';
import '../application/reports_providers.dart';
import '../domain/activity_type.dart';
import '../domain/daily_report.dart';
import '../domain/measure_format.dart';
import '../domain/report_goal.dart';
import '../infrastructure/activities_api.dart';
import 'new_item_screen.dart';
import 'widgets/entry_row.dart';
import 'widgets/entry_sheet.dart';
import 'widgets/measure_labels.dart';

/// "My items": the standard items, the user's own (archivable), and a way to create one.
@RoutePage()
class ItemsScreen extends HookConsumerWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final activities = ref.watch(activitiesProvider);
    final goals = ref.watch(reportGoalsProvider);
    final archiving = useState<int?>(null);

    Future<void> editGoal(ActivityType item) async {
      final goal = goals[item.id];
      final values = await showEntrySheet(
        context,
        entry: ReportEntry(
          activityTypeId: item.id,
          code: item.code,
          label: item.label,
          tracksQuantity: item.tracksQuantity,
          quantityUnit: item.quantityUnit,
          tracksDuration: item.tracksDuration,
          quantity: goal?.quantity,
          durationMinutes: goal?.minutes,
        ),
        personal: !item.isStandard,
        caption: '${t.items.goalTitle}. ${t.items.goalHint}',
        clearLabel: t.items.goalRemove,
      );
      if (values == null || !context.mounted) {
        return;
      }
      final next = ReportGoal(
        quantity: values.quantity,
        minutes: values.durationMinutes,
      );
      await ref.read(reportGoalsProvider.notifier).set(item.id, next);
      if (context.mounted) {
        ref
            .read(toasterProvider)
            .of(context)
            .success(next.isEmpty ? t.items.goalRemoved : t.items.goalSaved);
      }
    }

    Future<void> archive(ActivityType item) async {
      final confirmed = await showConfirmDialog(
        context,
        title: t.items.archiveTitle(code: item.code),
        text: t.items.archiveText,
        confirmLabel: t.items.archive,
      );
      if (!confirmed || !context.mounted) {
        return;
      }

      final toast = ref.read(toasterProvider).of(context);
      archiving.value = item.id;
      try {
        await ref.read(activitiesApiProvider).archive(item.id);
        ref.invalidate(activitiesProvider);
        toast.success(t.items.archived(code: item.code));
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      } finally {
        if (context.mounted) {
          archiving.value = null;
        }
      }
    }

    ItemUnit? unitOf(ActivityType item) =>
        t.itemUnit(item.code, item.quantityUnit, standard: item.isStandard);

    Widget goalLine(ActivityType item) {
      final goal = goals[item.id];
      final color = goal == null
          ? scheme.onSurfaceVariant
          : item.isStandard
          ? scheme.primary
          : AppTones.of(context).personal;
      return Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Row(
          children: [
            Icon(
              goal == null ? AppIcons.add : AppIcons.goal,
              size: 14,
              color: color,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                goal == null
                    ? t.items.goalAdd
                    : t.items.goal(value: goalLabel(goal, unitOf(item))),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // tapping an item sets its daily goal
    Widget row(ActivityType item, {Widget? trailing}) => InkWell(
      onTap: () => editGoal(item),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(
          14,
          AppSpacing.sm,
          trailing == null ? 14 : 10,
          AppSpacing.sm,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 40),
          child: Row(
            children: [
              CodeChip(code: item.code, personal: !item.isStandard),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.itemLabel(
                        item.code,
                        item.label,
                        standard: item.isStandard,
                      ),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      measureDescription(
                        t,
                        quantity: item.tracksQuantity,
                        duration: item.tracksDuration,
                        unit: unitOf(item),
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    goalLine(item),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );

    return SubPage(
      title: t.items.title,
      child: switch (activities) {
        AsyncValue(value: final items?) => RefreshIndicator.adaptive(
          onRefresh: () => ref
              .refresh(activitiesProvider.future)
              .then((_) {}, onError: (_) {}),
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
                    SectionLabel(t.items.standardSection),
                    const SizedBox(height: AppSpacing.md),
                    SectionCard(
                      children: [
                        for (final item in items.where(
                          (item) => item.isStandard,
                        ))
                          row(item),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              FadeSlideIn(
                index: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionLabel(t.items.personalSection),
                    const SizedBox(height: AppSpacing.md),
                    SectionCard(
                      children: [
                        for (final item in items.where(
                          (item) => !item.isStandard,
                        ))
                          row(
                            item,
                            trailing: OutlinedButton(
                              onPressed: archiving.value == null
                                  ? () => archive(item)
                                  : null,
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(0, 44),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                ),
                                side: BorderSide(color: scheme.outlineVariant),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                textStyle: const TextStyle(
                                  fontFamily: AppTheme.fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: archiving.value == item.id
                                  ? const AppSpinner(size: 16, strokeWidth: 2)
                                  : Text(t.items.archive),
                            ),
                          ),
                        if (items.every((item) => item.isStandard))
                          Padding(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            child: Text(
                              t.items.emptyPersonal,
                              style: TextStyle(color: scheme.onSurfaceVariant),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              FadeSlideIn(
                index: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // the button grows into the form
                    OpenPage(
                      page: const NewItemScreen(),
                      color: scheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      builder: (context, open) => FilledButton.icon(
                        onPressed: open,
                        icon: const Icon(AppIcons.add),
                        label: Text(t.items.create),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                      ),
                      child: Text(
                        t.items.footnote,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(activitiesProvider),
        ),
        // the items: their code, name, measure and goal
        _ => const LoadingList(count: 8, leading: 36, round: false, lines: 3),
      },
    );
  }
}
