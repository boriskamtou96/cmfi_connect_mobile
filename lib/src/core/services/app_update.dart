import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/flavor.dart';
import '../storage/preferences.dart';
import 'app_log.dart';
import 'link_launcher.dart';

part 'app_update.g.dart';

/// A version of the app: "1.0.21", or "1.0.21+55" with its build number.
class AppVersion implements Comparable<AppVersion> {
  const AppVersion(this.numbers, {this.build});

  /// [1, 0, 21]
  final List<int> numbers;
  final int? build;

  /// null when [text] is not a version ("", "beta").
  static AppVersion? tryParse(String text) {
    final [name, ...rest] = text.trim().split('+');
    final numbers = name.split('.').map(int.tryParse).toList();
    if (name.isEmpty || numbers.contains(null) || rest.length > 1) {
      return null;
    }
    final build = rest.isEmpty ? null : int.tryParse(rest.single);
    if (rest.isNotEmpty && build == null) {
      return null;
    }
    return AppVersion(numbers.cast<int>(), build: build);
  }

  /// The numbers first (1.0.9 < 1.0.10, 1.2 = 1.2.0); the builds only when
  /// both versions give one.
  @override
  int compareTo(AppVersion other) {
    final length = numbers.length > other.numbers.length
        ? numbers.length
        : other.numbers.length;
    for (var i = 0; i < length; i++) {
      final mine = i < numbers.length ? numbers[i] : 0;
      final theirs = i < other.numbers.length ? other.numbers[i] : 0;
      if (mine != theirs) {
        return mine.compareTo(theirs);
      }
    }
    if (build case final mine?) {
      if (other.build case final theirs?) {
        return mine.compareTo(theirs);
      }
    }
    return 0;
  }

  bool operator <(AppVersion other) => compareTo(other) < 0;

  @override
  bool operator ==(Object other) =>
      other is AppVersion && compareTo(other) == 0 && build == other.build;

  @override
  int get hashCode => Object.hash(Object.hashAll(numbers), build);

  /// "1.0.21": what the user is shown (the build means nothing to them).
  @override
  String toString() => numbers.join('.');
}

/// What is asked of the phones, set in Firebase Remote Config for each
/// platform: below [minimum] the app is locked until it is updated; below
/// [latest] the update is offered.
class UpdateRules {
  const UpdateRules({
    this.minimum,
    this.latest,
    this.messages = const {},
    this.storeUrl = '',
  });

  final AppVersion? minimum;
  final AppVersion? latest;

  /// A word about the new version, by language ({"fr": "…", "en": "…"}).
  final Map<String, String> messages;

  /// The page of the app in the store; '' for the default one.
  final String storeUrl;

  static const none = UpdateRules();
}

enum UpdateNeed {
  /// Up to date, or nothing is known.
  none,

  /// A newer version exists: offered once, and in Plus.
  optional,

  /// This version is no longer allowed: nothing else until it is updated.
  required,
}

/// Where this phone stands.
class AppUpdateStatus {
  const AppUpdateStatus({
    this.need = UpdateNeed.none,
    this.installed,
    this.target,
    this.messages = const {},
    this.storeUrl = '',
  });

  /// From the installed version and the [rules].
  factory AppUpdateStatus.of(AppVersion? installed, UpdateRules rules) {
    if (installed == null) {
      // the version is unknown (tests, web): never lock anyone out
      return const AppUpdateStatus();
    }
    final need = switch (rules) {
      UpdateRules(minimum: final minimum?) when installed < minimum =>
        UpdateNeed.required,
      UpdateRules(latest: final latest?) when installed < latest =>
        UpdateNeed.optional,
      _ => UpdateNeed.none,
    };
    // the version to reach: the latest one, at least the minimum
    final target = switch ((rules.minimum, rules.latest)) {
      (final minimum?, final latest?) => latest < minimum ? minimum : latest,
      (final minimum, final latest) => latest ?? minimum,
    };
    return AppUpdateStatus(
      need: need,
      installed: installed,
      target: target,
      messages: rules.messages,
      storeUrl: rules.storeUrl,
    );
  }

  final UpdateNeed need;
  final AppVersion? installed;
  final AppVersion? target;
  final Map<String, String> messages;
  final String storeUrl;

  /// The word of the admins in [language], else in French or English; ''
  /// without one.
  String messageIn(String language) =>
      messages[language] ?? messages['fr'] ?? messages['en'] ?? '';
}

/// Where the rules come from. Behind a provider: tests use a fake.
abstract class UpdateRulesSource {
  /// The rules in force now (the ones fetched last time, at once).
  Future<UpdateRules> read();

  /// Asks for newer rules; [changes] tells when they arrive.
  Future<void> refresh();

  /// The rules changed: read them again.
  Stream<void> get changes;
}

/// Without Firebase (web, a flavor without it): nothing is ever asked.
class NoUpdateRules implements UpdateRulesSource {
  const NoUpdateRules();

  @override
  Future<UpdateRules> read() async => UpdateRules.none;

  @override
  Future<void> refresh() async {}

  @override
  Stream<void> get changes => const Stream.empty();
}

