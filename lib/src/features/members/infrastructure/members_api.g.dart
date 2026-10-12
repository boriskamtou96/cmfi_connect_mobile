// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(membersApi)
final membersApiProvider = MembersApiProvider._();

final class MembersApiProvider
    extends $FunctionalProvider<MembersApi, MembersApi, MembersApi>
    with $Provider<MembersApi> {
  MembersApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'membersApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$membersApiHash();

  @$internal
  @override
  $ProviderElement<MembersApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MembersApi create(Ref ref) {
    return membersApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MembersApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MembersApi>(value),
    );
  }
}

String _$membersApiHash() => r'd78d21f7f9edcdfacfe4be13a0e578959a379704';
