import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/date_extensions.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../members/presentation/widgets/member_avatar.dart';
import '../../application/overdue.dart';
import '../../domain/overdue.dart';
import '../../infrastructure/disciples_api.dart';

/// On top of Mes disciples: who hasn't filled their report for [overdueThresholds]
/// days, with a reminder (a push) in one touch, to one or to all.
class OverdueSection extends HookConsumerWidget {
  const OverdueSection({super.key});

  /// How many late disciples show before « Voir tout ».
  static const _shown = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.disciples;
    final scheme = Theme.of(context).colorScheme;
    final days = useState(overdueThresholds.first);
    final expanded = useState(false);
    final busy = useState(false);
    final provider = overdueDisciplesProvider(days: days.value);
    final overdue = ref.watch(provider).value;

    // nothing to say yet, or nobody shares
    if (overdue == null || overdue.sharing == 0) {
      return const SizedBox.shrink();
    }

    Future<void> remind(List<int> ids) async {
      final toast = ref.read(toasterProvider).of(context);
      final strings = context.t;
      busy.value = true;
      try {
        final result = await ref
            .read(disciplesApiProvider)
            .nudge(authorityIds: ids, days: days.value, today: today());
        toast.success(
          result.sent > 0 ? t.remindSent(n: result.sent) : t.remindNone,
        );
        ref.invalidate(provider);
      } on Object catch (error) {
        toast.error(userMessageFor(error, strings));
      } finally {
        busy.value = false;
      }
    }

    final late = overdue.overdue;
    final visible = expanded.value ? late : late.take(_shown).toList();
    final canNudge = late.where((d) => d.canNudge).length;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        0,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border.all(color: scheme.outlineVariant),
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      late.isEmpty
                          ? t.upToDateTitle
                          : t.overdueTitle(n: late.length),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  for (final value in overdueThresholds) ...[
                    const SizedBox(width: 6),
                    ChoiceChip(
                      label: Text(t.daysShort(n: value)),
                      selected: days.value == value,
                      visualDensity: VisualDensity.compact,
                      onSelected: (_) {
                        days.value = value;
                        expanded.value = false;
                      },
                    ),
                  ],
                ],
              ),
              if (late.isEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  t.upToDate,
                  style: TextStyle(
                    fontSize: 14,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
              for (final disciple in visible)
                _LateRow(
                  disciple: disciple,
                  busy: busy.value,
                  onRemind: () => remind([disciple.authorityId]),
                ),
              if (late.length > _shown)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton(
                    onPressed: () => expanded.value = !expanded.value,
                    child: Text(
                      expanded.value
                          ? t.showLess
                          : t.showAll(n: late.length - _shown),
                    ),
                  ),
                ),
              if (canNudge > 1) ...[
                const SizedBox(height: AppSpacing.sm),
                FilledButton.tonal(
                  onPressed: busy.value ? null : () => remind(const []),
                  child: Text(t.remindAll),
                ),
              ],
              if (overdue.notSharing > 0) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  t.overdueHidden(n: overdue.notSharing),
                  style: TextStyle(
                    fontSize: 13,
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

/// A late disciple: picture, name, how long, and the reminder.
class _LateRow extends StatelessWidget {
  const _LateRow({
    required this.disciple,
    required this.busy,
    required this.onRemind,
  });

  final OverdueDisciple disciple;
  final bool busy;
  final VoidCallback onRemind;

  @override
  Widget build(BuildContext context) {
    final t = context.t.disciples;
    final scheme = Theme.of(context).colorScheme;
    final member = disciple.member;
    final since = disciple.daysSince;

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Row(
        children: [
          MemberAvatar(
            initials: member.initials,
            photo: member.avatar,
            size: 36,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  since == null
                      ? t.never
                      : t.since(days: t.daysShort(n: since)),
                  style: TextStyle(
                    fontSize: 13,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (disciple.canNudge)
            OutlinedButton(
              // the theme's buttons fill the width: this one fits its text
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 40),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              ),
              onPressed: busy ? null : onRemind,
              child: Text(t.remind),
            )
          else
            Text(
              t.reminded,
              style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
            ),
        ],
      ),
    );
  }
}
