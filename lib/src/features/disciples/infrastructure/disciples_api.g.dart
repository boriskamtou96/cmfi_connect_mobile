// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disciples_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(disciplesApi)
final disciplesApiProvider = DisciplesApiProvider._();

final class DisciplesApiProvider
    extends $FunctionalProvider<DisciplesApi, DisciplesApi, DisciplesApi>
    with $Provider<DisciplesApi> {
  DisciplesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'disciplesApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$disciplesApiHash();

  @$internal
  @override
  $ProviderElement<DisciplesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DisciplesApi create(Ref ref) {
    return disciplesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DisciplesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DisciplesApi>(value),
    );
  }
}

String _$disciplesApiHash() => r'f1f6d2de3d3508d95e2dadbb52eb7c7f3df3459b';
