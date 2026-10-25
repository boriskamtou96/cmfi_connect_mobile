import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../application/collective_walk.dart';

/// « La marche du groupe »: the walk of the member's disciples this week, as
/// an aggregate. No name, no ranking, no one singled out.
class CollectiveCard extends ConsumerWidget {
  const CollectiveCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.gamification.collective;
    final scheme = Theme.of(context).colorScheme;
    final walk = ref.watch(collectiveWalkProvider);
    // wait for the first answer: no flash of "no disciple" for a disciple maker
    if (walk.isLoading && !walk.hasValue) {
      return const SizedBox.shrink();
    }
    // offline: better nothing than a wrong "no disciple"
    if (walk.hasError && !walk.hasValue) {
      return const SizedBox.shrink();
    }
    final data = walk.value;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl - 4),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(AppIcons.authorities, size: 18, color: scheme.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  t.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (data == null)
            Text(
              t.noDisciples,
              style: TextStyle(
                fontSize: 14,
                height: 1.45,
                color: scheme.onSurfaceVariant,
              ),
            )
          else ...[
            if (data.walkers > 0) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: data.ratio,
                  minHeight: 7,
                  color: scheme.primary,
                  backgroundColor: scheme.surfaceContainerHighest,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                t.sharedThisWeek(n: data.walkers, total: data.disciples),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
            ] else
              Text(
                t.empty,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            const SizedBox(height: 4),
            Text(
              t.reports(n: data.reports),
              style: TextStyle(
                fontSize: 13.5,
                height: 1.4,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.anonymous,
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                color: scheme.outline,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
