import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cmfi_connect/src/core/network/app_exception.dart';
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
import 'package:cmfi_connect/src/core/storage/saved_login.dart';
import 'package:cmfi_connect/src/core/storage/token_storage.dart';
import 'package:cmfi_connect/src/core/widgets/app_toast.dart';
import 'package:cmfi_connect/src/features/admin/infrastructure/admin_api.dart';
import 'package:cmfi_connect/src/features/auth/infrastructure/auth_api.dart';
import 'package:cmfi_connect/src/features/auth/infrastructure/login_response.dart';
import 'package:cmfi_connect/src/features/authorities/domain/authority.dart';
import 'package:cmfi_connect/src/features/authorities/infrastructure/authorities_api.dart';
import 'package:cmfi_connect/src/features/disciples/domain/disciple.dart';
import 'package:cmfi_connect/src/features/disciples/domain/received_report.dart';
import 'package:cmfi_connect/src/features/disciples/infrastructure/disciples_api.dart';
import 'package:cmfi_connect/src/features/documents/domain/library_document.dart';
import 'package:cmfi_connect/src/features/documents/infrastructure/documents_api.dart';
import 'package:cmfi_connect/src/features/events/domain/event.dart';
import 'package:cmfi_connect/src/features/events/domain/event_draft.dart';
import 'package:cmfi_connect/src/features/events/infrastructure/events_api.dart';
import 'package:cmfi_connect/src/features/hymns/domain/hymn.dart';
import 'package:cmfi_connect/src/features/hymns/infrastructure/hymn_book_storage.dart';
import 'package:cmfi_connect/src/features/hymns/infrastructure/hymns_api.dart';
import 'package:cmfi_connect/src/features/members/domain/member.dart';
import 'package:cmfi_connect/src/features/members/infrastructure/members_api.dart';
import 'package:cmfi_connect/src/features/ministry/domain/ministry_person.dart';
import 'package:cmfi_connect/src/features/ministry/domain/nation.dart';
import 'package:cmfi_connect/src/features/ministry/infrastructure/ministry_api.dart';
import 'package:cmfi_connect/src/features/notifications/domain/announcement.dart';
import 'package:cmfi_connect/src/features/notifications/infrastructure/notifications_api.dart';
import 'package:cmfi_connect/src/features/payments/domain/payment.dart';
import 'package:cmfi_connect/src/features/payments/infrastructure/payments_api.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/prayer/infrastructure/prayer_api.dart';
import 'package:cmfi_connect/src/features/profile/domain/profile.dart';
import 'package:cmfi_connect/src/features/profile/infrastructure/profile_api.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/features/reports/domain/in_app_sending.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_goal.dart';
import 'package:cmfi_connect/src/features/reports/domain/report_summary.dart';
import 'package:cmfi_connect/src/features/reports/infrastructure/activities_api.dart';
import 'package:cmfi_connect/src/features/reports/infrastructure/report_sendings_api.dart';
import 'package:cmfi_connect/src/features/reports/infrastructure/reports_api.dart';
import 'package:cmfi_connect/src/features/souls/infrastructure/souls_storage.dart';
import 'package:cmfi_connect/src/features/teachings/application/teaching_player.dart';
import 'package:cmfi_connect/src/features/teachings/domain/teaching.dart';
import 'package:cmfi_connect/src/features/teachings/infrastructure/teaching_files.dart';
import 'package:cmfi_connect/src/features/teachings/infrastructure/teachings_api.dart';
import 'package:dio/dio.dart' show CancelToken;
import 'package:flutter/widgets.dart';

/// In-memory token storage: the real one needs the Keychain / Keystore.
class FakeTokenStorage implements TokenStorage {
  FakeTokenStorage([this.token]);

  String? token;

  @override
  Future<String?> read() async => token;

  @override
  Future<void> write(String value) async => token = value;

  @override
  Future<void> delete() async => token = null;
}

/// In-memory account storage.
class FakeAccountStorage implements AccountStorage {
  FakeAccountStorage([this.account]);

  Account? account;

  @override
  Future<Account?> read() async => account;

  @override
  Future<void> write(Account value) async => account = value;

  @override
  Future<void> delete() async => account = null;
}

/// Answers login with a token, or throws [error] when given.
class FakeAuthApi implements AuthApi {
  FakeAuthApi({this.error, this.registerError});

  final AppException? error;
  final AppException? registerError;

  /// Phone numbers registered through [register].
  final registered = <String>[];

  /// Pseudo of the last [register].
  String? registeredUsername;

  /// Phone number of the last [login].
  String? loggedInWith;

  /// The (token, password) of each [resetPassword].
  final resets = <(String, String)>[];
  AppException? resetError;

  @override
  Future<void> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String username,
    String? email,
  }) async {
    if (registerError case final error?) {
      throw error;
    }
    registered.add(phoneNumber);
    registeredUsername = username;
  }

  @override
  Future<LoginResponse> login({
    required String phoneNumber,
    required String password,
  }) async {
    if (error case final error?) {
      throw error;
    }
    loggedInWith = phoneNumber;
    return LoginResponse(
      account: Account(
        firstName: 'Boris',
        lastName: 'Kamtou',
        phoneNumber: phoneNumber,
      ),
      accessToken: 'test-token',
    );
  }

  @override
  Future<void> resetPassword({
    required String firebaseToken,
    required String password,
  }) async {
    if (resetError case final error?) {
      throw error;
    }
    resets.add((firebaseToken, password));
  }
}

/// Keeps the profile in memory; [updates] and [creates] record what was sent.
/// A null [profile] answers 404, like a user without profile on the server.
class FakeProfileApi implements ProfileApi {
  FakeProfileApi([this.profile = defaultProfile]);

  static const defaultProfile = Profile(
    firstName: 'Boris',
    lastName: 'Kamtou',
    phoneNumber: '+237690000001',
  );

  Profile? profile;
  final updates = <Profile>[];
  final creates = <Profile>[];

  /// A network that never answers (a retreat must not wait for it).
  bool slow = false;

  @override
  Future<Profile> get() async => slow
      ? await Completer<Profile>().future
      : profile ??
            (throw const ApiException(
              status: 404,
              code: 'NOT_FOUND',
              message: 'Profile not found',
            ));

  @override
  Future<Profile> update(Profile profile) async {
    updates.add(profile);
    return this.profile = profile;
  }

  @override
  Future<Profile> create(Profile profile) async {
    creates.add(profile);
    return this.profile = profile;
  }

  /// The photos sent, and an error to answer instead.
  final avatars = <Uint8List>[];
  AppException? avatarError;
  var removedAvatars = 0;
  var _nextAvatar = 500;

  @override
  Future<EventImage> setAvatar(Uint8List bytes) async {
    if (avatarError case final error?) {
      throw error;
    }
    avatars.add(bytes);
    final id = _nextAvatar++;
    final avatar = EventImage(
      id: id,
      url: '/v1/media/avatar-$id.jpg',
      width: 512,
      height: 512,
      color: '#7A5A3C',
    );
    profile = profile?.copyWith(avatar: avatar);
    return avatar;
  }

  @override
  Future<void> removeAvatar() async {
    removedAvatars++;
    profile = profile?.copyWith(avatar: null);
  }
}

/// Keeps the authorities in memory and refuses a second disciple maker, like the database.
class FakeAuthoritiesApi implements AuthoritiesApi {
  FakeAuthoritiesApi([
    List<Authority> authorities = const [],
    List<AuthorityRequest> requests = const [],
  ]) : authorities = [...authorities],
       pendingRequests = [...requests];

  final List<Authority> authorities;

  /// Members asking the user to accompany them.
  final List<AuthorityRequest> pendingRequests;

  /// Requests answered: id -> accepted.
  final answers = <int, bool>{};

  @override
  Future<Authority> createForMember({
    required String username,
    required bool isDiscipleMaker,
  }) async {
    final member = sampleMembers[username];
    if (member == null) {
      throw const ApiException(status: 404, code: 'NOT_FOUND', message: '');
    }
    if (authorities.any((a) => a.username == username)) {
      throw const ApiException(
        status: 409,
        code: 'AUTHORITY_EXISTS',
        message: '',
      );
    }
    final created = Authority(
      id: 100 + authorities.length,
      firstName: member.firstName,
      lastName: member.lastName,
      isDiscipleMaker: isDiscipleMaker,
      username: username,
      church: member.church,
      status: AuthorityStatus.pending,
    );
    authorities.add(created);
    return created;
  }

  @override
  Future<List<AuthorityRequest>> requests() async => [...pendingRequests];

  @override
  Future<void> answer(int requestId, {required bool accept}) async {
    answers[requestId] = accept;
    pendingRequests.removeWhere((request) => request.id == requestId);
  }

  @override
  Future<List<Authority>> list() async => [...authorities];

  /// The sharing turned on or off, by authority.
  final sharing = <int, bool>{};

  @override
  Future<Authority> setSharing(int id, {required bool shares}) async {
    sharing[id] = shares;
    final at = authorities.indexWhere((authority) => authority.id == id);
    return authorities[at] = authorities[at].copyWith(sharesRegularity: shares);
  }

  @override
  Future<Authority> create({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required bool isDiscipleMaker,
  }) async {
    if (isDiscipleMaker && authorities.any((a) => a.isDiscipleMaker)) {
      throw const ApiException(
        status: 500,
        code: 'INTERNAL_SERVER_ERROR',
        message: 'unique violation',
      );
    }
    final created = Authority(
      id: 100 + authorities.length,
      firstName: firstName,
      lastName: lastName.isEmpty ? null : lastName,
      phoneNumber: phoneNumber,
      email: email.isEmpty ? null : email,
      isDiscipleMaker: isDiscipleMaker,
    );
    authorities.add(created);
    return created;
  }

