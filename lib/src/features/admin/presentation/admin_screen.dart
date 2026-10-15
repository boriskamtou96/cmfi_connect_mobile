import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../../members/application/my_account.dart';
import '../../members/domain/member.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../infrastructure/admin_api.dart';

String roleLabel(Translations t, MemberRole role) => switch (role) {
  MemberRole.user => t.admin.roleUser,
  MemberRole.admin => t.admin.roleAdmin,
  MemberRole.superadmin => t.admin.roleSuperadmin,
};

/// Plus › Équipe et rôles: who is admin. A superadmin gives and takes back roles.
@RoutePage()
class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final staff = ref.watch(staffProvider);
    final me = ref.watch(myAccountProvider).value;
    final isSuperadmin = me?.isSuperadmin ?? false;

    Future<void> setRole(String username, MemberRole role) async {
      final toast = ref.read(toasterProvider).of(context);
      try {
        final updated = await ref
            .read(staffProvider.notifier)
            .setRole(username, role);
        toast.success(
          t.admin.roleChanged(
            username: updated.username,
            role: roleLabel(t, updated.role),
          ),
        );
      } on Object catch (error) {
        toast.error(
          error is ApiException && error.code == 'NOT_FOUND'
              ? t.authorities.form.notFound(username: username)
              : userMessageFor(error, t),
        );
      }
    }

    return SubPage(
      title: t.admin.title,
      child: switch (staff) {
        AsyncValue(value: final members?) => RefreshIndicator(
          onRefresh: () =>
              ref.refresh(staffProvider.future).then((_) {}, onError: (_) {}),
          child: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              FadeSlideIn(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  child: Text(
                    t.admin.intro,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              FadeSlideIn(
                index: 1,
                child: SectionCard(
                  children: [
                    if (members.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Text(t.admin.empty),
                      ),
                    for (final member in members)
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: AppSpacing.xs,
                        ),
                        leading: MemberAvatar(
                          initials: member.initials,
                          photo: member.avatar,
                          size: 42,
                        ),
                        title: Text(
                          member.username == me?.username
                              ? '${member.fullName} (${t.admin.you})'
                              : member.fullName,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text('@${member.username}'),
                        trailing:
                            isSuperadmin && member.username != me?.username
                            ? PopupMenuButton<MemberRole>(
                                tooltip: t.admin.roleFor(
                                  username: member.username,
                                ),
                                initialValue: member.role,
                                onSelected: (role) =>
                                    setRole(member.username, role),
                                itemBuilder: (context) => [
                                  for (final role in MemberRole.values)
                                    PopupMenuItem(
                                      value: role,
                                      child: Text(roleLabel(t, role)),
                                    ),
                                ],
                                child: StatusPill(roleLabel(t, member.role)),
                              )
                            : StatusPill(roleLabel(t, member.role)),
                      ),
                  ],
                ),
              ),
              if (isSuperadmin) ...[
                const SizedBox(height: 18),
                FadeSlideIn(
                  index: 2,
                  child: FilledButton.icon(
                    onPressed: () async {
                      final choice = await _showGiveRole(context);
                      if (choice != null) {
                        await setRole(choice.username, choice.role);
                      }
                    },
                    icon: const Icon(AppIcons.admin),
                    label: Text(t.admin.giveRole),
                  ),
                ),
              ],
            ],
          ),
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(staffProvider),
        ),
        _ => const LoadingList(count: 4, leading: 42),
      },
    );
  }
}

/// A pseudo and the role to give.
Future<({String username, MemberRole role})?> _showGiveRole(
  BuildContext context,
) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (context) => const _GiveRoleSheet(),
);

class _GiveRoleSheet extends HookWidget {
  const _GiveRoleSheet();

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final controller = useTextEditingController();
    final role = useState(MemberRole.admin);
    final username = UsernameRules.normalize(
      useValueListenable(controller).text,
    );

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        MediaQuery.viewInsetsOf(context).bottom + AppSpacing.xl,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.admin.giveRole,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: controller,
              autofocus: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                prefixText: '@',
                hintText: t.admin.memberUsername,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const SizedBox(height: AppSpacing.sm),
            RadioGroup<MemberRole>(
              groupValue: role.value,
              onChanged: (value) => role.value = value ?? role.value,
              child: Column(
                children: [
                  for (final value in MemberRole.values)
                    RadioListTile<MemberRole>(
                      contentPadding: EdgeInsets.zero,
                      value: value,
                      title: Text(roleLabel(t, value)),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: UsernameRules.check(username) == null
                  ? () => Navigator.of(
                      context,
                    ).pop((username: username, role: role.value))
                  : null,
              child: Text(t.admin.giveRole),
            ),
          ],
        ),
      ),
    );
  }
}
