// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cross_references.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(crossReferences)
final crossReferencesProvider = CrossReferencesProvider._();

final class CrossReferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<CrossReferences>,
          CrossReferences,
          FutureOr<CrossReferences>
        >
    with $FutureModifier<CrossReferences>, $FutureProvider<CrossReferences> {
  CrossReferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'crossReferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$crossReferencesHash();

  @$internal
  @override
  $FutureProviderElement<CrossReferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CrossReferences> create(Ref ref) {
    return crossReferences(ref);
  }
}

String _$crossReferencesHash() => r'2299bbd5578ca3e1865d4a9039a757c789a8b6a2';
