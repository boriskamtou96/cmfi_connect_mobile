// « La conquête de Canaan », the journey of « Verset en vol » (18/11/2026):
// the road of Israel from Egypt to Canaan in twelve stages. Each stage is a
// verse of the story to catch, under its own sky, a little faster than the
// one before. A stage won opens the next one; the hearts kept are its score.
// Pure Dart: the verses are in assets/games/journey_canaan.json (made by
// tool/flight_journey.mjs), the progress is kept by `FlightJourney`.

/// What Zoé flies over.
enum FlightScenery {
  /// The free flight: the night of the app, its stars.
  night,

  /// Pyramids on the sand.
  egypt,

  /// The waves of the Red Sea.
  sea,

  /// The palm trees of Elim.
  oasis,

  /// Dunes and rocks.
  desert,

  /// Mount Sinai, its top in the cloud.
  mountain,

  /// The tents of the camp, the pillar of cloud.
  camp,

  /// The Jordan.
  river,

  /// The walls of Jericho.
  walls,

  /// The green hills of Canaan.
  canaan,
}

/// A stage of the journey: its verse (USFM, "EXO.14.14"), its sky and how
/// fast its words come (1 at the start).
class FlightStage {
  const FlightStage(this.osis, this.scenery, this.pace);

  final String osis;
  final FlightScenery scenery;
  final double pace;
}

/// From Egypt to Canaan. The same order as `stages` in
/// tool/flight_journey.mjs and as `games.journey.places` and `stories` in
/// the texts of the app.
const canaanStages = [
  FlightStage('EXO.2.24', FlightScenery.egypt, 1),
  FlightStage('EXO.12.51', FlightScenery.egypt, 1.03),
  FlightStage('EXO.14.14', FlightScenery.sea, 1.06),
  FlightStage('EXO.15.27', FlightScenery.oasis, 1.09),
  FlightStage('EXO.17.15', FlightScenery.desert, 1.12),
  FlightStage('EXO.20.2', FlightScenery.mountain, 1.15),
  FlightStage('EXO.40.34', FlightScenery.camp, 1.18),
  FlightStage('NUM.14.8', FlightScenery.desert, 1.21),
  FlightStage('DEU.6.5', FlightScenery.camp, 1.24),
  FlightStage('JOS.3.5', FlightScenery.river, 1.27),
  FlightStage('JOS.6.2', FlightScenery.walls, 1.3),
  FlightStage('JOS.21.45', FlightScenery.canaan, 1.33),
];

/// Where a player stands on the journey: the hearts kept at each stage won,
/// in the order of the stages (1 to 3 each). Immutable.
class JourneyProgress {
  const JourneyProgress([this.hearts = const [], this.length = 12]);

  /// Read from what the phone keeps ("3,2,3"); anything unreadable is a
  /// journey not started.
  factory JourneyProgress.parse(String? saved, {required int length}) {
    if (saved == null || saved.isEmpty) {
      return JourneyProgress(const [], length);
    }
    final hearts = <int>[];
    for (final part in saved.split(',')) {
      final value = int.tryParse(part);
      if (value == null || value < 1 || value > maxHearts) {
        return JourneyProgress(const [], length);
      }
      hearts.add(value);
    }
    return JourneyProgress(hearts.take(length).toList(), length);
  }

  static const maxHearts = 3;

  /// The best hearts kept at each stage won.
  final List<int> hearts;

  /// How many stages the journey has.
  final int length;

  /// How many stages are won.
  int get reached => hearts.length;

  bool get started => hearts.isNotEmpty;
  bool get finished => reached >= length;

  /// The stage to play now: the first one not won, the last one once the
  /// journey is finished.
  int get current => finished ? length - 1 : reached;

  /// A stage can be played once the one before is won.
  bool isOpen(int stage) => stage >= 0 && stage < length && stage <= reached;

  bool isWon(int stage) => stage >= 0 && stage < reached;

  /// The hearts kept at [stage], null while it is not won.
  int? heartsOf(int stage) => isWon(stage) ? hearts[stage] : null;

  /// All the hearts kept, of [length] × 3.
  int get total => hearts.fold(0, (sum, value) => sum + value);

  /// After [stage] won with [kept] hearts: the best score stays, and the
  /// next stage opens. A stage not open yet changes nothing.
  JourneyProgress won(int stage, int kept) {
    if (!isOpen(stage)) {
      return this;
    }
    final score = kept.clamp(1, maxHearts);
    if (stage == reached) {
      return JourneyProgress([...hearts, score], length);
    }
    if (score <= hearts[stage]) {
      return this;
    }
    return JourneyProgress([
      for (var i = 0; i < hearts.length; i++) i == stage ? score : hearts[i],
    ], length);
  }

  /// What the phone keeps.
  String get saved => hearts.join(',');
}
