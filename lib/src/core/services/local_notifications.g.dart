// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_notifications.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localNotifications)
final localNotificationsProvider = LocalNotificationsProvider._();

final class LocalNotificationsProvider
    extends
        $FunctionalProvider<
          LocalNotifications,
          LocalNotifications,
          LocalNotifications
        >
    with $Provider<LocalNotifications> {
  LocalNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localNotificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localNotificationsHash();

  @$internal
  @override
  $ProviderElement<LocalNotifications> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalNotifications create(Ref ref) {
    return localNotifications(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalNotifications value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalNotifications>(value),
    );
  }
}

String _$localNotificationsHash() =>
    r'85060b88a1b9af972f0bd3780a612db25e98d535';
