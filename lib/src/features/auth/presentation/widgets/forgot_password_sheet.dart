import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/services/link_launcher.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';

/// Where to ask for help (the same as Plus › Nous contacter).
const _teamEmail = 'info@cmfi-connect.com';

/// « Mot de passe oublié ? »: no SMS (it costs), an admin gives a temporary
/// password from the back office; the app asks for a new one at the next
/// sign-in.
Future<void> showForgotPasswordSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const _ForgotPasswordSheet(),
    );

class _ForgotPasswordSheet extends ConsumerWidget {
  const _ForgotPasswordSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.auth.forgot;
    final scheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl,
        AppSpacing.sm,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                AppIcons.forgotPassword,
                size: 28,
                color: scheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(t.link, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.adminText,
            style: TextStyle(
              fontSize: 15,
              height: 1.45,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.adminNext,
            style: TextStyle(
              fontSize: 15,
              height: 1.45,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.tonalIcon(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () => unawaited(
              ref
                  .read(linkLauncherProvider)
                  .open(
                    Uri(
                      scheme: 'mailto',
                      path: _teamEmail,
                      query: 'subject=${Uri.encodeComponent(t.mailSubject)}',
                    ),
                  ),
            ),
            icon: const Icon(AppIcons.contactTile),
            label: Text(t.writeTeam),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(t.remembered),
          ),
        ],
      ),
    );
  }
}