  @override
  Future<void> remove(int id) async =>
      authorities.removeWhere((authority) => authority.id == id);
}

/// Two standard items and a personal one, like the dev database.
const sampleActivities = [
  ActivityType(
    id: 1,
    code: 'LB',
    label: 'Lecture biblique',
    tracksQuantity: true,
    quantityUnit: 'chapitres',
    isStandard: true,
  ),
  ActivityType(
    id: 2,
    code: 'PS',
    label: 'Prière seule',
    tracksDuration: true,
    isStandard: true,
  ),
  ActivityType(
    id: 30,
    code: 'RQDQA',
    label: 'RQDQA',
    tracksQuantity: true,
    quantityUnit: 'Nombre de fois',
    tracksDuration: true,
  ),
];

class FakeActivitiesApi implements ActivitiesApi {
  FakeActivitiesApi([List<ActivityType> activities = sampleActivities])
    : activities = [...activities];

  final List<ActivityType> activities;

  /// No network: every call fails like a lost connection.
  bool offline = false;

  @override
  Future<List<ActivityType>> list() async {
    if (offline) {
      throw const NetworkException();
    }
    return activities;
  }

  @override
  Future<ActivityType> create({
    required String code,
    required String label,
    required bool tracksQuantity,
    String? quantityUnit,
    required bool tracksDuration,
  }) async {
    if (activities.any((activity) => activity.code == code)) {
      throw const ApiException(
        status: 409,
        code: 'CONFLICT',
        message: 'conflict',
      );
    }
    final created = ActivityType(
      id: 100 + activities.length,
      code: code,
      label: label,
      tracksQuantity: tracksQuantity,
      quantityUnit: quantityUnit,
      tracksDuration: tracksDuration,
    );
    activities.add(created);
    return created;
  }

  @override
  Future<void> archive(int id) async =>
      activities.removeWhere((activity) => activity.id == id);

  /// The goals sent, in order.
  final goalsSent = <(int, ReportGoal?)>[];

  @override
  Future<void> setGoal(int id, ReportGoal? goal) async {
    if (offline) {
      throw const NetworkException();
    }
    final index = activities.indexWhere((activity) => activity.id == id);
    if (index < 0) {
      throw const ApiException(
        status: 404,
        code: 'NOT_FOUND',
        message: 'not found',
      );
    }
    goalsSent.add((id, goal));
    activities[index] = activities[index].copyWith(
      goal: goal == null || goal.isEmpty ? null : goal,
    );
  }
}

/// Stores the saved days in memory, like the API would.
class FakeReportsApi implements ReportsApi {
  FakeReportsApi({this.activities = sampleActivities});

  final List<ActivityType> activities;

  /// No network: every call fails like a lost connection.
  bool offline = false;

  void _online() {
    if (offline) {
      throw const NetworkException();
    }
  }

  /// Saved days, by date.
  final days = <DateTime, DailyReport>{};

  /// Every PUT, in order.
  final saves = <DailyReport>[];

  ReportEntry _empty(ActivityType activity) => ReportEntry(
    activityTypeId: activity.id,
    code: activity.code,
    label: activity.label,
    tracksQuantity: activity.tracksQuantity,
    quantityUnit: activity.quantityUnit,
    tracksDuration: activity.tracksDuration,
  );

  /// A slow network: each day arrives after it.
  Duration dayDelay = Duration.zero;

  @override
  Future<DailyReport> getDay(DateTime date) async {
    if (dayDelay > Duration.zero) {
      await Future<void>.delayed(dayDelay);
    }
    _online();
    final saved = days[date];
    final values = {
      for (final entry in saved?.entries ?? const <ReportEntry>[])
        entry.activityTypeId: entry,
    };
    return DailyReport(
      date: date,
      note: saved?.note,
      submitted: saved != null,
      entries: [
        for (final activity in activities)
          _empty(activity).copyWith(
            quantity: values[activity.id]?.quantity,
            durationMinutes: values[activity.id]?.durationMinutes,
          ),
      ],
    );
  }

  /// The share of the goals sent with each saved day (null: no goals).
  final goalPercents = <DateTime, int?>{};

  @override
  Future<DailyReport> saveDay(
    DateTime date, {
    required String note,
    required List<ReportEntry> entries,
    int? goalPercent,
  }) async {
    _online();
    goalPercents[date] = goalPercent;
    final report = DailyReport(
      date: date,
      note: note.trim().isEmpty ? null : note.trim(),
      submitted: true,
      entries: entries.where((entry) => entry.isFilled).toList(),
    );
    saves.add(report);
    days[date] = report;
    return getDay(date);
  }

  @override
  Future<List<DailyReport>> history({
    required DateTime from,
    required DateTime to,
  }) async {
    _online();
    return days.values
        .where((day) => !day.date.isBefore(from) && !day.date.isAfter(to))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  @override
  Future<ReportSummary> summary({
    required DateTime from,
    required DateTime to,
  }) async {
    _online();
    final inRange = await history(from: from, to: to);
    return ReportSummary(
      from: from,
      to: to,
      daysInRange: to.difference(from).inDays + 1,
      daysReported: inRange.length,
      items: [
        for (final activity in activities)
          SummaryItem(
            activityTypeId: activity.id,
            code: activity.code,
            label: activity.label,
            quantityUnit: activity.quantityUnit,
            tracksQuantity: activity.tracksQuantity,
            tracksDuration: activity.tracksDuration,
            daysCount: inRange
                .where(
                  (day) => day.entries.any(
                    (entry) => entry.activityTypeId == activity.id,
                  ),
                )
                .length,
          ),
      ],
    );
  }
}

// --- hymns ---------------------------------------------------------------------------

/// A small French book: a chorus printed once, and a second hymn with accents.
const sampleHymnBook = HymnBook(
  code: 'rendons-ministere-1',
  title: 'Rendons ministère au Seigneur, volume 1',
  version: '20261008T224132.000000Z',
  hymnCount: 3,
  hymns: [
    Hymn(
      number: 1,
      title: 'A Toi la gloire',
      firstLine: 'À toi la gloire',
      parts: [
        HymnPart(
          kind: HymnPartKind.verse,
          label: '1',
          lines: ['À toi la gloire', 'Ô Ressuscité'],
        ),
        HymnPart(
          kind: HymnPartKind.chorus,
          repeat: 2,
          lines: ['À toi la victoire', "Pour l'éternité"],
        ),
        HymnPart(
          kind: HymnPartKind.verse,
          label: '2',
          lines: ['Vois-le paraître', "C'est lui, c'est Jésus"],
        ),
      ],
    ),
    Hymn(
      number: 2,
      title: 'Saint, Saint, Saint',
      author: 'EMPEYTAZ.',
      firstLine: "Saint ! Saint ! Saint ! est l'Eternel",
      parts: [
        HymnPart(
          kind: HymnPartKind.verse,
          label: '1',
          lines: [
            "Saint ! Saint ! Saint ! est l'Eternel",
            'Dieu le Tout-Puissant',
          ],
        ),
      ],
    ),
    Hymn(
      number: 3,
      title: 'Ils ont mis le maître sur la croix',
      firstLine: 'Ils ont mis le Maître sur la Croix',
      parts: [
        HymnPart(
          kind: HymnPartKind.verse,
          label: '1',
          lines: [
            'Ils ont mis le Maître sur la Croix',
            'Oh je tremble, tremble encore',
          ],
        ),
      ],
    ),
  ],
);

const sampleEnglishBook = HymnBook(
  code: 'christ-the-victor',
  title: 'Christ the Victor',
  language: 'en',
  version: '20261008T224132.000000Z',
  hymnCount: 1,
  hymns: [
    Hymn(
      number: 1,
      title: "There's a Man on the Throne of God",
      firstLine: "There's a Man on the Throne of God",
      parts: [
        HymnPart(
          kind: HymnPartKind.verse,
          label: '1',
          lines: ["There's a Man on the Throne of God", 'Glory to the Lord'],
        ),
      ],
    ),
  ],
);

/// The books shipped with the app and those downloaded, in memory.
class FakeHymnBookStorage implements HymnBookStorage {
  FakeHymnBookStorage({
    List<HymnBook> bundled = const [sampleHymnBook, sampleEnglishBook],
  }) : bundled = {for (final book in bundled) book.code: book};

  final Map<String, HymnBook> bundled;
  final saved = <String, HymnBook>{};
  List<String>? order;

  @override
  Future<List<String>> bundledCodes() async => bundled.keys.toList();

  @override
  Future<HymnBook?> readBundled(String code) async => bundled[code];

  @override
  Future<HymnBook?> readSaved(String code) async => saved[code];

  @override
  Future<void> save(HymnBook book) async => saved[book.code] = book;

  @override
  Future<List<String>?> readOrder() async => order;

  @override
  Future<void> saveOrder(List<String> codes) async => order = codes;
}

/// The server's books; answers "not modified" (null) when the phone has the current version.
class FakeHymnsApi implements HymnsApi {
  FakeHymnsApi({
    List<HymnBook> books = const [sampleHymnBook, sampleEnglishBook],
    this.error,
  }) : books = [...books];

  final List<HymnBook> books;
  final AppException? error;
  final downloads = <String>[];

  @override
  Future<List<HymnBookSummary>> listBooks() async {
    if (error case final error?) {
      throw error;
    }
    return [
      for (final book in books)
        HymnBookSummary(
          code: book.code,
          title: book.title,
          language: book.language,
          hymnCount: book.hymns.length,
          version: book.version,
        ),
    ];
  }

