import '../../../core/i18n/strings.g.dart';
import '../domain/journey_progress.dart';
import '../domain/weekly_cap.dart';

/// "Encore 2 jours", "Encore 1 chapitre"… in the units of the step.
String journeyRemainingText(Translations t, JourneyProgress progress) {
  final n = progress.remaining;
  final next = t.gamification.next;
  return switch (progress.unit) {
    JourneyUnit.reports => next.remainingReports(n: n),
    JourneyUnit.actions => next.remainingActions(n: n),
    JourneyUnit.days => next.remainingDays(n: n),
    JourneyUnit.fullDays => next.remainingFullDays(n: n),
    JourneyUnit.retreats => next.remainingRetreats(n: n),
    JourneyUnit.chapters => next.remainingChapters(n: n),
    JourneyUnit.souls => next.remainingSouls(n: n),
  };
}

/// "4 jours de compte rendu", "3 retraites", "5 chapitres": the cap itself.
String capGoalText(Translations t, CapKind kind, int target) {
  final cap = t.gamification.cap;
  return switch (kind) {
    CapKind.reports => cap.suggestReports(n: target),
    CapKind.retreats => cap.suggestRetreats(n: target),
    CapKind.chapters => cap.suggestChapters(n: target),
  };
}

/// "Encore 2 jours de compte rendu", "Encore 1 chapitre"…
String capRemainingText(Translations t, CapKind kind, int n) {
  final cap = t.gamification.cap;
  return switch (kind) {
    CapKind.reports => cap.remainingReports(n: n),
    CapKind.retreats => cap.remainingRetreats(n: n),
    CapKind.chapters => cap.remainingChapters(n: n),
  };
}
