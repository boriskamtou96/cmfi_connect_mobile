import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/session/session.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/tab_page.dart';
import '../../../routing/app_router.dart';
import '../../authorities/application/authorities_controller.dart';
import '../../members/application/my_account.dart';
import '../../profile/application/current_profile.dart';
import '../../reports/application/pending_reports.dart';
import '../../reports/application/report_reminder.dart';
import '../../reports/presentation/widgets/reminder_sheets.dart';
import 'widgets/theme_sheet.dart';

/// "Plus" tab: profile, the modules without a tab, settings, sign out.
@RoutePage()
class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final profile = ref.watch(currentProfileProvider).value;
    final authorities = ref.watch(authoritiesControllerProvider).value;
    final themeMode = ref.watch(savedThemeModeProvider);
    final reminder = ref.watch(reportReminderProvider);
    final account = ref.watch(myAccountProvider).value;
    final requests = ref.watch(authorityRequestsProvider).value?.length ?? 0;
    final discipleMaker = authorities
        ?.where((authority) => authority.isDiscipleMaker)
        .firstOrNull;
    // an incomplete profile (no name on the server) invites to fill it in
    final missingName = profile != null && !profile.hasName;
    final events = AppModule.events;

    Widget moduleIcon(IconData icon, AppModule module) {
      final tone = module.tone(context);
      return Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: tone.soft,
          borderRadius: BorderRadius.circular(11),
        ),
        child: PhosphorIcon(icon, size: 20, color: tone.onSoft),
      );
    }

    return TabPage(
      title: t.more.title,
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.xs,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          FadeSlideIn(
            child: SectionCard(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  leading: InitialsAvatar(
                    initials: profile?.initials ?? '',
                    size: 52,
                  ),
                  title: Text(
                    missingName
                        ? t.more.completeProfile
                        : profile?.fullName ?? '',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: missingName ? scheme.primary : null,
                    ),
                  ),
                  subtitle: Text(
                    [
                      if ((account?.username ?? '').isNotEmpty)
                        '@${account!.username}',
                      // if (profile != null && profile.phoneNumber.isNotEmpty)
                      //   formatPhone(profile.phoneNumber),
                    ].join(' · '),
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  trailing: const Icon(AppIcons.chevronRight),
                  onTap: () =>
                      context.router.push(ChurchFormRoute(isEditing: true)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          FadeSlideIn(
            index: 1,
            child: _Section(
              label: t.more.accompaniment,
              card: SectionCard(
                children: [
                  ListTile(
                    leading: moduleIcon(
                      AppIcons.authoritiesTile,
                      AppModule.reports,
                    ),
                    title: Text(
                      t.authorities.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: requests > 0
                        ? Text(
                            t.authorities.requestsCount(n: requests),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: scheme.primary,
                            ),
                          )
                        : authorities == null
                        ? null
                        : Text(
                            discipleMaker != null
                                ? t.authorities.discipleMakerOf(
                                    name: discipleMaker.fullName,
                                  )
                                : t.authorities.count(n: authorities.length),
                            style: TextStyle(
                              fontSize: 13,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () => context.router.push(const AuthoritiesRoute()),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          FadeSlideIn(
            index: 2,
            child: _Section(
              label: t.more.community,
              card: SectionCard(
                children: [
                  ListTile(
                    leading: moduleIcon(AppIcons.eventsTile, events),
                    title: Text(
                      t.more.events,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () => context.router.push(const EventsRoute()),
                  ),
                  ListTile(
                    leading: moduleIcon(AppIcons.announcementsTile, events),
                    title: Text(
                      t.more.announcements,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: StatusPill(t.common.soon),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          FadeSlideIn(
            index: 3,
            child: _Section(
              label: t.more.reports,
              card: SectionCard(
                children: [
                  ListTile(
                    leading: moduleIcon(AppIcons.itemsTile, AppModule.reports),
                    title: Text(
                      t.more.myItems,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () => context.router.push(const ItemsRoute()),
                  ),
                  ListTile(
                    leading: moduleIcon(AppIcons.shareTile, AppModule.reports),
                    title: Text(
                      t.more.exportReport,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () => context.router.push(const ExportReportRoute()),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          if (account?.isAdmin ?? false) ...[
            FadeSlideIn(
              index: 4,
              child: _Section(
                label: t.more.admin,
                card: SectionCard(
                  children: [
                    ListTile(
                      leading: moduleIcon(
                        AppIcons.adminTile,
                        AppModule.reports,
                      ),
                      title: Text(
                        t.more.staff,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(AppIcons.chevronRight),
                      onTap: () => context.router.push(const AdminRoute()),
                    ),
                    ListTile(
                      leading: moduleIcon(AppIcons.eventsTile, events),
                      title: Text(
                        t.more.manageEvents,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(AppIcons.chevronRight),
                      onTap: () =>
                          context.router.push(const AdminEventsRoute()),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
          ],
          FadeSlideIn(
            index: 4,
            child: _Section(
              label: t.more.app,
              card: SectionCard(
                children: [
                  ListTile(
                    title: Text(
                      t.reminder.settings,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          reminder.enabled
                              ? reminder.time.format(context)
                              : t.reminder.off,
                          style: TextStyle(
                            fontSize: 14,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(AppIcons.chevronRight),
                      ],
                    ),
                    onTap: () => showReminderSettings(context),
                  ),
                  ListTile(
                    title: Text(
                      t.more.appearance,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          themeModeLabel(t, themeMode),
                          style: TextStyle(
                            fontSize: 14,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(AppIcons.chevronRight),
                      ],
                    ),
                    onTap: () => showThemeSheet(context),
                  ),
                  ListTile(
                    title: Text(
                      t.more.language,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          t.app.languageName,
                          style: TextStyle(
                            fontSize: 14,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        const Icon(AppIcons.chevronRight),
                      ],
                    ),
                    onTap: () => _pickLanguage(context, ref),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FadeSlideIn(
            index: 5,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: scheme.error,
                minimumSize: const Size.fromHeight(52),
              ),
              // App listens to the session and goes back to the welcome screen
              onPressed: () => _signOut(context, ref),
              child: Text(
                t.more.logout,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          // required by the stores: the account can be deleted from the app
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: scheme.onSurfaceVariant,
              ),
              onPressed: () => context.router.push(const DeleteAccountRoute()),
              child: Text(t.members.deleteAccount.button),
            ),
          ),
        ],
      ),
    );
  }

  /// Days saved offline would be lost: asks first.
  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final pending = ref.read(pendingReportsProvider).length;
    if (pending > 0) {
      final confirmed = await showAppDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(t.more.logoutPendingTitle),
          content: Text(t.more.logoutPendingText(n: pending)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(t.common.cancel),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(t.more.logoutAnyway),
            ),
          ],
        ),
      );
      if (confirmed != true) {
        return;
      }
    }
    await ref.read(sessionProvider.notifier).signOut();
  }

  Future<void> _pickLanguage(BuildContext context, WidgetRef ref) async {
    final current = TranslationProvider.of(context).locale;
    final picked = await showModalBottomSheet<AppLocale>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.xl,
                  0,
                  AppSpacing.xl,
                  AppSpacing.sm,
                ),
                child: Text(
                  context.t.more.languageTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              RadioGroup<AppLocale>(
                groupValue: current,
                onChanged: (locale) => Navigator.of(context).pop(locale),
                child: Column(
                  children: [
                    for (final locale in AppLocale.values)
                      RadioListTile<AppLocale>(
                        value: locale,
                        // each language is written in itself
                        title: Text(locale.buildSync().app.languageName),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );
    if (picked == null || picked == current) {
      return;
    }
    await LocaleSettings.setLocale(picked);
    await ref.read(savedLanguageProvider.notifier).save(picked.languageCode);
  }
}

/// "COMMUNAUTÉ" and its card: one block, so they come in together.
class _Section extends StatelessWidget {
  const _Section({required this.label, required this.card});

  final String label;
  final Widget card;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [SectionLabel(label), const SizedBox(height: 10), card],
    );
  }
}
