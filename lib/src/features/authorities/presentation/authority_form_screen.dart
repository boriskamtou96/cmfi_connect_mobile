import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../core/widgets/phone_field.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/sub_page.dart';
import '../../members/application/my_account.dart';
import '../../members/domain/member.dart';
import '../../members/infrastructure/members_api.dart';
import '../application/add_authority_controller.dart';
import '../application/authorities_controller.dart';

/// What the pseudo search found.
sealed class _Search {
  const _Search();
}

class _Searching extends _Search {
  const _Searching();
}

class _Found extends _Search {
  const _Found(this.member);
  final MemberCard member;
}

class _NotFound extends _Search {
  const _NotFound(this.username);
  final String username;
}

class _Yourself extends _Search {
  const _Yourself();
}

/// Adds a spiritual authority: a member found by pseudo, who then accepts, or
/// someone typed by hand. And whether it is the disciple maker.
@RoutePage()
class AuthorityFormScreen extends HookConsumerWidget {
  const AuthorityFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final searchController = useTextEditingController();
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final manual = useState(false);
    final search = useState<_Search?>(null);
    final isDiscipleMaker = useState(false);
    final state = ref.watch(addAuthorityControllerProvider);
    // a refused request pops up at the top of the screen
    ref.listen(addAuthorityControllerProvider, (_, next) {
      if (next case AsyncError(:final error)) {
        ref.read(toasterProvider).of(context).error(userMessageFor(error, t));
      }
    });
    final me = ref.watch(myAccountProvider).value;
    // only one disciple maker: the API refuses a second one
    final currentMaker = ref
        .watch(authoritiesControllerProvider)
        .value
        ?.where((authority) => authority.isDiscipleMaker)
        .firstOrNull;
    final found = switch (search.value) {
      _Found(:final member) => member,
      _ => null,
    };

    Future<void> find() async {
      final username = UsernameRules.normalize(searchController.text);
      if (username.isEmpty) {
        return;
      }
      FocusScope.of(context).unfocus();
      if (username == me?.username) {
        search.value = const _Yourself();
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      search.value = const _Searching();
      try {
        final member = await ref.read(membersApiProvider).byUsername(username);
        search.value = _Found(member);
      } on Object catch (error) {
        if (error is ApiException && error.code == 'NOT_FOUND') {
          search.value = _NotFound(username);
        } else {
          // no answer (network…): said in a popup, the search can be tried again
          search.value = null;
          toast.error(userMessageFor(error, t));
        }
      }
    }

    Future<void> invite(BuildContext anchor) {
      final box = anchor.findRenderObject() as RenderBox?;
      final mine = me?.username ?? '';
      return ref
          .read(shareServiceProvider)
          .shareText(
            [
              t.authorities.form.inviteText,
              if (mine.isNotEmpty)
                t.authorities.form.inviteMine(username: mine),
            ].join('\n\n'),
            origin: box == null
                ? null
                : box.localToGlobal(Offset.zero) & box.size,
          );
    }

    Future<void> submit() async {
      final maker = currentMaker == null && isDiscipleMaker.value;
      final toast = ref.read(toasterProvider).of(context);
      final controller = ref.read(addAuthorityControllerProvider.notifier);
      final String? done;
      if (manual.value) {
        if (!(formKey.currentState?.validate() ?? false)) {
          return;
        }
        FocusScope.of(context).unfocus();
        final added = await controller.submit(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneController.text,
          email: emailController.text,
          isDiscipleMaker: maker,
        );
        done = added == null
            ? null
            : t.authorities.form.added(name: added.fullName);
      } else if (found != null) {
        final asked = await controller.submitMember(
          username: found.username,
          isDiscipleMaker: maker,
        );
        done = asked == null
            ? null
            : t.authorities.form.requested(name: found.fullName);
      } else {
        return;
      }
      if (done != null && context.mounted) {
        toast.success(done);
        await context.router.maybePop();
      }
    }

    final cardDecoration = BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      border: Border.all(color: scheme.outlineVariant),
    );