  @override
  Future<HymnBook?> getBook(String code, {String? version}) async {
    final book = books.firstWhere((book) => book.code == code);
    if (book.version == version) {
      return null;
    }
    downloads.add(code);
    return book;
  }
}

/// Records whether the screen is kept on.
class FakeScreenAwake implements ScreenAwake {
  bool on = false;

  @override
  Future<void> keepOn({required bool on}) async => this.on = on;
}

/// Records the planned reminders instead of asking the system.
class FakeLocalNotifications implements LocalNotifications {
  FakeLocalNotifications({this.granted = true, this.launchedWith});

  /// What the user answers to the permission prompt.
  bool granted;

  /// Payload of the notification that "opened" the app.
  String? launchedWith;

  var permissionAsked = false;
  final groups = <NotificationGroup, List<PlannedNotification>>{};
  final tapsController = StreamController<String?>.broadcast();

  @override
  Stream<String?> get taps => tapsController.stream;

  @override
  Future<bool> requestPermission() async {
    permissionAsked = true;
    return granted;
  }

  @override
  Future<String?> takeLaunchPayload() async {
    final payload = launchedWith;
    launchedWith = null;
    return payload;
  }

  /// The evening reminders planned.
  List<PlannedNotification> get planned =>
      groups[NotificationGroup.reportReminder] ?? const [];

  /// The reminders of the events the user registered for.
  List<PlannedNotification> get plannedEvents =>
      groups[NotificationGroup.events] ?? const [];

  @override
  Future<void> replace(
    NotificationGroup group,
    List<PlannedNotification> notifications, {
    required String channelName,
  }) async => groups[group] = [...notifications];

  @override
  Future<void> cancel(NotificationGroup group) async => groups.remove(group);

  @override
  Future<void> cancelAll() async => groups.clear();

  @override
  Future<void> showStopwatch({
    required String title,
    required String body,
    required DateTime since,
    required bool running,
    required String channelName,
  }) async {}

  @override
  Future<void> hideStopwatch() async {}

  /// The pushes shown while the app was open (Android).
  final pushes = <({String title, String body, Map<String, String> data})>[];

  @override
  Future<void> showPush({
    required String title,
    required String body,
    required Map<String, String> data,
    required String channelId,
    required String channelName,
  }) async => pushes.add((title: title, body: body, data: data));

  /// The Android channels made for the pushes of the server.
  final pushChannels = <String>[];

  @override
  Future<void> createPushChannel(String channelId, String name) async =>
      pushChannels.add(channelId);
}

/// Records what would have been shared.
class FakeShareService implements ShareService {
  final texts = <String>[];
  final files = <({String name, String mimeType, Uint8List bytes})>[];

  @override
  Future<void> shareText(String text, {String? subject, Rect? origin}) async =>
      texts.add(text);

  @override
  Future<void> shareFile(
    Uint8List bytes, {
    required String name,
    required String mimeType,
    String? subject,
    Rect? origin,
  }) async => files.add((name: name, mimeType: mimeType, bytes: bytes));
}

/// The network comes and goes when the test says so.
class FakeNetworkStatus implements NetworkStatus {
  final controller = StreamController<bool>.broadcast();

  @override
  Stream<bool> get changes => controller.stream;
}

/// Members of the app, by pseudo.
const sampleMembers = {
  'marc.tientcheu': MemberCard(
    username: 'marc.tientcheu',
    firstName: 'Marc',
    lastName: 'Tientcheu',
    church: 'PSU-Yaoundé',
  ),
  'clarisse.nguele': MemberCard(
    username: 'clarisse.nguele',
    firstName: 'Clarisse',
    lastName: 'Nguele',
  ),
};

/// The account of the tests, as GET /v1/users/me gives it.
const sampleAccount = Account(
  id: 1,
  firstName: 'Boris',
  lastName: 'Kamtou',
  phoneNumber: '+237690000001',
  username: 'boris.kamtou',
);

/// Pseudos and members in memory. [sampleMembers] are taken.
class FakeMembersApi implements MembersApi {
  FakeMembersApi({this.account = sampleAccount});

  Account account;

  /// Pseudos asked to [availability], in order.
  final checked = <String>[];

  bool _taken(String username) =>
      sampleMembers.containsKey(username) || username == account.username;

  @override
  Future<UsernameCheck> availability({
    String username = '',
    String firstName = '',
    String lastName = '',
  }) async {
    checked.add(username);
    String slug(String name) =>
        name.toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '');
    final first = slug(firstName);
    final last = slug(lastName);
    final suggestions = [
      if (first.isNotEmpty && last.isNotEmpty) ...[
        '$first.$last',
        '$first$last',
        '${first}_$last',
        '$first.$last${2}',
      ],
    ].where((candidate) => !_taken(candidate)).take(3).toList();
    final problem = username.isEmpty
        ? null
        : UsernameRules.check(username) ??
              (username == 'admin'
                  ? UsernameProblem.reserved
                  : _taken(username)
                  ? UsernameProblem.taken
                  : null);
    return UsernameCheck(
      username: username,
      available: username.isNotEmpty && problem == null,
      problem: problem,
      suggestions: suggestions,
    );
  }

  @override
  Future<MemberCard> byUsername(String username) async {
    if (sampleMembers[username] case final member?) {
      return member;
    }
    throw const ApiException(status: 404, code: 'NOT_FOUND', message: '');
  }

  @override
  Future<Account> me() async => account;

  /// The password [deleteAccount] accepts; the passwords it was given.
  String password = 'Secret123';
  final deletions = <String>[];

  /// The server refuses: the account is the last superadmin's.
  bool lastSuperadmin = false;

  @override
  Future<void> deleteAccount({required String password}) async {
    deletions.add(password);
    if (password != this.password) {
      throw const ApiException(
        status: 401,
        code: 'INVALID_CREDENTIALS',
        message: '',
      );
    }
    if (lastSuperadmin) {
      throw const ApiException(
        status: 409,
        code: 'LAST_SUPERADMIN',
        message: '',
      );
    }
  }

  @override
  Future<Account> updateUsername(String username) async {
    if (_taken(username)) {
      throw const ApiException(
        status: 409,
        code: 'USERNAME_TAKEN',
        message: '',
      );
    }
    return account = account.copyWith(username: username);
  }
}

/// The team in memory; [roles] records what a superadmin gave.
class FakeAdminApi implements AdminApi {
  FakeAdminApi([List<StaffMember> staff = const []]) : members = [...staff];

  final List<StaffMember> members;
  final roles = <String, MemberRole>{};

  @override
  Future<List<StaffMember>> staff() async => [...members];

  @override
  Future<StaffMember> setRole(String username, MemberRole role) async {
    final member = sampleMembers[username];
    if (member == null) {
      throw const ApiException(status: 404, code: 'NOT_FOUND', message: '');
    }
    roles[username] = role;
    final updated = StaffMember(
      username: username,
      firstName: member.firstName,
      lastName: member.lastName,
      role: role,
    );
    members
      ..removeWhere((other) => other.username == username)
      ..add(updated);
    return updated;
  }
}

/// Records the popups instead of showing them.
class FakeToaster implements Toaster {
  final shown = <(ToastKind, String)>[];

  List<String> get messages => [for (final (_, message) in shown) message];

  List<String> get errors => [
    for (final (kind, message) in shown)
      if (kind == ToastKind.error) message,
  ];

  @override
  ToastMessenger of(BuildContext context) =>
      ToastMessenger((kind, message) => shown.add((kind, message)));
}

// ----- events -----

/// A poster of the server (portrait, green).
const samplePoster = EventImage(
  id: 1,
  url: '/v1/media/poster.jpg',
  width: 1080,
  height: 1350,
  color: '#1F4D3A',
);

/// The yearly conference [daysAhead] days from now (3 days, program and news),
/// and last year's edition.
({CommunityEvent next, CommunityEvent past}) sampleEvents({
  int daysAhead = 42,
  DateTime? now,
}) {
  final today = now ?? DateTime.now();
  final start = DateTime(today.year, today.month, today.day + daysAhead, 8);
  DateTime at(int day, int hour) =>
      DateTime(start.year, start.month, start.day + day, hour);
  final past = CommunityEvent(
    id: 1,
    seriesId: 1,
    title: 'Conférence annuelle 2025',
    theme: 'La prière qui change tout',
    startsAt: DateTime(today.year - 1, today.month, today.day, 8),
    endsAt: DateTime(today.year - 1, today.month, today.day + 2, 13),
    timeZone: '',
    venue: 'Centre de conférences de Mvolyé',
    city: 'Yaoundé',
    country: 'Cameroun',
    poster: samplePoster.copyWith(id: 2, url: '/v1/media/past.jpg'),
    registration: const RegistrationSummary(
      state: RegistrationState.ended,
      registrations: 812,
      people: 1290,
    ),
  );
  final next = CommunityEvent(
    id: 2,
    seriesId: 1,
    title: 'Conférence annuelle 2026',
    theme: "Marcher dans l'Esprit",
    themeVerse:
        "« Si nous vivons par l'Esprit, marchons aussi par l'Esprit. » Galates 5.25",
    description: 'Trois jours pour apprendre à marcher par l\'Esprit.',
    startsAt: start,
    endsAt: at(2, 13),
    // the phone's own clock: the tests read the times as they are written
    timeZone: '',
    venue: 'Centre de conférences de Mvolyé',
    address: 'Mvolyé',
    city: 'Yaoundé',
    country: 'Cameroun',
    mapsUrl: 'https://maps.example/mvolye',
    contactName: 'Secrétariat',
    contactPhone: '+237690000000',
    poster: samplePoster,
    registration: const RegistrationSummary(
      state: RegistrationState.open,
      registrations: 128,
      people: 340,
    ),
    capacity: 1500,
    asksLodging: true,
    asksDepartureCity: true,
    feeNote: 'Participation libre. Repas : 2 000 FCFA par jour.',
    sessions: [
      EventSession(
        id: 1,
        startsAt: at(0, 8),
        endsAt: at(0, 10),
        title: 'Accueil et inscriptions',
        place: 'Hall principal',
      ),
      EventSession(
        id: 2,
        startsAt: at(0, 10),
        endsAt: at(0, 12),
        title: "Culte d'ouverture",
        speaker: 'Pasteur principal',
        place: 'Grande salle',
        hymns: const [SessionHymn(book: 'rendons-ministere-1', number: 1)],
      ),
      EventSession(
        id: 3,
        startsAt: at(1, 9),
        endsAt: at(1, 12),
        title: 'Enseignement : « Conduits par l\'Esprit »',
        speaker: 'Pasteur invité',
      ),
      EventSession(
        id: 4,
        startsAt: at(2, 9),
        endsAt: at(2, 12),
        title: 'Culte de clôture',
      ),
    ],
    posts: [
      EventPost(
        id: 1,
        body: 'Les inscriptions sont ouvertes !',
        pinned: true,
        createdAt: today.subtract(const Duration(days: 2)),
      ),
    ],
    editions: [
      EventEdition(
        id: past.id,
        title: past.title,
        startsAt: past.startsAt,
        endsAt: past.endsAt,
        timeZone: '',
        poster: past.poster,
      ),
    ],
  );
  return (next: next, past: past);
}

