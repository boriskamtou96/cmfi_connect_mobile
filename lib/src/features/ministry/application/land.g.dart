// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'land.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The land of the globe: 4233 points of a regular grid of the sphere kept
/// where they fall on land, from Natural Earth 1:110m countries (public
/// domain, naturalearthdata.com). assets/ministry/land_dots.bin holds, for
/// each point, its latitude and longitude in hundredths of a degree (two
/// little-endian int16).

@ProviderFor(landDots)
final landDotsProvider = LandDotsProvider._();

/// The land of the globe: 4233 points of a regular grid of the sphere kept
/// where they fall on land, from Natural Earth 1:110m countries (public
/// domain, naturalearthdata.com). assets/ministry/land_dots.bin holds, for
/// each point, its latitude and longitude in hundredths of a degree (two
/// little-endian int16).

final class LandDotsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SpherePoint>>,
          List<SpherePoint>,
          FutureOr<List<SpherePoint>>
        >
    with
        $FutureModifier<List<SpherePoint>>,
        $FutureProvider<List<SpherePoint>> {
  /// The land of the globe: 4233 points of a regular grid of the sphere kept
  /// where they fall on land, from Natural Earth 1:110m countries (public
  /// domain, naturalearthdata.com). assets/ministry/land_dots.bin holds, for
  /// each point, its latitude and longitude in hundredths of a degree (two
  /// little-endian int16).
  LandDotsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'landDotsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$landDotsHash();

  @$internal
  @override
  $FutureProviderElement<List<SpherePoint>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpherePoint>> create(Ref ref) {
    return landDots(ref);
  }
}

String _$landDotsHash() => r'216cd109305d2c81da88dcc746785520ef4f4ada';
