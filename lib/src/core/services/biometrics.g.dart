// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biometrics.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(biometrics)
final biometricsProvider = BiometricsProvider._();

final class BiometricsProvider
    extends $FunctionalProvider<Biometrics, Biometrics, Biometrics>
    with $Provider<Biometrics> {
  BiometricsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricsHash();

  @$internal
  @override
  $ProviderElement<Biometrics> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Biometrics create(Ref ref) {
    return biometrics(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Biometrics value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Biometrics>(value),
    );
  }
}

String _$biometricsHash() => r'29718fe2fef53184e3adcbcf8b325f458878428c';

/// What this phone recognises, null without biometrics.

@ProviderFor(biometricKind)
final biometricKindProvider = BiometricKindProvider._();

/// What this phone recognises, null without biometrics.

final class BiometricKindProvider
    extends
        $FunctionalProvider<
          AsyncValue<BiometricKind?>,
          BiometricKind?,
          FutureOr<BiometricKind?>
        >
    with $FutureModifier<BiometricKind?>, $FutureProvider<BiometricKind?> {
  /// What this phone recognises, null without biometrics.
  BiometricKindProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'biometricKindProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$biometricKindHash();

  @$internal
  @override
  $FutureProviderElement<BiometricKind?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BiometricKind?> create(Ref ref) {
    return biometricKind(ref);
  }
}

String _$biometricKindHash() => r'c4d4c12644dfff8899eb676471c7ed210bc9b468';
