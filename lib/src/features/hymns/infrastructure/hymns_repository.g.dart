// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hymns_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hymnsRepository)
final hymnsRepositoryProvider = HymnsRepositoryProvider._();

final class HymnsRepositoryProvider
    extends
        $FunctionalProvider<HymnsRepository, HymnsRepository, HymnsRepository>
    with $Provider<HymnsRepository> {
  HymnsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hymnsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hymnsRepositoryHash();

  @$internal
  @override
  $ProviderElement<HymnsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HymnsRepository create(Ref ref) {
    return hymnsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HymnsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HymnsRepository>(value),
    );
  }
}

String _$hymnsRepositoryHash() => r'f58b5a0e5d74c07f474abf5da2efe75bf40f5f7c';
