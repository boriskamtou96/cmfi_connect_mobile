import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/utils/date_extensions.dart';
import '../../../../core/utils/date_format.dart';
import '../../application/reports_providers.dart';

/// The 7 days of the selected day's week. A dot shows the days with a report;
/// an outlined dot, the past days without one. Future days can't be picked.
class WeekStrip extends ConsumerWidget {
  const WeekStrip({required this.selected, required this.onSelect, super.key});

  final DateTime selected;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final now = today();
    final reported =
        ref.watch(reportedDaysOfWeekProvider(selected)).value ??
        const <DateTime>{};
    final monday = selected.startOfWeek;
    final duration = AppMotion.of(context, AppMotion.medium);
    final baseStyle = DefaultTextStyle.of(context).style;

    return Row(
      children: [
        for (var i = 0; i < 7; i++)
          Expanded(
            child: Builder(
              key: ValueKey(
                DateTime(monday.year, monday.month, monday.day + i),
              ),
              builder: (context) {
                final day = DateTime(monday.year, monday.month, monday.day + i);
                final isSelected = day.isSameDay(selected);
                final isFuture = day.isAfter(now);
                final done = reported.contains(day);
                final foreground = isSelected
                    ? scheme.onPrimary
                    : isFuture
                    ? tones.disabled
                    : scheme.onSurface;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Semantics(
                    selected: isSelected,
                    button: !isFuture,
                    label: context.formatDate(day, 'EEEE d MMMM'),
                    excludeSemantics: true,
                    // the blue background moves to the picked day
                    child: AnimatedContainer(
                      duration: duration,
                      curve: AppMotion.standard,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? scheme.primary
                            : scheme.primary.withValues(alpha: 0),
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(AppRadius.md),
                          onTap: isFuture ? null : () => onSelect(day),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 66),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedDefaultTextStyle(
                                  duration: duration,
                                  curve: AppMotion.standard,
                                  style: baseStyle.merge(
                                    TextStyle(
                                      fontSize: 12,
                                      color: isSelected
                                          ? scheme.onPrimary.withValues(
                                              alpha: 0.75,
                                            )
                                          : isFuture
                                          ? tones.disabled
                                          : scheme.onSurfaceVariant,
                                    ),
                                  ),
                                  child: Text(
                                    context.formatDate(day, 'EEE'),
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                AnimatedDefaultTextStyle(
                                  duration: duration,
                                  curve: AppMotion.standard,
                                  style: baseStyle.merge(
                                    TextStyle(
                                      fontSize: 17,
                                      fontWeight: isSelected
                                          ? FontWeight.w800
                                          : FontWeight.w700,
                                      color: foreground,
                                    ),
                                  ),
                                  child: Text('${day.day}'),
                                ),
                                const SizedBox(height: 3),
                                _Dot(
                                  done: done,
                                  missing: !done && !isFuture,
                                  onSelected: isSelected,
                                  duration: duration,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

/// Filled: a report; outlined: a past day without one. Pops in when it appears.
class _Dot extends StatelessWidget {
  const _Dot({
    required this.done,
    required this.missing,
    required this.onSelected,
    required this.duration,
  });

  final bool done;
  final bool missing;

  /// On the blue background of the selected day.
  final bool onSelected;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: AppMotion.pop,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      child: AnimatedContainer(
        key: ValueKey((done, missing)),
        duration: duration,
        curve: AppMotion.standard,
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: done ? (onSelected ? AppColors.gold : scheme.primary) : null,
          border: missing
              ? Border.all(
                  color: onSelected
                      ? AppColors.goldLight
                      : AppTones.of(context).missing,
                  width: 1.5,
                )
              : null,
        ),
      ),
    );
  }
}