/// The events of the server, in memory. [offline]: every call fails as
/// without network. [registerError]: what registering answers.
class FakeEventsApi implements EventsApi {
  FakeEventsApi({List<CommunityEvent>? upcoming, List<CommunityEvent>? past}) {
    final sample = sampleEvents();
    for (final event in [
      ...(upcoming ?? [sample.next]),
      ...(past ?? [sample.past]),
    ]) {
      events[event.id] = event;
    }
    upcomingIds = [
      for (final event in upcoming ?? [sample.next]) event.id,
    ];
    pastIds = [
      for (final event in past ?? [sample.past]) event.id,
    ];
  }

  final events = <int, CommunityEvent>{};
  late List<int> upcomingIds;
  late List<int> pastIds;
  var offline = false;
  AppException? registerError;
  final drafts = <EventDraft>[];
  final programs = <List<SessionDraft>>[];
  final uploads = <String>[];

  Future<void> _call() async {
    if (offline) {
      throw const NetworkException();
    }
  }

  CommunityEvent _event(int id) =>
      events[id] ??
      (throw const ApiException(status: 404, code: 'NOT_FOUND', message: ''));

  @override
  Future<List<CommunityEvent>> list({
    EventPeriod period = EventPeriod.upcoming,
    int page = 1,
    int size = 20,
  }) async {
    await _call();
    return [
      for (final id in period == EventPeriod.upcoming ? upcomingIds : pastIds)
        events[id]!,
    ];
  }

  @override
  Future<CommunityEvent> get(int id) async {
    await _call();
    return _event(id);
  }

  @override
  Future<CommunityEvent> register(
    int id, {
    required int people,
    bool needsLodging = false,
    String departureCity = '',
  }) async {
    await _call();
    if (registerError != null) {
      throw registerError!;
    }
    final event = _event(id);
    final before = event.myRegistration?.people ?? 0;
    return events[id] = event.copyWith(
      myRegistration: MyRegistration(
        people: people,
        needsLodging: needsLodging,
        departureCity: departureCity,
      ),
      registration: event.registration.copyWith(
        registered: true,
        registrations: event.registration.registrations + (before == 0 ? 1 : 0),
        people: event.registration.people - before + people,
      ),
    );
  }

  @override
  Future<CommunityEvent> unregister(int id) async {
    await _call();
    final event = _event(id);
    return events[id] = event.copyWith(
      myRegistration: null,
      registration: event.registration.copyWith(
        registered: false,
        registrations: event.registration.registrations - 1,
        people: event.registration.people - (event.myRegistration?.people ?? 0),
      ),
    );
  }

  @override
  Future<List<CommunityEvent>> adminList({int page = 1, int size = 50}) async {
    await _call();
    return events.values.toList().reversed.toList();
  }

  @override
  Future<EventImage> upload(Uint8List bytes, {required String filename}) async {
    await _call();
    uploads.add(filename);
    return samplePoster.copyWith(id: 100 + uploads.length);
  }

  @override
  Future<CommunityEvent> create(EventDraft draft) async {
    await _call();
    drafts.add(draft);
    final id = events.keys.fold(0, (a, b) => a > b ? a : b) + 1;
    return events[id] = CommunityEvent(
      id: id,
      title: draft.title,
      theme: draft.theme,
      startsAt: draft.startsAt,
      endsAt: draft.endsAt,
      timeZone: draft.timeZone,
      venue: draft.venue,
      city: draft.city,
      country: draft.country,
      status: draft.status,
      poster: draft.posterId == null
          ? null
          : samplePoster.copyWith(id: draft.posterId!),
    );
  }

  @override
  Future<CommunityEvent> update(int id, EventDraft draft) async {
    await _call();
    drafts.add(draft);
    return events[id] = _event(id).copyWith(
      title: draft.title,
      theme: draft.theme,
      startsAt: draft.startsAt,
      endsAt: draft.endsAt,
      status: draft.status,
    );
  }

  @override
  Future<void> delete(int id) async {
    await _call();
    events.remove(id);
    upcomingIds.remove(id);
    pastIds.remove(id);
  }

  @override
  Future<CommunityEvent> saveProgram(
    int id,
    List<SessionDraft> sessions,
  ) async {
    await _call();
    programs.add(sessions);
    return events[id] = _event(id).copyWith(
      sessions: [
        for (final (i, session) in sessions.indexed)
          EventSession(
            id: i + 1,
            startsAt: session.startsAt,
            endsAt: session.endsAt,
            title: session.title,
            speaker: session.speaker,
            place: session.place,
            hymns: session.hymns,
          ),
      ],
    );
  }

  @override
  Future<CommunityEvent> prepareNextEdition(int id) async {
    await _call();
    final event = _event(id);
    final next = events.keys.fold(0, (a, b) => a > b ? a : b) + 1;
    return events[next] = event.copyWith(
      id: next,
      status: EventStatus.draft,
      startsAt: event.startsAt.add(const Duration(days: 365)),
      endsAt: event.endsAt.add(const Duration(days: 365)),
    );
  }

  @override
  Future<EventRegistrations> registrations(int id) async {
    await _call();
    return EventRegistrations(
      registrations: 2,
      people: 5,
      lodging: 3,
      cities: const [CityCount(city: 'Douala', people: 3)],
      registrants: [
        Registrant(
          username: 'marie.ngo',
          firstName: 'Marie',
          lastName: 'Ngo',
          church: 'PSU-Yaoundé',
          phoneNumber: '+237690000002',
          people: 3,
          needsLodging: true,
          departureCity: 'Douala',
          createdAt: DateTime(2026, 10, 1),
        ),
        Registrant(
          username: 'paul.mbarga',
          firstName: 'Paul',
          lastName: 'Mbarga',
          people: 2,
          createdAt: DateTime(2026, 10, 2),
        ),
      ],
    );
  }

  @override
  Future<CommunityEvent> addPost(
    int id, {
    required String body,
    int? imageId,
    bool pinned = false,
  }) async {
    await _call();
    final event = _event(id);
    return events[id] = event.copyWith(
      posts: [
        EventPost(
          id: event.posts.length + 10,
          body: body,
          pinned: pinned,
          createdAt: DateTime.now(),
        ),
        ...event.posts,
      ],
    );
  }

  @override
  Future<void> deletePost(int id, int postId) async => _call();

  @override
  Future<CommunityEvent> addPhotos(int id, List<int> imageIds) async {
    await _call();
    final event = _event(id);
    return events[id] = event.copyWith(
      photos: [
        ...event.photos,
        for (final imageId in imageIds)
          EventPhoto(
            id: imageId,
            image: samplePoster.copyWith(id: imageId),
          ),
      ],
    );
  }

  @override
  Future<void> deletePhoto(int id, int photoId) async => _call();
}

/// The server's images, without network: [images] by URL (screenshots), a
/// transparent pixel otherwise.
class FakeMediaImages implements MediaImages {
  FakeMediaImages([this.images = const {}]);

  final Map<String, Uint8List> images;

  static final _pixel = Uint8List.fromList(const [
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
    0x42,
    0x60,
    0x82,
  ]);

  @override
  String resolve(String url) => 'http://localhost:8080$url';

  @override
  ImageProvider of(String url) => MemoryImage(images[url] ?? _pixel);
}

/// Records the entries added to the calendar.
class FakeCalendarService implements CalendarService {
  final added = <String>[];
  var opens = true;

  @override
  Future<bool> add({
    required String title,
    required DateTime start,
    required DateTime end,
    String description = '',
    String location = '',
  }) async {
    added.add(title);
    return opens;
  }
}

/// Records the links opened (maps, phone).
class FakeLinkLauncher implements LinkLauncher {
  final opened = <Uri>[];

  @override
  Future<bool> open(Uri uri) async {
    opened.add(uri);
    return true;
  }

  @override
  Future<bool> openInApp(Uri uri) => open(uri);

  @override
  Future<bool> call(String number) => open(Uri(scheme: 'tel', path: number));

  @override
  Future<bool> directions({String mapsUrl = '', String place = ''}) =>
      open(Uri.parse(mapsUrl.isNotEmpty ? mapsUrl : 'maps:$place'));
}

