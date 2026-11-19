import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/storage/preferences.dart';
import '../domain/flight_journey.dart';
import '../domain/verse_flight.dart';

part 'flight_journey.g.dart';

/// The languages the verses of the journey are written in; another one
/// flies with the English verses.
const _languages = {'fr', 'en', 'es', 'de', 'zh', 'ar', 'hi'};

/// The verses of « La conquête de Canaan » in [language], one per stage, in
/// the order of [canaanStages], and the Bible they come from (shown with
/// the verse: the Hindi one asks to be named).
typedef JourneyVerses = ({List<FlightVerse> verses, String source});

@Riverpod(keepAlive: true)
Future<JourneyVerses> journeyVerses(Ref ref, String language) async {
  final code = _languages.contains(language) ? language : 'en';
  final data = await rootBundle.load('assets/games/journey_canaan.json');
  final json =
      jsonDecode(utf8.decode(data.buffer.asUint8List()))
          as Map<String, dynamic>;
  final book = json[code] as Map<String, dynamic>;
  final byOsis = {
    for (final verse in book['verses'] as List<dynamic>)
      if (verse case {
        'osis': final String osis,
        'text': final String text,
        'ref': final String reference,
      })
        osis: (text: text, reference: reference),
  };
  return (
    verses: [for (final stage in canaanStages) byOsis[stage.osis]!],
    source: book['source'] as String,
  );
}

/// Where the player stands on « La conquête de Canaan »: kept on the phone
/// (key `flight_journey`), at sign-out too, like the bookmark of the Bible.
/// No points from the server: the journey is played to keep the Word.
@Riverpod(keepAlive: true)
class FlightJourney extends _$FlightJourney {
  static const _key = 'flight_journey';

  @override
  JourneyProgress build() => JourneyProgress.parse(
    ref.watch(sharedPreferencesProvider).getString(_key),
    length: canaanStages.length,
  );

  /// [stage] won with [hearts] left: the next stage opens, the best score
  /// of a stage played again stays.
  Future<void> won(int stage, int hearts) async {
    final after = state.won(stage, hearts);
    if (identical(after, state)) {
      return;
    }
    state = after;
    await ref.read(sharedPreferencesProvider).setString(_key, after.saved);
  }
}