    final searchPart = Container(
      key: const ValueKey('search'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LabeledField(
            label: t.authorities.form.searchLabel,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    autocorrect: false,
                    enableSuggestions: false,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => find(),
                    decoration: InputDecoration(
                      prefixText: '@',
                      hintText: t.authorities.form.searchHint,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                IconButton.filled(
                  tooltip: t.authorities.form.search,
                  style: IconButton.styleFrom(
                    fixedSize: const Size.square(52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  onPressed: find,
                  icon: const Icon(AppIcons.search),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.authorities.form.searchHelp,
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: scheme.onSurfaceVariant,
            ),
          ),
          AnimatedSize(
            duration: AppMotion.of(context, AppMotion.medium),
            curve: AppMotion.standard,
            alignment: Alignment.topCenter,
            child: switch (search.value) {
              null => const SizedBox(width: double.infinity),
              _Searching() => const Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Center(child: CircularProgressIndicator()),
              ),
              _Found(:final member) => Padding(
                padding: const EdgeInsets.only(top: AppSpacing.lg),
                child: _MemberResult(member: member),
              ),
              _NotFound(:final username) => Padding(
                padding: const EdgeInsets.only(top: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      t.authorities.form.notFound(username: username),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Builder(
                      builder: (anchor) => OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                        ),
                        onPressed: () => invite(anchor),
                        icon: const Icon(AppIcons.share, size: 20),
                        label: Text(t.authorities.form.invite),
                      ),
                    ),
                  ],
                ),
              ),
              _Yourself() => Padding(
                padding: const EdgeInsets.only(top: AppSpacing.lg),
                child: Text(
                  t.authorities.form.yourself,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            },
          ),
        ],
      ),
    );

    final manualPart = Container(
      key: const ValueKey('manual'),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                    validator: (value) => (value ?? '').trim().isEmpty
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
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          PhoneField(controller: phoneController),
          const SizedBox(height: AppSpacing.lg),
          LabeledField(
            label: t.auth.register.email,
            optionalText: t.common.optional,
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: t.authorities.form.emailHint,
              ),
              validator: (value) {
                final email = (value ?? '').trim();
                final valid =
                    email.isEmpty ||
                    RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
                return valid ? null : t.validation.invalidEmail;
              },
            ),
          ),
        ],
      ),
    );

    return SubPage(
      title: t.authorities.form.title,
      bottom: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(top: BorderSide(color: scheme.outlineVariant)),
        ),
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: AppButton(
          label: manual.value
              ? t.authorities.form.submit
              : t.authorities.form.request,
          isLoading: state.isLoading,
          onPressed: manual.value || found != null ? submit : null,
        ),
      ),
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          children: [
            AnimatedSwitcher(
              duration: AppMotion.of(context, AppMotion.medium),
              child: manual.value ? manualPart : searchPart,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                onPressed: () => manual.value = !manual.value,
                child: Text(
                  manual.value
                      ? t.authorities.form.backToSearch
                      : t.authorities.form.manual,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Container(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                AppSpacing.xs,
                AppSpacing.sm,
                AppSpacing.xs,
              ),
              decoration: cardDecoration,
              child: MergeSemantics(
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    t.authorities.form.isDiscipleMaker,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    currentMaker == null
                        ? t.authorities.form.isDiscipleMakerHelp
                        : t.authorities.form.discipleMakerTaken(
                            name: currentMaker.fullName,
                          ),
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  value: currentMaker == null && isDiscipleMaker.value,
                  onChanged: currentMaker == null
                      ? (value) => isDiscipleMaker.value = value
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The member found: initials, name, pseudo, church.
class _MemberResult extends StatelessWidget {
  const _MemberResult({required this.member});

  final MemberCard member;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Row(
        children: [
          InitialsAvatar(initials: member.initials, size: 44),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.fullName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  [
                    '@${member.username}',
                    if (member.place.isNotEmpty) member.place,
                  ].join(' · '),
                  style: TextStyle(
                    fontSize: 13,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
          Icon(AppIcons.verified, color: scheme.primary),
        ],
      ),
    );
  }
}
