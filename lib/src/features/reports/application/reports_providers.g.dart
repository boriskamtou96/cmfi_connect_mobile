// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Active report items (standard + personal), in display order. Without
/// network, the ones seen last time, so a day can still be filled in.

@ProviderFor(activities)
final activitiesProvider = ActivitiesProvider._();

/// Active report items (standard + personal), in display order. Without
/// network, the ones seen last time, so a day can still be filled in.

final class ActivitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ActivityType>>,
          List<ActivityType>,
          FutureOr<List<ActivityType>>
        >
    with
        $FutureModifier<List<ActivityType>>,
        $FutureProvider<List<ActivityType>> {
  /// Active report items (standard + personal), in display order. Without
  /// network, the ones seen last time, so a day can still be filled in.
  ActivitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<ActivityType>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ActivityType>> create(Ref ref) {
    return activities(ref);
  }
}

String _$activitiesHash() => r'3c92543eeb05641c54f91a7b362f32c96666093d';

/// The last history the server gave for each period, shown again while the
/// network is gone. In memory only.

@ProviderFor(lastHistory)
final lastHistoryProvider = LastHistoryProvider._();

/// The last history the server gave for each period, shown again while the
/// network is gone. In memory only.

final class LastHistoryProvider
    extends
        $FunctionalProvider<
          Map<(DateTime, DateTime), List<DailyReport>>,
          Map<(DateTime, DateTime), List<DailyReport>>,
          Map<(DateTime, DateTime), List<DailyReport>>
        >
    with $Provider<Map<(DateTime, DateTime), List<DailyReport>>> {
  /// The last history the server gave for each period, shown again while the
  /// network is gone. In memory only.
  LastHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lastHistoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lastHistoryHash();

  @$internal
  @override
  $ProviderElement<Map<(DateTime, DateTime), List<DailyReport>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<(DateTime, DateTime), List<DailyReport>> create(Ref ref) {
    return lastHistory(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    Map<(DateTime, DateTime), List<DailyReport>> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<Map<(DateTime, DateTime), List<DailyReport>>>(
            value,
          ),
    );
  }
}

String _$lastHistoryHash() => r'a26a845ace85fba0992a5feea05cf86caa4ca74e';

/// Days with a report between [from] and [to] (included), newest first.
/// The days saved offline and not sent yet are included, as the user sees them.

@ProviderFor(reportHistory)
final reportHistoryProvider = ReportHistoryFamily._();

/// Days with a report between [from] and [to] (included), newest first.
/// The days saved offline and not sent yet are included, as the user sees them.

