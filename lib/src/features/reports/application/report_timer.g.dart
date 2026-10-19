// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_timer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The one stopwatch that can run (key `report_timer`), null without one.
/// The minutes counted for each source are kept apart (key
/// `report_timer_sources`: "importunity:7" → minutes).

@ProviderFor(ReportTimer)
final reportTimerProvider = ReportTimerProvider._();

/// The one stopwatch that can run (key `report_timer`), null without one.
/// The minutes counted for each source are kept apart (key
/// `report_timer_sources`: "importunity:7" → minutes).
final class ReportTimerProvider
    extends $NotifierProvider<ReportTimer, RunningTimer?> {
  /// The one stopwatch that can run (key `report_timer`), null without one.
  /// The minutes counted for each source are kept apart (key
  /// `report_timer_sources`: "importunity:7" → minutes).
  ReportTimerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportTimerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportTimerHash();

  @$internal
  @override
  ReportTimer create() => ReportTimer();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RunningTimer? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RunningTimer?>(value),
    );
  }
}

String _$reportTimerHash() => r'7aaeef1cbf07a98144edad7acf799ad8a3a0a3cb';

/// The one stopwatch that can run (key `report_timer`), null without one.
/// The minutes counted for each source are kept apart (key
/// `report_timer_sources`: "importunity:7" → minutes).

abstract class _$ReportTimer extends $Notifier<RunningTimer?> {
  RunningTimer? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<RunningTimer?, RunningTimer?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RunningTimer?, RunningTimer?>,
              RunningTimer?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
