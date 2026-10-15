import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../../members/domain/member.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../application/importunities.dart';

/// Plus › Membres bloqués: the members whose invitations to pray don't reach
/// the user any more, each with "Débloquer".
@RoutePage()
class BlockedMembersScreen extends ConsumerWidget {
  const BlockedMembersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.blocking;
    final scheme = Theme.of(context).colorScheme;
    final blocked = ref.watch(blockedMembersProvider);

    Future<void> unblock(MemberCard member) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      try {
        await ref.read(blockedMembersProvider.notifier).unblock(member);
        toast.success(
          messages.blocking.unblocked(
            name: member.firstName.isEmpty
                ? '@${member.username}'
                : member.firstName,
          ),
        );
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      }
    }

    return SubPage(
      title: t.listTitle,
      child: switch (blocked) {
        AsyncData(value: final members) when members.isEmpty => Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const DoveMascot(pose: DovePose.rest, size: 104),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  t.empty,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  t.intro,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        AsyncData(value: final members) => ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          children: [
            Text(
              t.intro,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SectionCard(
              children: [
                for (final member in members)
                  ListTile(
                    leading: MemberAvatar(
                      initials: member.initials,
                      photo: member.avatar,
                      size: 40,
                    ),
                    title: Text(
                      member.fullName,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      [
                        '@${member.username}',
                        if (member.place.isNotEmpty) member.place,
                      ].join(' · '),
                    ),
                    trailing: TextButton(
                      onPressed: () => unblock(member),
                      child: Text(t.unblock),
                    ),
                  ),
              ],
            ),
          ],
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(blockedMembersProvider),
        ),
        _ => const LoadingList(count: 3),
      },
    );
  }
}
