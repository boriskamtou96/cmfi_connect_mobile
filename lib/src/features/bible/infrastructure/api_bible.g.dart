// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_bible.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The ids FUMS wants: the device's, and the reader's (a random one of this
/// phone, the same at each launch, that says nothing of who reads).

@ProviderFor(apiBible)
final apiBibleProvider = ApiBibleProvider._();

/// The ids FUMS wants: the device's, and the reader's (a random one of this
/// phone, the same at each launch, that says nothing of who reads).

final class ApiBibleProvider
    extends $FunctionalProvider<ApiBible, ApiBible, ApiBible>
    with $Provider<ApiBible> {
  /// The ids FUMS wants: the device's, and the reader's (a random one of this
  /// phone, the same at each launch, that says nothing of who reads).
  ApiBibleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiBibleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiBibleHash();

  @$internal
  @override
  $ProviderElement<ApiBible> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiBible create(Ref ref) {
    return apiBible(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiBible value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiBible>(value),
    );
  }
}

String _$apiBibleHash() => r'3de44e84dd9131be36a4ab2520a4d21a8b22d8be';
