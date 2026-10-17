import 'package:flutter/material.dart';

import '../theme/app_icons.dart';
import '../theme/app_spacing.dart';
import 'adaptive_pickers.dart';
import 'section_card.dart';

/// "Rappel chaque jour  07:00  [on]" on a single line: a daily reminder,
/// its time a tap away.
class ReminderRow extends StatelessWidget {
  const ReminderRow({
    required this.label,
    required this.timeLabel,
    required this.on,
    required this.minutes,
    required this.onChanged,
    required this.onTime,
    super.key,
  });

  /// "Rappel chaque jour".
  final String label;

  /// "Heure du rappel": read with the time by screen readers.
  final String timeLabel;
  final bool on;
  final int minutes;
  final ValueChanged<bool> onChanged;
  final ValueChanged<int> onTime;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final time = TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
    return SectionCard(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.xs,
            AppSpacing.sm,
            AppSpacing.xs,
          ),
          child: Row(
            children: [
              Icon(AppIcons.reminder, color: scheme.onSurfaceVariant),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              if (on)
                TextButton(
                  onPressed: () async {
                    final picked = await showAppTimePicker(
                      context,
                      initialTime: time,
                      use24h: true,
                    );
                    if (picked != null) {
                      onTime(picked.hour * 60 + picked.minute);
                    }
                  },
                  child: Text(
                    time.format(context),
                    semanticsLabel: '$timeLabel ${time.format(context)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              Switch.adaptive(value: on, onChanged: onChanged),
            ],
          ),
        ),
      ],
    );
  }
}
