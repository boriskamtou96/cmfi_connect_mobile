import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

import 'src/core/i18n/strings.g.dart';
import 'src/core/session/session.dart';
import 'src/core/storage/preferences.dart';
import 'src/core/theme/app_motion.dart';
import 'src/core/theme/app_theme.dart';
import 'src/features/events/infrastructure/events_local_store.dart';
import 'src/features/prayer/application/importunities.dart';
import 'src/features/prayer/application/prayer_people.dart';
import 'src/features/prayer/application/retreats.dart';
import 'src/features/prayer/infrastructure/prayer_local_store.dart';
import 'src/features/reports/application/pending_reports.dart';
import 'src/features/reports/application/report_reminder.dart';
import 'src/features/reports/application/reports_providers.dart';
import 'src/features/reports/infrastructure/reports_local_store.dart';
import 'src/routing/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

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
        ref
          ..invalidate(pendingReportsProvider)
          ..invalidate(lastHistoryProvider)
          // kept alive: the next account must not see this one's prayers
          ..invalidate(retreatLogProvider)
          ..invalidate(prayerPeopleProvider)
          ..invalidate(importunitiesProvider);
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
