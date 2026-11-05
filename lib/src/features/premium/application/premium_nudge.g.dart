// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_nudge.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// When the member last hid the Premium card of the home screen (kept on the
/// phone); null when never.

@ProviderFor(PremiumNudgeHidden)
final premiumNudgeHiddenProvider = PremiumNudgeHiddenProvider._();

/// When the member last hid the Premium card of the home screen (kept on the
/// phone); null when never.
final class PremiumNudgeHiddenProvider
    extends $NotifierProvider<PremiumNudgeHidden, DateTime?> {
  /// When the member last hid the Premium card of the home screen (kept on the
  /// phone); null when never.
  PremiumNudgeHiddenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'premiumNudgeHiddenProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$premiumNudgeHiddenHash();

  @$internal
  @override
  PremiumNudgeHidden create() => PremiumNudgeHidden();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$premiumNudgeHiddenHash() =>
    r'bf6ff60f767368f7b414b1e116bdc627b10181cb';

/// When the member last hid the Premium card of the home screen (kept on the
/// phone); null when never.

abstract class _$PremiumNudgeHidden extends $Notifier<DateTime?> {
  DateTime? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime?, DateTime?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime?, DateTime?>,
              DateTime?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
