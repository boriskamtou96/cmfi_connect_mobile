// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_plan.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The Bible reading plan of the member (one at a time), kept on the phone:
/// what was asked (`bible_plan`) and the chapters read (`bible_plan_read`).
/// A chapter marked "J'ai lu ce chapitre" in the reader is read in the plan
/// too. The reminder of each day is planned 14 days ahead, silent once the
/// day's reading is done.

@ProviderFor(BiblePlan)
final biblePlanProvider = BiblePlanProvider._();

/// The Bible reading plan of the member (one at a time), kept on the phone:
/// what was asked (`bible_plan`) and the chapters read (`bible_plan_read`).
/// A chapter marked "J'ai lu ce chapitre" in the reader is read in the plan
/// too. The reminder of each day is planned 14 days ahead, silent once the
/// day's reading is done.
final class BiblePlanProvider
    extends $NotifierProvider<BiblePlan, PlanProgress?> {
  /// The Bible reading plan of the member (one at a time), kept on the phone:
  /// what was asked (`bible_plan`) and the chapters read (`bible_plan_read`).
  /// A chapter marked "J'ai lu ce chapitre" in the reader is read in the plan
  /// too. The reminder of each day is planned 14 days ahead, silent once the
  /// day's reading is done.
  BiblePlanProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biblePlanProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biblePlanHash();

  @$internal
  @override
  BiblePlan create() => BiblePlan();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlanProgress? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlanProgress?>(value),
    );
  }
}

String _$biblePlanHash() => r'3541474fd4aca00ac12b19a4bedbc5fce3a060f0';

/// The Bible reading plan of the member (one at a time), kept on the phone:
/// what was asked (`bible_plan`) and the chapters read (`bible_plan_read`).
/// A chapter marked "J'ai lu ce chapitre" in the reader is read in the plan
/// too. The reminder of each day is planned 14 days ahead, silent once the
/// day's reading is done.

abstract class _$BiblePlan extends $Notifier<PlanProgress?> {
  PlanProgress? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PlanProgress?, PlanProgress?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlanProgress?, PlanProgress?>,
              PlanProgress?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
