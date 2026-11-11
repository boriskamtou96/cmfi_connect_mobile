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
/// Firebase. [compact]: two round buttons under « ou continuer avec » (the
/// welcome screen), instead of the wide ones under « ou ».
class SocialButtons extends HookConsumerWidget {
  const SocialButtons({
    required this.onSignedIn,
    this.enabled = true,
    this.compact = false,
    super.key,
  });

  final Future<void> Function(Account account) onSignedIn;
  final bool enabled;
  final bool compact;

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
    if (compact) {
      return _RoundButtons(
        offered: offered,
        busy: busy.value,
        enabled: enabled,
        onTap: start,
      );
    }
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
                  : _ProviderIcon(provider),
              label: Text(t.auth.social.continueWith(provider: provider.label)),
            ),
          ],
        ],
      ),
    );
  }
}

/// « ou continuer avec » and one round button per provider.
class _RoundButtons extends StatelessWidget {
  const _RoundButtons({
    required this.offered,
    required this.busy,
    required this.enabled,
    required this.onTap,
  });

  final List<SocialProvider> offered;
  final SocialProvider? busy;
  final bool enabled;
  final void Function(SocialProvider provider) onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: scheme.outlineVariant)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                t.auth.social.orWith,
                style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
              ),
            ),
            Expanded(child: Divider(color: scheme.outlineVariant)),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final (index, provider) in offered.indexed) ...[
              if (index > 0) const SizedBox(width: AppSpacing.lg),
              Tooltip(
                message: t.auth.social.continueWith(provider: provider.label),
                child: IconButton(
                  onPressed: !enabled || busy != null
                      ? null
                      : () => onTap(provider),
                  style: IconButton.styleFrom(
                    fixedSize: const Size.square(52),
                    // Apple asks for a black (or white) button, Google a white one
                    backgroundColor: provider == SocialProvider.apple
                        ? (dark ? Colors.white : Colors.black)
                        : (dark ? scheme.surfaceContainerHigh : Colors.white),
                    foregroundColor: provider == SocialProvider.apple
                        ? (dark ? Colors.black : Colors.white)
                        : scheme.onSurface,
                    side: provider == SocialProvider.google
                        ? BorderSide(color: scheme.outlineVariant)
                        : null,
                  ),
                  icon: busy == provider
                      ? const AppSpinner(size: 18, strokeWidth: 2.2)
                      : _ProviderIcon(provider),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

/// The mark of the provider: the Google « G » in its four colors (their sign-in
/// guidelines ask for it), Apple's logo in the color of the button.
class _ProviderIcon extends StatelessWidget {
  const _ProviderIcon(this.provider);

  final SocialProvider provider;

  @override
  Widget build(BuildContext context) => switch (provider) {
    SocialProvider.google => Image.asset(
      'assets/social/google_g.png',
      width: 22,
      height: 22,
      filterQuality: FilterQuality.medium,
      excludeFromSemantics: true,
    ),
    SocialProvider.apple => const Icon(AppIcons.apple),
  };
}
