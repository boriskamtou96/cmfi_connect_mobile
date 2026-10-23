// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_steps.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dailySteps)
final dailyStepsProvider = DailyStepsProvider._();

final class DailyStepsProvider
    extends $FunctionalProvider<DailySteps, DailySteps, DailySteps>
    with $Provider<DailySteps> {
  DailyStepsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dailyStepsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dailyStepsHash();

  @$internal
  @override
  $ProviderElement<DailySteps> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DailySteps create(Ref ref) {
    return dailySteps(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DailySteps value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DailySteps>(value),
    );
  }
}

String _$dailyStepsHash() => r'd99241fcf8dd7e5367c1c192d9895a25cb4cbf0f';

/// The days the three steps were all done (`full_days`, the last 60), for
/// « Sept journées complètes ».

@ProviderFor(FullDays)
final fullDaysProvider = FullDaysProvider._();

/// The days the three steps were all done (`full_days`, the last 60), for
/// « Sept journées complètes ».
final class FullDaysProvider
    extends $NotifierProvider<FullDays, Set<DateTime>> {
  /// The days the three steps were all done (`full_days`, the last 60), for
  /// « Sept journées complètes ».
  FullDaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fullDaysProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fullDaysHash();

  @$internal
  @override
  FullDays create() => FullDays();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<DateTime> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<DateTime>>(value),
    );
  }
}

String _$fullDaysHash() => r'3acf4d7850aee4e69fde46f0aa5300e52a27fc6e';

/// The days the three steps were all done (`full_days`, the last 60), for
/// « Sept journées complètes ».

abstract class _$FullDays extends $Notifier<Set<DateTime>> {
  Set<DateTime> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<DateTime>, Set<DateTime>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<DateTime>, Set<DateTime>>,
              Set<DateTime>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
