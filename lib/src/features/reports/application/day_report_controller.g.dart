// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// One day of report. A day with unsaved changes stays in memory (switching
/// day or tab doesn't lose it) until it is saved. Without network, the day
/// shown is the one kept on the phone, and a save waits there to be sent.

@ProviderFor(DayReportController)
final dayReportControllerProvider = DayReportControllerFamily._();

/// One day of report. A day with unsaved changes stays in memory (switching
/// day or tab doesn't lose it) until it is saved. Without network, the day
/// shown is the one kept on the phone, and a save waits there to be sent.
final class DayReportControllerProvider
    extends $AsyncNotifierProvider<DayReportController, DayDraft> {
  /// One day of report. A day with unsaved changes stays in memory (switching
  /// day or tab doesn't lose it) until it is saved. Without network, the day
  /// shown is the one kept on the phone, and a save waits there to be sent.
  DayReportControllerProvider._({
    required DayReportControllerFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'dayReportControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dayReportControllerHash();

  @override
  String toString() {
    return r'dayReportControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DayReportController create() => DayReportController();

  @override
  bool operator ==(Object other) {
    return other is DayReportControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dayReportControllerHash() =>
    r'586ed71be8130dc8961ee822524ea5d1ec0be28f';

/// One day of report. A day with unsaved changes stays in memory (switching
/// day or tab doesn't lose it) until it is saved. Without network, the day
/// shown is the one kept on the phone, and a save waits there to be sent.

final class DayReportControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          DayReportController,
          AsyncValue<DayDraft>,
          DayDraft,
          FutureOr<DayDraft>,
          DateTime
        > {
  DayReportControllerFamily._()
    : super(
        retry: null,
        name: r'dayReportControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One day of report. A day with unsaved changes stays in memory (switching
  /// day or tab doesn't lose it) until it is saved. Without network, the day
  /// shown is the one kept on the phone, and a save waits there to be sent.

  DayReportControllerProvider call(DateTime date) =>
      DayReportControllerProvider._(argument: date, from: this);

  @override
  String toString() => r'dayReportControllerProvider';
}

/// One day of report. A day with unsaved changes stays in memory (switching
/// day or tab doesn't lose it) until it is saved. Without network, the day
/// shown is the one kept on the phone, and a save waits there to be sent.

abstract class _$DayReportController extends $AsyncNotifier<DayDraft> {
  late final _$args = ref.$arg as DateTime;
  DateTime get date => _$args;

  FutureOr<DayDraft> build(DateTime date);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DayDraft>, DayDraft>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DayDraft>, DayDraft>,
              AsyncValue<DayDraft>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
