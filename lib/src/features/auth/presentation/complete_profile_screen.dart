import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/social_photo.dart';
import '../../../core/services/social_sign_in.dart';
import '../../../core/session/session.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/phone.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../core/widgets/password_field.dart';
import '../../../core/widgets/phone_field.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../infrastructure/auth_api.dart';
import '../infrastructure/login_response.dart';

/// The first sign-in with Google or Apple: the name it gave, to check, and
/// the number (the community finds members by it). A number that already
/// has an account asks for its password, to link it instead.
@RoutePage()
class CompleteProfileScreen extends HookConsumerWidget {
  const CompleteProfileScreen({required this.account, super.key});

  final SocialAccount account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final firstName = useTextEditingController(text: account.firstName);
    final lastName = useTextEditingController(text: account.lastName);
    final phone = useTextEditingController();
    final password = useTextEditingController();
    final country = ref.watch(phoneCountryProvider);
    final saving = useState(false);
    // the number has an account: its password links it
    final phoneTaken = useState<String?>(null);
    useEffect(() {
      void changed() {
        if (phoneTaken.value != null) {
          phoneTaken.value = null;
        }
      }

      phone.addListener(changed);
      return () => phone.removeListener(changed);
    }, [phone]);

    String? required(String? value) =>
        (value ?? '').trim().isEmpty ? t.validation.required : null;

    Future<void> signIn(LoginResponse response, {String? typed}) async {
      // a new account takes the photo of its Google account (the app does it
      // once signed in)
      if (typed == null && account.photoUrl.isNotEmpty) {
        ref.read(pendingSocialPhotoProvider.notifier).set(account.photoUrl);
      }
      await ref
          .read(sessionProvider.notifier)
          .signIn(response.accessToken, account: response.account);
      if (!context.mounted) {
        return;
      }
      await context.router.replaceAll([
        if (response.account.mustChangePassword)
          ChangePasswordRoute(forced: true, currentPassword: typed)
        else if (typed != null)
          const AppShellRoute()
        // a new account: its church next, like the sign-up
        else
          ChurchFormRoute(),
      ]);
    }

    Future<void> submit() async {
      if (!(formKey.currentState?.validate() ?? false) || saving.value) {
        return;
      }
      FocusScope.of(context).unfocus();
      final toast = ref.read(toasterProvider).of(context);
      final number = toInternationalPhone(phone.text, country: country);
      final api = ref.read(authApiProvider);
      saving.value = true;
      try {
        if (phoneTaken.value case final taken?) {
          await signIn(
            await api.socialLink(
              firebaseToken: account.idToken,
              phoneNumber: taken,
              password: password.text,
            ),
            typed: password.text,
          );
        } else {
          await signIn(
            await api.socialRegister(
              firebaseToken: account.idToken,
              firstName: firstName.text.trim(),
              lastName: lastName.text.trim(),
              phoneNumber: number,
            ),
          );
        }
      } on ApiException catch (error) {
        switch (error.code) {
          case 'PHONE_TAKEN':
            phoneTaken.value = number;
          case 'INVALID_CREDENTIALS':
            toast.error(t.errors.invalidCredentials);
          case 'IDENTITY_TAKEN':
            toast.error(
              t.auth.social.identityTaken(provider: account.provider.label),
            );
          // the token lasts an hour: back to the buttons
          case 'INVALID_SOCIAL_TOKEN':
            toast.error(t.auth.social.expired);
            if (context.mounted) {
              await context.router.maybePop();
            }
          default:
            toast.error(userMessageFor(error, t));
        }
      } on AppException catch (error) {
        toast.error(userMessageFor(error, t));
      } finally {
        if (context.mounted) {
          saving.value = false;
        }
      }
    }

    final taken = phoneTaken.value != null;
    return SubPage(
      title: t.auth.social.completeTitle,
      bottom: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: AppButton(
          label: taken ? t.auth.social.link : t.auth.social.create,
          isLoading: saving.value,
          onPressed: submit,
        ),
      ),
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          children: [
            Text(
              t.auth.social.completeText(provider: account.provider.label),
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: scheme.onSurfaceVariant,
              ),
            ),
            if (account.email.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                account.email,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            LabeledField(
              label: t.auth.register.firstName,
              child: TextFormField(
                controller: firstName,
                enabled: !taken,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.givenName],
                validator: required,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            LabeledField(
              label: t.auth.register.lastName,
              child: TextFormField(
                controller: lastName,
                enabled: !taken,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.familyName],
                validator: required,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            PhoneField(
              controller: phone,
              country: country,
              onCountryChanged: ref.read(phoneCountryProvider.notifier).save,
              textInputAction: TextInputAction.done,
            ),
            if (taken) ...[
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.auth.social.phoneTakenTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.auth.social.phoneTakenText(
                        provider: account.provider.label,
                      ),
                      style: TextStyle(
                        height: 1.4,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              PasswordField(controller: password, onSubmitted: submit),
            ],
          ],
        ),
      ),
    );
  }
}
