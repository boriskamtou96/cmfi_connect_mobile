// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_journey.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(journeyVerses)
final journeyVersesProvider = JourneyVersesFamily._();

final class JourneyVersesProvider
    extends
        $FunctionalProvider<
          AsyncValue<JourneyVerses>,
          JourneyVerses,
          FutureOr<JourneyVerses>
        >
    with $FutureModifier<JourneyVerses>, $FutureProvider<JourneyVerses> {
  JourneyVersesProvider._({
    required JourneyVersesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'journeyVersesProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$journeyVersesHash();

  @override
  String toString() {
    return r'journeyVersesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<JourneyVerses> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<JourneyVerses> create(Ref ref) {
    final argument = this.argument as String;
    return journeyVerses(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is JourneyVersesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$journeyVersesHash() => r'458ddf6e18ae290016f239b380bfed258721bd7e';

final class JourneyVersesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<JourneyVerses>, String> {
  JourneyVersesFamily._()
    : super(
        retry: null,
        name: r'journeyVersesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  JourneyVersesProvider call(String language) =>
      JourneyVersesProvider._(argument: language, from: this);

  @override
  String toString() => r'journeyVersesProvider';
}

/// Where the player stands on « La conquête de Canaan »: kept on the phone
/// (key `flight_journey`), at sign-out too, like the bookmark of the Bible.
/// No points from the server: the journey is played to keep the Word.

@ProviderFor(FlightJourney)
final flightJourneyProvider = FlightJourneyProvider._();

/// Where the player stands on « La conquête de Canaan »: kept on the phone
/// (key `flight_journey`), at sign-out too, like the bookmark of the Bible.
/// No points from the server: the journey is played to keep the Word.
final class FlightJourneyProvider
    extends $NotifierProvider<FlightJourney, JourneyProgress> {
  /// Where the player stands on « La conquête de Canaan »: kept on the phone
  /// (key `flight_journey`), at sign-out too, like the bookmark of the Bible.
  /// No points from the server: the journey is played to keep the Word.
  FlightJourneyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flightJourneyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flightJourneyHash();

  @$internal
  @override
  FlightJourney create() => FlightJourney();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(JourneyProgress value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<JourneyProgress>(value),
    );
  }
}

String _$flightJourneyHash() => r'b8faaf99bc7f8149350c0fc8fdde22a30703c814';

/// Where the player stands on « La conquête de Canaan »: kept on the phone
/// (key `flight_journey`), at sign-out too, like the bookmark of the Bible.
/// No points from the server: the journey is played to keep the Word.

abstract class _$FlightJourney extends $Notifier<JourneyProgress> {
  JourneyProgress build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<JourneyProgress, JourneyProgress>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<JourneyProgress, JourneyProgress>,
              JourneyProgress,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
