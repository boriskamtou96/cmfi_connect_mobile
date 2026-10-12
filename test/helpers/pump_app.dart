import 'package:cmfi_connect/app.dart';
import 'package:cmfi_connect/src/core/config/flavor.dart';
import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/calendar_service.dart';
import 'package:cmfi_connect/src/core/services/chime.dart';
import 'package:cmfi_connect/src/core/services/image_picking.dart';
import 'package:cmfi_connect/src/core/services/link_launcher.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/core/services/media_images.dart';
import 'package:cmfi_connect/src/core/services/network_status.dart';
import 'package:cmfi_connect/src/core/services/screen_awake.dart';
import 'package:cmfi_connect/src/core/services/share_service.dart';
import 'package:cmfi_connect/src/core/session/account.dart';
import 'package:cmfi_connect/src/core/storage/account_storage.dart';
import 'package:cmfi_connect/src/core/storage/preferences.dart';
import 'package:cmfi_connect/src/core/storage/token_storage.dart';
import 'package:cmfi_connect/src/core/widgets/app_toast.dart';
import 'package:cmfi_connect/src/features/admin/infrastructure/admin_api.dart';
import 'package:cmfi_connect/src/features/auth/infrastructure/auth_api.dart';
import 'package:cmfi_connect/src/features/authorities/infrastructure/authorities_api.dart';
import 'package:cmfi_connect/src/features/events/infrastructure/events_api.dart';
import 'package:cmfi_connect/src/features/hymns/infrastructure/hymn_book_storage.dart';
import 'package:cmfi_connect/src/features/hymns/infrastructure/hymns_api.dart';
import 'package:cmfi_connect/src/features/members/infrastructure/members_api.dart';
import 'package:cmfi_connect/src/features/prayer/infrastructure/prayer_api.dart';
import 'package:cmfi_connect/src/features/profile/domain/profile.dart';
import 'package:cmfi_connect/src/features/profile/infrastructure/profile_api.dart';
import 'package:cmfi_connect/src/features/reports/infrastructure/activities_api.dart';
import 'package:cmfi_connect/src/features/reports/infrastructure/reports_api.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final FakeChime chime;
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
  Map<String, Object> initialPreferences = const {},
}) async {
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
  final activitiesApi = FakeActivitiesApi();
  // the day form lists the active items, like the API
  final reportsApi = FakeReportsApi(activities: activitiesApi.activities);
  final events = eventsApi ?? FakeEventsApi();
  final calendar = FakeCalendarService();
  final links = FakeLinkLauncher();
  final picker = FakeImagePicking();
  final prayer = prayerApi ?? FakePrayerApi();
  final chime = FakeChime();

  final container = ProviderContainer(
    overrides: [
      flavorProvider.overrideWithValue(Flavor.dev),
      sharedPreferencesProvider.overrideWithValue(preferences),
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
      child: TranslationProvider(child: const App()),
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
  );
}

/// Scrolls the visible list to its end ("Se déconnecter" in Plus): a row only
/// half in view would be tapped through the tab bar.
Future<void> scrollToEnd(WidgetTester tester) async {
  await tester.drag(find.byType(Scrollable).last, const Offset(0, -3000));
  await tester.pumpAndSettle();
}
