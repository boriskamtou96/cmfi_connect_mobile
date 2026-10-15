import 'dart:convert';

/// The verse of a day: its text and reference ("Jean 3.16") in the app's
/// language, the Bible it comes from (shown under it: some licences ask for
/// it), and where it is ("JHN.3.16": the book's USFM code, the chapter and the
/// verse, as numbered in that Bible) to open it in the Bible.
typedef Verse = ({String text, String reference, String source, String? osis});

/// One verse per day of the year, the same for everyone ("MM-dd", 29 February
/// included), as written in `assets/verses/verses_<language>.json` by the
/// script that picks them (public domain Bibles; the Hindi one under
/// CC BY-SA 4.0).
class VerseCalendar {
  const VerseCalendar({required this.source, required this.days});

  factory VerseCalendar.fromJson(String raw) {
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final days = json['days'] as Map<String, dynamic>;
    return VerseCalendar(
      source: json['source'] as String,
      days: {
        for (final MapEntry(:key, :value) in days.entries)
          key: (
            text: (value as Map<String, dynamic>)['text'] as String,
            reference: value['ref'] as String,
            osis: value['osis'] as String?,
          ),
      },
    );
  }

  final String source;
  final Map<String, ({String text, String reference, String? osis})> days;

  /// The verse of [day]; any day has one.
  Verse? of(DateTime day) {
    final key =
        '${day.month.toString().padLeft(2, '0')}-'
        '${day.day.toString().padLeft(2, '0')}';
    final verse = days[key];
    return verse == null
        ? null
        : (
            text: verse.text,
            reference: verse.reference,
            source: source,
            osis: verse.osis,
          );
  }
}
