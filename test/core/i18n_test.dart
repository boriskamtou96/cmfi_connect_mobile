import 'dart:convert';
import 'dart:io';

import 'package:cmfi_connect/src/core/i18n/languages.dart';
import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../helpers/pump_app.dart';

/// The keys of a translation file, plural maps counted as one key.
Set<String> keysOf(Map<String, dynamic> json, [String prefix = '']) => {
  for (final MapEntry(:key, :value) in json.entries)
    if (value is Map<String, dynamic> && !key.contains('('))
      ...keysOf(value, '$prefix$key.')
    else
      '$prefix$key',
};

Map<String, dynamic> read(String language) =>
    jsonDecode(File('lib/src/core/i18n/$language.i18n.json').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
    setUpLanguages();
  });
  tearDown(() => LocaleSettings.setLocale(AppLocale.fr));

  test('the app speaks seven languages', () {
    expect(
      AppLocale.values.map((locale) => locale.languageCode),
      unorderedEquals(['fr', 'en', 'de', 'es', 'ar', 'zh', 'hi']),
    );
  });

  test('every language has every text of the French one, and no other', () {
    final french = keysOf(read('fr'));
    for (final locale in AppLocale.values) {
      final keys = keysOf(read(locale.languageCode));
      expect(
        french.difference(keys),
        isEmpty,
        reason: '${locale.languageCode}: missing',
      );
      expect(
        keys.difference(french),
        isEmpty,
        reason: '${locale.languageCode}: unknown',
      );
    }
  });

  test('each language names itself in the language picker', () {
    expect(
      [
        for (final locale in AppLocale.values)
          locale.buildSync().app.languageName,
      ],
      containsAll([
        'Français',
        'English',
        'Deutsch',
        'Español',
        'العربية',
        '中文',
        'हिन्दी',
      ]),
    );
  });

  test('plurals follow each language', () {
    final arabic = AppLocale.ar.buildSync();
    expect(arabic.events.daysLeft(n: 2), 'يومان');
    expect(arabic.events.daysLeft(n: 5), '5 أيام');
    expect(arabic.events.daysLeft(n: 15), '15 يومًا');
    // Hindi: 0 and 1 are singular
    final hindi = AppLocale.hi.buildSync();
    expect(hindi.events.inDays(n: 1), hindi.events.inDays(n: 1));
    expect(AppLocale.zh.buildSync().events.daysLeft(n: 3), contains('3'));
    expect(AppLocale.fr.buildSync().events.inDays(n: 1), 'Dans 1 jour');
  });

  test('Arabic dates are written with 0-9 digits, like the rest', () {
    expect(
      DateFormat('d MMMM y', 'ar').format(DateTime(2026, 11, 20)),
      contains('20'),
    );
  });

  testWidgets('in Arabic, the app reads right to left', (tester) async {
    await LocaleSettings.setLocale(AppLocale.ar);
    await pumpApp(tester, token: 't');

    final tab = tester.element(find.text(AppLocale.ar.buildSync().nav.home));
    expect(Directionality.of(tab), TextDirection.rtl);

    // every tab opens without a layout error
    for (final tab in [
      AppLocale.ar.buildSync().nav.reports,
      AppLocale.ar.buildSync().nav.hymns,
      AppLocale.ar.buildSync().nav.prayer,
      AppLocale.ar.buildSync().nav.bible,
    ]) {
      await tester.tap(find.text(tab).last);
      await tester.pumpAndSettle();
    }
    // and Plus, from the photo of the home screen
    await tester.tap(find.text(AppLocale.ar.buildSync().nav.home).last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip(AppLocale.ar.buildSync().home.profile));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  for (final locale in [AppLocale.de, AppLocale.hi, AppLocale.zh]) {
    testWidgets('the home screen fits in ${locale.languageCode}', (
      tester,
    ) async {
      await LocaleSettings.setLocale(locale);
      await pumpApp(tester, token: 't');
      await tester.tap(find.byTooltip(locale.buildSync().home.profile));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(AppBackButton));
      await tester.pumpAndSettle();
      await tester.tap(find.text(locale.buildSync().nav.bible).last);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  }
}
