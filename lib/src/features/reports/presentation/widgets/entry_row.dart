import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/animated_progress_bar.dart';
import '../../../../core/widgets/code_chip.dart';
import '../../application/report_item_texts.dart';
import '../../domain/daily_report.dart';
import '../../domain/measure_format.dart';
import '../../domain/report_goal.dart';
import 'measure_labels.dart';

/// One item of the day: code, name, what it measures, and its value or a "+" button.
class EntryRow extends StatelessWidget {
  const EntryRow({
    required this.entry,
    required this.personal,
    required this.onTap,
    this.goal,
    super.key,
  });

  final ReportEntry entry;
  final bool personal;
  final VoidCallback onTap;

  /// The item's daily goal: its progress shows under the name.
  final ReportGoal? goal;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final accent = personal ? tones.personal : scheme.primary;
    final accentSoft = personal ? tones.personalSoft : scheme.primaryContainer;
    final label = t.itemLabel(entry.code, entry.label);
    final unit = t.itemUnit(entry.code, entry.quantityUnit);
    final value = MeasureFormat.value(
      quantity: entry.quantity,
      minutes: entry.durationMinutes,
      unit: unit,
    );
    final goal = this.goal;
    final reached =
        goal?.reachedBy(
          quantity: entry.quantity,
          minutes: entry.durationMinutes,
        ) ??
        false;
    final goalText = goal == null
        ? null
        : reached
        ? t.reports.goalReached
        : t.reports.goal(value: goalLabel(goal, unit));

    return Semantics(
      button: true,
      label: [
        if (entry.isFilled) '$label, $value' else t.reports.add(label: label),
        ?goalText,
      ].join(', '),
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 58),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              children: [
                CodeChip(
                  code: entry.code,
                  personal: personal,
                  filled: entry.isFilled,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (goal == null)
                        Text(
                          measureSubtitle(
                            t,
                            quantity: entry.tracksQuantity,
                            duration: entry.tracksDuration,
                            unit: unit,
                          ),
                          style: TextStyle(
                            fontSize: 12,
                            color: scheme.onSurfaceVariant,
                          ),
                        )
                      else ...[
                        Row(
                          children: [
                            if (reached) ...[
                              Icon(
                                AppIcons.checkCircleFilled,
                                size: 14,
                                color: accent,
                              ),
                              const SizedBox(width: 4),
                            ],
                            Flexible(
                              child: Text(
                                goalText!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: reached
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  color: reached
                                      ? accent
                                      : scheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 140),
                          child: AnimatedProgressBar(
                            value: goal.progress(
                              quantity: entry.quantity,
                              minutes: entry.durationMinutes,
                            ),
                            minHeight: 4,
                            color: accent,
                            backgroundColor: scheme.outlineVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // the "+" square turns into the value, a value into the next one
                AnimatedSwitcher(
                  duration: AppMotion.of(context, AppMotion.medium),
                  switchInCurve: AppMotion.standard,
                  switchOutCurve: Curves.easeInCubic,
                  layoutBuilder: (current, previous) => Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [...previous, ?current],
                  ),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation.drive(Tween(begin: 0.6, end: 1)),
                      alignment: AlignmentDirectional.centerEnd.resolve(
                        Directionality.of(context),
                      ),
                      child: child,
                    ),
                  ),
                  child: entry.isFilled
                      ? ConstrainedBox(
                          key: ValueKey(value),
                          constraints: const BoxConstraints(maxWidth: 150),
                          child: Text(
                            value,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: accent,
                            ),
                          ),
                        )
                      : Container(
                          key: const ValueKey('add'),
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: accentSoft,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(AppIcons.add, size: 20, color: accent),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// "3 chapitres", "1 h", "2 fois · 30 min": a goal written like a value.
String goalLabel(ReportGoal goal, ItemUnit? unit) => MeasureFormat.value(
  quantity: goal.quantity,
  minutes: goal.minutes,
  unit: unit,
);
