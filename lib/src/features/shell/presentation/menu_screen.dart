import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/app_version.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/menu_tile.dart';
import '../../../core/widgets/premium_crown.dart';
import '../../../core/widgets/section_card.dart';
import '../../../routing/app_router.dart';
import '../../members/application/my_account.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../../profile/application/current_profile.dart';
import '../../reports/application/reading_books.dart';
import '../../reports/domain/reading_book.dart';
import '../../settings/presentation/sign_out.dart';
import '../../souls/application/souls.dart';

/// « Vous », the last tab (the photo of the member, 12/11/2026; it was a
/// drawer before): the member at the top with their pseudo (their profile),
/// what is theirs (the souls they follow, their fasts, their readings), what
/// the community offers, the administration for the admins, then the
/// settings, signing out and the version.
@RoutePage()
class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  static const _night = Color(0xFF0B3B70);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final profile = ref.watch(currentProfileProvider).value;
    final account = ref.watch(myAccountProvider).value;
    final isAdmin = account?.isAdmin ?? false;
    final username = account?.username ?? '';
    final souls = ref.watch(soulsProvider).value ?? const [];
    final due = souls.where((soul) => soul.dueBy(today())).length;
    // the books being read
    final reading =
        (ref.watch(readingBooksProvider).value ?? const <ReadingBook>[])
            .where((book) => book.isReading)
            .length;
    final version = ref.watch(appVersionProvider).value ?? '';
    final top = MediaQuery.paddingOf(context).top;

    // a page above the tabs
    void go(PageRouteInfo<Object?> route) => context.router.push(route);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // the member is on night blue, under the status bar
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.only(bottom: AppSpacing.xl),
              children: [
                // the member: their profile
                Material(
                  color: AppColors.primaryDeep,
                  child: Tooltip(
                    message: t.menu.seeProfile,
                    child: InkWell(
                      onTap: () => go(const ProfileRoute()),
                      child: Container(
                        padding: EdgeInsetsDirectional.fromSTEB(
                          20,
                          top + 22,
                          14,
                          22,
                        ),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [_night, AppColors.primaryDeep],
                          ),
                        ),
                        child: Row(
                          children: [
                            PremiumCrown(
                              size: 58,
                              child: MemberAvatar(
                                initials: profile?.initials ?? '',
                                photo: profile?.avatar,
                                size: 58,
                                background: Colors.white,
                                foreground: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Semantics(
                                    header: true,
                                    child: Text(
                                      profile?.fullName ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    // their pseudo, as the others find them
                                    username.isEmpty
                                        ? t.menu.seeProfile
                                        : '@$username',
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.75,
                                      ),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              AppIcons.chevronRight,
                              color: Colors.white70,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.lg,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // what is theirs (12/11/2026, in place of the hymns
                      // and the prayer, which open from the home screen)
                      SectionLabel(t.me.journey),
                      const SizedBox(height: AppSpacing.xs),
                      SectionCard(
                        children: [
                          MenuTile(
                            icon: AppIcons.soulsTile,
                            module: AppModule.hymns,
                            title: t.souls.title,
                            subtitle: souls.isEmpty
                                ? t.souls.moreSubtitle
                                : [
                                    t.me.souls(n: souls.length),
                                    if (due > 0) t.me.soulsDue(n: due),
                                  ].join(' · '),
                            onTap: () => go(const SoulsRoute()),
                          ),
                          MenuTile(
                            icon: AppIcons.fastsTile,
                            module: AppModule.prayer,
                            title: t.fasts.title,
                            subtitle: t.fasts.moreSubtitle,
                            onTap: () => go(const FastsRoute()),
                          ),
                          MenuTile(
                            icon: AppIcons.readingTile,
                            module: AppModule.bible,
                            title: t.reading.title,
                            subtitle: reading == 0
                                ? t.reading.moreSubtitle
                                : t.reading.moreCount(n: reading),
                            onTap: () => go(const ReadingRoute()),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SectionLabel(t.menu.discover),
                      const SizedBox(height: AppSpacing.xs),
                      SectionCard(
                        children: [
                          MenuTile(
                            icon: AppIcons.eventsTile,
                            module: AppModule.events,
                            title: t.more.events,
                            onTap: () => go(const EventsRoute()),
                          ),
                          MenuTile(
                            icon: AppIcons.ministryTile,
                            module: AppModule.events,
                            title: t.ministry.title,
                            onTap: () => go(const MinistryRoute()),
                          ),
                          MenuTile(
                            icon: AppIcons.teachingsTile,
                            module: AppModule.prayer,
                            title: t.teachings.title,
                            onTap: () => go(const TeachingsRoute()),
                          ),
                          MenuTile(
                            icon: AppIcons.documentsTile,
                            module: AppModule.bible,
                            title: t.documents.title,
                            onTap: () => go(const DocumentsRoute()),
                          ),
                        ],
                      ),
                      if (isAdmin) ...[
                        const SizedBox(height: AppSpacing.lg),
                        SectionLabel(t.more.admin),
                        const SizedBox(height: AppSpacing.xs),
                        SectionCard(
                          children: [
                            MenuTile(
                              icon: AppIcons.adminTile,
                              title: t.more.staff,
                              onTap: () => go(const AdminRoute()),
                            ),
                            MenuTile(
                              icon: AppIcons.eventsTile,
                              title: t.more.manageEvents,
                              onTap: () => go(const AdminEventsRoute()),
                            ),
                            MenuTile(
                              icon: AppIcons.documentsTile,
                              title: t.more.manageDocuments,
                              onTap: () => go(const AdminDocumentsRoute()),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: AppSpacing.lg),
                      SectionCard(
                        children: [
                          MenuTile(
                            icon: AppIcons.settings,
                            title: t.settings.title,
                            onTap: () => go(const SettingsRoute()),
                          ),
                          MenuTile(
                            icon: AppIcons.signOut,
                            title: t.more.logout,
                            destructive: true,
                            // App listens to the session and goes back to
                            // welcome
                            onTap: () => signOut(context, ref),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Row(
                        children: [
                          const SizedBox(width: AppSpacing.xs),
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
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
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
            // the status bar stays on night blue when the page scrolls
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              height: top,
              child: const ColoredBox(color: _night),
            ),
          ],
        ),
      ),
    );
  }
}
