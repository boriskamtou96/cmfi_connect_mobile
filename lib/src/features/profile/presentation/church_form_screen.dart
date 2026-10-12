import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../core/widgets/step_progress.dart';
import '../../../routing/app_router.dart';
import '../../members/application/my_account.dart';
import '../../members/domain/member.dart';
import '../../members/presentation/widgets/username_field.dart';
import '../application/church_form_controller.dart';
import '../application/current_profile.dart';

/// Your church: step 2 of the sign-up, and later "Edit my profile" from the More tab.
@RoutePage()
class ChurchFormScreen extends HookConsumerWidget {
  const ChurchFormScreen({this.isEditing = false, super.key});

  /// false: end of the sign-up (Finish / Skip open the app).
  /// true: opened from the profile, saving goes back.
  final bool isEditing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final countryController = useTextEditingController();
    final cityController = useTextEditingController();
    final churchController = useTextEditingController();
    final assemblyController = useTextEditingController();
    final usernameController = useTextEditingController();
    final state = ref.watch(churchFormControllerProvider);
    // a refused request pops up at the top of the screen
    ref.listen(churchFormControllerProvider, (_, next) {
      if (next case AsyncError(:final error)) {
        ref.read(toasterProvider).of(context).error(userMessageFor(error, t));
      }
    });
    final profile = ref.watch(currentProfileProvider).value;
    final account = isEditing ? ref.watch(myAccountProvider).value : null;
    final firstName = useValueListenable(firstNameController).text;
    final lastName = useValueListenable(lastNameController).text;

    useEffect(() {
      if (usernameController.text.isEmpty &&
          (account?.username ?? '').isNotEmpty) {
        usernameController.text = account!.username;
      }
      return null;
    }, [account]);

    // fill the fields once the profile has arrived, without erasing what was typed
    useEffect(() {
      if (profile == null) {
        return null;
      }
      for (final (controller, value) in [
        (firstNameController, profile.firstName),
        (lastNameController, profile.lastName),
        (countryController, profile.country),
        (cityController, profile.city),
        (churchController, profile.church),
        (assemblyController, profile.assembly),
      ]) {
        if (controller.text.isEmpty && value != null) {
          controller.text = value;
        }
      }
      return null;
    }, [profile]);

    Future<void> openApp() =>
        context.router.replaceAll([const AppShellRoute()]);

    Future<void> submit() async {
      if (!(formKey.currentState?.validate() ?? false)) {
        return;
      }
      FocusScope.of(context).unfocus();
      // a new pseudo first: if it is taken, nothing else is saved
      final username = UsernameRules.normalize(usernameController.text);
      if (isEditing &&
          account != null &&
          username.isNotEmpty &&
          username != account.username) {
        try {
          await ref.read(myAccountProvider.notifier).changeUsername(username);
        } on Object catch (error) {
          if (context.mounted) {
            ref
                .read(toasterProvider)
                .of(context)
                .error(userMessageFor(error, t));
          }
          return;
        }
      }
      final saved = await ref
          .read(churchFormControllerProvider.notifier)
          .submit(
            // the name is only editable from the profile, not at sign-up
            firstName: isEditing ? firstNameController.text : null,
            lastName: isEditing ? lastNameController.text : null,
            country: countryController.text,
            city: cityController.text,
            church: churchController.text,
            assembly: assemblyController.text,
          );
      if (!saved || !context.mounted) {
        return;
      }
      if (isEditing) {
        ref.read(toasterProvider).of(context).success(t.auth.church.saved);
        await context.router.maybePop();
      } else {
        await openApp();
      }
    }

    Widget field(
      String label,
      TextEditingController controller,
      String hint, {
      List<String>? autofill,
    }) => LabeledField(
      label: label,
      child: TextField(
        controller: controller,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        autofillHints: autofill,
        decoration: InputDecoration(hintText: hint),
      ),
    );

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
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
              child: SizedBox(
                height: 48,
                child: Row(
                  children: [
                    if (isEditing)
                      const AppBackButton()
                    else
                      const SizedBox(width: AppSpacing.md + AppSpacing.xs),
                    if (!isEditing)
                      const Expanded(child: StepProgress(current: 2, total: 2)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Form(
                key: formKey,
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
                        isEditing
                            ? t.auth.church.editTitle
                            : t.auth.church.title,
                        style: textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        isEditing
                            ? t.auth.church.editSubtitle
                            : t.auth.church.subtitle,
                        style: textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg + 2),
                      if (isEditing) ...[
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
                                  validator: (value) =>
                                      (value ?? '').trim().isEmpty
                                      ? t.validation.required
                                      : null,
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
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        if (account != null) ...[
                          UsernameField(
                            controller: usernameController,
                            firstName: firstName,
                            lastName: lastName,
                            current: account.username,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                      ],
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: field(
                              t.auth.church.country,
                              countryController,
                              t.auth.church.countryHint,
                              autofill: const [AutofillHints.countryName],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: field(
                              t.auth.church.city,
                              cityController,
                              t.auth.church.cityHint,
                              autofill: const [AutofillHints.addressCity],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      field(
                        t.auth.church.church,
                        churchController,
                        t.auth.church.churchHint,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      field(
                        t.auth.church.assembly,
                        assemblyController,
                        t.auth.church.assemblyHint,
                      ),
                      if (!isEditing) ...[
                        const SizedBox(height: AppSpacing.lg),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.primaryContainer,
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                AppIcons.info,
                                size: 20,
                                color: scheme.primary,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Text(
                                  t.auth.church.info,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.45,
                                    color: scheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl,
                AppSpacing.md,
                AppSpacing.xl,
                AppSpacing.md,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppButton(
                    label: isEditing ? t.common.save : t.auth.church.submit,
                    isLoading: state.isLoading,
                    onPressed: submit,
                  ),
                  if (!isEditing) ...[
                    const SizedBox(height: AppSpacing.xs),
                    TextButton(
                      onPressed: state.isLoading ? null : openApp,
                      style: TextButton.styleFrom(
                        foregroundColor: scheme.onSurfaceVariant,
                      ),
                      child: Text(t.auth.church.skip),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