/// Gives the pictures the test puts in [next].
class FakeImagePicking implements ImagePicking {
  final next = <PickedImage>[];

  /// Whether each pickOne was a photo taken with the camera.
  final cameraCalls = <bool>[];

  @override
  Future<PickedImage?> pickOne({bool camera = false}) async {
    cameraCalls.add(camera);
    return next.isEmpty ? null : next.removeAt(0);
  }

  @override
  Future<List<PickedImage>> pickMany({int limit = 20}) async {
    final picked = [...next];
    next.clear();
    return picked;
  }
}

// ----- prayer -----

/// A topic of the community: the conference, 3 points, 12 people praying.
PrayerTopic sampleTopic({int id = 1, DateTime? startsOn, DateTime? endsOn}) =>
    PrayerTopic(
      id: id,
      title: 'Conférence annuelle 2026 : prions ensemble',
      category: PrayerTopicCategory.event,
      verse: "« Si nous vivons par l'Esprit, marchons aussi par l'Esprit. »",
      startsOn: startsOn ?? DateTime(2026, 11, 3),
      endsOn: endsOn ?? DateTime(2099, 11, 22),
      document: const PrayerDocument(
        url: '/v1/media/sujets.pdf',
        name: 'sujets.pdf',
        sizeBytes: 184000,
      ),
      points: const [
        'Pour les orateurs.',
        'Pour les participants.',
        'Pour les voyages.',
      ],
      people: 12,
    );

/// The prayer module in memory: topics, lists, retreats, importunities.
class FakePrayerApi implements PrayerApi {
  FakePrayerApi({
    List<PrayerTopic>? topics,
    List<PrayerPerson>? people,
    List<Importunity>? importunities,
    this.spiritualFamily = const PrayerFamily(),
  }) : topicList = [...?topics],
       peopleList = [...?people],
       importunityList = [...?importunities];

  final List<PrayerTopic> topicList;
  final List<PrayerPerson> peopleList;
  final List<Importunity> importunityList;
  PrayerFamily spiritualFamily;

  /// No network: every call fails like a lost connection.
  bool offline = false;

  final retreatList = <RetreatRecord>[];
  final deletedRetreats = <(DateTime, RetreatMoment)>[];
  final markedPrayed = <List<int>>[];
  final counts = <(int, int)>[];
  final invitations = <({int id, List<String> usernames, bool family})>[];

  /// The members blocked by the user, and the reports sent.
  final blockedList = <MemberCard>[];
  final reports =
      <
        ({
          String username,
          int? importunityId,
          ReportReason reason,
          String comment,
        })
      >[];
  var _nextId = 100;

  /// Every call fails with it (a session that ended, a server error…).
  AppException? failure;

  void _online() {
    if (offline) {
      throw const NetworkException();
    }
    if (failure case final failure?) {
      throw failure;
    }
  }

  @override
  Future<List<PrayerTopic>> topics({
    required DateTime day,
    bool archive = false,
  }) async {
    _online();
    return archive ? const [] : [...topicList];
  }

  @override
  Future<PrayerTopic> topic(int id, {required DateTime day}) async {
    _online();
    return topicList.firstWhere((topic) => topic.id == id);
  }

  /// The PDFs downloaded (their full address).
  final documents = <String>[];

  @override
  Future<Uint8List> document(String url) async {
    _online();
    documents.add(url);
    // "%PDF"
    return Uint8List.fromList(const [0x25, 0x50, 0x44, 0x46]);
  }

  @override
  Future<List<PrayerPerson>> people() async {
    _online();
    return [...peopleList];
  }

  @override
  Future<PrayerPerson> addPerson({
    required PrayerList list,
    required String name,
    String note = '',
  }) async {
    _online();
    final person = PrayerPerson(
      id: _nextId++,
      list: list,
      name: name,
      note: note,
    );
    peopleList.add(person);
    return person;
  }

  @override
  Future<PrayerPerson> updatePerson(PrayerPerson person) async {
    _online();
    final at = peopleList.indexWhere((other) => other.id == person.id);
    peopleList[at] = person;
    return person;
  }

  @override
  Future<void> deletePerson(int id) async {
    _online();
    peopleList.removeWhere((person) => person.id == id);
  }

  @override
  Future<List<PrayerPerson>> markPrayed(
    List<int> ids, {
    required DateTime day,
  }) async {
    _online();
    markedPrayed.add(ids);
    for (final (i, person) in peopleList.indexed) {
      if (ids.contains(person.id)) {
        peopleList[i] = person.copyWith(lastPrayedOn: day);
      }
    }
    return [...peopleList];
  }

  @override
  Future<List<RetreatRecord>> retreats({
    required DateTime from,
    required DateTime to,
  }) async {
    _online();
    return [...retreatList];
  }

  @override
  Future<void> saveRetreat(RetreatRecord record) async {
    _online();
    retreatList
      ..removeWhere(
        (other) => other.day == record.day && other.moment == record.moment,
      )
      ..add(record);
  }

  @override
  Future<void> deleteRetreat(DateTime day, RetreatMoment moment) async {
    _online();
    deletedRetreats.add((day, moment));
    retreatList.removeWhere(
      (record) => record.day == day && record.moment == moment,
    );
  }

  @override
  Future<List<Importunity>> importunities() async {
    _online();
    return [...importunityList];
  }

  @override
  Future<Importunity> importunity(int id) async {
    _online();
    return importunityList.firstWhere((topic) => topic.id == id);
  }

  void _put(Importunity topic) {
    final at = importunityList.indexWhere((other) => other.id == topic.id);
    if (at < 0) {
      importunityList.insert(0, topic);
    } else {
      importunityList[at] = topic;
    }
  }

  @override
  Future<Importunity> createImportunity({
    required String title,
    String description = '',
    int? goal,
  }) async {
    _online();
    final topic = Importunity(
      id: _nextId++,
      title: title,
      description: description,
      goal: goal,
      owner: sampleMembers.values.first,
      isOwner: true,
      participants: 1,
      members: [sampleMembers.values.first],
    );
    _put(topic);
    return topic;
  }

  @override
  Future<Importunity> updateImportunity(
    int id, {
    required String title,
    required String description,
    required int? goal,
    required ImportunityStatus status,
  }) async {
    _online();
    final topic = (await importunity(id)).copyWith(
      title: title,
      description: description,
      goal: goal,
      status: status,
    );
    _put(topic);
    return topic;
  }

  @override
  Future<void> deleteImportunity(int id) async {
    _online();
    importunityList.removeWhere((topic) => topic.id == id);
  }

  @override
  Future<Importunity> count(int id, int amount) async {
    _online();
    counts.add((id, amount));
    final topic = await importunity(id);
    final total = topic.total + amount;
    final updated = topic.copyWith(
      total: total,
      myCount: topic.myCount + amount,
      reachedAt: topic.goal != null && total >= topic.goal!
          ? topic.reachedAt ?? DateTime(2026, 10, 10)
          : null,
    );
    _put(updated);
    return updated;
  }

  @override
  Future<int> invite(
    int id, {
    List<String> usernames = const [],
    bool family = false,
  }) async {
    _online();
    invitations.add((id: id, usernames: usernames, family: family));
    final count = usernames.length + (family ? spiritualFamily.members : 0);
    _put((await importunity(id)).copyWith(invited: count));
    return count;
  }

  @override
  Future<Importunity?> answer(int id, {required bool join}) async {
    _online();
    final topic = await importunity(id);
    if (!join) {
      importunityList.removeWhere((other) => other.id == id);
      return null;
    }
    final joined = topic.copyWith(
      myStatus: ImportunityMemberStatus.joined,
      participants: topic.participants + 1,
    );
    _put(joined);
    return joined;
  }

  @override
  Future<void> leave(int id) async {
    _online();
    importunityList.removeWhere((topic) => topic.id == id);
  }

  @override
  Future<PrayerFamily> family() async {
    _online();
    return spiritualFamily;
  }

  MemberCard _member(String username) {
    for (final topic in importunityList) {
      for (final member in [topic.owner, ?topic.invitedBy, ...topic.members]) {
        if (member.username == username) {
          return member;
        }
      }
    }
    if (sampleMembers[username] case final member?) {
      return member;
    }
    throw const ApiException(status: 404, code: 'NOT_FOUND', message: '');
  }

  /// Like the server: their pending invitations to the user are removed.
  @override
  Future<void> block(String username) async {
    _online();
    final member = _member(username);
    if (!blockedList.any((other) => other.username == username)) {
      blockedList.add(member);
    }
    importunityList.removeWhere(
      (topic) => topic.isInvitation && topic.inviter.username == username,
    );
  }

  @override
  Future<void> unblock(String username) async {
    _online();
    blockedList.removeWhere((member) => member.username == username);
  }

  @override
  Future<List<MemberCard>> blocked() async {
    _online();
    return [...blockedList];
  }

  @override
  Future<int> report({
    required String username,
    required ReportReason reason,
    int? importunityId,
    String comment = '',
  }) async {
    _online();
    _member(username);
    reports.add((
      username: username,
      importunityId: importunityId,
      reason: reason,
      comment: comment.trim(),
    ));
    return reports.length;
  }
}

/// The sound between two points: counted, not played.
class FakeChime implements Chime {
  var played = 0;

  @override
  Future<void> play() async => played++;

  @override
  Future<void> dispose() async {}
}

/// The stopwatch outside the app: what is shown ([shown], null once hidden)
/// and every change.
class FakeLockScreenTimer implements LockScreenTimer {
  ({String label, DateTime since, Duration? paused})? shown;
  var changes = 0;

