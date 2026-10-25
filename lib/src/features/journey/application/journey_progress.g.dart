// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_progress.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Where the member stands on every step, and the next one to aim at. The
/// next step is the first one not reached in [journeyProgressionOrder] that
/// can be reached now: a step that needs a reading plan, an authority or a
/// disciple is skipped until it is possible.

@ProviderFor(journeyOverview)
final journeyOverviewProvider = JourneyOverviewProvider._();

/// Where the member stands on every step, and the next one to aim at. The
/// next step is the first one not reached in [journeyProgressionOrder] that
/// can be reached now: a step that needs a reading plan, an authority or a
/// disciple is skipped until it is possible.

final class JourneyOverviewProvider
    extends
        $FunctionalProvider<JourneyOverview, JourneyOverview, JourneyOverview>
    with $Provider<JourneyOverview> {
  /// Where the member stands on every step, and the next one to aim at. The
  /// next step is the first one not reached in [journeyProgressionOrder] that
  /// can be reached now: a step that needs a reading plan, an authority or a
  /// disciple is skipped until it is possible.
  JourneyOverviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journeyOverviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journeyOverviewHash();

  @$internal
  @override
  $ProviderElement<JourneyOverview> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JourneyOverview create(Ref ref) {
    return journeyOverview(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JourneyOverview value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JourneyOverview>(value),
    );
  }
}

String _$journeyOverviewHash() => r'3e71865684b6671c12dacecfc4a3448b2462c005';

/// The next step only, for the home line and the profile.

@ProviderFor(nextJourneyStep)
final nextJourneyStepProvider = NextJourneyStepProvider._();

/// The next step only, for the home line and the profile.

final class NextJourneyStepProvider
    extends
        $FunctionalProvider<
          JourneyProgress?,
          JourneyProgress?,
          JourneyProgress?
        >
    with $Provider<JourneyProgress?> {
  /// The next step only, for the home line and the profile.
  NextJourneyStepProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nextJourneyStepProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nextJourneyStepHash();

  @$internal
  @override
  $ProviderElement<JourneyProgress?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  JourneyProgress? create(Ref ref) {
    return nextJourneyStep(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JourneyProgress? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JourneyProgress?>(value),
    );
  }
}

String _$nextJourneyStepHash() => r'318561feed69fbb56c7dbd35cdb7dc4279ee5e32';
