import 'dart:convert';
import 'dart:io';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/verses/domain/verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  test('every language has a verse for every day, 29 February included', () {
    for (final language in ['fr', 'en', 'es', 'de', 'zh', 'ar', 'hi']) {
      final calendar = VerseCalendar.fromJson(
        File('assets/verses/verses_$language.json').readAsStringSync(),
      );
      expect(calendar.days, hasLength(366), reason: language);
      expect(calendar.source, isNotEmpty);
      for (
        var day = DateTime(2024);
        day.year == 2024;
        day = day.add(const Duration(days: 1))
      ) {
        expect(calendar.of(day)?.text, isNotEmpty, reason: '$language $day');
      }
    }
    // the same verse for everyone on Christmas, numbered in each Bible
    final fr = VerseCalendar.fromJson(
      File('assets/verses/verses_fr.json').readAsStringSync(),
    );
    final en = VerseCalendar.fromJson(
      File('assets/verses/verses_en.json').readAsStringSync(),
    );
    expect(fr.of(DateTime(2026, 12, 25))?.reference, 'Luc 2.11');
    expect(en.of(DateTime(2026, 12, 25))?.reference, 'Luke 2:11');
  });

  testWidgets("today's verse on the home screen, shared as text", (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    final now = DateTime.now();
    final key =
        '${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final today =
        (jsonDecode(File('assets/verses/verses_fr.json').readAsStringSync())
                as Map<String, dynamic>)['days'][key]
            as Map<String, dynamic>;

    await tester.scrollUntilVisible(
      find.text('VERSET DU JOUR'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text(today['text'] as String), findsOneWidget);
    expect(find.text(today['ref'] as String), findsOneWidget);

    await tester.tap(find.byTooltip('Partager le verset'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Partager le texte'));
    await tester.pumpAndSettle();
    expect(app.share.texts.single, contains(today['text'] as String));
    expect(app.share.texts.single, contains(today['ref'] as String));
  });
}
