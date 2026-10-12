// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retreat_reminders.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The reminders of the retreats: a time per retreat, or none (off). Kept on
/// the phone; the next [plannedDays] days are planned at once, without the
/// retreats already made today.

@ProviderFor(RetreatReminders)
final retreatRemindersProvider = RetreatRemindersProvider._();

/// The reminders of the retreats: a time per retreat, or none (off). Kept on
/// the phone; the next [plannedDays] days are planned at once, without the
/// retreats already made today.
final class RetreatRemindersProvider
    extends
        $NotifierProvider<RetreatReminders, Map<RetreatMoment, TimeOfDay?>> {
  /// The reminders of the retreats: a time per retreat, or none (off). Kept on
  /// the phone; the next [plannedDays] days are planned at once, without the
  /// retreats already made today.
  RetreatRemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'retreatRemindersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$retreatRemindersHash();

  @$internal
  @override
  RetreatReminders create() => RetreatReminders();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<RetreatMoment, TimeOfDay?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<RetreatMoment, TimeOfDay?>>(
        value,
      ),
    );
  }
}

String _$retreatRemindersHash() => r'b21d617f7f9e4c3a5c6f4bcc2e02102ea2141f3d';

/// The reminders of the retreats: a time per retreat, or none (off). Kept on
/// the phone; the next [plannedDays] days are planned at once, without the
/// retreats already made today.

abstract class _$RetreatReminders
    extends $Notifier<Map<RetreatMoment, TimeOfDay?>> {
  Map<RetreatMoment, TimeOfDay?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              Map<RetreatMoment, TimeOfDay?>,
              Map<RetreatMoment, TimeOfDay?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                Map<RetreatMoment, TimeOfDay?>,
                Map<RetreatMoment, TimeOfDay?>
              >,
              Map<RetreatMoment, TimeOfDay?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
