// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lock_screen_timer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(lockScreenTimer)
final lockScreenTimerProvider = LockScreenTimerProvider._();

final class LockScreenTimerProvider
    extends
        $FunctionalProvider<LockScreenTimer, LockScreenTimer, LockScreenTimer>
    with $Provider<LockScreenTimer> {
  LockScreenTimerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lockScreenTimerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lockScreenTimerHash();

  @$internal
  @override
  $ProviderElement<LockScreenTimer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LockScreenTimer create(Ref ref) {
    return lockScreenTimer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LockScreenTimer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LockScreenTimer>(value),
    );
  }
}

String _$lockScreenTimerHash() => r'd503ce049b94b5fcaf0bf40925f4120475239093';
