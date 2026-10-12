// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_local_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventsLocalStore)
final eventsLocalStoreProvider = EventsLocalStoreProvider._();

final class EventsLocalStoreProvider
    extends
        $FunctionalProvider<
          EventsLocalStore,
          EventsLocalStore,
          EventsLocalStore
        >
    with $Provider<EventsLocalStore> {
  EventsLocalStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsLocalStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsLocalStoreHash();

  @$internal
  @override
  $ProviderElement<EventsLocalStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventsLocalStore create(Ref ref) {
    return eventsLocalStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventsLocalStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventsLocalStore>(value),
    );
  }
}

String _$eventsLocalStoreHash() => r'77cf1a6f90e5fb182a68955db39f21d7cf28338a';
