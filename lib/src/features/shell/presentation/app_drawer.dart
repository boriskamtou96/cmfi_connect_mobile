import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/app_version.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/menu_tile.dart';
import '../../../core/widgets/premium_crown.dart';
import '../../../core/widgets/section_card.dart';
import '../../../routing/app_router.dart';
import '../../members/application/my_account.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../../profile/application/current_profile.dart';
import '../../settings/presentation/sign_out.dart';

/// The menu of the app (validated on 23/10/2026), from ☰ on the home screen
/// or swiped from its edge: where to go. The member at the top (their
/// profile), what the community offers, the administration for the admins,
/// then the settings, signing out and the version.
class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final profile = ref.watch(currentProfileProvider).value;
    final isAdmin = ref.watch(myAccountProvider).value?.isAdmin ?? false;
    final version = ref.watch(appVersionProvider).value ?? '';
    final top = MediaQuery.paddingOf(context).top;

    // closes the menu, then opens [route] over the home screen
    void go(PageRouteInfo<Object?> route) {
      Navigator.of(context).pop();
      context.router.push(route);
    }

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.horizontal(
          end: Radius.circular(28),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // the member: their profile
          Material(
            color: AppColors.primaryDeep,
            child: InkWell(
              onTap: () => go(const ProfileRoute()),
              child: Container(
                padding: EdgeInsets.fromLTRB(18, top + 18, 14, 18),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0B3B70), AppColors.primaryDeep],
                  ),
                ),
                child: Row(
                  children: [
                    PremiumCrown(
                      size: 54,
                      child: MemberAvatar(
                        initials: profile?.initials ?? '',
                        photo: profile?.avatar,
                        size: 54,
                        background: Colors.white,
                        foreground: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile?.fullName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            t.menu.seeProfile,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(AppIcons.chevronRight, color: Colors.white70),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionLabel(t.menu.discover),
                const SizedBox(height: AppSpacing.xs),
                MenuTile(
                  icon: AppIcons.eventsTile,
                  module: AppModule.events,
                  title: t.more.events,
                  trailing: const SizedBox.shrink(),
                  onTap: () => go(const EventsRoute()),
                ),
                MenuTile(
                  icon: AppIcons.ministryTile,
                  module: AppModule.events,
                  title: t.ministry.title,
                  trailing: const SizedBox.shrink(),
                  onTap: () => go(const MinistryRoute()),
                ),
                MenuTile(
                  icon: AppIcons.teachingsTile,
                  module: AppModule.prayer,
                  title: t.teachings.title,
                  trailing: const SizedBox.shrink(),
                  onTap: () => go(const TeachingsRoute()),
                ),
                MenuTile(
                  icon: AppIcons.documentsTile,
                  module: AppModule.bible,
                  title: t.documents.title,
                  trailing: const SizedBox.shrink(),
                  onTap: () => go(const DocumentsRoute()),
                ),
                if (isAdmin) ...[
                  const SizedBox(height: AppSpacing.md),
                  SectionLabel(t.more.admin),
                  const SizedBox(height: AppSpacing.xs),
                  MenuTile(
                    icon: AppIcons.adminTile,
                    title: t.more.staff,
                    trailing: const SizedBox.shrink(),
                    onTap: () => go(const AdminRoute()),
                  ),
                  MenuTile(
                    icon: AppIcons.eventsTile,
                    title: t.more.manageEvents,
                    trailing: const SizedBox.shrink(),
                    onTap: () => go(const AdminEventsRoute()),
                  ),
                ],
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: Divider(),
                ),
                MenuTile(
                  icon: AppIcons.settings,
                  title: t.settings.title,
                  trailing: const SizedBox.shrink(),
                  onTap: () => go(const SettingsRoute()),
                ),
                MenuTile(
                  icon: AppIcons.signOut,
                  title: t.more.logout,
                  destructive: true,
                  // App listens to the session and goes back to welcome
                  onTap: () => signOut(context, ref),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    const SizedBox(width: AppSpacing.md),
                    const CmfiLogo.onDark(size: 30),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        [
                          t.app.name,
                          if (version.isNotEmpty)
                            t.more.version(version: version),
                        ].join(' · '),
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
