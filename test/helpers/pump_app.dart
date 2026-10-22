import 'package:cmfi_connect/app.dart';
import 'package:cmfi_connect/src/core/config/flavor.dart';
import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/app_shield.dart';
import 'package:cmfi_connect/src/core/services/app_shortcuts.dart';
import 'package:cmfi_connect/src/core/services/app_update.dart';
import 'package:cmfi_connect/src/core/services/biometrics.dart';
import 'package:cmfi_connect/src/core/services/calendar_service.dart';
import 'package:cmfi_connect/src/core/services/chime.dart';
import 'package:cmfi_connect/src/core/services/crash_reporting.dart';
import 'package:cmfi_connect/src/core/services/deep_links.dart';
import 'package:cmfi_connect/src/core/services/home_widgets.dart';
import 'package:cmfi_connect/src/core/services/image_picking.dart';
import 'package:cmfi_connect/src/core/services/link_launcher.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/core/services/lock_screen_timer.dart';
import 'package:cmfi_connect/src/core/services/media_images.dart';
import 'package:cmfi_connect/src/core/services/network_status.dart';
import 'package:cmfi_connect/src/core/services/phone_verification.dart';
import 'package:cmfi_connect/src/core/services/premium_store.dart';
import 'package:cmfi_connect/src/core/services/push_messaging.dart';
import 'package:cmfi_connect/src/core/services/screen_awake.dart';
import 'package:cmfi_connect/src/core/services/share_service.dart';
import 'package:cmfi_connect/src/core/services/store_review.dart';
import 'package:cmfi_connect/src/core/services/voice_reader.dart';
import 'package:cmfi_connect/src/core/session/account.dart';
import 'package:cmfi_connect/src/core/storage/account_storage.dart';
import 'package:cmfi_connect/src/core/storage/preferences.dart';
import 'package:cmfi_connect/src/core/storage/saved_login.dart';
import 'package:cmfi_connect/src/core/storage/token_storage.dart';
import 'package:cmfi_connect/src/core/widgets/app_toast.dart';
import 'package:cmfi_connect/src/core/widgets/dove_mascot.dart';
import 'package:cmfi_connect/src/features/admin/infrastructure/admin_api.dart';
import 'package:cmfi_connect/src/features/auth/infrastructure/auth_api.dart';
import 'package:cmfi_connect/src/features/authorities/infrastructure/authorities_api.dart';
import 'package:cmfi_connect/src/features/bible/infrastructure/bible_api.dart';
import 'package:cmfi_connect/src/features/bible/infrastructure/bible_storage.dart';
import 'package:cmfi_connect/src/features/disciples/infrastructure/disciples_api.dart';
import 'package:cmfi_connect/src/features/documents/infrastructure/documents_api.dart';
import 'package:cmfi_connect/src/features/events/infrastructure/events_api.dart';
import 'package:cmfi_connect/src/features/hymns/infrastructure/hymn_book_storage.dart';
import 'package:cmfi_connect/src/features/hymns/infrastructure/hymns_api.dart';
import 'package:cmfi_connect/src/features/members/infrastructure/members_api.dart';
import 'package:cmfi_connect/src/features/ministry/infrastructure/ministry_api.dart';
import 'package:cmfi_connect/src/features/notifications/infrastructure/notifications_api.dart';
import 'package:cmfi_connect/src/features/payments/infrastructure/payments_api.dart';
import 'package:cmfi_connect/src/features/prayer/infrastructure/prayer_api.dart';
import 'package:cmfi_connect/src/features/profile/application/photo_decoding.dart';
import 'package:cmfi_connect/src/features/profile/domain/profile.dart';
import 'package:cmfi_connect/src/features/profile/infrastructure/profile_api.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/infrastructure/activities_api.dart';
import 'package:cmfi_connect/src/features/reports/infrastructure/report_sendings_api.dart';
import 'package:cmfi_connect/src/features/reports/infrastructure/reports_api.dart';
import 'package:cmfi_connect/src/features/souls/infrastructure/souls_storage.dart';
import 'package:cmfi_connect/src/features/teachings/application/teaching_player.dart';
import 'package:cmfi_connect/src/features/teachings/infrastructure/teaching_files.dart';
import 'package:cmfi_connect/src/features/teachings/infrastructure/teachings_api.dart';
import 'package:cmfi_connect/src/features/update/presentation/app_update_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bible_fakes.dart';
import 'fakes.dart';

