// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fasts.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mes jeûnes, on the phone (keys `fast_current`, `fast_history`): each day
/// kept adds 1 to « Jeûne complet » (JC) or « Jeûne partiel » (JP) in the
/// report of the day it ends, when the app opens again after it (`catchUp`,
/// at launch, on the screen, after a notification). The end of each day and
/// of the fast come as notifications.

@ProviderFor(Fasts)
final fastsProvider = FastsProvider._();

/// Mes jeûnes, on the phone (keys `fast_current`, `fast_history`): each day
/// kept adds 1 to « Jeûne complet » (JC) or « Jeûne partiel » (JP) in the
/// report of the day it ends, when the app opens again after it (`catchUp`,
/// at launch, on the screen, after a notification). The end of each day and
/// of the fast come as notifications.
final class FastsProvider extends $NotifierProvider<Fasts, FastsState> {
  /// Mes jeûnes, on the phone (keys `fast_current`, `fast_history`): each day
  /// kept adds 1 to « Jeûne complet » (JC) or « Jeûne partiel » (JP) in the
  /// report of the day it ends, when the app opens again after it (`catchUp`,
  /// at launch, on the screen, after a notification). The end of each day and
  /// of the fast come as notifications.
  FastsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fastsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fastsHash();

  @$internal
  @override
  Fasts create() => Fasts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FastsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FastsState>(value),
    );
  }
}

String _$fastsHash() => r'bc3f8bbdab0cad88ec9369c654d986a0abb00ff9';

/// Mes jeûnes, on the phone (keys `fast_current`, `fast_history`): each day
/// kept adds 1 to « Jeûne complet » (JC) or « Jeûne partiel » (JP) in the
/// report of the day it ends, when the app opens again after it (`catchUp`,
/// at launch, on the screen, after a notification). The end of each day and
/// of the fast come as notifications.

abstract class _$Fasts extends $Notifier<FastsState> {
  FastsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<FastsState, FastsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FastsState, FastsState>,
              FastsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
