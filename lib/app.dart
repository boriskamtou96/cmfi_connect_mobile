import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import 'src/core/i18n/strings.g.dart';
import 'src/core/services/app_shortcuts.dart';
import 'src/core/services/crash_reporting.dart';
import 'src/core/services/deep_links.dart';
import 'src/core/services/home_widgets.dart';
import 'src/core/services/premium_store.dart';
import 'src/core/session/session.dart';
import 'src/core/storage/preferences.dart';
import 'src/core/theme/app_motion.dart';
import 'src/core/theme/app_theme.dart';
import 'src/features/events/infrastructure/events_local_store.dart';
import 'src/features/notifications/application/inbox.dart';
import 'src/features/prayer/application/importunities.dart';
import 'src/features/prayer/application/prayer_people.dart';
import 'src/features/prayer/application/retreats.dart';
import 'src/features/prayer/infrastructure/prayer_local_store.dart';
import 'src/features/reports/application/pending_reports.dart';
import 'src/features/reports/application/report_goals.dart';
import 'src/features/reports/application/report_reminder.dart';
import 'src/features/reports/application/report_sending.dart';
import 'src/features/reports/application/reports_providers.dart';
import 'src/features/reports/application/streak_milestones.dart';
import 'src/features/reports/application/today_widget.dart';
import 'src/features/reports/infrastructure/reports_local_store.dart';
import 'src/features/verses/application/verse_widget.dart';
import 'src/routing/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    // the links that open the app are caught from the start: one arriving
    // signed out waits for the sign-in (SignedInTasks opens it)
    ref.listen(pendingDeepLinkProvider, (_, _) {});

    // the "Verset du jour" widget of the home screen, signed in or not: the
    // next two weeks, again when the language changes
    ref.listen(verseWidgetProvider, (_, next) {
      if (next.value case final verses?) {
        unawaited(ref.read(homeWidgetsProvider).showVerses(verses));
      }
    });

    // Signing out (the "Plus" tab, or a 401 seen by AuthInterceptor) goes back
    // to the welcome screen. Signing in is handled by the login / sign-up screens.
    ref.listen(sessionProvider, (previous, next) {
      if (previous?.value == SessionStatus.authenticated &&
          next.value == SessionStatus.unauthenticated) {
        router.replaceAll([const WelcomeRoute()]);
        // nothing of the account stays: days kept offline, cache, reminders
        unawaited(ref.read(reportsLocalStoreProvider).clear());
        unawaited(ref.read(eventsLocalStoreProvider).clear());
        unawaited(ref.read(prayerLocalStoreProvider).clear());
        unawaited(ref.read(reportReminderProvider.notifier).cancelAll());
        unawaited(ref.read(reportSendingProvider.notifier).forget());
        unawaited(ref.read(reportGoalsProvider.notifier).clear());
        unawaited(ref.read(crashReportingProvider).identify(null));
        unawaited(ref.read(sentReportsProvider.notifier).forget());
        unawaited(ref.read(streakMilestonesProvider.notifier).clear());
        // no shortcut into an account that is gone
        unawaited(ref.read(appShortcutsProvider).clear());
        ref
          ..invalidate(pendingReportsProvider)
          ..invalidate(lastHistoryProvider)
          // kept alive: the next account must not see this one's prayers
          ..invalidate(retreatLogProvider)
          ..invalidate(prayerPeopleProvider)
          ..invalidate(importunitiesProvider)
          ..invalidate(inboxProvider)
          ..invalidate(premiumProvider);
        // the widget of the home screen keeps nothing of the account
        unawaited(
          ref
              .read(homeWidgetsProvider)
              .show(TodayWidgetData.signedOut(texts: todayWidgetTexts())),
        );
      }
    });

    // the popups (core/widgets/app_toast.dart) share these settings
    return ToastificationWrapper(
      config: const ToastificationConfig(
        alignment: Alignment.topCenter,
        maxTitleLines: 4,
        maxToastLimit: 3,
      ),
      child: MaterialApp.router(
        onGenerateTitle: (context) => context.t.app.name,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ref.watch(savedThemeModeProvider),
        // switching light / dark cross-fades every color
        themeAnimationStyle: AnimationStyle(
          duration: AppMotion.slow,
          curve: AppMotion.standard,
        ),
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        routerConfig: router.config(),
        // status bar icons that read on the app's background, even when the
        // chosen mode is not the phone's (screens on dark blue set their own)
        builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: Theme.of(context).brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: child!,
        ),
      ),
    );
  }
}
