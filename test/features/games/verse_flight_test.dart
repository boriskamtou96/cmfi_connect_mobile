import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/games/domain/verse_flight.dart';
import 'package:cmfi_connect/src/features/games/presentation/verse_flight_screen.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

const _verse = (
  text: 'Je puis tout par celui qui me fortifie.',
  reference: 'Philippiens 4.13',
);

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  test('a verse is cut in words, its punctuation kept', () {
    expect(flightWords(_verse.text, language: 'fr'), [
      'Je',
      'puis',
      'tout',
      'par',
      'celui',
      'qui',
      'me',
      'fortifie.',
    ]);
    expect(fitsFlight(_verse.text, language: 'fr'), isTrue);
    expect(fitsFlight('Jésus pleura.', language: 'fr'), isFalse);
  });

  test('Chinese, without spaces, is cut in pieces of three characters', () {
    expect(flightWords('神爱世人，甚至将他的独生子赐给他们。', language: 'zh'), [
      '神爱世',
      '人，',
      '甚至将',
      '他的独',
      '生子赐',
      '给他们',
      '。',
    ]);
  });

  test('the words are caught in order; a wrong one costs a heart', () {
    var flight = VerseFlight.of(_verse, language: 'fr');
    Catch result;

    (flight, result) = flight.meet(0);
    expect(result, Catch.right);
    expect(flight.caught, 1);

    (flight, result) = flight.meet(5);
    expect(result, Catch.wrong);
    expect((flight.caught, flight.hearts), (1, 2));

    for (var i = 1; i < 7; i++) {
      (flight, result) = flight.meet(i);
      expect(result, Catch.right);
    }
    (flight, result) = flight.meet(7);
    expect(result, Catch.won);
    expect(flight.won, isTrue);
    expect(flight.next, isNull);
  });

  test('three wrong words and the flight is lost', () {
    var flight = VerseFlight.of(_verse, language: 'fr');
    var result = Catch.right;
    for (var i = 0; i < 3; i++) {
      (flight, result) = flight.meet(4);
    }
    expect(result, Catch.lost);
    expect(flight.lost, isTrue);
    // nothing more happens
    expect(flight.meet(0).$2, Catch.lost);
  });

  testWidgets('the game opens on a verse to build, three hearts and the hint', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    // ignore: unawaited_futures
    app.container.read(appRouterProvider).push(const VerseFlightRoute());
    // the game never settles: its frames are pumped one by one
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    expect(find.byType(VerseFlightScreen), findsOneWidget);
    expect(find.text('Verset en vol'), findsOneWidget);
    expect(find.bySemanticsLabel('3 cœurs'), findsOneWidget);
    expect(
      find.textContaining('Touche au-dessus ou au-dessous'),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Terminer'));
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.byType(VerseFlightScreen), findsNothing);
  });
}
