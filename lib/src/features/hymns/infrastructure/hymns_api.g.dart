// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymns_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hymnsApi)
final hymnsApiProvider = HymnsApiProvider._();

final class HymnsApiProvider
    extends $FunctionalProvider<HymnsApi, HymnsApi, HymnsApi>
    with $Provider<HymnsApi> {
  HymnsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hymnsApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hymnsApiHash();

  @$internal
  @override
  $ProviderElement<HymnsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HymnsApi create(Ref ref) {
    return hymnsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HymnsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HymnsApi>(value),
    );
  }
}

String _$hymnsApiHash() => r'a4a1b03bc2094d1fc11b6133f9940938a201d0f2';
