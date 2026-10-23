// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_local_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(inboxLocalStore)
final inboxLocalStoreProvider = InboxLocalStoreProvider._();

final class InboxLocalStoreProvider
    extends
        $FunctionalProvider<InboxLocalStore, InboxLocalStore, InboxLocalStore>
    with $Provider<InboxLocalStore> {
  InboxLocalStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inboxLocalStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inboxLocalStoreHash();

  @$internal
  @override
  $ProviderElement<InboxLocalStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  InboxLocalStore create(Ref ref) {
    return inboxLocalStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InboxLocalStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InboxLocalStore>(value),
    );
  }
}

String _$inboxLocalStoreHash() => r'40a6eed8f882054c1e09f1026f49612ddc7a49af';
