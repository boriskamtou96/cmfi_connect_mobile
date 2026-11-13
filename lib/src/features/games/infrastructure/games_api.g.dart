// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(gamesApi)
final gamesApiProvider = GamesApiProvider._();

final class GamesApiProvider
    extends $FunctionalProvider<GamesApi, GamesApi, GamesApi>
    with $Provider<GamesApi> {
  GamesApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gamesApiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gamesApiHash();

  @$internal
  @override
  $ProviderElement<GamesApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GamesApi create(Ref ref) {
    return gamesApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GamesApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GamesApi>(value),
    );
  }
}

String _$gamesApiHash() => r'1c2f94025d4913f0df8557335c4fd3c791326a5c';
