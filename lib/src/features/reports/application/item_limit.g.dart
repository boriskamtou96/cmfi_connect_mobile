// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_limit.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The quota of the signed-in member; null while the items are unknown.
/// Premium still unknown (loading, store unreachable) opens creation: no lock
/// is shown to a member who paid.

@ProviderFor(itemQuota)
final itemQuotaProvider = ItemQuotaProvider._();

/// The quota of the signed-in member; null while the items are unknown.
/// Premium still unknown (loading, store unreachable) opens creation: no lock
/// is shown to a member who paid.

final class ItemQuotaProvider
    extends $FunctionalProvider<ItemQuota?, ItemQuota?, ItemQuota?>
    with $Provider<ItemQuota?> {
  /// The quota of the signed-in member; null while the items are unknown.
  /// Premium still unknown (loading, store unreachable) opens creation: no lock
  /// is shown to a member who paid.
  ItemQuotaProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemQuotaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemQuotaHash();

  @$internal
  @override
  $ProviderElement<ItemQuota?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ItemQuota? create(Ref ref) {
    return itemQuota(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ItemQuota? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ItemQuota?>(value),
    );
  }
}

String _$itemQuotaHash() => r'874b824793f89af0bf0a2a0bd91b9fecfd443a91';
