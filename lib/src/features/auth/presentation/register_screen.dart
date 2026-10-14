import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/phone.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../core/widgets/password_field.dart';
import '../../../core/widgets/phone_field.dart';
import '../../../core/widgets/step_progress.dart';
import '../../../routing/app_router.dart';
import '../../members/presentation/widgets/username_field.dart';
import '../application/register_controller.dart';
import 'widgets/auth_footer.dart';

/// Sign-up, step 1 of 2: who you are. Step 2 (your church) is ChurchFormScreen.
@RoutePage()
class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final textTheme = Theme.of(context).textTheme;
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final country = ref.watch(phoneCountryProvider);
    final passwordController = useTextEditingController();
    final emailController = useTextEditingController();
    final usernameController = useTextEditingController();
    // the pseudos offered follow the name being typed
    final firstName = useValueListenable(firstNameController).text;
    final lastName = useValueListenable(lastNameController).text;
    final state = ref.watch(registerControllerProvider);
    // a refused request pops up at the top of the screen
    ref.listen(registerControllerProvider, (_, next) {
      if (next case AsyncError(:final error)) {
        ref
            .read(toasterProvider)
            .of(context)
            .error(_registerErrorMessage(error, t));
      }
    });

    String? required(String? value) =>
        (value ?? '').trim().isEmpty ? t.validation.required : null;

    Future<void> submit() async {
      if (!(formKey.currentState?.validate() ?? false)) {
        return;
      }
      FocusScope.of(context).unfocus();
      final done = await ref
          .read(registerControllerProvider.notifier)
          .submit(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            phoneNumber: toInternationalPhone(
              phoneController.text,
              country: country,
            ),
            password: passwordController.text,
            username: usernameController.text,
            email: emailController.text,
          );
      if (done && context.mounted) {
        await context.router.replaceAll([ChurchFormRoute()]);
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.xs,
                    0,
                    AppSpacing.lg,
                    0,
                  ),
                  child: Row(
                    children: [
                      if (context.router.canPop())
                        const AppBackButton()
                      else
                        const SizedBox(width: AppSpacing.md),
                      const Expanded(child: StepProgress(current: 1, total: 2)),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.xl,
                      22,
                      AppSpacing.xl,
                      AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          t.auth.register.title,
                          style: textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          t.auth.register.subtitle,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg + 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: LabeledField(
                                label: t.auth.register.firstName,
                                child: TextFormField(
                                  controller: firstNameController,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [
                                    AutofillHints.givenName,
                                  ],
                                  validator: required,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: LabeledField(
                                label: t.auth.register.lastName,
                                child: TextFormField(
                                  controller: lastNameController,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [
                                    AutofillHints.familyName,
                                  ],
                                  validator: required,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        UsernameField(
                          controller: usernameController,
                          firstName: firstName,
                          lastName: lastName,
                          autofill: true,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        PhoneField(
                          controller: phoneController,
                          country: country,
                          onCountryChanged: ref
                              .read(phoneCountryProvider.notifier)
                              .save,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        PasswordField(
                          controller: passwordController,
                          isNewPassword: true,
                          helper: t.auth.register.passwordHelp,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        LabeledField(
                          label: t.auth.register.email,
                          optionalText: t.common.optional,
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.email],
                            onFieldSubmitted: (_) => submit(),
                            decoration: InputDecoration(
                              hintText: t.auth.register.emailHint,
                            ),
                            validator: (value) {
                              final email = (value ?? '').trim();
                              final valid =
                                  email.isEmpty ||
                                  RegExp(
                                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                  ).hasMatch(email);
                              return valid ? null : t.validation.invalidEmail;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AuthFooter(
                  button: AppButton(
                    label: t.auth.register.submit,
                    isLoading: state.isLoading,
                    onPressed: submit,
                  ),
                  question: t.auth.register.haveAccount,
                  linkLabel: t.auth.register.login,
                  onLink: () => context.router.replace(const LoginRoute()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The API answers 403 FORBIDDEN when the phone number or the email already has an account.
String _registerErrorMessage(Object error, Translations t) => switch (error) {
  ApiException(code: 'FORBIDDEN') => t.auth.register.alreadyUsed,
  ApiException(code: 'USERNAME_TAKEN') => t.members.usernameTaken,
  _ => userMessageFor(error, t),
};
