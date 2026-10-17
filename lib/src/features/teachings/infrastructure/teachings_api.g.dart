// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teachings_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teachingsApi)
final teachingsApiProvider = TeachingsApiProvider._();

final class TeachingsApiProvider
    extends $FunctionalProvider<TeachingsApi, TeachingsApi, TeachingsApi>
    with $Provider<TeachingsApi> {
  TeachingsApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teachingsApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teachingsApiHash();

  @$internal
  @override
  $ProviderElement<TeachingsApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeachingsApi create(Ref ref) {
    return teachingsApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeachingsApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeachingsApi>(value),
    );
  }
}

String _$teachingsApiHash() => r'2cb68112f8d191d746c42afa699b22b3abeeae1c';
