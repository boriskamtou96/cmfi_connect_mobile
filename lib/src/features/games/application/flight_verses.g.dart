// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_verses.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The verses of « Verset en vol » in [language]: those of the verse of the
/// day (366, in the Bibles of the app) short enough to fly through. Read from
/// the assets here, the games not reaching into the verses feature.

@ProviderFor(flightVerses)
final flightVersesProvider = FlightVersesFamily._();

/// The verses of « Verset en vol » in [language]: those of the verse of the
/// day (366, in the Bibles of the app) short enough to fly through. Read from
/// the assets here, the games not reaching into the verses feature.

final class FlightVersesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FlightVerse>>,
          List<FlightVerse>,
          FutureOr<List<FlightVerse>>
        >
    with
        $FutureModifier<List<FlightVerse>>,
        $FutureProvider<List<FlightVerse>> {
  /// The verses of « Verset en vol » in [language]: those of the verse of the
  /// day (366, in the Bibles of the app) short enough to fly through. Read from
  /// the assets here, the games not reaching into the verses feature.
  FlightVersesProvider._({
    required FlightVersesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'flightVersesProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$flightVersesHash();

  @override
  String toString() {
    return r'flightVersesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FlightVerse>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FlightVerse>> create(Ref ref) {
    final argument = this.argument as String;
    return flightVerses(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FlightVersesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$flightVersesHash() => r'90c9fd930fa976ebd500bd79b79395eed48a6a9c';

/// The verses of « Verset en vol » in [language]: those of the verse of the
/// day (366, in the Bibles of the app) short enough to fly through. Read from
/// the assets here, the games not reaching into the verses feature.

final class FlightVersesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<FlightVerse>>, String> {
  FlightVersesFamily._()
    : super(
        retry: null,
        name: r'flightVersesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// The verses of « Verset en vol » in [language]: those of the verse of the
  /// day (366, in the Bibles of the app) short enough to fly through. Read from
  /// the assets here, the games not reaching into the verses feature.

  FlightVersesProvider call(String language) =>
      FlightVersesProvider._(argument: language, from: this);

  @override
  String toString() => r'flightVersesProvider';
}
