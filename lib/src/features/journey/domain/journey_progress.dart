import 'journey_step.dart';

/// What a step counts: reports, days in a row, full days, retreats, chapters,
/// souls, or a single act.
enum JourneyUnit { reports, actions, days, fullDays, retreats, chapters, souls }

/// Where the member stands on one step of the journey: what is done, what it
/// takes, and whether it can be reached from where they are now.
class JourneyProgress {
  const JourneyProgress({
    required this.step,
    required this.done,
    required this.target,
    required this.unit,
    this.reachable = true,
  });

  final JourneyStep step;
  final int done;
  final int target;
  final JourneyUnit unit;

  /// False when the step needs something the member does not have yet (a
  /// reading plan, an authority, a disciple…): it is not proposed.
  final bool reachable;

  int get remaining {
    final left = target - done;
    return left < 0 ? 0 : left;
  }

  bool get reached => target > 0 && done >= target;

  double get ratio =>
      target <= 0 ? 0 : (done / target).clamp(0.0, 1.0).toDouble();
}

/// The order the journey is proposed in: a thought-out path, not the order of
/// the enum. A step that cannot be reached yet is skipped.
const journeyProgressionOrder = <JourneyStep>[
  JourneyStep.firstReport,
  JourneyStep.fullDay,
  JourneyStep.streak7,
  JourneyStep.fourRetreats,
  JourneyStep.sevenFullDays,
  JourneyStep.firstSoul,
  JourneyStep.streak30,
  JourneyStep.firstSending,
  JourneyStep.planDone,
  JourneyStep.lyricsShared,
  JourneyStep.tenSouls,
  JourneyStep.firstEncouragement,
  JourneyStep.streak100,
  JourneyStep.soulBaptized,
  JourneyStep.streak365,
];

/// All the steps with their progress, the next one to aim at, and how each
/// family is going.
class JourneyOverview {
  const JourneyOverview({required this.byStep, required this.next});

  final Map<JourneyStep, JourneyProgress> byStep;

  /// The first step not reached that can be reached now, in
  /// [journeyProgressionOrder]. null when every reachable step is reached.
  final JourneyProgress? next;

  int reachedIn(JourneyGroup group) => byStep.values
      .where((progress) => progress.step.group == group && progress.reached)
      .length;

  int totalIn(JourneyGroup group) =>
      JourneyStep.values.where((step) => step.group == group).length;

  double ratioIn(JourneyGroup group) {
    final total = totalIn(group);
    return total == 0 ? 0 : reachedIn(group) / total;
  }
}
