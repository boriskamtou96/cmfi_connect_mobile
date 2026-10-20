import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/app_version.dart';
import '../../../core/services/biometrics.dart';
import '../../../core/services/premium_store.dart';
import '../../../core/session/session.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/biometric_method.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../../auth/application/saved_login.dart';
import '../../auth/infrastructure/auth_api.dart';
import '../../authorities/application/authorities_controller.dart';
import '../../disciples/application/disciples.dart';
import '../../disciples/application/received_reports.dart';
import '../../home/domain/year_story.dart';
import '../../members/application/my_account.dart';
import '../../ministry/application/nations.dart';
import '../../notifications/application/inbox.dart';
import '../../notifications/application/push_registration.dart';
import '../../profile/application/current_profile.dart';
import '../../profile/presentation/widgets/profile_photo.dart';
import '../../reports/application/pending_reports.dart';
import '../../reports/application/report_reminder.dart';
import '../../reports/application/report_sending.dart';
import '../../reports/domain/report_sending.dart';
import '../../reports/presentation/widgets/reminder_sheets.dart';
import '../../seek_first/application/seek_first.dart';
import 'widgets/theme_sheet.dart';

/// "Plus", opened from the photo at the top of the home screen: profile, the
/// modules without a tab, settings, sign out.
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
    final sending = ref.watch(reportSendingProvider);
    final account = ref.watch(myAccountProvider).value;
    final requests = ref.watch(authorityRequestsProvider).value?.length ?? 0;
    // the members who chose the user as disciple maker or authority
    final disciples = ref.watch(disciplesListProvider()).value?.total ?? 0;
    // the reports they sent in the app, not opened yet
    final receivedUnread = disciples > 0
        ? ref.watch(receivedReportsUnreadProvider)
        : 0;
    final unread = ref.watch(inboxProvider).value?.unread ?? 0;
    final premium = ref.watch(premiumProvider).value ?? false;
    // v1: Premium is offered to everyone, nothing leads to the paywall
    final premiumForEveryone = ref.watch(premiumForEveryoneProvider);
    final seekFirst = ref.watch(seekFirstProvider).value;
    final biometricKind = ref.watch(biometricKindProvider).value;
    final savedLogin = ref.watch(savedLoginProvider).value;
    final nationCount = ref.watch(nationsProvider).value?.length ?? 154;
    final discipleMaker = authorities
        ?.where((authority) => authority.isDiscipleMaker)
        .firstOrNull;
    // an incomplete profile (no name on the server) invites to fill it in
    final missingName = profile != null && !profile.hasName;
    final events = AppModule.events;
    // "Mon année avec Dieu": the year so far, or the one just ended
    final storyYear = latestStoryYear(DateTime.now());

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

    return SubPage(
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
                  leading: const ProfilePhotoButton(size: 52),
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
                  if (disciples > 0)
                    ListTile(
                      leading: moduleIcon(
                        AppIcons.disciplesTile,
                        AppModule.reports,
                      ),
                      title: Text(
                        t.more.disciples,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        t.disciples.count(n: disciples),
                        style: TextStyle(
                          fontSize: 13,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      trailing: const Icon(AppIcons.chevronRight),
                      onTap: () => context.router.push(const DisciplesRoute()),
                    ),
                  if (disciples > 0)
                    ListTile(
                      leading: moduleIcon(
                        AppIcons.receivedReportsTile,
                        AppModule.reports,
                      ),
                      title: Text(
                        t.received.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        receivedUnread > 0
                            ? t.received.unreadCount(n: receivedUnread)
                            : t.received.subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: receivedUnread > 0
                              ? FontWeight.w700
                              : null,
                          color: receivedUnread > 0
                              ? scheme.primary
                              : scheme.onSurfaceVariant,
                        ),
                      ),
                      trailing: const Icon(AppIcons.chevronRight),
                      onTap: () =>
                          context.router.push(const ReceivedReportsRoute()),
                    ),
                  ListTile(
                    leading: moduleIcon(AppIcons.soulsTile, AppModule.reports),
                    title: Text(
                      t.souls.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      t.souls.moreSubtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () => context.router.push(const SoulsRoute()),
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
                    leading: moduleIcon(AppIcons.ministryTile, events),
                    title: Text(
                      t.ministry.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      t.ministry.homeText(n: nationCount),
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () => context.router.push(const MinistryRoute()),
                  ),
                  ListTile(
                    leading: moduleIcon(AppIcons.documentsTile, events),
                    title: Text(
                      t.documents.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      t.documents.moreSubtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () => context.router.push(const DocumentsRoute()),
                  ),
                  ListTile(
                    leading: moduleIcon(AppIcons.teachingsTile, events),
                    title: Text(
                      t.teachings.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      t.teachings.moreSubtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () => context.router.push(const TeachingsRoute()),
                  ),
                  ListTile(
                    leading: moduleIcon(AppIcons.notificationsTile, events),
                    title: Text(
                      t.notifications.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: unread > 0
                        ? Text(
                            t.notifications.unread(n: unread),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: scheme.primary,
                            ),
                          )
                        : null,
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () =>
                        context.router.push(const NotificationsRoute()),
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
                  // all year long; in January, the year just ended
                  ListTile(
                    leading: moduleIcon(
                      AppIcons.yearStoryTile,
                      AppModule.reports,
                    ),
                    title: Text(
                      t.yearStory.moreTitle,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      storyYear < DateTime.now().year
                          ? t.yearStory.moreDone(year: storyYear)
                          : t.yearStory.moreSoFar(year: storyYear),
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () =>
                        context.router.push(YearStoryRoute(year: storyYear)),
                  ),
                  ListTile(
                    leading: moduleIcon(AppIcons.fastsTile, AppModule.prayer),
                    title: Text(
                      t.fasts.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      t.fasts.moreSubtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () => context.router.push(const FastsRoute()),
                  ),
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
                  ListTile(
                    leading: moduleIcon(
                      AppIcons.sendReportTile,
                      AppModule.reports,
                    ),
                    title: Text(
                      t.sending.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      sending.enabled
                          ? '${switch (sending.rhythm) {
                              SendingRhythm.weekly => t.sending.weekly,
                              SendingRhythm.biweekly => t.sending.biweekly,
                              SendingRhythm.monthly => t.sending.monthly,
                            }} · ${sending.time.format(context)}'
                          : t.sending.moreOff,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () =>
                        context.router.push(const ReportSendingRoute()),
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
                  if (!premiumForEveryone)
                    ListTile(
                      leading: moduleIcon(
                        AppIcons.premiumTile,
                        AppModule.reports,
                      ),
                      title: Text(
                        t.premium.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        premium ? t.premium.moreActive : t.premium.moreSubtitle,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: premium ? FontWeight.w700 : null,
                          color: premium
                              ? scheme.primary
                              : scheme.onSurfaceVariant,
                        ),
                      ),
                      trailing: const Icon(AppIcons.chevronRight),
                      onTap: () => context.router.push(const PremiumRoute()),
                    ),
                  if (seekFirst?.supported ?? false)
                    ListTile(
                      leading: moduleIcon(
                        AppIcons.seekFirstTile,
                        AppModule.reports,
                      ),
                      title: Text(
                        t.seekFirst.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        seekFirst!.enabled
                            ? t.seekFirst.moreOn(
                                time: seekFirst.start.format(context),
                              )
                            : t.seekFirst.moreOff,
                        style: TextStyle(
                          fontSize: 13,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      trailing: const Icon(AppIcons.chevronRight),
                      onTap: () => context.router.push(const SeekFirstRoute()),
                    ),
                  if (biometricKind case final kind?)
                    SwitchListTile.adaptive(
                      secondary: moduleIcon(
                        biometricIcon(kind),
                        AppModule.reports,
                      ),
                      value: savedLogin?.biometric ?? false,
                      onChanged: (on) => _toggleBiometrics(
                        context,
                        ref,
                        on: on,
                        method: biometricMethod(t, kind),
                      ),
                      title: Text(
                        t.auth.biometric.settings(
                          method: biometricMethod(t, kind),
                        ),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        t.auth.biometric.settingsText,
                        style: TextStyle(
                          fontSize: 13,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
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
          const SizedBox(height: 18),
          FadeSlideIn(
            index: 5,
            child: _Section(
              label: t.more.account,
              card: SectionCard(
                children: [
                  ListTile(
                    title: Text(
                      t.blocking.listTitle,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(AppIcons.chevronRight),
                    onTap: () =>
                        context.router.push(const BlockedMembersRoute()),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FadeSlideIn(
            index: 6,
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
          const SizedBox(height: AppSpacing.lg),
          const _About(),
        ],
      ),
    );
  }

  /// Face ID / the fingerprint on: the password asked once, checked by the
  /// server, then kept behind the biometric check. Off: forgotten.
  Future<void> _toggleBiometrics(
    BuildContext context,
    WidgetRef ref, {
    required bool on,
    required String method,
  }) async {
    final t = context.t;
    final saved = ref.read(savedLoginProvider.notifier);
    if (!on) {
      await saved.disable();
      return;
    }
    final toast = ref.read(toasterProvider).of(context);
    final account = await ref.read(myAccountProvider.future);
    if (account == null || !context.mounted) {
      return;
    }
    final password = await showInputDialog(
      context,
      title: t.auth.biometric.passwordTitle,
      label: t.auth.biometric.passwordLabel,
      confirmLabel: t.auth.biometric.confirm,
      obscureText: true,
    );
    if (password == null || password.isEmpty) {
      return;
    }
    try {
      await ref
          .read(authApiProvider)
          .login(phoneNumber: account.phoneNumber, password: password);
    } on AppException catch (error) {
      toast.error(userMessageFor(error, t));
      return;
    }
    await saved.remember(account.phoneNumber, password);
    if (await saved.enable(password, reason: t.auth.biometric.enableReason)) {
      toast.success(t.auth.biometric.enabled(method: method));
    }
  }

  /// Days saved offline would be lost: asks first.
  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final pending = ref.read(pendingReportsProvider).length;
    if (pending > 0) {
      final confirmed = await showConfirmDialog(
        context,
        title: t.more.logoutPendingTitle,
        text: t.more.logoutPendingText(n: pending),
        confirmLabel: t.more.logoutAnyway,
        destructive: true,
      );
      if (!confirmed) {
        return;
      }
    }
    // while the session lasts: the server forgets this phone
    await ref.read(pushRegistrationProvider.notifier).stop();
    await ref.read(premiumStoreProvider).logOut();
    await ref.read(sessionProvider.notifier).signOut();
  }

  Future<void> _pickLanguage(BuildContext context, WidgetRef ref) async {
    final current = TranslationProvider.of(context).locale;
    final choice = context.isCupertino
        ? showActionSheet<AppLocale>(
            context,
            title: context.t.more.languageTitle,
            actions: [
              for (final locale in AppLocale.values)
                AdaptiveAction(
                  value: locale,
                  // each language is written in itself
                  label: locale.buildSync().app.languageName,
                  selected: locale == current,
                ),
            ],
          )
        : _languageSheet(context, current);
    final picked = await choice;
    if (picked == null || picked == current) {
      return;
    }
    await LocaleSettings.setLocale(picked);
    await ref.read(savedLanguageProvider.notifier).save(picked.languageCode);
  }

  /// The languages as radio buttons, on Android.
  Future<AppLocale?> _languageSheet(BuildContext context, AppLocale current) =>
      showModalBottomSheet<AppLocale>(
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
                        RadioListTile<AppLocale>.adaptive(
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

/// At the very bottom: the name of the app, its version and the copyright.
class _About extends ConsumerWidget {
  const _About();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    final version = ref.watch(appVersionProvider).value ?? '';

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: Column(
        children: [
          Text(
            t.app.name,
            style: TextStyle(fontWeight: FontWeight.w800, color: muted),
          ),
          if (version.isNotEmpty)
            Text(
              t.more.version(version: version),
              style: TextStyle(fontSize: 13, color: muted),
            ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            t.more.copyright(year: DateTime.now().year),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, height: 1.4, color: muted),
          ),
        ],
      ),
    );
  }
}
