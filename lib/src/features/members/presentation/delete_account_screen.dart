import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/inline_error.dart';
import '../../../core/widgets/password_field.dart';
import '../../../core/widgets/sub_page.dart';
import '../application/my_account.dart';

/// Plus › Supprimer mon compte: what goes, then the password to confirm. The
/// account is deleted on the server, and App goes back to the welcome screen.
@RoutePage()
class DeleteAccountScreen extends HookConsumerWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.members.deleteAccount;
    final scheme = Theme.of(context).colorScheme;
    final password = useTextEditingController();
    useListenable(password);
    final deleting = useState(false);
    final wrongPassword = useState(false);
    final errorKey = useMemoized(GlobalKey.new);

    Future<void> delete() async {
      if (password.text.isEmpty || deleting.value) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      deleting.value = true;
      wrongPassword.value = false;
      try {
        await ref.read(myAccountProvider.notifier).deleteAccount(password.text);
        toast.success(messages.members.deleteAccount.done);
      } on Object catch (error) {
        if (!context.mounted) {
          return;
        }
        deleting.value = false;
        if (error is ApiException && error.code == 'INVALID_CREDENTIALS') {
          wrongPassword.value = true;
          // below the field, often hidden by the keyboard or the button
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (errorKey.currentContext case final shown?) {
              Scrollable.ensureVisible(
                shown,
                duration: const Duration(milliseconds: 250),
                alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
              );
            }
          });
        } else {
          toast.error(userMessageFor(error, messages));
        }
      }
    }

    Widget line(String text) => Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(AppIcons.delete, size: 18, color: scheme.error),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
          ),
        ],
      ),
    );

    return SubPage(
      title: t.title,
      bottom: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: scheme.error,
            foregroundColor: scheme.onError,
          ),
          onPressed: password.text.isEmpty || deleting.value ? null : delete,
          child: deleting.value
              ? AppSpinner(size: 20, strokeWidth: 2.4, color: scheme.onError)
              : Text(t.confirm),
        ),
      ),
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: scheme.errorContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                AppIcons.delete,
                size: 28,
                color: scheme.onErrorContainer,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            t.intro,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          line(t.itemProfile),
          line(t.itemReports),
          line(t.itemAuthorities),
          line(t.itemEvents),
          line(t.itemPrayer),
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.kept,
            style: TextStyle(
              fontSize: 14,
              height: 1.45,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          PasswordField(
            controller: password,
            helper: t.passwordHelp,
            onSubmitted: delete,
          ),
          if (wrongPassword.value) ...[
            const SizedBox(height: AppSpacing.sm),
            InlineError(t.wrongPassword, key: errorKey),
          ],
        ],
      ),
    );
  }
}
