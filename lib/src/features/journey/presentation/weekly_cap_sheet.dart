import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../application/weekly_caps.dart';
import '../domain/weekly_cap.dart';
import 'progress_texts.dart';

/// The three caps proposed for a week; one tap chooses, one tap passes. No
/// penalty, no reminder that makes the member feel guilty.
Future<void> showWeeklyCapSheet(BuildContext context, {DateTime? week}) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SingleChildScrollView(
        child: _WeeklyCapSheet(week: (week ?? today()).startOfWeek),
      ),
    );

class _WeeklyCapSheet extends ConsumerWidget {
  const _WeeklyCapSheet({required this.week});

  final DateTime week;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.gamification.cap;
    final scheme = Theme.of(context).colorScheme;
    final options = ref.watch(weeklyCapOptionsProvider);
    final current = ref.watch(weeklyCapsProvider)[week];

    Future<void> choose(WeeklyCapSuggestion suggestion) async {
      await ref
          .read(weeklyCapsProvider.notifier)
          .choose(kind: suggestion.kind, target: suggestion.target, week: week);
      unawaited(HapticFeedback.selectionClick());
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }

    Future<void> skip() async {
      await ref.read(weeklyCapSkipsProvider.notifier).skip(week);
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xl,
          AppSpacing.sm,
          AppSpacing.xl,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(t.sheetTitle, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.sheetText,
              style: TextStyle(
                fontSize: 14,
                height: 1.45,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            switch (options) {
              AsyncValue(value: final list?) => Column(
                children: [
                  for (final suggestion in list)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _OptionTile(
                        suggestion: suggestion,
                        selected:
                            current?.kind == suggestion.kind &&
                            current?.target == suggestion.target,
                        onTap: () => choose(suggestion),
                      ),
                    ),
                ],
              ),
              AsyncError() => OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () => ref.invalidate(weeklyCapOptionsProvider),
                icon: const Icon(AppIcons.retry, size: 18),
                label: Text(context.t.common.retry),
              ),
              _ => const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                child: Center(child: CircularProgressIndicator()),
              ),
            },
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                foregroundColor: scheme.onSurfaceVariant,
              ),
              onPressed: skip,
              child: Text(t.skip),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.suggestion,
    required this.selected,
    required this.onTap,
  });

  final WeeklyCapSuggestion suggestion;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final icon = switch (suggestion.kind) {
      CapKind.reports => AppIcons.reports,
      CapKind.retreats => AppIcons.prayer,
      CapKind.chapters => AppIcons.bible,
    };
    return Material(
      color: selected ? scheme.primaryContainer : scheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 21, color: scheme.primary),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    capGoalText(t, suggestion.kind, suggestion.target),
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (selected)
                  Icon(
                    AppIcons.checkCircleFilled,
                    size: 22,
                    color: scheme.primary,
                  )
                else
                  Icon(
                    AppIcons.chevronRight,
                    size: 18,
                    color: scheme.onSurfaceVariant,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
