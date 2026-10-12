import 'package:flutter/material.dart';

import '../i18n/strings.g.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_tones.dart';
import 'cmfi_logo.dart';

/// Placeholder of a module that has no API yet (hymns, prayer…).
class ComingSoonView extends StatelessWidget {
  const ComingSoonView({
    required this.module,
    required this.icon,
    required this.title,
    required this.message,
    this.onBack,
    super.key,
  });

  final AppModule module;
  final Widget icon;
  final String title;
  final String message;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final textTheme = Theme.of(context).textTheme;
    final tone = module.tone(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 36,
          vertical: AppSpacing.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: 132,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  BrandRing(
                    size: 132,
                    color: tone.onSoft.withValues(alpha: 0.16),
                    strokeWidth: 9,
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: tone.color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: IconTheme(
                      data: const IconThemeData(color: Colors.white, size: 32),
                      child: icon,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: tone.soft,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                t.comingSoon.badge,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: tone.onSoft,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            if (onBack != null) ...[
              const SizedBox(height: AppSpacing.xl),
              OutlinedButton(
                style: OutlinedButton.styleFrom(minimumSize: const Size(0, 48)),
                onPressed: onBack,
                child: Text(t.comingSoon.backHome),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
