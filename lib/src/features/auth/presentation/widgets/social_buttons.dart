import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/social_sign_in.dart';
import '../../../../core/session/account.dart';
import '../../../../core/session/session.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/adaptive.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../routing/app_router.dart';
import '../../infrastructure/auth_api.dart';

/// « Continuer avec Google / Apple », under « ou ». An account already linked
/// (or of the same email) signs in, then [onSignedIn]; the first time, the
/// member completes a profile (CompleteProfileScreen). Nothing without
/// Firebase.
class SocialButtons extends HookConsumerWidget {
  const SocialButtons({
    required this.onSignedIn,
    this.enabled = true,
    super.key,
  });

  final Future<void> Function(Account account) onSignedIn;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final social = ref.watch(socialSignInProvider);
    final offered = [
      for (final provider in SocialProvider.values)
        if (social.offers(provider)) provider,
    ];
    final busy = useState<SocialProvider?>(null);
    if (offered.isEmpty) {
      return const SizedBox.shrink();
    }

    Future<void> start(SocialProvider provider) async {
      final toast = ref.read(toasterProvider).of(context);
      busy.value = provider;
      try {
        final account = await social.signIn(provider);
        if (account == null) {
          return;
        }
        try {
          final response = await ref
              .read(authApiProvider)
              .socialSignIn(account.idToken);
          await ref
              .read(sessionProvider.notifier)
              .signIn(response.accessToken, account: response.account);
          await onSignedIn(response.account);
        } on ApiException catch (error) {
          if (error.code != 'NO_ACCOUNT') {
            rethrow;
          }
          // the first time: the number and the name
          if (context.mounted) {
            await context.router.push(CompleteProfileRoute(account: account));
          }
        }
      } on SocialSignInException catch (error) {
        toast.error(
          error.unavailable ? t.auth.social.unavailable : t.auth.social.failed,
        );
      } on AppException catch (error) {
        toast.error(userMessageFor(error, t));
      } finally {
        if (context.mounted) {
          busy.value = null;
        }
      }
    }

    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Divider(color: scheme.outlineVariant)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  t.auth.social.or,
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
              ),
              Expanded(child: Divider(color: scheme.outlineVariant)),
            ],
          ),
          for (final provider in offered) ...[
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: !enabled || busy.value != null
                  ? null
                  : () => start(provider),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              icon: busy.value == provider
                  ? const AppSpinner(size: 18, strokeWidth: 2.2)
                  : Icon(switch (provider) {
                      SocialProvider.google => AppIcons.google,
                      SocialProvider.apple => AppIcons.apple,
                    }),
              label: Text(t.auth.social.continueWith(provider: provider.label)),
            ),
          ],
        ],
      ),
    );
  }
}
