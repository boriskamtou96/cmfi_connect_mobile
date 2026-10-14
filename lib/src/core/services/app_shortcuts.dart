import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_shortcuts.g.dart';

/// The shortcuts of the app icon (long press), set while signed in.
enum AppShortcut {
  /// Fill in today's report.
  today('ic_shortcut_today'),

  /// The Hymns tab.
  hymns('ic_shortcut_hymns'),

  /// The retreat of the moment (the Prayer tab once the four are done).
  retreat('ic_shortcut_retreat');

  const AppShortcut(this.androidIcon);

  /// res/drawable of the Android app. iOS shows none: the plugin only takes
  /// images of the asset catalog.
  final String androidIcon;

  static AppShortcut? tryParse(String? type) => values.asNameMap()[type];
}

/// The shortcuts of the app icon (quick_actions), with their titles in the
/// app language. Behind a provider: tests use a fake.
abstract class AppShortcuts {
  Future<void> show(Map<AppShortcut, String> titles);

  /// Signing out: no shortcut into an account that is gone.
  Future<void> clear();

  /// The shortcut the app was opened with, once (null when none or already
  /// handed out on [taps]).
  Future<AppShortcut?> takeLaunchShortcut();

  /// Shortcuts touched while the app runs (and the launch one, when it
  /// arrives after listening).
  Stream<AppShortcut> get taps;
}

class NoAppShortcuts implements AppShortcuts {
  const NoAppShortcuts();

  @override
  Future<void> show(Map<AppShortcut, String> titles) async {}

  @override
  Future<void> clear() async {}

  @override
  Future<AppShortcut?> takeLaunchShortcut() async => null;

  @override
  Stream<AppShortcut> get taps => const Stream.empty();
}

class NativeAppShortcuts implements AppShortcuts {
  NativeAppShortcuts();

  final _quickActions = const QuickActions();
  final _taps = StreamController<AppShortcut>.broadcast();
  Future<void>? _ready;

  /// Touched before anyone listened (the launch shortcut).
  AppShortcut? _waiting;

  Future<void> _init() => _ready ??= () async {
    try {
      await _quickActions.initialize(_touched);
    } on Object catch (error) {
      debugPrint('App shortcuts unavailable: $error');
    }
  }();

  void _touched(String type) {
    final shortcut = AppShortcut.tryParse(type);
    if (shortcut == null) {
      return;
    }
    if (_taps.hasListener) {
      _taps.add(shortcut);
    } else {
      _waiting = shortcut;
    }
  }

  @override
  Future<void> show(Map<AppShortcut, String> titles) async {
    await _init();
    try {
      await _quickActions.setShortcutItems([
        for (final MapEntry(key: shortcut, value: title) in titles.entries)
          ShortcutItem(
            type: shortcut.name,
            localizedTitle: title,
            icon: defaultTargetPlatform == TargetPlatform.android
                ? shortcut.androidIcon
                : null,
          ),
      ]);
    } on Object catch (error) {
      debugPrint('App shortcuts not set: $error');
    }
  }

  @override
  Future<void> clear() async {
    await _init();
    try {
      await _quickActions.clearShortcutItems();
    } on Object catch (error) {
      debugPrint('App shortcuts not cleared: $error');
    }
  }

  @override
  Future<AppShortcut?> takeLaunchShortcut() async {
    await _init();
    final shortcut = _waiting;
    _waiting = null;
    return shortcut;
  }

  @override
  Stream<AppShortcut> get taps => _taps.stream;
}

@Riverpod(keepAlive: true)
AppShortcuts appShortcuts(Ref ref) =>
    kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.iOS &&
            defaultTargetPlatform != TargetPlatform.android)
    ? const NoAppShortcuts()
    : NativeAppShortcuts();
