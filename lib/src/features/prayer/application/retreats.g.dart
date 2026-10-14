// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retreats.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The texts of the retreats in [language], French when it has none.

@ProviderFor(retreatContent)
final retreatContentProvider = RetreatContentFamily._();

/// The texts of the retreats in [language], French when it has none.

final class RetreatContentProvider
    extends
        $FunctionalProvider<
          AsyncValue<RetreatContent>,
          RetreatContent,
          FutureOr<RetreatContent>
        >
    with $FutureModifier<RetreatContent>, $FutureProvider<RetreatContent> {
  /// The texts of the retreats in [language], French when it has none.
  RetreatContentProvider._({
    required RetreatContentFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'retreatContentProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$retreatContentHash();

  @override
  String toString() {
    return r'retreatContentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<RetreatContent> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RetreatContent> create(Ref ref) {
    final argument = this.argument as String;
    return retreatContent(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RetreatContentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$retreatContentHash() => r'7354bdb25c54c268b8616ef8c84597770001dbee';

/// The texts of the retreats in [language], French when it has none.

final class RetreatContentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<RetreatContent>, String> {
  RetreatContentFamily._()
    : super(
        retry: null,
        name: r'retreatContentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// The texts of the retreats in [language], French when it has none.

  RetreatContentProvider call(String language) =>
      RetreatContentProvider._(argument: language, from: this);

  @override
  String toString() => r'retreatContentProvider';
}

/// The fifteen points of a retreat, filled with the user's data. Without
/// network, what is kept on the phone (or nothing) fills them.

@ProviderFor(retreatPlan)
final retreatPlanProvider = RetreatPlanFamily._();

/// The fifteen points of a retreat, filled with the user's data. Without
/// network, what is kept on the phone (or nothing) fills them.

final class RetreatPlanProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PlannedPoint>>,
          List<PlannedPoint>,
          FutureOr<List<PlannedPoint>>
        >
    with
        $FutureModifier<List<PlannedPoint>>,
        $FutureProvider<List<PlannedPoint>> {
  /// The fifteen points of a retreat, filled with the user's data. Without
  /// network, what is kept on the phone (or nothing) fills them.
  RetreatPlanProvider._({
    required RetreatPlanFamily super.from,
    required (RetreatMoment, String) super.argument,
  }) : super(
         retry: null,
         name: r'retreatPlanProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$retreatPlanHash();

  @override
  String toString() {
    return r'retreatPlanProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<PlannedPoint>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PlannedPoint>> create(Ref ref) {
    final argument = this.argument as (RetreatMoment, String);
    return retreatPlan(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is RetreatPlanProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$retreatPlanHash() => r'fb939c28b137f8c57c0c3122caa16ce7018e519b';

/// The fifteen points of a retreat, filled with the user's data. Without
/// network, what is kept on the phone (or nothing) fills them.

final class RetreatPlanFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<PlannedPoint>>,
          (RetreatMoment, String)
        > {
  RetreatPlanFamily._()
    : super(
        retry: null,
        name: r'retreatPlanProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The fifteen points of a retreat, filled with the user's data. Without
  /// network, what is kept on the phone (or nothing) fills them.

  RetreatPlanProvider call(RetreatMoment moment, String language) =>
      RetreatPlanProvider._(argument: (moment, language), from: this);

  @override
  String toString() => r'retreatPlanProvider';
}

/// The retreats of the last week: from the server, with those made without
/// network (sent as soon as it comes back).

@ProviderFor(RetreatLog)
final retreatLogProvider = RetreatLogProvider._();

/// The retreats of the last week: from the server, with those made without
/// network (sent as soon as it comes back).
final class RetreatLogProvider
    extends $AsyncNotifierProvider<RetreatLog, List<RetreatRecord>> {
  /// The retreats of the last week: from the server, with those made without
  /// network (sent as soon as it comes back).
  RetreatLogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'retreatLogProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$retreatLogHash();

  @$internal
  @override
  RetreatLog create() => RetreatLog();
}

String _$retreatLogHash() => r'61c39d373fb6ee3ca2c903c2732ce1d9fed4a9e0';

/// The retreats of the last week: from the server, with those made without
/// network (sent as soon as it comes back).

abstract class _$RetreatLog extends $AsyncNotifier<List<RetreatRecord>> {
  FutureOr<List<RetreatRecord>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<RetreatRecord>>, List<RetreatRecord>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<RetreatRecord>>, List<RetreatRecord>>,
              AsyncValue<List<RetreatRecord>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The retreats made today.

@ProviderFor(retreatsToday)
final retreatsTodayProvider = RetreatsTodayProvider._();

/// The retreats made today.

final class RetreatsTodayProvider
    extends
        $FunctionalProvider<
          Set<RetreatMoment>,
          Set<RetreatMoment>,
          Set<RetreatMoment>
        >
    with $Provider<Set<RetreatMoment>> {
  /// The retreats made today.
  RetreatsTodayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'retreatsTodayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$retreatsTodayHash();

  @$internal
  @override
  $ProviderElement<Set<RetreatMoment>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Set<RetreatMoment> create(Ref ref) {
    return retreatsToday(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<RetreatMoment> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<RetreatMoment>>(value),
    );
  }
}

String _$retreatsTodayHash() => r'996d8cfea0e737aebcd1a9b267871e37dcc3dabc';

/// Adds the minutes of a retreat to "Prière seule" in today's report (and
/// takes them back for "Annuler"). null when the report has no such item.

@ProviderFor(RetreatReport)
final retreatReportProvider = RetreatReportProvider._();

/// Adds the minutes of a retreat to "Prière seule" in today's report (and
/// takes them back for "Annuler"). null when the report has no such item.
final class RetreatReportProvider
    extends $NotifierProvider<RetreatReport, void> {
  /// Adds the minutes of a retreat to "Prière seule" in today's report (and
  /// takes them back for "Annuler"). null when the report has no such item.
  RetreatReportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'retreatReportProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$retreatReportHash();

  @$internal
  @override
  RetreatReport create() => RetreatReport();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$retreatReportHash() => r'd94776cfeb9d24d64632217ddc700073593be8b3';

/// Adds the minutes of a retreat to "Prière seule" in today's report (and
/// takes them back for "Annuler"). null when the report has no such item.

abstract class _$RetreatReport extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
