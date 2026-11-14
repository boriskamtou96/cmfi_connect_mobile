// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_flags.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(remoteFlags)
final remoteFlagsProvider = RemoteFlagsProvider._();

final class RemoteFlagsProvider
    extends $FunctionalProvider<RemoteFlags, RemoteFlags, RemoteFlags>
    with $Provider<RemoteFlags> {
  RemoteFlagsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteFlagsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteFlagsHash();

  @$internal
  @override
  $ProviderElement<RemoteFlags> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RemoteFlags create(Ref ref) {
    return remoteFlags(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteFlags value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteFlags>(value),
    );
  }
}

String _$remoteFlagsHash() => r'e6645d013b826baf04e372ff07871f51f23e100c';
