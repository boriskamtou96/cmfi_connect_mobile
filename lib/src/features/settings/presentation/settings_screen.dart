import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/app_update.dart';
import '../../../core/services/app_version.dart';
import '../../../core/services/biometrics.dart';
import '../../../core/services/link_launcher.dart';
import '../../../core/services/premium_store.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/adaptive_menus.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/biometric_method.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/menu_tile.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../../auth/application/saved_login.dart';
import '../../auth/infrastructure/auth_api.dart';
import '../../members/application/my_account.dart';
import '../../reports/application/report_reminder.dart';
import '../../reports/application/report_sending.dart';
import '../../reports/domain/report_sending.dart';
import '../../reports/presentation/widgets/reminder_sheets.dart';
import '../../seek_first/application/seek_first.dart';
import '../../update/presentation/update_prompts.dart';
import 'sign_out.dart';
import 'widgets/theme_sheet.dart';

/// Where to write to the team (the address of the site's legal pages).
const _contactEmail = 'info@cmfi-connect.com';

/// « Réglages » (validated on 23/10/2026), from the gear of the profile or
/// the menu: how the app works for the member. Premium, the practice (Cherche
/// d'abord Dieu, the sending to the authorities, the evening reminder), the
/// app (Face ID, appearance, language), the account, help, then sign out and
/// the version.
@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final s = t.settings;
    final scheme = Theme.of(context).colorScheme;
    final themeMode = ref.watch(savedThemeModeProvider);
    final reminder = ref.watch(reportReminderProvider);
    final sending = ref.watch(reportSendingProvider);
    final premium = ref.watch(premiumProvider).value ?? false;
    // v1: Premium is offered to everyone, nothing leads to the paywall
    final premiumForEveryone = ref.watch(premiumForEveryoneProvider);
    final seekFirst = ref.watch(seekFirstProvider).value;
    final biometricKind = ref.watch(biometricKindProvider).value;
    final savedLogin = ref.watch(savedLoginProvider).value;
    final links = ref.read(linkLauncherProvider);

    // a page of the site, in the app's language (French at the root)
    Uri sitePage(String page) {
      final language = LocaleSettings.currentLocale.languageCode;
      return Uri.parse(
        language == 'fr'
            ? '${AppConfig.siteUrl}/$page'
            : '${AppConfig.siteUrl}/$language/$page',
      );
    }

    var index = 0;
    Widget group(String? label, List<Widget> tiles) => FadeSlideIn(
      index: index++,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (label != null) ...[
              SectionLabel(label),
              const SizedBox(height: 10),
            ],
            SectionCard(children: tiles),
          ],
        ),
      ),
    );

    return SubPage(
      title: s.title,
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.xs,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          if (!premiumForEveryone)
            group(null, [
              MenuTile(
                icon: AppIcons.premiumTile,
                title: t.premium.name,
                subtitle: premium
                    ? t.premium.moreActive
                    : t.premium.moreSubtitle,
                subtitleStrong: premium,
                onTap: () => context.router.push(const PremiumRoute()),
              ),
            ]),
          group(s.practice, [
            if (seekFirst?.supported ?? false)
              MenuTile(
                icon: AppIcons.seekFirstTile,
                module: AppModule.prayer,
                title: t.seekFirst.title,
                subtitle: seekFirst!.enabled
                    ? t.seekFirst.moreOn(time: seekFirst.start.format(context))
                    : t.seekFirst.moreOff,
                onTap: () => context.router.push(const SeekFirstRoute()),
              ),
            MenuTile(
              icon: AppIcons.sendReportTile,
              title: t.sending.title,
              subtitle: sending.enabled
                  ? '${switch (sending.rhythm) {
                      SendingRhythm.weekly => t.sending.weekly,
                      SendingRhythm.biweekly => t.sending.biweekly,
                      SendingRhythm.monthly => t.sending.monthly,
                    }} · ${sending.time.format(context)}'
                  : t.sending.moreOff,
              onTap: () => context.router.push(const ReportSendingRoute()),
            ),
            MenuTile(
              icon: AppIcons.reminderTile,
              title: t.reminder.settings,
              trailing: MenuValue(
                reminder.enabled
                    ? reminder.time.format(context)
                    : t.reminder.off,
              ),
              onTap: () => showReminderSettings(context),
            ),
          ]),
          group(t.more.app, [
            if (biometricKind case final kind?)
              SwitchListTile.adaptive(
                secondary: MenuIcon(biometricIcon(kind)),
                value: savedLogin?.biometric ?? false,
                onChanged: (on) => _toggleBiometrics(
                  context,
                  ref,
                  on: on,
                  method: biometricMethod(t, kind),
                ),
                title: Text(
                  t.auth.biometric.settings(method: biometricMethod(t, kind)),
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
            MenuTile(
              icon: AppIcons.appearanceTile,
              title: t.more.appearance,
              trailing: MenuValue(themeModeLabel(t, themeMode)),
              onTap: () => showThemeSheet(context),
            ),
            MenuTile(
              icon: AppIcons.languageTile,
              title: t.more.language,
              trailing: MenuValue(t.app.languageName),
              onTap: () => _pickLanguage(context, ref),
            ),
          ]),
          group(t.more.account, [
            MenuTile(
              icon: AppIcons.blockedTile,
              title: t.blocking.listTitle,
              onTap: () => context.router.push(const BlockedMembersRoute()),
            ),
            // required by the stores: the account can be deleted from the app
            MenuTile(
              icon: AppIcons.deleteAccountTile,
              title: t.members.deleteAccount.button,
              onTap: () => context.router.push(const DeleteAccountRoute()),
            ),
          ]),
          group(s.help, [
            MenuTile(
              icon: AppIcons.contactTile,
              title: s.contact,
              subtitle: _contactEmail,
              onTap: () =>
                  links.open(Uri(scheme: 'mailto', path: _contactEmail)),
            ),
            MenuTile(
              icon: AppIcons.privacyTile,
              title: s.privacy,
              onTap: () => links.openInApp(sitePage('privacy')),
            ),
            MenuTile(
              icon: AppIcons.termsTile,
              title: s.terms,
              onTap: () => links.openInApp(sitePage('terms')),
            ),
          ]),
          FadeSlideIn(
            index: index++,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: scheme.error,
                side: BorderSide(color: scheme.error.withValues(alpha: 0.35)),
                minimumSize: const Size.fromHeight(52),
              ),
              // App listens to the session and goes back to the welcome screen
              onPressed: () => signOut(context, ref),
              icon: const Icon(AppIcons.signOut),
              label: Text(
                t.more.logout,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
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

/// At the very bottom: the name of the app, its version and the copyright;
/// above them, the update when a newer version is out.
class _About extends ConsumerWidget {
  const _About();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    final version = ref.watch(appVersionProvider).value ?? '';
    final update = ref.watch(appUpdateProvider).value;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        0,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: Column(
        children: [
          if (update case AppUpdateStatus(
            need: UpdateNeed.optional,
            :final target?,
          )) ...[
            FilledButton.tonalIcon(
              onPressed: () => startUpdate(context, ref),
              icon: const Icon(AppIcons.update),
              label: Text(t.update.moreButton(version: '$target')),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
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
