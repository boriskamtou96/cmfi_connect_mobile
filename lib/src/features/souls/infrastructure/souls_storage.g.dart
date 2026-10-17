// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'souls_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(soulsStorage)
final soulsStorageProvider = SoulsStorageProvider._();

final class SoulsStorageProvider
    extends $FunctionalProvider<SoulsStorage, SoulsStorage, SoulsStorage>
    with $Provider<SoulsStorage> {
  SoulsStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'soulsStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$soulsStorageHash();

  @$internal
  @override
  $ProviderElement<SoulsStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SoulsStorage create(Ref ref) {
    return soulsStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SoulsStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SoulsStorage>(value),
    );
  }
}

String _$soulsStorageHash() => r'6d012a11554ad788a24532465750710ed60ff6ad';