/// The rules in Firebase Remote Config, in the console of the project of
/// each flavor (cmfi-connect-dev, the production one). Every value is a
/// string, empty when not set:
///
/// - `update_minimum_android`, `update_minimum_ios`: "1.0.21" (or
///   "1.0.21+55"); older versions are locked until updated;
/// - `update_latest_android`, `update_latest_ios`: the version in the
///   store; older ones are offered the update (set it once the store
///   publishes the version, not before);
/// - `update_message`: {"fr": "…", "en": "…"}, a word shown with the update;
/// - `update_store_url_ios`: the App Store page of the app
///   (https://apps.apple.com/app/id…); `update_store_url_android` when
///   Google Play's default page is not the right one.
///
/// A change published in the console reaches the open apps at once
/// (real-time updates), the others when they open or come back.
class RemoteConfigUpdateRules implements UpdateRulesSource {
  RemoteConfigUpdateRules(this._platform, {required this.fetchInterval});

  final String _platform;

  /// How often the app may ask Firebase (it limits the fetches).
  final Duration fetchInterval;

  static const keys = [
    'update_minimum_android',
    'update_minimum_ios',
    'update_latest_android',
    'update_latest_ios',
    'update_message',
    'update_store_url_android',
    'update_store_url_ios',
  ];

  FirebaseRemoteConfig get _config => FirebaseRemoteConfig.instance;
  late final Future<void> _ready = _setUp();

  Future<void> _setUp() async {
    await _config.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: fetchInterval,
      ),
    );
    await _config.setDefaults({for (final key in keys) key: ''});
    await _config.ensureInitialized();
  }

  @override
  Future<UpdateRules> read() async {
    await _ready;
    String value(String name) => _config.getString('update_${name}_$_platform');
    return UpdateRules(
      minimum: AppVersion.tryParse(value('minimum')),
      latest: AppVersion.tryParse(value('latest')),
      messages: _messages(_config.getString('update_message')),
      storeUrl: value('store_url').trim(),
    );
  }

  final _changes = StreamController<void>.broadcast();
  StreamSubscription<void>? _realTime;

  @override
  Future<void> refresh() async {
    try {
      await _ready;
      if (await _config.fetchAndActivate()) {
        _changes.add(null);
      }
    } on Object catch (error) {
      // offline, throttled: the rules of last time stay
      AppLog.info('update rules not fetched: $error');
    }
  }

  @override
  Stream<void> get changes {
    _realTime ??= _config.onConfigUpdated.listen(
      (update) async {
        if (update.updatedKeys.any(keys.contains)) {
          await _config.activate();
          _changes.add(null);
        }
      },
      onError: (Object error) =>
          AppLog.info('update rules not listened to: $error'),
    );
    return _changes.stream;
  }

  static Map<String, String> _messages(String json) {
    if (json.trim().isEmpty) {
      return const {};
    }
    try {
      return {
        for (final MapEntry(:key, :value)
            in (jsonDecode(json) as Map<String, dynamic>).entries)
          if (value is String && value.trim().isNotEmpty) key: value.trim(),
      };
    } on Object {
      return const {};
    }
  }
}

@Riverpod(keepAlive: true)
UpdateRulesSource updateRulesSource(Ref ref) {
  final platform = switch (defaultTargetPlatform) {
    TargetPlatform.android => 'android',
    TargetPlatform.iOS => 'ios',
    _ => null,
  };
  if (kIsWeb || platform == null || Firebase.apps.isEmpty) {
    return const NoUpdateRules();
  }
  return RemoteConfigUpdateRules(
    platform,
    // the dev builds see a change at once, the others at most every hour
    // (plus the real-time updates)
    fetchInterval: ref.watch(flavorProvider) == Flavor.dev
        ? Duration.zero
        : const Duration(hours: 1),
  );
}

/// How an update started.
enum UpdateStart {
  /// Google Play installs it now, or the store is open on the app.
  started,

  /// Google Play downloads it in the background: [AppInstaller.downloaded]
  /// tells when it can be installed.
  downloading,

  /// Neither Google Play nor the store could be opened.
  failed,
}

/// Puts the new version on the phone. Behind a provider: tests use a fake.
abstract class AppInstaller {
  /// The version installed; null when unknown.
  Future<AppVersion?> installed();

  /// Google Play's own update on Android (immediate when [required], else
  /// downloaded while the app is used), the store page otherwise.
  Future<UpdateStart> update({required bool required, String storeUrl = ''});

  /// The update downloaded in the background is ready to be installed.
  Stream<void> get downloaded;

  /// Installs it: the app restarts.
  Future<void> install();
}

class NativeAppInstaller implements AppInstaller {
  NativeAppInstaller({required this.flavor, required this.links});

  final Flavor flavor;
  final LinkLauncher links;

  /// Answered by MainActivity.kt and AppDelegate.swift.
  static const _channel = MethodChannel('cmficonnect/app');

