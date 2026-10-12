import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';

/// Main button + "No account yet? Create one" link, pinned at the bottom of the auth forms.
class AuthFooter extends StatelessWidget {
  const AuthFooter({
    required this.button,
    required this.question,
    required this.linkLabel,
    required this.onLink,
    super.key,
  });

  final Widget button;
  final String question;
  final String linkLabel;
  final VoidCallback onLink;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          button,
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                question,
                style: TextStyle(fontSize: 15, color: scheme.onSurfaceVariant),
              ),
              TextButton(
                onPressed: onLink,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                ),
                child: Text(
                  linkLabel,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
