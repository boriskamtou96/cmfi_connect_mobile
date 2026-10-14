// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_milestones.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The streak milestones already celebrated (7, 30, 100, 365 days), kept on
/// the phone for the account: each one is celebrated once. Signing out
/// forgets them.

@ProviderFor(StreakMilestones)
final streakMilestonesProvider = StreakMilestonesProvider._();

/// The streak milestones already celebrated (7, 30, 100, 365 days), kept on
/// the phone for the account: each one is celebrated once. Signing out
/// forgets them.
final class StreakMilestonesProvider
    extends $NotifierProvider<StreakMilestones, Set<int>> {
  /// The streak milestones already celebrated (7, 30, 100, 365 days), kept on
  /// the phone for the account: each one is celebrated once. Signing out
  /// forgets them.
  StreakMilestonesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'streakMilestonesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$streakMilestonesHash();

  @$internal
  @override
  StreakMilestones create() => StreakMilestones();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<int>>(value),
    );
  }
}

String _$streakMilestonesHash() => r'e6b4cb3e6adda1e059275554ecb206698284ef8b';

/// The streak milestones already celebrated (7, 30, 100, 365 days), kept on
/// the phone for the account: each one is celebrated once. Signing out
/// forgets them.

abstract class _$StreakMilestones extends $Notifier<Set<int>> {
  Set<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<int>, Set<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<int>, Set<int>>,
              Set<int>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
