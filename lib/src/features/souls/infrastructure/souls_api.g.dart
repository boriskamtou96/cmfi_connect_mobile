// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souls_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(soulsApi)
final soulsApiProvider = SoulsApiProvider._();

final class SoulsApiProvider
    extends $FunctionalProvider<SoulsApi, SoulsApi, SoulsApi>
    with $Provider<SoulsApi> {
  SoulsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'soulsApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$soulsApiHash();

  @$internal
  @override
  $ProviderElement<SoulsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SoulsApi create(Ref ref) {
    return soulsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SoulsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SoulsApi>(value),
    );
  }
}

String _$soulsApiHash() => r'bc7d79ca6424a8df5931654476ccc7699ef2939d';
