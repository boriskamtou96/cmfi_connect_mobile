// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_steps.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The steps just reached while the app is open, to celebrate (Zoé shows
/// them).

@ProviderFor(journeyCelebrations)
final journeyCelebrationsProvider = JourneyCelebrationsProvider._();

/// The steps just reached while the app is open, to celebrate (Zoé shows
/// them).

final class JourneyCelebrationsProvider
    extends
        $FunctionalProvider<
          StreamController<JourneyStep>,
          StreamController<JourneyStep>,
          StreamController<JourneyStep>
        >
    with $Provider<StreamController<JourneyStep>> {
  /// The steps just reached while the app is open, to celebrate (Zoé shows
  /// them).
  JourneyCelebrationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journeyCelebrationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journeyCelebrationsHash();

  @$internal
  @override
  $ProviderElement<StreamController<JourneyStep>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StreamController<JourneyStep> create(Ref ref) {
    return journeyCelebrations(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StreamController<JourneyStep> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StreamController<JourneyStep>>(
        value,
      ),
    );
  }
}

String _$journeyCelebrationsHash() =>
    r'84299147d5153bbe240976273218144b6e59bad9';

/// The steps of the journey reached, with when, kept on the phone for each
/// account (`journey_steps_<id>`): signing out and back keeps them. A step
/// reached while the app is open is told on [journeyCelebrations].

@ProviderFor(JourneySteps)
final journeyStepsProvider = JourneyStepsProvider._();

/// The steps of the journey reached, with when, kept on the phone for each
/// account (`journey_steps_<id>`): signing out and back keeps them. A step
/// reached while the app is open is told on [journeyCelebrations].
final class JourneyStepsProvider
    extends $AsyncNotifierProvider<JourneySteps, Map<JourneyStep, DateTime>> {
  /// The steps of the journey reached, with when, kept on the phone for each
  /// account (`journey_steps_<id>`): signing out and back keeps them. A step
  /// reached while the app is open is told on [journeyCelebrations].
  JourneyStepsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'journeyStepsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$journeyStepsHash();

  @$internal
  @override
  JourneySteps create() => JourneySteps();
}

String _$journeyStepsHash() => r'bb7f319f95493f1daef7097c8a906d319b5c2ad9';

/// The steps of the journey reached, with when, kept on the phone for each
/// account (`journey_steps_<id>`): signing out and back keeps them. A step
/// reached while the app is open is told on [journeyCelebrations].

abstract class _$JourneySteps
    extends $AsyncNotifier<Map<JourneyStep, DateTime>> {
  FutureOr<Map<JourneyStep, DateTime>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<JourneyStep, DateTime>>,
              Map<JourneyStep, DateTime>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<JourneyStep, DateTime>>,
                Map<JourneyStep, DateTime>
              >,
              AsyncValue<Map<JourneyStep, DateTime>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
