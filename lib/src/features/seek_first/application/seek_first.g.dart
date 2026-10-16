// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seek_first.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The settings stay on the phone (and leave with the account at sign-out);
/// the phone keeps the apps chosen and closes them (AppShield).

@ProviderFor(SeekFirst)
final seekFirstProvider = SeekFirstProvider._();

/// The settings stay on the phone (and leave with the account at sign-out);
/// the phone keeps the apps chosen and closes them (AppShield).
final class SeekFirstProvider
    extends $AsyncNotifierProvider<SeekFirst, SeekFirstState> {
  /// The settings stay on the phone (and leave with the account at sign-out);
  /// the phone keeps the apps chosen and closes them (AppShield).
  SeekFirstProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seekFirstProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seekFirstHash();

  @$internal
  @override
  SeekFirst create() => SeekFirst();
}

String _$seekFirstHash() => r'c187babd5172d7c4107e9b4bb4f32794dd56edd7';

/// The settings stay on the phone (and leave with the account at sign-out);
/// the phone keeps the apps chosen and closes them (AppShield).

abstract class _$SeekFirst extends $AsyncNotifier<SeekFirstState> {
  FutureOr<SeekFirstState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SeekFirstState>, SeekFirstState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SeekFirstState>, SeekFirstState>,
              AsyncValue<SeekFirstState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
