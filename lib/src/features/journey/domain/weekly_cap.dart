/// One weekly commitment, chosen by the member: a few report days, a few
/// retreats, or a few chapters. It ends with the week, without penalty.
enum CapKind { reports, retreats, chapters }

/// The cap chosen for a week (Monday to Sunday), kept on the phone.
class WeeklyCap {
  const WeeklyCap({
    required this.week,
    required this.kind,
    required this.target,
    required this.chosenAt,
  });

  /// The Monday of the week, at midnight.
  final DateTime week;
  final CapKind kind;
  final int target;
  final DateTime chosenAt;

  factory WeeklyCap.fromJson(Map<String, dynamic> json) => WeeklyCap(
    week: DateTime.parse(json['week'] as String),
    kind: CapKind.values.asNameMap()[json['kind']] ?? CapKind.reports,
    target: (json['target'] as num?)?.toInt() ?? 1,
    chosenAt:
        DateTime.tryParse(json['chosen_at'] as String? ?? '') ?? DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    'week': week.toIso8601String().substring(0, 10),
    'kind': kind.name,
    'target': target,
    'chosen_at': chosenAt.toIso8601String(),
  };
}

/// How far the cap of a week went.
class WeeklyCapProgress {
  const WeeklyCapProgress({required this.cap, required this.done});

  final WeeklyCap cap;
  final int done;

  int get remaining {
    final left = cap.target - done;
    return left < 0 ? 0 : left;
  }

  bool get reached => done >= cap.target;

  double get ratio =>
      cap.target <= 0 ? 0 : (done / cap.target).clamp(0.0, 1.0).toDouble();
}

/// A cap proposed to the member, before they choose it.
class WeeklyCapSuggestion {
  const WeeklyCapSuggestion({required this.kind, required this.target});

  final CapKind kind;
  final int target;
}
