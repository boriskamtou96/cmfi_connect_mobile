import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/verse.dart';

part 'verse_of_the_day.g.dart';

/// The languages with a verse calendar; another one reads the English.
const _languages = {'fr', 'en', 'es', 'de', 'zh', 'ar', 'hi'};

/// The calendar of [language], read once from the assets.
@Riverpod(keepAlive: true)
Future<VerseCalendar> verseCalendar(Ref ref, String language) async {
  final code = _languages.contains(language) ? language : 'en';
  // decoded here: loadString hands files over 50 KB to another isolate,
  // which is not worth it for ~100 KB
  final data = await rootBundle.load('assets/verses/verses_$code.json');
  return VerseCalendar.fromJson(utf8.decode(data.buffer.asUint8List()));
}

/// Today's verse in the app's language (the same for everyone that day).
@riverpod
Future<Verse?> verseOfTheDay(Ref ref) async {
  // read again when the language of the app changes
  ref.watch(savedLanguageProvider);
  final language = LocaleSettings.currentLocale.languageCode;
  final calendar = await ref.watch(verseCalendarProvider(language).future);
  return calendar.of(today());
}
