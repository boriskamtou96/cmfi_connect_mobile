import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/verse_flight.dart';

part 'flight_verses.g.dart';

/// The languages with a verse calendar (assets/verses); another one flies
/// with the English verses.
const _languages = {'fr', 'en', 'es', 'de', 'zh', 'ar', 'hi'};

/// The verses of « Verset en vol » in [language]: those of the verse of the
/// day (366, in the Bibles of the app) short enough to fly through. Read from
/// the assets here, the games not reaching into the verses feature.
@Riverpod(keepAlive: true)
Future<List<FlightVerse>> flightVerses(Ref ref, String language) async {
  final code = _languages.contains(language) ? language : 'en';
  final data = await rootBundle.load('assets/verses/verses_$code.json');
  final json =
      jsonDecode(utf8.decode(data.buffer.asUint8List()))
          as Map<String, dynamic>;
  return [
    for (final day in (json['days'] as Map<String, dynamic>).values)
      if (day case {
        'text': final String text,
        'ref': final String reference,
      } when fitsFlight(text, language: code))
        (text: text, reference: reference),
  ];
}
