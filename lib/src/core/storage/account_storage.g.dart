// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(accountStorage)
final accountStorageProvider = AccountStorageProvider._();

final class AccountStorageProvider
    extends $FunctionalProvider<AccountStorage, AccountStorage, AccountStorage>
    with $Provider<AccountStorage> {
  AccountStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountStorageHash();

  @$internal
  @override
  $ProviderElement<AccountStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AccountStorage create(Ref ref) {
    return accountStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountStorage>(value),
    );
  }
}

String _$accountStorageHash() => r'594df99c90383f32289f0ac2538faf72d3688568';
