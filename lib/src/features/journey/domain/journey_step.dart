/// What a step of the journey rewards: faithfulness, prayer, the Word, the
/// souls, or walking with others. Gives its color.
enum JourneyGroup { faithfulness, prayer, word, souls, together }

/// « Les étapes du chemin »: what a member reaches on the way, kept for
/// them only (no ranking). Each one is reached once.
enum JourneyStep {
  /// The first report saved.
  firstReport(JourneyGroup.faithfulness),

  /// 7, 30, 100 and 365 days in a row (days of grace kept).
  streak7(JourneyGroup.faithfulness, streak: 7),
  streak30(JourneyGroup.faithfulness, streak: 30),
  streak100(JourneyGroup.faithfulness, streak: 100),
  streak365(JourneyGroup.faithfulness, streak: 365),

  /// The three steps of a day done, then seven such days.
  fullDay(JourneyGroup.faithfulness),
  sevenFullDays(JourneyGroup.faithfulness),

  /// The four retreats of a day.
  fourRetreats(JourneyGroup.prayer),

  /// A Bible reading plan finished.
  planDone(JourneyGroup.word),

  /// Words of a hymn shared.
  lyricsShared(JourneyGroup.word),

  /// The first soul followed, then ten; one baptized.
  firstSoul(JourneyGroup.souls),
  tenSouls(JourneyGroup.souls),
  soulBaptized(JourneyGroup.souls),

  /// A report sent in the app to an authority.
  firstSending(JourneyGroup.together),

  /// A word of encouragement sent to a disciple.
  firstEncouragement(JourneyGroup.together);

  const JourneyStep(this.group, {this.streak});

  final JourneyGroup group;

  /// The days in a row it takes, for the steps of the streak.
  final int? streak;

  /// The steps of the streak reached by [days] in a row.
  static Iterable<JourneyStep> ofStreak(int days) =>
      values.where((step) => step.streak != null && days >= step.streak!);
}