/// The whole app, with every API and storage faked.
class TestApp {
  TestApp({
    required this.container,
    required this.preferences,
    required this.storage,
    required this.accountStorage,
    required this.authApi,
    required this.authoritiesApi,
    required this.hymnsApi,
    required this.hymnStorage,
    required this.screenAwake,
    required this.notifications,
    required this.membersApi,
    required this.toasts,
    required this.adminApi,
    required this.share,
    required this.network,
    required this.profileApi,
    required this.activitiesApi,
    required this.reportsApi,
    required this.eventsApi,
    required this.calendar,
    required this.links,
    required this.picker,
    required this.prayerApi,
    required this.chime,
    required this.push,
    required this.notificationsApi,
    required this.premium,
    required this.homeWidgets,
    required this.ministryApi,
    required this.storeReview,
    required this.shortcuts,
    required this.incomingLinks,
    required this.disciplesApi,
    required this.bibleApi,
    required this.bibleStorage,
    required this.appShield,
    required this.documentsApi,
    required this.biometrics,
    required this.savedLogin,
    required this.teachingsApi,
    required this.player,
    required this.teachingFiles,
    required this.soulsStorage,
    required this.voice,
    required this.reportSendingsApi,
    required this.lockScreen,
    required this.updateRules,
    required this.installer,
    required this.paymentsApi,
  });

  final ProviderContainer container;
  final SharedPreferences preferences;
  final FakeTokenStorage storage;
  final FakeAccountStorage accountStorage;
  final FakeAuthApi authApi;
  final FakeAuthoritiesApi authoritiesApi;
  final FakeHymnsApi hymnsApi;
  final FakeHymnBookStorage hymnStorage;
  final FakeScreenAwake screenAwake;
  final FakeLocalNotifications notifications;
  final FakeMembersApi membersApi;

  /// The popups shown (errors, confirmations).
  final FakeToaster toasts;
  final FakeAdminApi adminApi;
  final FakeShareService share;
  final FakeNetworkStatus network;
  final FakeProfileApi profileApi;
  final FakeActivitiesApi activitiesApi;
  final FakeReportsApi reportsApi;
  final FakeEventsApi eventsApi;
  final FakeCalendarService calendar;
  final FakeLinkLauncher links;
  final FakeImagePicking picker;
  final FakePrayerApi prayerApi;
  final FakePushMessaging push;
  final FakeNotificationsApi notificationsApi;
  final FakePremiumStore premium;
  final FakeHomeWidgets homeWidgets;
  final FakeMinistryApi ministryApi;
  final FakeChime chime;
  final FakeStoreReview storeReview;
  final FakeAppShortcuts shortcuts;

  /// The links that open the app (cmfi-connect.com/open?to=…).
  final FakeIncomingLinks incomingLinks;
  final FakeDisciplesApi disciplesApi;
  final FakeBibleApi bibleApi;
  final FakeBibleStorage bibleStorage;
  final FakeAppShield appShield;
  final FakeDocumentsApi documentsApi;
  final FakeBiometrics biometrics;
  final FakeSavedLoginStorage savedLogin;
  final FakeTeachingsApi teachingsApi;
  final FakeTeachingPlayer player;
  final FakeTeachingFiles teachingFiles;
  final FakeSoulsStorage soulsStorage;
  final FakeVoiceReader voice;
  final FakeReportSendingsApi reportSendingsApi;
  final FakeLockScreenTimer lockScreen;

  /// The update rules of Firebase Remote Config, and the version installed.
  final FakeUpdateRules updateRules;
  final FakeAppInstaller installer;

  /// The mobile money payments (pawaPay through the server).
  final FakePaymentsApi paymentsApi;
}

