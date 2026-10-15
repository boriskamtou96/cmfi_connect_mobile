import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/flavor.dart';
import '../utils/date_extensions.dart';
import 'app_log.dart';

part 'home_widgets.g.dart';

/// What the "Aujourd'hui" widget of the home screen shows. The texts come
/// in the app language: the widget is drawn by the phone (iOS WidgetKit,
/// Android AppWidget), not by Flutter.
class TodayWidgetData {
  const TodayWidgetData({
    required this.signedIn,
    required this.premium,
    required this.day,
    required this.done,
    required this.filled,
    required this.total,
    required this.goalPercent,
    required this.texts,
  });

  /// Signed out: the widget asks to sign in, nothing of the account stays.
  const TodayWidgetData.signedOut({required this.texts})
    : signedIn = false,
      premium = false,
      day = null,
      done = false,
      filled = 0,
      total = 0,
      goalPercent = null;

  final bool signedIn;

  /// The widget comes with Premium: without it, it says so.
  final bool premium;

  /// The day of these values: the next day the widget shows "to fill in"
  /// by itself, even if the app wasn't opened.
  final DateTime? day;

  /// The day is saved (sent, or kept on the phone without network).
  final bool done;
  final int filled;
  final int total;

  /// 0 to 100; null without goals.
  final int? goalPercent;

  /// title, done, todo, goals, items ("8 sur 12"), open, locked, signedOut.
  final Map<String, String> texts;

  Map<String, Object?> toStorage() => {
    'signed_in': signedIn,
    'premium': premium,
    'day': day?.toApiDate() ?? '',
    'done': done,
    'filled': filled,
    'total': total,
    'goal_percent': goalPercent ?? -1,
    for (final MapEntry(:key, :value) in texts.entries) 'text_$key': value,
  };
}

/// What the "Verset du jour" widget shows: the verses of the next days (it
/// turns to the next one at midnight by itself), in the app language.
class VerseWidgetData {
  const VerseWidgetData({
    required this.days,
    required this.source,
    required this.title,
    required this.rightToLeft,
  });

  final Map<DateTime, ({String text, String reference})> days;

  /// The Bible they come from ("Louis Segond 1910").
  final String source;

  /// "Verset du jour".
  final String title;

  /// Arabic: written from right to left.
  final bool rightToLeft;

  Map<String, Object?> toStorage() => {
    'verse_days': jsonEncode({
      for (final MapEntry(:key, :value) in days.entries)
        key.toApiDate(): {'text': value.text, 'ref': value.reference},
    }),
    'verse_source': source,
    'verse_title': title,
    'verse_rtl': rightToLeft,
  };
}

/// Hands the data to the widgets of the phone, and tells which widget link
/// opened the app ("cmficonnect://today", "cmficonnect://premium",
/// "cmficonnect://verse").
abstract class HomeWidgets {
  Future<void> show(TodayWidgetData data);

  Future<void> showVerses(VerseWidgetData data);

  Future<Uri?> takeLaunchUri();

  Stream<Uri?> get clicks;
}

class NoHomeWidgets implements HomeWidgets {
  const NoHomeWidgets();

  @override
  Future<void> show(TodayWidgetData data) async {}

  @override
  Future<void> showVerses(VerseWidgetData data) async {}

  @override
  Future<Uri?> takeLaunchUri() async => null;

  @override
  Stream<Uri?> get clicks => const Stream.empty();
}

class NativeHomeWidgets implements HomeWidgets {
  NativeHomeWidgets(this._flavor);

  /// The kind of the iOS widget (TodayWidget.swift).
  static const iOSName = 'TodayWidget';

  /// The provider of the Android widget (TodayWidgetProvider.kt).
  static const androidName = 'com.example.cmfi_connect.TodayWidgetProvider';

  /// The "Verset du jour" widget (VerseWidget.swift, VerseWidgetProvider.kt).
  static const verseIOSName = 'VerseWidget';
  static const verseAndroidName =
      'com.example.cmfi_connect.VerseWidgetProvider';

  final Flavor _flavor;
  Future<void>? _ready;
  var _launchTaken = false;

  /// Shared with the widget extension (Runner.entitlements, TodayWidget).
  String get _appGroup => switch (_flavor) {
    Flavor.dev => 'group.com.cmficonnect.app.dev',
    Flavor.prod => 'group.com.cmficonnect.app',
  };

  Future<void> _init() => _ready ??= HomeWidget.setAppGroupId(_appGroup);

  @override
  Future<void> show(TodayWidgetData data) async {
    try {
      await _init();
      for (final MapEntry(:key, :value) in data.toStorage().entries) {
        await HomeWidget.saveWidgetData<Object>(key, value);
      }
      await HomeWidget.updateWidget(
        iOSName: iOSName,
        qualifiedAndroidName: androidName,
      );
      // Android: the widget turns to the new day at midnight on its own
      if (defaultTargetPlatform == TargetPlatform.android) {
        final now = DateTime.now();
        await HomeWidget.scheduleWidgetUpdates([
          DateTime(now.year, now.month, now.day + 1, 0, 1),
        ], qualifiedAndroidName: androidName);
      }
    } on Object catch (error) {
      // no widget on this phone (or no app group yet): nothing to show
      AppLog.info('home widget not updated: $error');
    }
  }

  @override
  Future<void> showVerses(VerseWidgetData data) async {
    try {
      await _init();
      for (final MapEntry(:key, :value) in data.toStorage().entries) {
        await HomeWidget.saveWidgetData<Object>(key, value);
      }
      await HomeWidget.updateWidget(
        iOSName: verseIOSName,
        qualifiedAndroidName: verseAndroidName,
      );
      // Android: the next verse at midnight, without the app
      if (defaultTargetPlatform == TargetPlatform.android) {
        final now = DateTime.now();
        await HomeWidget.scheduleWidgetUpdates([
          DateTime(now.year, now.month, now.day + 1, 0, 1),
        ], qualifiedAndroidName: verseAndroidName);
      }
    } on Object catch (error) {
      AppLog.info('verse widget not updated: $error');
    }
  }

  @override
  Future<Uri?> takeLaunchUri() async {
    if (_launchTaken) {
      return null;
    }
    _launchTaken = true;
    await _init();
    return HomeWidget.initiallyLaunchedFromHomeWidget();
  }

  @override
  Stream<Uri?> get clicks => HomeWidget.widgetClicked;
}

@Riverpod(keepAlive: true)
HomeWidgets homeWidgets(Ref ref) =>
    kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.iOS &&
            defaultTargetPlatform != TargetPlatform.android)
    ? const NoHomeWidgets()
    : NativeHomeWidgets(ref.watch(flavorProvider));
