import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/session/session.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/inline_error.dart';
import '../../../core/widgets/password_field.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../../members/application/my_account.dart';
import '../application/saved_login.dart';

/// The member chooses their password: Plus › Mot de passe, or [forced] right
/// after signing in with a temporary one an admin gave (no way around it,
/// [currentPassword] is the one just typed). An account made with Google or
/// Apple has no current password to type.
@RoutePage()
class ChangePasswordScreen extends HookConsumerWidget {
  const ChangePasswordScreen({
    this.forced = false,
    this.currentPassword,
    super.key,
  });

  final bool forced;
  final String? currentPassword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.auth.change;
    final scheme = Theme.of(context).colorScheme;
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final current = useTextEditingController();
    final password = useTextEditingController();
    final again = useTextEditingController();
    final saving = useState(false);
    final wrongCurrent = useState(false);
    final account = ref.watch(myAccountProvider).value;
    final hasPassword = account?.hasPassword ?? true;
    // typed at the sign-in, or none to type
    final askCurrent = hasPassword && currentPassword == null;

    Future<void> save() async {
      if (!(formKey.currentState?.validate() ?? false) || saving.value) {
        return;
      }
      FocusScope.of(context).unfocus();
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      saving.value = true;
      wrongCurrent.value = false;
      try {
        final changed = await ref
            .read(myAccountProvider.notifier)
            .changePassword(
              currentPassword: hasPassword
                  ? currentPassword ?? current.text
                  : null,
              password: password.text,
            );
        // the number and the password kept for Face ID follow
        await ref
            .read(savedLoginProvider.notifier)
            .remember(changed.phoneNumber, password.text);
        ref.invalidate(signedInAccountProvider);
        toast.success(t.done);
        if (!context.mounted) {
          return;
        }
        if (forced) {
          await context.router.replaceAll([const AppShellRoute()]);
        } else {
          await context.router.maybePop();
        }
      } on ApiException catch (error) {
        if (error.code == 'INVALID_CREDENTIALS' && askCurrent) {
          wrongCurrent.value = true;
        } else {
          toast.error(userMessageFor(error, messages));
        }
      } on AppException catch (error) {
        toast.error(userMessageFor(error, messages));
      } finally {
        if (context.mounted) {
          saving.value = false;
        }
      }
    }

    final page = SubPage(
      title: forced
          ? t.forcedTitle
          : hasPassword
          ? t.title
          : t.setTitle,
      bottom: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: AppButton(
          label: t.submit,
          isLoading: saving.value,
          onPressed: save,
        ),
      ),
      child: AutofillGroup(
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
                forced
                    ? t.forcedText
                    : hasPassword
                    ? t.text
                    : t.setText,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.45,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (askCurrent) ...[
                PasswordField(controller: current, label: t.current),
                if (wrongCurrent.value) ...[
                  const SizedBox(height: AppSpacing.sm),
                  InlineError(t.wrongCurrent),
                ],
                const SizedBox(height: AppSpacing.lg),
              ],
              PasswordField(
                controller: password,
                label: t.newPassword,
                isNewPassword: true,
                helper: context.t.auth.register.passwordHelp,
                validator: (value) =>
                    !forced && askCurrent && value == current.text
                    ? t.same
                    : null,
              ),
              const SizedBox(height: AppSpacing.lg),
              PasswordField(
                controller: again,
                label: t.again,
                isNewPassword: true,
                onSubmitted: save,
                validator: (value) =>
                    value == password.text ? null : t.mismatch,
              ),
            ],
          ),
        ),
      ),
    );
    // after a temporary password: nowhere else to go first
    return forced ? PopScope(canPop: false, child: page) : page;
  }
}
