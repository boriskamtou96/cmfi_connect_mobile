import 'package:flutter/material.dart';

import '../i18n/strings.g.dart';
import '../network/app_exception_message.dart';
import '../theme/app_icons.dart';
import '../theme/app_spacing.dart';

/// Full-area error state for an AsyncError: translated message + "Try again".
class ErrorView extends StatelessWidget {
  const ErrorView({required this.error, this.onRetry, super.key});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              AppIcons.error,
              size: 40,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(userMessageFor(error, t), textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              OutlinedButton(onPressed: onRetry, child: Text(t.common.retry)),
            ],
          ],
        ),
      ),
    );
  }
}
