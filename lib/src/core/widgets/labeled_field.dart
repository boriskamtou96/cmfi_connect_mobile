import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// A form field with its label above (the design never floats labels inside fields).
class LabeledField extends StatelessWidget {
  const LabeledField({
    required this.label,
    required this.child,
    this.optionalText,
    this.helper,
    super.key,
  });

  final String label;
  final String? optionalText;
  final String? helper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text.rich(
          TextSpan(
            text: label,
            children: [
              if (optionalText != null)
                TextSpan(
                  text: ' $optionalText',
                  style: TextStyle(fontWeight: FontWeight.w400, color: muted),
                ),
            ],
          ),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        child,
        if (helper != null) ...[
          const SizedBox(height: AppSpacing.xs + 2),
          Text(helper!, style: TextStyle(fontSize: 13, color: muted)),
        ],
      ],
    );
  }
}
