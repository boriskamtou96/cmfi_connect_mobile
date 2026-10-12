import 'prayer.dart';

/// The 15-minute retreats of the community (the leaflet "Retraites de prière
/// de 15'"): four a day, fifteen points each, one minute per point. The texts
/// are in `assets/prayer/retreats_<language>.json`; what the app adds to a
/// point (the user's assembly, the next names of a list, the country of the
/// day…) is described here, the same in every language.

const retreatPoints = 15;
const retreatMinutes = 15;

/// What the app shows under a point, filled from the user's data.
sealed class RetreatHint {
  const RetreatHint();
}

/// "Pray for your assembly": the assembly of the profile.
class AssemblyHint extends RetreatHint {
  const AssemblyHint();
}

/// "Pray for the spiritual leaders": the user's authorities.
class AuthoritiesHint extends RetreatHint {
  const AuthoritiesHint();
}

/// Five people of a list, taken in turn: [group] 0 the next five, 1 the five
/// after them (two points of the same retreat).
class ListHint extends RetreatHint {
  const ListHint(this.list, {this.group = 0});

  final PrayerList list;
  final int group;
}

/// A country or a people of the day, from a list of the content file.
class NationHint extends RetreatHint {
  const NationHint(this.kind);

  final NationKind kind;
}

/// "The leaders of your country": the country of the profile.
class MyCountryHint extends RetreatHint {
  const MyCountryHint();
}

/// "Sing a hymn": opens the hymn book.
class HymnHint extends RetreatHint {
  const HymnHint();
}

/// The lists of the content file, one taken each day.
enum NationKind { unreached, muslim, hindu, peoples }

/// What the app adds to each point (1-based), by retreat.
const retreatHints = <RetreatMoment, Map<int, RetreatHint>>{
  RetreatMoment.morning: {15: HymnHint()},
  RetreatMoment.noon: {
    3: AssemblyHint(),
    4: AuthoritiesHint(),
    5: ListHint(PrayerList.unbelievers),
    6: ListHint(PrayerList.unbelievers, group: 1),
    7: ListHint(PrayerList.believers),
    8: ListHint(PrayerList.backsliders),
    13: NationHint(NationKind.unreached),
    14: MyCountryHint(),
    15: HymnHint(),
  },
  RetreatMoment.evening: {
    10: ListHint(PrayerList.coworkers),
    11: ListHint(PrayerList.coworkers, group: 1),
  },
  RetreatMoment.night: {
    10: NationHint(NationKind.muslim),
    11: NationHint(NationKind.hindu),
    13: NationHint(NationKind.peoples),
  },
};

/// The texts of the four retreats in one language, and the lists of
/// countries and peoples prayed for in turn.
class RetreatContent {
  const RetreatContent({required this.points, required this.nations});

  factory RetreatContent.fromJson(Map<String, dynamic> json) {
    List<String> strings(Object? value) => [
      for (final item in value as List<dynamic>? ?? const []) item as String,
    ];
    final nations = json['nations'] as Map<String, dynamic>? ?? const {};
    return RetreatContent(
      points: {
        for (final moment in RetreatMoment.values)
          moment: strings(json[moment.name]),
      },
      nations: {
        for (final kind in NationKind.values) kind: strings(nations[kind.name]),
      },
    );
  }

  final Map<RetreatMoment, List<String>> points;
  final Map<NationKind, List<String>> nations;

  /// The same country all day long, another one the next day.
  String? nationOfDay(NationKind kind, DateTime day) {
    final list = nations[kind] ?? const [];
    if (list.isEmpty) {
      return null;
    }
    final days = DateTime.utc(
      day.year,
      day.month,
      day.day,
    ).difference(DateTime.utc(2024)).inDays;
    return list[days % list.length];
  }
}

/// The retreat to suggest at [now]: morning until 11:00, noon until 16:00,
/// evening until 20:00, night after.
RetreatMoment momentAt(DateTime now) => switch (now.hour) {
  < 11 => RetreatMoment.morning,
  < 16 => RetreatMoment.noon,
  < 20 => RetreatMoment.evening,
  _ => RetreatMoment.night,
};

/// The people a retreat prays for: those not answered yet, the ones prayed
/// for the longest ago first (never prayed: first of all), then in the
/// order they were added. [group] 0: the first five, 1: the five after.
List<PrayerPerson> nextPeople(
  List<PrayerPerson> people,
  PrayerList list, {
  int group = 0,
  int count = 5,
}) {
  final waiting = [
    for (final person in people)
      if (person.list == list && !person.answered) person,
  ]..sort(_byTurn);
  return waiting.skip(group * count).take(count).toList();
}

int _byTurn(PrayerPerson a, PrayerPerson b) {
  final last = switch ((a.lastPrayedOn, b.lastPrayedOn)) {
    (null, null) => 0,
    (null, _) => -1,
    (_, null) => 1,
    (final x?, final y?) => x.compareTo(y),
  };
  return last != 0 ? last : a.id.compareTo(b.id);
}
