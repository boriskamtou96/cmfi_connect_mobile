// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_goals.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The daily goals, by item id. Kept on the phone.

@ProviderFor(ReportGoals)
final reportGoalsProvider = ReportGoalsProvider._();

/// The daily goals, by item id. Kept on the phone.
final class ReportGoalsProvider
    extends $NotifierProvider<ReportGoals, Map<int, ReportGoal>> {
  /// The daily goals, by item id. Kept on the phone.
  ReportGoalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportGoalsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportGoalsHash();

  @$internal
  @override
  ReportGoals create() => ReportGoals();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, ReportGoal> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<int, ReportGoal>>(value),
    );
  }
}

String _$reportGoalsHash() => r'b7100028f7bed97cd16d50e197f82579b61d6d69';

/// The daily goals, by item id. Kept on the phone.

abstract class _$ReportGoals extends $Notifier<Map<int, ReportGoal>> {
  Map<int, ReportGoal> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<int, ReportGoal>, Map<int, ReportGoal>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<int, ReportGoal>, Map<int, ReportGoal>>,
              Map<int, ReportGoal>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// How far the goals of [day] are reached, as it is being filled in (changes
/// not saved yet included). Null without goals.

@ProviderFor(goalsOfDay)
final goalsOfDayProvider = GoalsOfDayFamily._();

/// How far the goals of [day] are reached, as it is being filled in (changes
/// not saved yet included). Null without goals.

final class GoalsOfDayProvider
    extends $FunctionalProvider<DayGoals?, DayGoals?, DayGoals?>
    with $Provider<DayGoals?> {
  /// How far the goals of [day] are reached, as it is being filled in (changes
  /// not saved yet included). Null without goals.
  GoalsOfDayProvider._({
    required GoalsOfDayFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'goalsOfDayProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$goalsOfDayHash();

  @override
  String toString() {
    return r'goalsOfDayProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<DayGoals?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DayGoals? create(Ref ref) {
    final argument = this.argument as DateTime;
    return goalsOfDay(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DayGoals? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DayGoals?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GoalsOfDayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$goalsOfDayHash() => r'78054693050f9016fea5fd901ae85eb7168787ef';

/// How far the goals of [day] are reached, as it is being filled in (changes
/// not saved yet included). Null without goals.

final class GoalsOfDayFamily extends $Family
    with $FunctionalFamilyOverride<DayGoals?, DateTime> {
  GoalsOfDayFamily._()
    : super(
        retry: null,
        name: r'goalsOfDayProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// How far the goals of [day] are reached, as it is being filled in (changes
  /// not saved yet included). Null without goals.

  GoalsOfDayProvider call(DateTime day) =>
      GoalsOfDayProvider._(argument: day, from: this);

  @override
  String toString() => r'goalsOfDayProvider';
}

/// The goals of the last [weeks] weeks, the oldest first (Premium).

@ProviderFor(goalsEvolution)
final goalsEvolutionProvider = GoalsEvolutionFamily._();

/// The goals of the last [weeks] weeks, the oldest first (Premium).

final class GoalsEvolutionProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GoalsWeek>>,
          List<GoalsWeek>,
          FutureOr<List<GoalsWeek>>
        >
    with $FutureModifier<List<GoalsWeek>>, $FutureProvider<List<GoalsWeek>> {
  /// The goals of the last [weeks] weeks, the oldest first (Premium).
  GoalsEvolutionProvider._({
    required GoalsEvolutionFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'goalsEvolutionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$goalsEvolutionHash();

  @override
  String toString() {
    return r'goalsEvolutionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<GoalsWeek>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<GoalsWeek>> create(Ref ref) {
    final argument = this.argument as int;
    return goalsEvolution(ref, weeks: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GoalsEvolutionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$goalsEvolutionHash() => r'd5cf090b48d84199c62ce0a15104d38680395fbf';

/// The goals of the last [weeks] weeks, the oldest first (Premium).

final class GoalsEvolutionFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<GoalsWeek>>, int> {
  GoalsEvolutionFamily._()
    : super(
        retry: null,
        name: r'goalsEvolutionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The goals of the last [weeks] weeks, the oldest first (Premium).

  GoalsEvolutionProvider call({int weeks = 12}) =>
      GoalsEvolutionProvider._(argument: weeks, from: this);

  @override
  String toString() => r'goalsEvolutionProvider';
}
