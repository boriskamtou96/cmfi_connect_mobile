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

String _$reportGoalsHash() => r'27ae71d923011a589d87163093a6fd0aa082156e';

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
