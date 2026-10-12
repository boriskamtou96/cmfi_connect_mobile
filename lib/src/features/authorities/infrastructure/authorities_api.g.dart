// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorities_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authoritiesApi)
final authoritiesApiProvider = AuthoritiesApiProvider._();

final class AuthoritiesApiProvider
    extends $FunctionalProvider<AuthoritiesApi, AuthoritiesApi, AuthoritiesApi>
    with $Provider<AuthoritiesApi> {
  AuthoritiesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authoritiesApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authoritiesApiHash();

  @$internal
  @override
  $ProviderElement<AuthoritiesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthoritiesApi create(Ref ref) {
    return authoritiesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthoritiesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthoritiesApi>(value),
    );
  }
}

String _$authoritiesApiHash() => r'512b77df93156e37931c6cb4acb62b7a86ffcb7a';
