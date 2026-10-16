import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/app_shield.dart';
import '../../../core/storage/preferences.dart';

part 'seek_first.g.dart';

/// « Cherche d'abord Dieu » as the member set it, and what the phone says.
@immutable
class SeekFirstState {
  const SeekFirstState({
    required this.supported,
    required this.enabled,
    required this.start,
    this.selection = const ShieldSelection(),
    this.pausesLeft = 0,
  });

  /// false where the phone can't close apps (Android for now).
  final bool supported;
  final bool enabled;

  /// From when the apps close each day.
  final TimeOfDay start;
  final ShieldSelection selection;
  final int pausesLeft;

  SeekFirstState copyWith({
    bool? enabled,
    TimeOfDay? start,
    ShieldSelection? selection,
    int? pausesLeft,
  }) => SeekFirstState(
    supported: supported,
    enabled: enabled ?? this.enabled,
    start: start ?? this.start,
    selection: selection ?? this.selection,
    pausesLeft: pausesLeft ?? this.pausesLeft,
  );
}

enum SeekFirstOutcome { enabled, denied, noApps }

/// The settings stay on the phone (and leave with the account at sign-out);
/// the phone keeps the apps chosen and closes them (AppShield).
@Riverpod(keepAlive: true)
class SeekFirst extends _$SeekFirst {
  static const pausesPerDay = 3;
  static const defaultStart = TimeOfDay(hour: 5, minute: 0);
  static const _enabledKey = 'seek_first_enabled';
  static const _startKey = 'seek_first_start';

  @override
  Future<SeekFirstState> build() async {
    final shield = await ref.watch(appShieldProvider.future);
    final preferences = ref.watch(sharedPreferencesProvider);
    final minutes = preferences.getInt(_startKey);
    final start = minutes == null
        ? defaultStart
        : TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
    if (!shield.supported) {
      return SeekFirstState(supported: false, enabled: false, start: start);
    }
    return SeekFirstState(
      supported: true,
      enabled: preferences.getBool(_enabledKey) ?? false,
      start: start,
      selection: await shield.selection(),
      pausesLeft: await shield.pausesLeft(),
    );
  }

  Future<AppShield> get _shield => ref.read(appShieldProvider.future);

  /// Asks Screen Time access, then the apps when none is chosen yet.
  Future<SeekFirstOutcome> enable() async {
    final shield = await _shield;
    if (!await shield.authorized() && !await shield.authorize()) {
      return SeekFirstOutcome.denied;
    }
    var current = await future;
    if (current.selection.isEmpty) {
      final chosen = await shield.choose();
      if (chosen == null || chosen.isEmpty) {
        return SeekFirstOutcome.noApps;
      }
      current = current.copyWith(selection: chosen);
    }
    await ref.read(sharedPreferencesProvider).setBool(_enabledKey, true);
    state = AsyncData(current.copyWith(enabled: true));
    await sync();
    return SeekFirstOutcome.enabled;
  }

  Future<void> disable() async {
    await ref.read(sharedPreferencesProvider).setBool(_enabledKey, false);
    final current = await future;
    state = AsyncData(current.copyWith(enabled: false));
    await sync();
  }

  /// The system's list of apps, again.
  Future<void> choose() async {
    final shield = await _shield;
    if (!await shield.authorized() && !await shield.authorize()) {
      return;
    }
    final chosen = await shield.choose();
    if (chosen == null) {
      return;
    }
    final current = await future;
    state = AsyncData(current.copyWith(selection: chosen));
    await sync();
  }

  Future<void> setStart(TimeOfDay start) async {
    await ref
        .read(sharedPreferencesProvider)
        .setInt(_startKey, start.hour * 60 + start.minute);
    final current = await future;
    state = AsyncData(current.copyWith(start: start));
    await sync();
  }

  /// Gives the phone the settings and the texts in the app language: after
  /// a change, at each launch, when the language changes.
  Future<void> sync() async {
    final shield = await _shield;
    if (!shield.supported) {
      return;
    }
    final current = await future;
    await shield.configure(
      enabled: current.enabled && !current.selection.isEmpty,
      startMinutes: current.start.hour * 60 + current.start.minute,
      pausesPerDay: pausesPerDay,
      texts: shieldTexts(),
    );
    final pauses = await shield.pausesLeft();
    if (ref.mounted) {
      state = AsyncData(current.copyWith(pausesLeft: pauses));
    }
  }

  /// [day]'s report is saved (or waits to be sent): the apps open.
  Future<void> reportSaved(DateTime day) async {
    final shield = await _shield;
    if (shield.supported) {
      await shield.unlock(day);
    }
  }

  /// Signing out: nothing stays closed, and the settings go with the account.
  Future<void> forget() async {
    final preferences = ref.read(sharedPreferencesProvider);
    await preferences.remove(_enabledKey);
    await preferences.remove(_startKey);
    final shield = await _shield;
    if (shield.supported) {
      await shield.configure(
        enabled: false,
        startMinutes: defaultStart.hour * 60,
        pausesPerDay: pausesPerDay,
        texts: shieldTexts(),
      );
    }
    ref.invalidateSelf();
  }
}

/// What a closed app says (ShieldConfig, ShieldActions), in the app
/// language: "{app}" and "{n}" are filled in on the phone.
Map<String, String> shieldTexts() {
  final t = LocaleSettings.instance.currentTranslations.seekFirst.shield;
  return {
    'title': t.title,
    'subtitle': t.subtitle(app: '{app}'),
    'thisApp': t.thisApp,
    'fill': t.fill,
    'pause': t.pause(n: '{n}'),
    'notificationTitle': t.notificationTitle,
    'notificationBody': t.notificationBody,
  };
}