Future<TestApp> pumpApp(
  WidgetTester tester, {
  String? token,
  bool onboardingSeen = true,
  // the evening reminder offered after the first save: tested on its own
  bool reminderOffered = true,
  FakeAuthApi? authApi,
  Account? account,
  Profile? profile = FakeProfileApi.defaultProfile,
  FakeAuthoritiesApi? authoritiesApi,
  FakeHymnsApi? hymnsApi,
  FakeHymnBookStorage? hymnStorage,
  FakeLocalNotifications? notifications,
  FakeMembersApi? membersApi,
  FakeAdminApi? adminApi,
  FakeEventsApi? eventsApi,
  FakeMediaImages? mediaImages,
  FakePrayerApi? prayerApi,
  FakePushMessaging? push,
  FakeNotificationsApi? notificationsApi,
  FakePremiumStore? premium,
  FakeMinistryApi? ministryApi,
  FakeAppShield? appShield,
  FakeDocumentsApi? documentsApi,
  FakeBiometrics? biometrics,
  FakeSavedLoginStorage? savedLogin,
  FakeTeachingsApi? teachingsApi,
  FakeTeachingFiles? teachingFiles,
  FakeSoulsStorage? soulsStorage,
  FakePhoneVerification? phoneVerification,
  FakeStoreReview? storeReview,
  FakeAppShortcuts? shortcuts,
  FakeIncomingLinks? incomingLinks,
  FakeDisciplesApi? disciplesApi,
  FakeReportSendingsApi? reportSendingsApi,
  FakeBibleApi? bibleApi,
  FakeUpdateRules? updateRules,
  FakeAppInstaller? installer,
  FakePaymentsApi? paymentsApi,
  // the pictures picked for a profile photo, decoded beforehand
  PhotoDecoder? photoDecoder,
  // v1 offers Premium to everyone (premiumForEveryoneProvider); the tests
  // see the paywall unless they say so
  bool premiumForEveryone = false,
  // the items of the report and days already saved (store screenshots)
  List<ActivityType> activities = sampleActivities,
  Map<DateTime, DailyReport> reportDays = const {},
  // a boundary around the whole app, to take a picture of the screen
  GlobalKey? screenKey,
  Map<String, Object> initialPreferences = const {},
}) async {
  // Zoé breathes forever: still in the tests, so that they settle
  DoveMascot.lively = false;
  SharedPreferences.setMockInitialValues({
    if (onboardingSeen) 'onboarding_seen': true,
    if (reminderOffered) 'reminder_offered': true,
    ...initialPreferences,
  });
  final preferences = await SharedPreferences.getInstance();
  final storage = FakeTokenStorage(token);
  final auth = authApi ?? FakeAuthApi();
  final accountStorage = FakeAccountStorage(account);
  final profileApi = FakeProfileApi(profile);
  final authorities = authoritiesApi ?? FakeAuthoritiesApi();
  final hymns = hymnsApi ?? FakeHymnsApi();
  final storage0 = hymnStorage ?? FakeHymnBookStorage();
  final awake = FakeScreenAwake();
  final notifier = notifications ?? FakeLocalNotifications();
  final members = membersApi ?? FakeMembersApi();
  final toasts = FakeToaster();
  final admin = adminApi ?? FakeAdminApi();
  final share = FakeShareService();
  final network = FakeNetworkStatus();
  final activitiesApi = FakeActivitiesApi(activities);
  // the day form lists the active items, like the API
  final reportsApi = FakeReportsApi(activities: activitiesApi.activities);
  reportsApi.days.addAll(reportDays);
  final events = eventsApi ?? FakeEventsApi();
  final calendar = FakeCalendarService();
  final links = FakeLinkLauncher();
  final picker = FakeImagePicking();
  final prayer = prayerApi ?? FakePrayerApi();
  final chime = FakeChime();
  final pushMessaging = push ?? FakePushMessaging();
  final notificationsApi0 = notificationsApi ?? FakeNotificationsApi();
  final premiumStore = premium ?? FakePremiumStore();
  final widgets = FakeHomeWidgets();
  final ministry = ministryApi ?? FakeMinistryApi();
  final shield = appShield ?? FakeAppShield();
  final library = documentsApi ?? FakeDocumentsApi();
  final faceId = biometrics ?? FakeBiometrics();
  final keychain = savedLogin ?? FakeSavedLoginStorage();
  final review = storeReview ?? FakeStoreReview();
  final appShortcuts = shortcuts ?? FakeAppShortcuts();
  final appLinks = incomingLinks ?? FakeIncomingLinks();
  final disciples = disciplesApi ?? FakeDisciplesApi();
  final bible = bibleApi ?? FakeBibleApi();
  final bibleStorage = FakeBibleStorage();
  final teachings = teachingsApi ?? FakeTeachingsApi();
  final player = FakeTeachingPlayer();
  final files = teachingFiles ?? FakeTeachingFiles();
  final souls = soulsStorage ?? FakeSoulsStorage();
  final voice = FakeVoiceReader();
  final lockScreen = FakeLockScreenTimer();
  final sendings = reportSendingsApi ?? FakeReportSendingsApi();
  final rules = updateRules ?? FakeUpdateRules();
  final appInstaller = installer ?? FakeAppInstaller();
  final payments = (paymentsApi ?? FakePaymentsApi())..events ??= events;

  final container = ProviderContainer(
    overrides: [
      flavorProvider.overrideWithValue(Flavor.dev),
      sharedPreferencesProvider.overrideWithValue(preferences),
      // phone numbers default to Cameroon, whatever the test machine's region
      deviceRegionProvider.overrideWithValue('CM'),
      tokenStorageProvider.overrideWithValue(storage),
      accountStorageProvider.overrideWithValue(accountStorage),
      authoritiesApiProvider.overrideWithValue(authorities),
      hymnsApiProvider.overrideWithValue(hymns),
      hymnBookStorageProvider.overrideWithValue(storage0),
      screenAwakeProvider.overrideWithValue(awake),
      localNotificationsProvider.overrideWithValue(notifier),
      membersApiProvider.overrideWithValue(members),
      toasterProvider.overrideWithValue(toasts),
      adminApiProvider.overrideWithValue(admin),
      shareServiceProvider.overrideWithValue(share),
      networkStatusProvider.overrideWithValue(network),
      authApiProvider.overrideWithValue(auth),
      profileApiProvider.overrideWithValue(profileApi),
      activitiesApiProvider.overrideWithValue(activitiesApi),
      reportsApiProvider.overrideWithValue(reportsApi),
      eventsApiProvider.overrideWithValue(events),
      mediaImagesProvider.overrideWithValue(mediaImages ?? FakeMediaImages()),
      calendarServiceProvider.overrideWithValue(calendar),
      linkLauncherProvider.overrideWithValue(links),
      imagePickingProvider.overrideWithValue(picker),
      prayerApiProvider.overrideWithValue(prayer),
      chimeProvider.overrideWithValue(chime),
      pushMessagingProvider.overrideWithValue(pushMessaging),
      notificationsApiProvider.overrideWithValue(notificationsApi0),
      premiumStoreProvider.overrideWithValue(premiumStore),
      premiumForEveryoneProvider.overrideWithValue(premiumForEveryone),
      storeReviewProvider.overrideWithValue(review),
      appShortcutsProvider.overrideWithValue(appShortcuts),
      incomingLinksProvider.overrideWithValue(appLinks),
      disciplesApiProvider.overrideWithValue(disciples),
      bibleApiProvider.overrideWithValue(bible),
      bibleStorageProvider.overrideWithValue(bibleStorage),
      if (photoDecoder != null)
        photoDecoderProvider.overrideWithValue(photoDecoder),
      homeWidgetsProvider.overrideWithValue(widgets),
      ministryApiProvider.overrideWithValue(ministry),
      appShieldProvider.overrideWith((ref) async => shield),
      documentsApiProvider.overrideWithValue(library),
      biometricsProvider.overrideWithValue(faceId),
      savedLoginStorageProvider.overrideWithValue(keychain),
      teachingsApiProvider.overrideWithValue(teachings),
      teachingPlayerProvider.overrideWithValue(player),
      teachingFilesProvider.overrideWithValue(files),
      soulsStorageProvider.overrideWithValue(souls),
      voiceReaderProvider.overrideWithValue(voice),
      lockScreenTimerProvider.overrideWithValue(lockScreen),
      reportSendingsApiProvider.overrideWithValue(sendings),
      crashReportingProvider.overrideWithValue(const NoCrashReporting()),
      updateRulesSourceProvider.overrideWithValue(rules),
      appInstallerProvider.overrideWithValue(appInstaller),
      paymentsApiProvider.overrideWithValue(payments),
      phoneVerificationProvider.overrideWithValue(
        phoneVerification ?? FakePhoneVerification(),
      ),
    ],
  );
  addTearDown(container.dispose);

  // a phone-sized screen, like the design
  tester.view.physicalSize = const Size(390 * 3, 844 * 3);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: TranslationProvider(
        child: RepaintBoundary(
          key: screenKey,
          child: const AppUpdateGate(child: App()),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();

  return TestApp(
    container: container,
    preferences: preferences,
    storage: storage,
    accountStorage: accountStorage,
    authApi: auth,
    authoritiesApi: authorities,
    hymnsApi: hymns,
    hymnStorage: storage0,
    screenAwake: awake,
    notifications: notifier,
    membersApi: members,
    toasts: toasts,
    adminApi: admin,
    share: share,
    network: network,
    profileApi: profileApi,
    activitiesApi: activitiesApi,
    reportsApi: reportsApi,
    eventsApi: events,
    calendar: calendar,
    links: links,
    picker: picker,
    prayerApi: prayer,
    chime: chime,
    push: pushMessaging,
    notificationsApi: notificationsApi0,
    premium: premiumStore,
    homeWidgets: widgets,
    ministryApi: ministry,
    storeReview: review,
    shortcuts: appShortcuts,
    incomingLinks: appLinks,
    disciplesApi: disciples,
    bibleApi: bible,
    bibleStorage: bibleStorage,
    appShield: shield,
    documentsApi: library,
    biometrics: faceId,
    savedLogin: keychain,
    teachingsApi: teachings,
    player: player,
    teachingFiles: files,
    soulsStorage: souls,
    voice: voice,
    reportSendingsApi: sendings,
    lockScreen: lockScreen,
    updateRules: rules,
    installer: appInstaller,
    paymentsApi: payments,
  );
}

/// Scrolls the visible list to its end ("Se déconnecter" in Plus): a row only
/// half in view would be tapped through the tab bar.
Future<void> scrollToEnd(WidgetTester tester) async {
  await tester.drag(find.byType(Scrollable).last, const Offset(0, -3000));
  await tester.pumpAndSettle();
}

/// Plus, from the photo at the top of the home screen (back to Accueil
/// first).
Future<void> openMore(WidgetTester tester) async {
  final home = find.descendant(
    of: find.byType(NavigationBar),
    matching: find.text('Accueil'),
  );
  if (home.evaluate().isNotEmpty) {
    await tester.tap(home);
    await tester.pumpAndSettle();
  }
  await tester.tap(find.byTooltip('Mon profil'));
  await tester.pumpAndSettle();
}

/// Drags the first list of the screen until [finder] is laid out and above
/// the tab bar. More robust than `scrollUntilVisible` on the home screen,
/// whose cards move with the length of the verse of the day.
Future<void> scrollTo(WidgetTester tester, Finder finder) async {
  bool inView() {
    final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
    for (final element in finder.evaluate()) {
      final box = element.renderObject;
      if (box is RenderBox && box.hasSize && box.attached) {
        final top = box.localToGlobal(Offset.zero).dy;
        if (top > 0 && top + box.size.height < screen.height - 100) {
          return true;
        }
      }
    }
    return false;
  }

  final list = find.byType(Scrollable).first;
  for (var i = 0; i < 30 && !inView(); i++) {
    await tester.drag(list, const Offset(0, -200));
    await tester.pumpAndSettle();
  }
}
