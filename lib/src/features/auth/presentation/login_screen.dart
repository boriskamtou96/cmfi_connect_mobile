import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/biometrics.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/countries.dart';
import '../../../core/utils/phone.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/biometric_method.dart';
import '../../../core/widgets/password_field.dart';
import '../../../core/widgets/phone_field.dart';
import '../../../routing/app_router.dart';
import '../application/login_controller.dart';
import '../application/saved_login.dart';
import 'widgets/auth_footer.dart';
import 'widgets/login_header.dart';

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
    final country = ref.watch(phoneCountryProvider);
    final state = ref.watch(loginControllerProvider);
    final saved = ref.watch(savedLoginProvider).value;
    final kind = ref.watch(biometricKindProvider).value;
    final method = kind == null ? null : biometricMethod(t, kind);
    // the sign-in comes from Face ID: a refused password means it changed
    final viaBiometrics = useRef(false);
    // a refused request pops up at the top of the screen
    ref.listen(loginControllerProvider, (_, next) {
      if (next case AsyncError(:final error)) {
        final refused =
            error is ApiException &&
            (error.code == 'INVALID_CREDENTIALS' || error.code == 'NOT_FOUND');
        final toast = ref.read(toasterProvider).of(context);
        if (viaBiometrics.value && refused && method != null) {
          unawaited(ref.read(savedLoginProvider.notifier).disable());
          toast.error(t.auth.biometric.changed(method: method));
        } else {
          toast.error(_loginErrorMessage(error, t));
        }
      }
    });

    // the number signed in with last, already there
    useEffect(() {
      final phone = saved?.phone;
      if (phone == null || phoneController.text.isNotEmpty) {
        return null;
      }
      if (parsePhone(phone, country) case final number?) {
        final own = Country(number.isoCode);
        if (own != country) {
          unawaited(ref.read(phoneCountryProvider.notifier).save(own));
        }
        phoneController.text = number.formatNsn();
      }
      return null;
    }, [saved?.phone]);

    Future<void> openApp() async {
      if (context.mounted) {
        await context.router.replaceAll([const AppShellRoute()]);
      }
    }

    // Face ID / the fingerprint: the number and the password kept
    Future<void> signInWithBiometrics() async {
      final phone = saved?.phone;
      if (phone == null) {
        return;
      }
      final password = await ref
          .read(savedLoginProvider.notifier)
          .unlock(reason: t.auth.biometric.reason);
      if (password == null) {
        return;
      }
      viaBiometrics.value = true;
      final signedIn = await ref
          .read(loginControllerProvider.notifier)
          .submit(phoneNumber: phone, password: password);
      viaBiometrics.value = false;
      if (signedIn) {
        await openApp();
      }
    }

    Future<void> submit() async {
      if (!(formKey.currentState?.validate() ?? false)) {
        return;
      }
      FocusScope.of(context).unfocus();
      final phone = toInternationalPhone(
        phoneController.text,
        country: country,
      );
      final password = passwordController.text;
      final signedIn = await ref
          .read(loginControllerProvider.notifier)
          .submit(phoneNumber: phone, password: password);
      if (!signedIn) {
        return;
      }
      final remembered = ref.read(savedLoginProvider.notifier);
      await remembered.remember(phone, password);
      // offered once: next time, Face ID instead of the password
      if (method != null &&
          !(saved?.biometric ?? false) &&
          !remembered.alreadyAsked() &&
          context.mounted) {
        final yes = await showConfirmDialog(
          context,
          title: t.auth.biometric.askTitle(method: method),
          text: t.auth.biometric.askText,
          confirmLabel: t.auth.biometric.enable,
          cancelLabel: t.auth.biometric.later,
        );
        if (yes) {
          await remembered.enable(
            password,
            reason: t.auth.biometric.enableReason,
          );
        } else {
          await remembered.markAsked();
        }
      }
      await openApp();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        // the faces go up under the status bar
        top: false,
        child: AutofillGroup(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LoginHeader(canPop: context.router.canPop()),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                            AppSpacing.xl,
                            AppSpacing.lg + 2,
                            AppSpacing.xl,
                            AppSpacing.lg,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                t.auth.login.title,
                                style: textTheme.headlineMedium?.copyWith(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -1,
                                ),
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
                              PhoneField(
                                controller: phoneController,
                                country: country,
                                onCountryChanged: ref
                                    .read(phoneCountryProvider.notifier)
                                    .save,
                                lenient: true,
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              PasswordField(
                                controller: passwordController,
                                onSubmitted: submit,
                              ),
                              if (kind != null &&
                                  method != null &&
                                  (saved?.biometric ?? false)) ...[
                                const SizedBox(height: AppSpacing.md),
                                OutlinedButton.icon(
                                  onPressed: state.isLoading
                                      ? null
                                      : signInWithBiometrics,
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(52),
                                  ),
                                  icon: Icon(biometricIcon(kind)),
                                  label: Text(
                                    t.auth.biometric.signIn(method: method),
                                  ),
                                ),
                              ],
                              // « Mot de passe oublié » reste masqué tant que
                              // le parcours n'est pas ouvert (l'écran existe
                              // déjà, pour le jour où il le sera).
                            ],
                          ),
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