  @override
  Future<AppVersion?> installed() async {
    try {
      final version = await _channel.invokeMethod<String>('version') ?? '';
      final build = await _channel.invokeMethod<String>('build') ?? '';
      return AppVersion.tryParse(
        build.isEmpty || int.tryParse(build) == null
            ? version
            : '$version+$build',
      );
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  /// The id on Google Play; the dev flavor adds ".dev" (build.gradle.kts).
  String get _packageName =>
      flavor == Flavor.dev ? 'com.cmficonnect.app.dev' : 'com.cmficonnect.app';

  @override
  Future<UpdateStart> update({
    required bool required,
    String storeUrl = '',
  }) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final started = await _updateWithGooglePlay(required: required);
      if (started != null) {
        return started;
      }
    }
    return await links.open(_storePage(storeUrl))
        ? UpdateStart.started
        : UpdateStart.failed;
  }

  /// null when Google Play can't do it (not installed from Play, the new
  /// version not there yet): the store page is opened instead.
  Future<UpdateStart?> _updateWithGooglePlay({required bool required}) async {
    try {
      final info = await InAppUpdate.checkForUpdate();
      if (info.updateAvailability != UpdateAvailability.updateAvailable) {
        return null;
      }
      if (required || !info.flexibleUpdateAllowed) {
        if (!info.immediateUpdateAllowed) {
          return null;
        }
        final result = await InAppUpdate.performImmediateUpdate();
        return result == AppUpdateResult.inAppUpdateFailed
            ? null
            : UpdateStart.started;
      }
      _listenToDownload();
      final result = await InAppUpdate.startFlexibleUpdate();
      return switch (result) {
        AppUpdateResult.success => UpdateStart.downloading,
        AppUpdateResult.userDeniedUpdate => UpdateStart.started,
        AppUpdateResult.inAppUpdateFailed => null,
      };
    } on Object catch (error) {
      AppLog.info('Google Play update unavailable: $error');
      return null;
    }
  }

  final _downloaded = StreamController<void>.broadcast();
  StreamSubscription<InstallStatus>? _download;

  void _listenToDownload() {
    _download ??= InAppUpdate.installUpdateListener.listen((status) {
      if (status == InstallStatus.downloaded) {
        _downloaded.add(null);
      }
    }, onError: (Object error) => AppLog.info('update download: $error'));
  }

  @override
  Stream<void> get downloaded => _downloaded.stream;

  @override
  Future<void> install() async {
    try {
      await InAppUpdate.completeFlexibleUpdate();
    } on Object catch (error) {
      AppLog.info('update not installed: $error');
    }
  }

  Uri _storePage(String storeUrl) {
    if (Uri.tryParse(storeUrl) case final url? when url.hasScheme) {
      return url;
    }
    return defaultTargetPlatform == TargetPlatform.iOS
        // without the link of the App Store page: a search of the app
        ? Uri.parse(
            'itms-apps://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/'
            'search?media=software&term=CMFI%20Connect',
          )
        : Uri.https('play.google.com', '/store/apps/details', {
            'id': _packageName,
          });
  }
}

@Riverpod(keepAlive: true)
AppInstaller appInstaller(Ref ref) => NativeAppInstaller(
  flavor: ref.watch(flavorProvider),
  links: ref.watch(linkLauncherProvider),
);

/// Where this phone stands, read at launch, again when the app comes back
/// and as soon as the rules change. AppUpdateGate locks the app when the
/// update is required; SignedInTasks offers it once per version otherwise.
@Riverpod(keepAlive: true)
class AppUpdate extends _$AppUpdate {
  /// The version last offered: offered once.
  static const offeredKey = 'update_offered_version';

  @override
  Future<AppUpdateStatus> build() async {
    final source = ref.watch(updateRulesSourceProvider);
    final changes = source.changes.listen((_) => unawaited(_check()));
    final lifecycle = AppLifecycleListener(
      onResume: () => unawaited(source.refresh()),
    );
    ref.onDispose(() {
      unawaited(changes.cancel());
      lifecycle.dispose();
    });
    // the rules of last time at once, the newer ones when they arrive
    unawaited(source.refresh());
    return _read();
  }

  Future<AppUpdateStatus> _read() async => AppUpdateStatus.of(
    await ref.read(appInstallerProvider).installed(),
    await ref.read(updateRulesSourceProvider).read(),
  );

  Future<void> _check() async {
    try {
      final status = await _read();
      if (ref.mounted) {
        state = AsyncData(status);
      }
    } on Object catch (error, stack) {
      AppLog.error(error, stack, reason: 'update rules unreadable');
    }
  }

  /// The update is optional and was not offered yet for this version.
  bool toOffer() {
    final status = state.value;
    return status != null &&
        status.need == UpdateNeed.optional &&
        ref.read(sharedPreferencesProvider).getString(offeredKey) !=
            '${status.target}';
  }

  /// It was offered: not again for this version.
  Future<void> offered() async {
    if (state.value?.target case final target?) {
      await ref
          .read(sharedPreferencesProvider)
          .setString(offeredKey, '$target');
    }
  }

  /// Starts the update.
  Future<UpdateStart> start() {
    final status = state.value ?? const AppUpdateStatus();
    return ref
        .read(appInstallerProvider)
        .update(
          required: status.need == UpdateNeed.required,
          storeUrl: status.storeUrl,
        );
  }
}
