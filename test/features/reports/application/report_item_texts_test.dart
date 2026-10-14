import 'package:cmfi_connect/src/core/i18n/languages.dart';
import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/reports/application/report_item_texts.dart';
import 'package:cmfi_connect/src/features/reports/domain/measure_format.dart';
import 'package:cmfi_connect/src/features/reports/domain/standard_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(setUpLanguages);

  group('standard items', () {
    final fr = AppLocale.fr.buildSync();
    final en = AppLocale.en.buildSync();
    final ar = AppLocale.ar.buildSync();

    test('are recognized by their exact code', () {
      expect(StandardItem.of('LB'), StandardItem.bibleReading);
      expect(StandardItem.of('Dîmes'), StandardItem.tithes);
      // personal codes are A-Z, 0-9 and _: "DIMES" is someone's own item
      expect(StandardItem.of('DIMES'), isNull);
      expect(StandardItem.of('lb'), isNull);
      // the server says it is personal: the code doesn't matter
      expect(StandardItem.of('LB', standard: false), isNull);
    });

    test('every one has a name in every language', () {
      for (final locale in AppLocale.values) {
        final t = locale.buildSync();
        for (final item in StandardItem.values) {
          expect(t.itemLabel(item.code, 'x'), isNot('x'));
          expect(t.itemLabel(item.code, 'x'), isNotEmpty);
        }
      }
    });

    test('names follow the app language, personal items stay as typed', () {
      expect(en.itemLabel('LB', 'Lecture biblique'), 'Bible reading');
      expect(en.itemLabel('Dîmes', 'Dîmes'), 'Tithes');
      expect(
        fr.itemLabel('LLC', 'Lecture de la littérature chrétienne'),
        'Lecture de la littérature chrétienne',
      );
      expect(en.itemLabel('RQDQA', 'RQDQA'), 'RQDQA');
      expect(
        en.itemLabel('LB', 'Lecture biblique', standard: false),
        'Lecture biblique',
      );
    });

    test('units are counted with the plural of the language', () {
      String value(Translations t, String code, int n) => MeasureFormat.value(
        quantity: n,
        unit: t.itemUnit(code, 'whatever the server says'),
      );
      expect(value(fr, 'LB', 1), '1 chapitre');
      expect(value(fr, 'LB', 4), '4 chapitres');
      expect(value(en, 'LB', 1), '1 chapter');
      expect(value(en, 'LB', 4), '4 chapters');
      expect(value(en, 'JC', 2), '2 times');
      expect(value(en, 'LLC', 12), '12 pages');
      expect(value(fr, 'OFF', 10), '10 %');
      expect(value(en, 'OFF', 10), '10%');
      expect(value(ar, 'LB', 2), 'فصلان');
      expect(value(ar, 'LB', 5), '5 فصول');
      // a personal unit stays as typed
      expect(
        MeasureFormat.value(
          quantity: 2,
          unit: en.itemUnit('RQDQA', 'Nombre de fois'),
        ),
        '2 fois',
      );
    });

    test('subtitles and titles are translated as well', () {
      final times = en.itemUnit('RDQAD', 'Nombre de fois')!;
      expect(times.name, 'Number of times');
      expect(times.label, 'times');
      expect(en.itemUnit('Dîmes', 'Pourcentage')!.symbol, '%');
      expect(fr.itemUnit('LB', 'chapitres')!.label, 'chapitres');
      // prayer alone only counts minutes
      expect(en.itemUnit('PS', null), isNull);
      // a written average decides the plural
      expect(
        en.itemUnit('LB', null)!.count(1.5, number: '1.5'),
        '1.5 chapters',
      );
    });
  });
}