final class ReportHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DailyReport>>,
          List<DailyReport>,
          FutureOr<List<DailyReport>>
        >
    with
        $FutureModifier<List<DailyReport>>,
        $FutureProvider<List<DailyReport>> {
  /// Days with a report between [from] and [to] (included), newest first.
  /// The days saved offline and not sent yet are included, as the user sees them.
  ReportHistoryProvider._({
    required ReportHistoryFamily super.from,
    required ({DateTime from, DateTime to}) super.argument,
  }) : super(
         retry: null,
         name: r'reportHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reportHistoryHash();

  @override
  String toString() {
    return r'reportHistoryProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<DailyReport>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<DailyReport>> create(Ref ref) {
    final argument = this.argument as ({DateTime from, DateTime to});
    return reportHistory(ref, from: argument.from, to: argument.to);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reportHistoryHash() => r'a420111e0bf955efff188d1bbc5f66b9d98f9a4a';

/// Days with a report between [from] and [to] (included), newest first.
/// The days saved offline and not sent yet are included, as the user sees them.

final class ReportHistoryFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<DailyReport>>,
          ({DateTime from, DateTime to})
        > {
  ReportHistoryFamily._()
    : super(
        retry: null,
        name: r'reportHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Days with a report between [from] and [to] (included), newest first.
  /// The days saved offline and not sent yet are included, as the user sees them.

  ReportHistoryProvider call({required DateTime from, required DateTime to}) =>
      ReportHistoryProvider._(argument: (from: from, to: to), from: this);

  @override
  String toString() => r'reportHistoryProvider';
}

/// Days in a row with a report, up to today (see [currentStreak]).

@ProviderFor(reportStreak)
final reportStreakProvider = ReportStreakProvider._();

/// Days in a row with a report, up to today (see [currentStreak]).

final class ReportStreakProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Days in a row with a report, up to today (see [currentStreak]).
  ReportStreakProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportStreakProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportStreakHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return reportStreak(ref);
  }
}

String _$reportStreakHash() => r'c4d3c3720310e6be54666ff637ee40b1f790adcc';

/// The dates that have a report in the week of [day] (Monday to Sunday).

@ProviderFor(reportedDaysOfWeek)
final reportedDaysOfWeekProvider = ReportedDaysOfWeekFamily._();

/// The dates that have a report in the week of [day] (Monday to Sunday).

final class ReportedDaysOfWeekProvider
    extends
        $FunctionalProvider<
          AsyncValue<Set<DateTime>>,
          Set<DateTime>,
          FutureOr<Set<DateTime>>
        >
    with $FutureModifier<Set<DateTime>>, $FutureProvider<Set<DateTime>> {
  /// The dates that have a report in the week of [day] (Monday to Sunday).
  ReportedDaysOfWeekProvider._({
    required ReportedDaysOfWeekFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'reportedDaysOfWeekProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reportedDaysOfWeekHash();

  @override
  String toString() {
    return r'reportedDaysOfWeekProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Set<DateTime>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Set<DateTime>> create(Ref ref) {
    final argument = this.argument as DateTime;
    return reportedDaysOfWeek(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportedDaysOfWeekProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reportedDaysOfWeekHash() =>
    r'e09c5397aeace76f3fa532010e66ba90f9ca5ad9';

/// The dates that have a report in the week of [day] (Monday to Sunday).

final class ReportedDaysOfWeekFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Set<DateTime>>, DateTime> {
  ReportedDaysOfWeekFamily._()
    : super(
        retry: null,
        name: r'reportedDaysOfWeekProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The dates that have a report in the week of [day] (Monday to Sunday).

  ReportedDaysOfWeekProvider call(DateTime day) =>
      ReportedDaysOfWeekProvider._(argument: day, from: this);

  @override
  String toString() => r'reportedDaysOfWeekProvider';
}

@ProviderFor(reportSummary)
final reportSummaryProvider = ReportSummaryFamily._();

final class ReportSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ReportSummary>,
          ReportSummary,
          FutureOr<ReportSummary>
        >
    with $FutureModifier<ReportSummary>, $FutureProvider<ReportSummary> {
  ReportSummaryProvider._({
    required ReportSummaryFamily super.from,
    required SummaryPeriod super.argument,
  }) : super(
         retry: null,
         name: r'reportSummaryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reportSummaryHash();

  @override
  String toString() {
    return r'reportSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ReportSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ReportSummary> create(Ref ref) {
    final argument = this.argument as SummaryPeriod;
    return reportSummary(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportSummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reportSummaryHash() => r'1faad6a77f1fb7e6f9aece88574f6c2016969ce3';

final class ReportSummaryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ReportSummary>, SummaryPeriod> {
  ReportSummaryFamily._()
    : super(
        retry: null,
        name: r'reportSummaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReportSummaryProvider call(SummaryPeriod period) =>
      ReportSummaryProvider._(argument: period, from: this);

  @override
  String toString() => r'reportSummaryProvider';
}

/// Kept alive so other tabs can open a given view (Home -> week -> history).

@ProviderFor(SelectedReportsView)
final selectedReportsViewProvider = SelectedReportsViewProvider._();

/// Kept alive so other tabs can open a given view (Home -> week -> history).
final class SelectedReportsViewProvider
    extends $NotifierProvider<SelectedReportsView, ReportsView> {
  /// Kept alive so other tabs can open a given view (Home -> week -> history).
  SelectedReportsViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedReportsViewProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedReportsViewHash();

  @$internal
  @override
  SelectedReportsView create() => SelectedReportsView();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsView value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsView>(value),
    );
  }
}

String _$selectedReportsViewHash() =>
    r'd75a2ad96754fda68d5bc73c84686101032a1208';

/// Kept alive so other tabs can open a given view (Home -> week -> history).

abstract class _$SelectedReportsView extends $Notifier<ReportsView> {
  ReportsView build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ReportsView, ReportsView>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReportsView, ReportsView>,
              ReportsView,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The day shown in the "Today" view. null means today, so the app follows
/// midnight without having to be restarted.

@ProviderFor(SelectedReportDay)
final selectedReportDayProvider = SelectedReportDayProvider._();

/// The day shown in the "Today" view. null means today, so the app follows
/// midnight without having to be restarted.
final class SelectedReportDayProvider
    extends $NotifierProvider<SelectedReportDay, DateTime?> {
  /// The day shown in the "Today" view. null means today, so the app follows
  /// midnight without having to be restarted.
  SelectedReportDayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedReportDayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedReportDayHash();

  @$internal
  @override
  SelectedReportDay create() => SelectedReportDay();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime?>(value),
    );
  }
}

String _$selectedReportDayHash() => r'ddb10b52dbadb6ea99796371615875daef9024c3';

/// The day shown in the "Today" view. null means today, so the app follows
/// midnight without having to be restarted.

abstract class _$SelectedReportDay extends $Notifier<DateTime?> {
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