  @override
  Future<void> show({
    required String label,
    required DateTime since,
    required LockScreenTexts texts,
    Duration? paused,
  }) async {
    shown = (label: label, since: since, paused: paused);
    changes++;
  }

  @override
  Future<void> hide() async {
    shown = null;
    changes++;
  }
}

/// The phone's voice: what it was asked to say, in which language, and
/// how many times it was told to stop.
class FakeVoiceReader implements VoiceReader {
  final spoken = <({String text, String language})>[];
  var stops = 0;

  @override
  Future<void> speak(String text, String language) async =>
      spoken.add((text: text, language: language));

  @override
  Future<void> speakToEnd(String text, String language) async {
    spoken.add((text: text, language: language));
    // the time of saying it
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<void> stop() async => stops++;
}

/// The report sent in the app: who it can go to ([receivers], authority
/// ids), what was sent, and the answers (in [sentList], newest first).
class FakeReportSendingsApi implements ReportSendingsApi {
  FakeReportSendingsApi({this.receivers = const {}, List<InAppSending>? sent})
    : sentList = sent ?? [];

  Set<int> receivers;
  final List<InAppSending> sentList;
  final sends = <({DateTime from, DateTime to, List<int> ids})>[];
  var _next = 1;

  @override
  Future<List<InAppSending>> send({
    required DateTime from,
    required DateTime to,
    List<int> authorityIds = const [],
  }) async {
    sends.add((from: from, to: to, ids: authorityIds));
    final done = [
      for (final id in authorityIds.isEmpty ? receivers : authorityIds)
        if (receivers.contains(id))
          InAppSending(
            id: _next++,
            authorityId: id,
            periodFrom: from,
            periodTo: to,
            sentAt: DateTime.now(),
          ),
    ];
    sentList.insertAll(0, done);
    return done;
  }

  @override
  Future<List<InAppSending>> sent({int size = 30}) async =>
      sentList.take(size).toList();
}

/// Pushes that never leave: [token] is the address of the phone, [granted]
/// what the user answers, and the test adds taps and received pushes.
class FakePushMessaging implements PushMessaging {
  FakePushMessaging({this.address = 'push-token', this.granted = true});

  /// What Firebase gives as this phone's address.
  final String? address;
  bool granted;
  Map<String, String>? launchedWith;
  var permissionAsked = false;
  final tapsController = StreamController<Map<String, String>>.broadcast();
  final receivedController = StreamController<PushMessage>.broadcast();

  @override
  Future<bool> requestPermission() async {
    permissionAsked = true;
    return granted;
  }

  @override
  Future<String?> token() async => address;

  @override
  Stream<String> get tokenRefreshes => const Stream.empty();

  @override
  Future<Map<String, String>?> takeLaunchData() async {
    final data = launchedWith;
    launchedWith = null;
    return data;
  }

  @override
  Stream<Map<String, String>> get taps => tapsController.stream;

  @override
  Stream<PushMessage> get received => receivedController.stream;

  @override
  String get platform => 'android';
}

Announcement sampleAnnouncement({
  int id = 1,
  String title = 'Veillée de prière',
  String body = 'Vendredi à 21 h, à l\'assemblée de Biyem-Assi.',
  bool read = false,
  List<AnnouncementFile> attachments = const [],
}) => Announcement(
  id: id,
  title: title,
  body: body,
  attachments: attachments,
  createdAt: DateTime.utc(2026, 10, 12, 18),
  readAt: read ? DateTime.utc(2026, 10, 12, 19) : null,
);

/// The member's notifications on the server; records the phones and reads.
class FakeNotificationsApi implements NotificationsApi {
  FakeNotificationsApi({List<Announcement>? items})
    : items = items ?? [sampleAnnouncement()];

  final List<Announcement> items;
  final registered = <({String token, String platform, String language})>[];
  final unregistered = <String>[];
  final read = <int>[];

  @override
  Future<AnnouncementPage> list({int page = 1, int size = 20}) async => (
    items: items.skip((page - 1) * size).take(size).toList(),
    unread: items.where((item) => !item.isRead).length,
    total: items.length,
  );

  @override
  Future<Announcement> get(int id) async =>
      items.where((item) => item.id == id).firstOrNull ??
      (throw const ApiException(
        status: 404,
        code: 'NOT_FOUND',
        message: 'not found',
      ));

  @override
  Future<Announcement> markRead(int id) async {
    read.add(id);
    final index = items.indexWhere((item) => item.id == id);
    items[index] = items[index].copyWith(readAt: DateTime.utc(2026, 10, 13));
    return items[index];
  }

  @override
  Future<void> registerDevice({
    required String token,
    required String platform,
    required String language,
  }) async =>
      registered.add((token: token, platform: platform, language: language));

  @override
  Future<void> unregisterDevice(String token) async => unregistered.add(token);
}

/// The store of the Premium subscription: two plans, nothing really paid.
class FakePremiumStore implements PremiumStore {
  FakePremiumStore({this.active = false, this.restorable = false});

  bool active;

  /// Restoring finds a purchase made elsewhere.
  bool restorable;
  final loggedIn = <String>[];
  var loggedOut = false;
  final bought = <PremiumPeriod>[];

  /// The times the Customer Center opened.
  var managed = 0;
  final _changes = StreamController<bool>.broadcast();

  static const monthly = PremiumPlan(
    period: PremiumPeriod.monthly,
    price: '2,99 €',
    amount: 2.99,
  );
  static const semiannual = PremiumPlan(
    period: PremiumPeriod.semiannual,
    price: '14,99 €',
    amount: 14.99,
    pricePerMonth: '2,50 €',
  );
  static const annual = PremiumPlan(
    period: PremiumPeriod.annual,
    price: '24,99 €',
    amount: 24.99,
    pricePerMonth: '2,08 €',
    trialDays: 7,
  );
  static const lifetime = PremiumPlan(
    period: PremiumPeriod.lifetime,
    price: '49,99 €',
    amount: 49.99,
  );

  @override
  Future<void> logIn(String userId) async => loggedIn.add(userId);

  @override
  Future<void> logOut() async => loggedOut = true;

  @override
  Future<bool> isActive() async => active;

  @override
  Stream<bool> get changes => _changes.stream;

  @override
  Future<List<PremiumPlan>> plans() async => const [
    monthly,
    semiannual,
    annual,
    lifetime,
  ];

  @override
  Future<bool> buy(PremiumPlan plan) async {
    bought.add(plan.period);
    active = true;
    return true;
  }

  @override
  Future<bool> restore() async {
    active = active || restorable;
    return active;
  }

  @override
  Future<void> manage() async => managed++;
}

/// The store's rating sheet: counts the requests, for the version [version].
class FakeStoreReview implements StoreReview {
  FakeStoreReview({this.version = '1.0.21'});

  String version;
  var requests = 0;

  @override
  Future<String> appVersion() async => version;

  @override
  Future<void> requestReview() async => requests++;
}

/// The shortcuts of the app icon: keeps what was set; the test touches one.
class FakeAppShortcuts implements AppShortcuts {
  /// The shortcuts shown now (empty once cleared), with their titles.
  Map<AppShortcut, String> shown = const {};
  var cleared = false;
  AppShortcut? launchedWith;
  final tapsController = StreamController<AppShortcut>.broadcast();

  @override
  Future<void> show(Map<AppShortcut, String> titles) async {
    shown = titles;
    cleared = false;
  }

  @override
  Future<void> clear() async {
    shown = const {};
    cleared = true;
  }

  @override
  Future<AppShortcut?> takeLaunchShortcut() async {
    final shortcut = launchedWith;
    launchedWith = null;
    return shortcut;
  }

  @override
  Stream<AppShortcut> get taps => tapsController.stream;
}

/// The members who chose the user as disciple maker, and the dates asked.
class FakeDisciplesApi implements DisciplesApi {
  FakeDisciplesApi([this.disciples = const [], List<ReceivedReport>? sent])
    : receivedList = sent ?? [];

  List<Disciple> disciples;
  final asked = <DateTime>[];

  /// The reports the disciples sent in the app, newest first; the ids
  /// opened.
  final List<ReceivedReport> receivedList;
  final opened = <int>[];

  @override
  Future<ReceivedReportsPage> received({int page = 1, int size = 20}) async => (
    items: receivedList.skip((page - 1) * size).take(size).toList(),
    total: receivedList.length,
  );

  @override
  Future<void> markRead(int id) async => opened.add(id);

  @override
  Future<ReceivedReport> reply(int id, String text) async {
    final index = receivedList.indexWhere((report) => report.id == id);
    final answered = receivedList[index].copyWith(
      reply: text,
      repliedAt: DateTime.now(),
    );
    receivedList[index] = answered;
    return answered;
  }

  /// The pages asked, with their search.
  final pages = <({String search, int page})>[];

  @override
  Future<DisciplesPage> list({
    required DateTime today,
    String search = '',
    int page = 1,
    int size = disciplesPageSize,
  }) async {
    asked.add(today);
    pages.add((search: search, page: page));
    final query = search.trim().toLowerCase().replaceFirst('@', '');
    final found = [
      for (final disciple in disciples)
        if ('${disciple.member.fullName} ${disciple.member.username}'
            .toLowerCase()
            .contains(query))
          disciple,
    ];
    return (
      items: found.skip((page - 1) * size).take(size).toList(),
      total: found.length,
    );
  }

  /// The reports of each disciple, by authority id; the ranges asked.
  final reportsOf = <int, DiscipleReports>{};
  final ranges = <({int id, DateTime from, DateTime to})>[];

