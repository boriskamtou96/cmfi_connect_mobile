import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/password_field.dart';
import '../../../core/widgets/phone_field.dart';
import '../../../routing/app_router.dart';
import '../application/login_controller.dart';
import 'widgets/auth_footer.dart';

@RoutePage()
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final textTheme = Theme.of(context).textTheme;
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final state = ref.watch(loginControllerProvider);
    // a refused request pops up at the top of the screen
    ref.listen(loginControllerProvider, (_, next) {
      if (next case AsyncError(:final error)) {
        ref
            .read(toasterProvider)
            .of(context)
            .error(_loginErrorMessage(error, t));
      }
    });

    Future<void> submit() async {
      if (!(formKey.currentState?.validate() ?? false)) {
        return;
      }
      FocusScope.of(context).unfocus();
      final signedIn = await ref
          .read(loginControllerProvider.notifier)
          .submit(
            phoneNumber: phoneController.text,
            password: passwordController.text,
          );
      if (signedIn && context.mounted) {
        await context.router.replaceAll([const AppShellRoute()]);
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: AutofillGroup(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (context.router.canPop())
                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: AppSpacing.xs),
                      child: AppBackButton(),
                    ),
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.xl,
                      AppSpacing.lg,
                      AppSpacing.xl,
                      AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: CmfiLogo(size: 56),
                        ),
                        const SizedBox(height: AppSpacing.lg + 6),
                        Text(
                          t.auth.login.title,
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          t.auth.login.subtitle,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 26),
                        PhoneField(controller: phoneController),
                        const SizedBox(height: AppSpacing.lg),
                        PasswordField(
                          controller: passwordController,
                          onSubmitted: submit,
                        ),
                      ],
                    ),
                  ),
                ),
                AuthFooter(
                  button: AppButton(
                    label: t.auth.login.submit,
                    isLoading: state.isLoading,
                    onPressed: submit,
                  ),
                  question: t.auth.login.noAccount,
                  linkLabel: t.auth.login.createAccount,
                  onLink: () => context.router.replace(const RegisterRoute()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The API answers 404 for an unknown phone number: show the same message as a wrong
/// password, so the screen doesn't reveal which numbers have an account.
String _loginErrorMessage(Object error, Translations t) => switch (error) {
  ApiException(code: 'NOT_FOUND') => t.errors.invalidCredentials,
  _ => userMessageFor(error, t),
};
