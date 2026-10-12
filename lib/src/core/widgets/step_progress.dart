import 'package:flutter/material.dart';

import '../i18n/strings.g.dart';
import '../theme/app_spacing.dart';

/// "1 / 2" bars at the top of a multi-step form.
class StepProgress extends StatelessWidget {
  const StepProgress({required this.current, required this.total, super.key});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: ExcludeSemantics(
            child: Row(
              children: [
                for (var i = 1; i <= total; i++) ...[
                  if (i > 1) const SizedBox(width: 6),
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: i <= current
                            ? scheme.primary
                            : scheme.outlineVariant,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          context.t.auth.register.step(current: current, total: total),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