  @override
  Future<DiscipleReports> reports(
    int authorityId, {
    required DateTime from,
    required DateTime to,
  }) async {
    ranges.add((id: authorityId, from: from, to: to));
    final reports = reportsOf[authorityId];
    if (reports == null) {
      throw const ApiException(
        status: 403,
        code: 'REPORTS_NOT_SHARED',
        message: '',
      );
    }
    return reports.copyWith(
      days: [
        for (final day in reports.days)
          if (!day.date.isBefore(from) && !day.date.isAfter(to)) day,
      ],
    );
  }
}

/// The links that open the app: [launchedWith] the one the app was opened
/// with (given first, like app_links), [add] the next ones.
class FakeIncomingLinks implements IncomingLinks {
  FakeIncomingLinks({Uri? launchedWith}) {
    if (launchedWith != null) {
      _controller.add(launchedWith);
    }
  }

  // kept until the app listens, like the link the app was opened with
  final _controller = StreamController<Uri>();

  void add(String link) => _controller.add(Uri.parse(link));

  @override
  Stream<Uri> get links => _controller.stream;
}

/// The home-screen widget: keeps what it was given; the test touches it.
class FakeHomeWidgets implements HomeWidgets {
  final shown = <TodayWidgetData>[];
  Uri? launchedWith;
  final clicksController = StreamController<Uri?>.broadcast();

  TodayWidgetData? get last => shown.lastOrNull;

  @override
  Future<void> show(TodayWidgetData data) async => shown.add(data);

  /// What the "Verset du jour" widget was given, the latest last.
  final verses = <VerseWidgetData>[];

  @override
  Future<void> showVerses(VerseWidgetData data) async => verses.add(data);

  @override
  Future<Uri?> takeLaunchUri() async {
    final uri = launchedWith;
    launchedWith = null;
    return uri;
  }

  @override
  Stream<Uri?> get clicks => clicksController.stream;
}

/// The nations of the ministry on the server; [offline] has no network.
class FakeMinistryApi implements MinistryApi {
  FakeMinistryApi({
    List<Nation>? list,
    Map<MinistryPersonKind, List<MinistryPerson>>? people,
    this.offline = false,
  }) : list = list ?? sampleNations,
       peopleByKind = people ?? {MinistryPersonKind.missionary: samplePeople};

  List<Nation> list;
  bool offline;

  /// The published portraits, by kind (none: no hero yet).
  Map<MinistryPersonKind, List<MinistryPerson>> peopleByKind;

  static const samplePeople = [
    MinistryPerson(
      id: 1,
      kind: MinistryPersonKind.missionary,
      name: 'Paul Ndjock',
      countryCode: 'TD',
      role: 'Implantation d’églises',
      sinceYear: 2004,
      story: 'Parti de Yaoundé avec sa famille.\n\nIl sert à N’Djamena.',
      position: 1,
    ),
    MinistryPerson(
      id: 2,
      kind: MinistryPersonKind.missionary,
      name: 'Esther Mbarga',
      countryCode: 'BJ',
      position: 2,
    ),
  ];

  static const sampleNations = [
    Nation(
      id: 1,
      position: 1,
      name: 'Le Cameroun',
      countryCode: 'CM',
      latitude: 4.59,
      longitude: 12.47,
      arrivalYear: 1975,
    ),
    Nation(
      id: 2,
      position: 2,
      name: 'Le Bénin',
      countryCode: 'BJ',
      latitude: 10.32,
      longitude: 2.35,
    ),
    Nation(
      id: 3,
      position: 3,
      name: 'L’Écosse',
      latitude: 56.82,
      longitude: -4.18,
    ),
  ];

  @override
  Future<List<Nation>> nations() async {
    if (offline) {
      throw const NetworkException();
    }
    return list;
  }

  @override
  Future<List<MinistryPerson>> people(MinistryPersonKind kind) async {
    if (offline) {
      throw const NetworkException();
    }
    return peopleByKind[kind] ?? const [];
  }
}

/// Firebase by SMS: the code is [code], the token `firebase:+237…`.
class FakePhoneVerification implements PhoneVerification {
  FakePhoneVerification({this.code = '123456', this.sendError});

  final String code;
  final PhoneVerificationException? sendError;

  /// The numbers an SMS was sent to.
  final sent = <String>[];
  var forgotten = false;

  @override
  Future<void> sendCode(
    String phoneNumber, {
    required void Function(String idToken) onAutoVerified,
  }) async {
    if (sendError case final error?) {
      throw error;
    }
    sent.add(phoneNumber);
  }

  @override
  Future<String> confirm(String code) async {
    if (code != this.code) {
      throw const PhoneVerificationException(
        PhoneVerificationError.invalidCode,
      );
    }
    return 'firebase:${sent.last}';
  }

  @override
  Future<void> forget() async => forgotten = true;
}

/// The log of the app, kept to be read by the tests.
class FakeCrashReporting implements CrashReporting {
  final errors = <({Object error, String reason})>[];
  final steps = <String>[];

  @override
  Future<void> identify(String? userId) async {}

  @override
  void record(Object error, StackTrace? stack, {required String reason}) =>
      errors.add((error: error, reason: reason));

  @override
  void log(String message) => steps.add(message);
}

/// Screen Time, without the phone: [granted] answers the access asked,
/// [chosen] the system's list; what the app asked is kept.
class FakeAppShield implements AppShield {
  FakeAppShield({
    this.supported = true,
    this.granted = true,
    this.chosen = const ShieldSelection(apps: 3, categories: 1),
  });

  @override
  final bool supported;
  bool granted;
  var allowed = false;
  ShieldSelection? chosen;
  var current = const ShieldSelection();
  var pauses = 3;

  /// The last settings given, and the days opened.
  Map<String, Object>? configured;
  final unlocked = <DateTime>[];

  @override
  Future<bool> authorized() async => allowed;

  @override
  Future<bool> authorize() async => allowed = granted;

  @override
  Future<ShieldSelection> selection() async => current;

  @override
  Future<ShieldSelection?> choose() async {
    if (chosen case final chosen?) {
      current = chosen;
    }
    return chosen;
  }

  @override
  Future<void> configure({
    required bool enabled,
    required int startMinutes,
    required int pausesPerDay,
    required Map<String, String> texts,
  }) async => configured = {
    'enabled': enabled,
    'startMinutes': startMinutes,
    'pausesPerDay': pausesPerDay,
    'texts': texts,
  };

  @override
  Future<void> unlock(DateTime day) async => unlocked.add(day);

  @override
  Future<int> pausesLeft() async => pauses;
}

/// Face ID / the fingerprint, without the phone: [kind] null has none;
/// [accept] answers the prompts, [prompts] keeps their reasons.
class FakeBiometrics implements Biometrics {
  FakeBiometrics({this.available, this.accept = true});

  BiometricKind? available;
  bool accept;
  final prompts = <String>[];

  @override
  Future<BiometricKind?> kind() async => available;

  @override
  Future<bool> authenticate(String reason) async {
    prompts.add(reason);
    return accept;
  }
}

/// The Keychain of the sign-in, in memory.
class FakeSavedLoginStorage implements SavedLoginStorage {
  FakeSavedLoginStorage({this.savedPhone, this.savedPassword});

  String? savedPhone;
  String? savedPassword;

  @override
  Future<String?> phone() async => savedPhone;

  @override
  Future<void> savePhone(String phone) async => savedPhone = phone;

  @override
  Future<String?> password() async => savedPassword;

  @override
  Future<void> savePassword(String password) async => savedPassword = password;

  @override
  Future<void> deletePassword() async => savedPassword = null;

  @override
  Future<void> forget() async {
    savedPhone = null;
    savedPassword = null;
  }
}

/// Nos documents without the server: [documents] answer like the API
/// (search on the words, case and accents aside; one category; a page at a
/// time); [pagesAsked] keeps the pages fetched.
class FakeDocumentsApi implements DocumentsApi {
  FakeDocumentsApi({List<LibraryDocument>? documents, this.offline = false})
    : documents = documents ?? sampleDocuments;

  List<LibraryDocument> documents;
  bool offline;
  final pagesAsked = <int>[];

  static const sampleDocuments = [
    LibraryDocument(
      id: 1,
      title: 'Règlement intérieur',
      description: 'À lire par tous les responsables.',
      category: 'Règlements',
      file: LibraryFile(
        id: 11,
        url: '/v1/media/a.pdf',
        name: 'Règlement intérieur.pdf',
        sizeBytes: 184320,
      ),
    ),
    LibraryDocument(
      id: 2,
      title: "Fiche d'inscription",
      category: 'Formulaires',
      file: LibraryFile(
        id: 12,
        url: '/v1/media/b.docx',
        name: 'Inscription.docx',
        kind: DocumentKind.word,
        sizeBytes: 2516582,
      ),
    ),
  ];

  static String _plain(String text) => text
      .toLowerCase()
      .replaceAll(RegExp('[éèêë]'), 'e')
      .replaceAll(RegExp('[àâ]'), 'a')
      .replaceAll(RegExp('[îï]'), 'i');

  @override
  Future<DocumentsPage> list({
    String search = '',
    String category = '',
    int page = 1,
    int size = 20,
  }) async {
    if (offline) {
      throw const NetworkException();
    }
    pagesAsked.add(page);
    final words = _plain(search).split(' ').where((w) => w.isNotEmpty);
    final kept = [
      for (final document in documents)
        if ((category.isEmpty || document.category == category) &&
            words.every(
              _plain(
                '${document.title} ${document.description} ${document.category}',
              ).contains,
            ))
          document,
    ];
    final start = (page - 1) * size;
    return (items: kept.skip(start).take(size).toList(), total: kept.length);
  }

