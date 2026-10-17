// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teaching_player.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teachingPlayer)
final teachingPlayerProvider = TeachingPlayerProvider._();

final class TeachingPlayerProvider
    extends $FunctionalProvider<TeachingPlayer, TeachingPlayer, TeachingPlayer>
    with $Provider<TeachingPlayer> {
  TeachingPlayerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teachingPlayerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teachingPlayerHash();

  @$internal
  @override
  $ProviderElement<TeachingPlayer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeachingPlayer create(Ref ref) {
    return teachingPlayer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeachingPlayer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeachingPlayer>(value),
    );
  }
}

String _$teachingPlayerHash() => r'fddd6451087fb31b111ffbf1538fec4ed1b36ed7';
