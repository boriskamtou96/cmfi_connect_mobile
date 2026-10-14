import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/phone_verification.dart';
import '../../../core/session/session.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/phone.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../core/widgets/password_field.dart';
import '../../../core/widgets/phone_field.dart';
import '../../../routing/app_router.dart';
import '../infrastructure/auth_api.dart';
import 'widgets/auth_footer.dart';

enum _Step { phone, code, password }

/// How long before a new SMS may be asked.
const resendDelay = Duration(seconds: 30);

/// Forgot password, in three steps: the phone number, the code received by
/// SMS (Firebase checks it), then the new password, and the member is signed
/// in. [phone] is what was typed on the login screen.
@RoutePage()
class ForgotPasswordScreen extends HookConsumerWidget {
  const ForgotPasswordScreen({this.phone, super.key});

  final String? phone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final f = t.auth.forgot;
    final textTheme = Theme.of(context).textTheme;
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final phoneController = useTextEditingController(text: phone);
    final codeController = useTextEditingController();
    final passwordController = useTextEditingController();
    final country = ref.watch(phoneCountryProvider);
    final step = useState(_Step.phone);
    final busy = useState(false);
    final number = useState('');
    final firebaseToken = useState<String?>(null);
    // each SMS sent: the seconds before another one may be asked
    final sends = useState(0);
    final waitLeft = useState(0);

    useEffect(() {
      if (sends.value == 0) {
        return null;
      }
      waitLeft.value = resendDelay.inSeconds;
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        waitLeft.value -= 1;
        if (waitLeft.value <= 0) {
          timer.cancel();
        }
      });
      return timer.cancel;
    }, [sends.value]);

    void showError(Object error) {
      final toast = ref.read(toasterProvider).of(context);
      toast.error(switch (error) {
        PhoneVerificationException(:final error) => switch (error) {
          PhoneVerificationError.invalidNumber => t.validation.invalidPhone,
          PhoneVerificationError.invalidCode => f.invalidCode,
          PhoneVerificationError.expired => f.expired,
          PhoneVerificationError.tooManyRequests => f.tooManyRequests,
          PhoneVerificationError.network => t.errors.network,
          PhoneVerificationError.unavailable => f.unavailable,
        },
        ApiException(code: 'NOT_FOUND') => f.noAccount,
        ApiException(code: 'INVALID_PHONE_VERIFICATION') => f.expired,
        ApiException(code: 'PASSWORD_RESET_UNAVAILABLE') => f.unavailable,
        _ => userMessageFor(error, t),
      });
    }

    Future<void> run(
      Future<void> Function() action, {
      bool validate = true,
    }) async {
      if (busy.value ||
          (validate && !(formKey.currentState?.validate() ?? false))) {
        return;
      }
      FocusScope.of(context).unfocus();
      busy.value = true;
      try {
        await action();
      } on Object catch (error) {
        if (context.mounted) {
          showError(error);
        }
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    Future<void> sendCode() => run(() async {
      final international = toInternationalPhone(
        phoneController.text,
        country: country,
      );
      await ref
          .read(phoneVerificationProvider)
          .sendCode(
            international,
            // Android read the SMS: straight to the new password
            onAutoVerified: (token) {
              if (context.mounted) {
                firebaseToken.value = token;
                step.value = _Step.password;
              }
            },
          );
      number.value = international;
      sends.value += 1;
      codeController.clear();
      if (step.value == _Step.phone) {
        step.value = _Step.code;
      }
      // sending again from the code step: the code field is still empty
    }, validate: step.value == _Step.phone);

    Future<void> verifyCode() => run(() async {
      firebaseToken.value = await ref
          .read(phoneVerificationProvider)
          .confirm(codeController.text.trim());
      step.value = _Step.password;
    });

    Future<void> save() => run(() async {
      final api = ref.read(authApiProvider);
      final verification = ref.read(phoneVerificationProvider);
      final router = context.router;
      final toast = ref.read(toasterProvider).of(context);
      final done = f.done;
      try {
        await api.resetPassword(
          firebaseToken: firebaseToken.value!,
          password: passwordController.text,
        );
      } on ApiException catch (error) {
        // the proof expired, or no account: back to the number
        if (error.code == 'INVALID_PHONE_VERIFICATION' ||
            error.code == 'NOT_FOUND') {
          step.value = _Step.phone;
        }
        rethrow;
      }
      final response = await api.login(
        phoneNumber: number.value,
        password: passwordController.text,
      );
      await ref
          .read(sessionProvider.notifier)
          .signIn(response.accessToken, account: response.account);
      unawaited(verification.forget());
      toast.success(done);
      await router.replaceAll([const AppShellRoute()]);
    });

    final (title, text) = switch (step.value) {
      _Step.phone => (f.title, f.phoneText),
      _Step.code => (f.codeTitle, f.codeText(phone: formatPhone(number.value))),
      _Step.password => (f.passwordTitle, f.passwordText),
    };

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: AutofillGroup(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: AppSpacing.xs,
                    ),
                    // a step back, then back to the login
                    child: AppBackButton(
                      onPressed: step.value == _Step.phone
                          ? null
                          : () => step.value = _Step.phone,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.xl,
                      AppSpacing.sm,
                      AppSpacing.xl,
                      AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          t.auth.register.step(
                            current: step.value.index + 1,
                            total: _Step.values.length,
                          ),
                          style: textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(title, style: textTheme.headlineMedium),
                        const SizedBox(height: 10),
                        Text(
                          text,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 26),
                        ...switch (step.value) {
                          _Step.phone => [
                            PhoneField(
                              controller: phoneController,
                              country: country,
                              onCountryChanged: ref
                                  .read(phoneCountryProvider.notifier)
                                  .save,
                              textInputAction: TextInputAction.done,
                            ),
                          ],
                          _Step.code => [
                            LabeledField(
                              label: f.code,
                              child: TextFormField(
                                controller: codeController,
                                autofocus: true,
                                keyboardType: TextInputType.number,
                                autofillHints: const [
                                  AutofillHints.oneTimeCode,
                                ],
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 8,
                                ),
                                decoration: const InputDecoration(
                                  hintText: '••••••',
                                ),
                                onFieldSubmitted: (_) => verifyCode(),
                                validator: (value) =>
                                    (value ?? '').trim().length == 6
                                    ? null
                                    : f.codeInvalid,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: busy.value || waitLeft.value > 0
                                      ? null
                                      : sendCode,
                                  child: Text(
                                    waitLeft.value > 0
                                        ? f.resendIn(seconds: waitLeft.value)
                                        : f.resend,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => step.value = _Step.phone,
                                  child: Text(f.changeNumber),
                                ),
                              ],
                            ),
                          ],
                          _Step.password => [
                            PasswordField(
                              controller: passwordController,
                              isNewPassword: true,
                              helper: t.auth.register.passwordHelp,
                              onSubmitted: save,
                            ),
                          ],
                        },
                      ],
                    ),
                  ),
                ),
                AuthFooter(
                  button: AppButton(
                    label: switch (step.value) {
                      _Step.phone => f.sendCode,
                      _Step.code => f.verify,
                      _Step.password => f.submit,
                    },
                    isLoading: busy.value,
                    onPressed: switch (step.value) {
                      _Step.phone => sendCode,
                      _Step.code => verifyCode,
                      _Step.password => save,
                    },
                  ),
                  question: f.remembered,
                  linkLabel: t.auth.login.submit,
                  onLink: () => context.router.maybePop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
