// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nations.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The nations of the ministry: the copy of the phone at once (the last one
/// seen, or the one shipped with the app), then the server's when it answers.
/// Without network, the copy stays.

@ProviderFor(Nations)
final nationsProvider = NationsProvider._();

/// The nations of the ministry: the copy of the phone at once (the last one
/// seen, or the one shipped with the app), then the server's when it answers.
/// Without network, the copy stays.
final class NationsProvider
    extends $AsyncNotifierProvider<Nations, List<Nation>> {
  /// The nations of the ministry: the copy of the phone at once (the last one
  /// seen, or the one shipped with the app), then the server's when it answers.
  /// Without network, the copy stays.
  NationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nationsHash();

  @$internal
  @override
  Nations create() => Nations();
}

String _$nationsHash() => r'b4eff53371bb2b31821f60ee5ce4331e911cdd43';

/// The nations of the ministry: the copy of the phone at once (the last one
/// seen, or the one shipped with the app), then the server's when it answers.
/// Without network, the copy stays.

abstract class _$Nations extends $AsyncNotifier<List<Nation>> {
  FutureOr<List<Nation>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Nation>>, List<Nation>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Nation>>, List<Nation>>,
              AsyncValue<List<Nation>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
