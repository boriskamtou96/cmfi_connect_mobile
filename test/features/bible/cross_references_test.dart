import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/bible/application/cross_references.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  test('the passages of a verse, the most voted first', () {
    final all = CrossReferences.parse(
      '# OpenBible.info (CC-BY)\n'
      'JHN.3.16\tROM.5.8;1JN.4.9-10;JHN.3.15\n'
      'JHN.3.17\tROM.5.8;JHN.12.47\n',
    );
    expect(all.of(const BibleRef('JHN', 3, 16)), [
      const CrossReference(BibleRef('ROM', 5, 8)),
      const CrossReference(BibleRef('1JN', 4, 9), 10),
      const CrossReference(BibleRef('JHN', 3, 15)),
    ]);
    expect(const CrossReference(BibleRef('1JN', 4, 9), 10).verses, [9, 10]);
    // two verses: each passage once, not the verses themselves
    expect(
      all.ofAll(const [BibleRef('JHN', 3, 15), BibleRef('JHN', 3, 16)]),
      hasLength(2),
    );
    expect(all.of(const BibleRef('GEN', 1, 2)), isEmpty);
  });

  testWidgets('kept in the app: about 20 000 verses', (tester) async {
    final file = await tester.runAsync(
      () => DefaultAssetBundle.of(
        tester.binding.rootElement!,
      ).loadString('assets/bible/cross_references.tsv'),
    );
    final all = CrossReferences.parse(file!);
    expect(
      all.of(const BibleRef('JHN', 3, 16)).first.start,
      const BibleRef('ROM', 5, 8),
    );
    expect(all.of(const BibleRef('GEN', 1, 1)), hasLength(12));
  });

  testWidgets('under a selected verse, opened in the Bible', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {
        'bible_tap_hint_seen': true,
        'bible_position': 'JHN.3',
      },
    );
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Bible'),
      ),
    );
    await tester.pumpAndSettle();
    final verse = find.textContaining(
      'Car Dieu a tant aimé',
      findRichText: true,
    );
    await tester.ensureVisible(verse);
    await tester.pumpAndSettle();
    await tester.tap(verse);
    await tester.pumpAndSettle();

    // the file is read for real (rootBundle): beforehand
    await tester.runAsync(
      () => app.container.read(crossReferencesProvider.future),
    );
    await tester.tap(find.byTooltip('Références croisées'));
    await tester.pumpAndSettle();
    expect(find.text('Références croisées · Jean 3:16'), findsOneWidget);
    expect(find.text('Source : OpenBible.info (CC-BY)'), findsOneWidget);
    // a passage of the sample Bible, with its words
    expect(find.text('1 Jean 4:9-10'), findsOneWidget);
  });
}
