// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_timer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The one stopwatch that can run (key `report_timer`), null without one.

@ProviderFor(ReportTimer)
final reportTimerProvider = ReportTimerProvider._();

/// The one stopwatch that can run (key `report_timer`), null without one.
final class ReportTimerProvider
    extends $NotifierProvider<ReportTimer, RunningTimer?> {
  /// The one stopwatch that can run (key `report_timer`), null without one.
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

String _$reportTimerHash() => r'df6679a72e33aba9c88884e494bb9f15b4331c7c';

/// The one stopwatch that can run (key `report_timer`), null without one.

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