  @override
  Future<List<DocumentCategory>> categories() async {
    if (offline) {
      throw const NetworkException();
    }
    final counts = <String, int>{};
    for (final document in documents) {
      if (document.category.isNotEmpty) {
        counts[document.category] = (counts[document.category] ?? 0) + 1;
      }
    }
    return [
      for (final MapEntry(:key, :value) in counts.entries)
        DocumentCategory(name: key, count: value),
    ]..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Future<Uint8List> file(String url) async =>
      Uint8List.fromList(const [37, 80, 68, 70]);
}

/// Enseignements: two messages, the newest first.
class FakeTeachingsApi implements TeachingsApi {
  FakeTeachingsApi({List<Teaching>? teachings, this.offline = false})
    : teachings = teachings ?? sampleTeachings;

  List<Teaching> teachings;
  bool offline;

  static const sampleTeachings = [
    Teaching(
      id: 1,
      title: 'Le message de la croix',
      speaker: 'Pr Zacharias Tanee Fomum',
      category: 'Prédications',
      recordedOn: '1994-08-15',
      description: 'La croix, puissance de Dieu.',
      audio: TeachingAudio(
        id: 21,
        url: '/v1/media/croix.mp3',
        sizeBytes: 12000000,
      ),
      durationSeconds: 3125,
    ),
    Teaching(
      id: 2,
      title: 'La prière',
      speaker: 'Théodore Andoseh',
      category: 'Vie chrétienne',
      audio: TeachingAudio(
        id: 22,
        url: '/v1/media/priere.m4a',
        format: AudioFormat.m4a,
      ),
      durationSeconds: 1800,
    ),
  ];

  @override
  Future<TeachingsPage> list({
    String search = '',
    String category = '',
    int page = 1,
    int size = 20,
  }) async {
    if (offline) {
      throw const NetworkException();
    }
    final words = search.toLowerCase().split(' ').where((w) => w.isNotEmpty);
    final kept = [
      for (final teaching in teachings)
        if ((category.isEmpty || teaching.category == category) &&
            words.every(
              '${teaching.title} ${teaching.speaker}'.toLowerCase().contains,
            ))
          teaching,
    ];
    final start = (page - 1) * size;
    return (items: kept.skip(start).take(size).toList(), total: kept.length);
  }

  @override
  Future<List<TeachingCategory>> categories() async {
    if (offline) {
      throw const NetworkException();
    }
    final names = {for (final t in teachings) t.category}..remove('');
    return [for (final name in names) TeachingCategory(name: name, count: 1)];
  }
}

/// A player that plays nothing: it says what it was asked.
class FakeTeachingPlayer implements TeachingPlayer {
  final _controller = StreamController<PlayerSnapshot>.broadcast();
  PlayerSnapshot _snapshot = const PlayerSnapshot();

  /// What [open] was given: the source and where it started.
  final opened = <({Teaching teaching, Uri source, Duration start})>[];

  @override
  Stream<PlayerSnapshot> get snapshots => _controller.stream;

  @override
  PlayerSnapshot get snapshot => _snapshot;

  /// What the real player would say (the position moving, the end).
  void emit(PlayerSnapshot snapshot) {
    _snapshot = snapshot;
    _controller.add(snapshot);
  }

  @override
  Future<void> open(
    Teaching teaching, {
    required Uri source,
    Uri? artwork,
    Duration start = Duration.zero,
    double speed = 1,
  }) async {
    opened.add((teaching: teaching, source: source, start: start));
    emit(
      PlayerSnapshot(
        teaching: teaching,
        playing: true,
        position: start,
        duration: teaching.duration,
        speed: speed,
      ),
    );
  }

  @override
  Future<void> play() async => emit(_snapshot.copyWith(playing: true));

  @override
  Future<void> pause() async => emit(_snapshot.copyWith(playing: false));

  @override
  Future<void> seek(Duration position) async =>
      emit(_snapshot.copyWith(position: position));

  @override
  Future<void> setSpeed(double speed) async =>
      emit(_snapshot.copyWith(speed: speed));

  @override
  Future<void> stop() async => emit(const PlayerSnapshot());
}

/// The teachings kept "on the phone": their ids.
class FakeTeachingFiles implements TeachingFiles {
  final kept = <int>{};
  bool fail = false;

  @override
  Future<File?> fileOf(Teaching teaching) async => kept.contains(teaching.id)
      ? File('/tmp/teachings/${teaching.id}.${teaching.audio.format.name}')
      : null;

  @override
  Future<void> download(
    Teaching teaching,
    String url, {
    required void Function(double progress) onProgress,
    CancelToken? cancel,
  }) async {
    if (fail) {
      throw const NetworkException();
    }
    onProgress(0.5);
    kept.add(teaching.id);
  }

  @override
  Future<void> delete(Teaching teaching) async => kept.remove(teaching.id);
}

/// The Keychain of Suivi des âmes, in memory.
class FakeSoulsStorage implements SoulsStorage {
  final saved = <int, String>{};

  @override
  Future<String?> read(int accountId) async => saved[accountId];

  @override
  Future<void> write(int accountId, String json) async =>
      saved[accountId] = json;
}

/// The rules of Firebase Remote Config: none unless the test gives some;
/// [publish] changes them the way the console does (real-time).
class FakeUpdateRules implements UpdateRulesSource {
  FakeUpdateRules([this.rules = UpdateRules.none]);

  UpdateRules rules;
  var refreshes = 0;
  final _changes = StreamController<void>.broadcast();

  void publish(UpdateRules next) {
    rules = next;
    _changes.add(null);
  }

  @override
  Future<UpdateRules> read() async => rules;

  @override
  Future<void> refresh() async => refreshes++;

  @override
  Stream<void> get changes => _changes.stream;
}

/// The installed version (1.0.21, build 55) and the updates started.
class FakeAppInstaller implements AppInstaller {
  FakeAppInstaller({this.version = '1.0.21+55'});

  String? version;

  /// What [update] answers.
  UpdateStart answer = UpdateStart.started;
  final updates = <({bool required, String storeUrl})>[];
  var installs = 0;
  final downloads = StreamController<void>.broadcast();

  @override
  Future<AppVersion?> installed() async =>
      version == null ? null : AppVersion.tryParse(version!);

  @override
  Future<UpdateStart> update({
    required bool required,
    String storeUrl = '',
  }) async {
    updates.add((required: required, storeUrl: storeUrl));
    return answer;
  }

  @override
  Stream<void> get downloaded => downloads.stream;

  @override
  Future<void> install() async => installs++;
}

/// pawaPay through the server: a payment waits for the member's PIN until
/// the test [complete]s or [fail]s it; completed, the member is registered
/// (paid) in [events].
class FakePaymentsApi implements PaymentsApi {
  FakePaymentsApi({this.events});

  FakeEventsApi? events;
  final payments = <String, Payment>{};
  final started =
      <({int eventId, int people, String phoneNumber, String provider})>[];
  final guessed = <String>[];

  /// What a new payment answers at once (pending, or failed when refused).
  PaymentStatus startStatus = PaymentStatus.pending;
  String startFailure = '';
  AppException? payError;

  /// PAYMENTS_DISABLED: no mobile money on the server.
  AppException? operatorsError;

  @override
  Future<List<MobileMoneyCountry>> operators({String currency = 'XAF'}) async {
    if (operatorsError != null) {
      throw operatorsError!;
    }
    return const [
      MobileMoneyCountry(
        country: 'CMR',
        names: {'fr': 'Cameroun'},
        prefix: '237',
        operators: [
          MobileMoneyOperator(provider: 'MTN_MOMO_CMR', name: 'MTN'),
          MobileMoneyOperator(provider: 'ORANGE_CMR', name: 'Orange'),
        ],
      ),
    ];
  }

  @override
  Future<OperatorGuess> guessOperator(String phoneNumber) async {
    final digits = phoneNumber.replaceAll(RegExp(r'\D'), '');
    guessed.add(digits);
    return OperatorGuess(
      country: 'CMR',
      provider: digits.startsWith('23769') ? 'ORANGE_CMR' : 'MTN_MOMO_CMR',
      phoneNumber: digits,
    );
  }

  @override
  Future<Payment> payForEvent(
    int eventId, {
    required int people,
    bool needsLodging = false,
    String departureCity = '',
    required String phoneNumber,
    String provider = '',
  }) async {
    if (payError != null) {
      throw payError!;
    }
    started.add((
      eventId: eventId,
      people: people,
      phoneNumber: phoneNumber,
      provider: provider,
    ));
    final price = events?.events[eventId]?.price;
    final payment = Payment(
      id: 'pay-${payments.length + 1}',
      status: startStatus,
      failureCode: startFailure,
      amount: (price?.amount ?? 0) * people,
      currency: price?.currency ?? 'XAF',
      provider: provider,
      eventId: eventId,
      people: people,
    );
    _details[payment.id] = (needsLodging, departureCity);
    return payments[payment.id] = payment;
  }

  final _details = <String, (bool, String)>{};

  @override
  Future<Payment> get(String id) async => payments[id]!;

  /// The money arrived: the server registers the member.
  Future<void> complete(String id) async {
    final payment = payments[id]!;
    final (lodging, city) = _details[id]!;
    final event = await events!.register(
      payment.eventId!,
      people: payment.people,
      needsLodging: lodging,
      departureCity: city,
    );
    events!.events[event.id] = event.copyWith(
      myRegistration: event.myRegistration!.copyWith(paid: true),
    );
    payments[id] = payment.copyWith(status: PaymentStatus.completed);
  }

  void fail(String id, String code) => payments[id] = payments[id]!.copyWith(
    status: PaymentStatus.failed,
    failureCode: code,
  );
}
