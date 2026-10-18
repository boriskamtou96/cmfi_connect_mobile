import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../i18n/strings.g.dart';

part 'app_shield.g.dart';

/// What the member chose to keep closed: counts only, the system keeps the
/// apps themselves (iOS gives opaque tokens, never their names).
class ShieldSelection {
  const ShieldSelection({this.apps = 0, this.categories = 0, this.sites = 0});

  factory ShieldSelection.fromMap(Map<Object?, Object?>? map) =>
      ShieldSelection(
        apps: (map?['apps'] as int?) ?? 0,
        categories: (map?['categories'] as int?) ?? 0,
        sites: (map?['sites'] as int?) ?? 0,
      );

  final int apps;
  final int categories;
  final int sites;

  bool get isEmpty => apps == 0 && categories == 0 && sites == 0;

  @override
  bool operator ==(Object other) =>
      other is ShieldSelection &&
      other.apps == apps &&
      other.categories == categories &&
      other.sites == sites;

  @override
  int get hashCode => Object.hash(apps, categories, sites);
}

/// « Cherche d'abord Dieu »: the apps the member chose stay closed each day,
/// from a set hour, until the day's report is saved. Behind a provider:
/// tests use a fake, and where the phone can't (the web, iOS before 16)
/// [supported] is false.
///
/// iOS: Screen Time (FamilyControls, ManagedSettings, DeviceActivity), in
/// Runner/AppShield.swift; the extensions ShieldMonitor (closes the apps
/// again each morning, ends a pause), ShieldConfig (the screen shown on a
/// closed app) and ShieldActions (its buttons) share the settings through
/// the App Group.
///
/// Android: usage access and drawing over other apps (two special
/// permissions, asked in the settings), a list of the phone's apps, and a
/// service that covers a closed app (SeekFirstChannel.kt, SeekFirstService.kt,
/// ShieldActivity.kt).
abstract class AppShield {
  bool get supported;

  /// Whether the member allowed Screen Time access.
  Future<bool> authorized();

  /// Asks Screen Time access (the system's sheet); true once allowed.
  Future<bool> authorize();

  /// The apps chosen so far.
  Future<ShieldSelection> selection();

  /// The system's list of apps; the new choice, null when cancelled.
  Future<ShieldSelection?> choose();

  /// Turns it on or off, from [startMinutes] after midnight each day.
  /// [texts]: what the closed apps say, in the app language (the
  /// extensions can't read the app's translations).
  Future<void> configure({
    required bool enabled,
    required int startMinutes,
    required int pausesPerDay,
    required Map<String, String> texts,
  });

  /// [day]'s report is saved: open until the next day's start.
  Future<void> unlock(DateTime day);

  /// The 5-minute pauses still left today.
  Future<int> pausesLeft();
}

class NoAppShield implements AppShield {
  const NoAppShield();

  @override
  bool get supported => false;

  @override
  Future<bool> authorized() async => false;

  @override
  Future<bool> authorize() async => false;

  @override
  Future<ShieldSelection> selection() async => const ShieldSelection();

  @override
  Future<ShieldSelection?> choose() async => null;

  @override
  Future<void> configure({
    required bool enabled,
    required int startMinutes,
    required int pausesPerDay,
    required Map<String, String> texts,
  }) async {}

  @override
  Future<void> unlock(DateTime day) async {}

  @override
  Future<int> pausesLeft() async => 0;
}

class NativeAppShield implements AppShield {
  const NativeAppShield();

  /// Answered by AppShield.swift.
  static const _channel = MethodChannel('cmficonnect/shield');

  /// "2026-10-16": the day as the extensions compare it.
  static String dayKey(DateTime day) =>
      '${day.year.toString().padLeft(4, '0')}-'
      '${day.month.toString().padLeft(2, '0')}-'
      '${day.day.toString().padLeft(2, '0')}';

  @override
  bool get supported => true;

  @override
  Future<bool> authorized() async =>
      await _channel.invokeMethod<bool>('authorized') ?? false;

  @override
  Future<bool> authorize() async {
    // Android explains the two permissions before the settings
    final t = LocaleSettings.instance.currentTranslations;
    return await _channel.invokeMethod<bool>('authorize', {
          'texts': {
            'title': t.seekFirst.title,
            'text': t.seekFirst.permissionsAndroid,
            'continue': t.seekFirst.permissionsContinue,
            'cancel': t.common.cancel,
          },
        }) ??
        false;
  }

  @override
  Future<ShieldSelection> selection() async => ShieldSelection.fromMap(
    await _channel.invokeMethod<Map<Object?, Object?>>('selection'),
  );

  @override
  Future<ShieldSelection?> choose() async {
    final t = LocaleSettings.instance.currentTranslations;
    final chosen = await _channel.invokeMethod<Map<Object?, Object?>>(
      'choose',
      {
        'texts': {
          'title': t.seekFirst.apps,
          'done': t.common.done,
          'cancel': t.common.cancel,
        },
      },
    );
    return chosen == null ? null : ShieldSelection.fromMap(chosen);
  }

  @override
  Future<void> configure({
    required bool enabled,
    required int startMinutes,
    required int pausesPerDay,
    required Map<String, String> texts,
  }) => _channel.invokeMethod<void>('configure', {
    'enabled': enabled,
    'startMinutes': startMinutes,
    'pausesPerDay': pausesPerDay,
    'texts': texts,
  });

  @override
  Future<void> unlock(DateTime day) =>
      _channel.invokeMethod<void>('unlock', {'day': dayKey(day)});

  @override
  Future<int> pausesLeft() async =>
      await _channel.invokeMethod<int>('pausesLeft') ?? 0;
}

/// Screen Time needs iOS 16: AppShield.swift says whether this phone has it;
/// SeekFirstChannel.kt answers on Android.
Future<bool> _nativeShieldAvailable() async {
  try {
    return await const MethodChannel(
          'cmficonnect/shield',
        ).invokeMethod<bool>('available') ??
        false;
  } on MissingPluginException {
    return false;
  } on PlatformException {
    return false;
  }
}

@Riverpod(keepAlive: true)
Future<AppShield> appShield(Ref ref) async {
  if (kIsWeb ||
      (defaultTargetPlatform != TargetPlatform.iOS &&
          defaultTargetPlatform != TargetPlatform.android)) {
    return const NoAppShield();
  }
  return await _nativeShieldAvailable()
      ? const NativeAppShield()
      : const NoAppShield();
}
