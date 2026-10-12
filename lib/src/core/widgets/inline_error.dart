import 'package:flutter/material.dart';

import '../theme/app_icons.dart';
import '../theme/app_spacing.dart';

/// Error message shown inside a form (wrong password, code already used…).
class InlineError extends StatelessWidget {
  const InlineError(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: scheme.errorContainer,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(AppIcons.error, size: 20, color: scheme.error),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: scheme.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
