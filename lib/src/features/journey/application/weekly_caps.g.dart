// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_caps.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The weekly caps chosen, by Monday of their week, kept on the phone (the
/// last eight weeks). A cap ends with its week: no penalty, no streak to
/// lose. Signing out forgets them.

@ProviderFor(WeeklyCaps)
final weeklyCapsProvider = WeeklyCapsProvider._();

/// The weekly caps chosen, by Monday of their week, kept on the phone (the
/// last eight weeks). A cap ends with its week: no penalty, no streak to
/// lose. Signing out forgets them.
final class WeeklyCapsProvider
    extends $NotifierProvider<WeeklyCaps, Map<DateTime, WeeklyCap>> {
  /// The weekly caps chosen, by Monday of their week, kept on the phone (the
  /// last eight weeks). A cap ends with its week: no penalty, no streak to
  /// lose. Signing out forgets them.
  WeeklyCapsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weeklyCapsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weeklyCapsHash();

  @$internal
  @override
  WeeklyCaps create() => WeeklyCaps();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<DateTime, WeeklyCap> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<DateTime, WeeklyCap>>(value),
    );
  }
}

String _$weeklyCapsHash() => r'762fb94036d848920f5bf1cfe6a99cdff71ba81f';

/// The weekly caps chosen, by Monday of their week, kept on the phone (the
/// last eight weeks). A cap ends with its week: no penalty, no streak to
/// lose. Signing out forgets them.

abstract class _$WeeklyCaps extends $Notifier<Map<DateTime, WeeklyCap>> {
  Map<DateTime, WeeklyCap> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<Map<DateTime, WeeklyCap>, Map<DateTime, WeeklyCap>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<DateTime, WeeklyCap>, Map<DateTime, WeeklyCap>>,
              Map<DateTime, WeeklyCap>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The weeks where the member said « pas cette semaine ». Kept so the app
/// doesn't ask again, without a cap and without a reproach.

@ProviderFor(WeeklyCapSkips)
final weeklyCapSkipsProvider = WeeklyCapSkipsProvider._();

/// The weeks where the member said « pas cette semaine ». Kept so the app
/// doesn't ask again, without a cap and without a reproach.
final class WeeklyCapSkipsProvider
    extends $NotifierProvider<WeeklyCapSkips, Set<DateTime>> {
  /// The weeks where the member said « pas cette semaine ». Kept so the app
  /// doesn't ask again, without a cap and without a reproach.
  WeeklyCapSkipsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weeklyCapSkipsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weeklyCapSkipsHash();

  @$internal
  @override
  WeeklyCapSkips create() => WeeklyCapSkips();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<DateTime> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<DateTime>>(value),
    );
  }
}

String _$weeklyCapSkipsHash() => r'4359905f2d2acc82c3923054a4030aa8742ded66';

/// The weeks where the member said « pas cette semaine ». Kept so the app
/// doesn't ask again, without a cap and without a reproach.

abstract class _$WeeklyCapSkips extends $Notifier<Set<DateTime>> {
  Set<DateTime> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<DateTime>, Set<DateTime>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<DateTime>, Set<DateTime>>,
              Set<DateTime>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The cap of [week], if one was chosen.

@ProviderFor(weeklyCap)
final weeklyCapProvider = WeeklyCapFamily._();

/// The cap of [week], if one was chosen.

final class WeeklyCapProvider
    extends $FunctionalProvider<WeeklyCap?, WeeklyCap?, WeeklyCap?>
    with $Provider<WeeklyCap?> {
  /// The cap of [week], if one was chosen.
  WeeklyCapProvider._({
    required WeeklyCapFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'weeklyCapProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$weeklyCapHash();

  @override
  String toString() {
    return r'weeklyCapProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<WeeklyCap?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WeeklyCap? create(Ref ref) {
    final argument = this.argument as DateTime;
    return weeklyCap(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeeklyCap? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeeklyCap?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is WeeklyCapProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$weeklyCapHash() => r'73189a2ba5e07f61922bd199536f6af98f3f3bcd';

/// The cap of [week], if one was chosen.

final class WeeklyCapFamily extends $Family
    with $FunctionalFamilyOverride<WeeklyCap?, DateTime> {
  WeeklyCapFamily._()
    : super(
        retry: null,
        name: r'weeklyCapProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The cap of [week], if one was chosen.

  WeeklyCapProvider call(DateTime week) =>
      WeeklyCapProvider._(argument: week, from: this);

  @override
  String toString() => r'weeklyCapProvider';
}

/// Three caps proposed for the week starting today: a few report days, a few
/// retreats, a few chapters. They follow the member's last week a little,
/// without ever asking too much.

@ProviderFor(weeklyCapOptions)
final weeklyCapOptionsProvider = WeeklyCapOptionsProvider._();

/// Three caps proposed for the week starting today: a few report days, a few
/// retreats, a few chapters. They follow the member's last week a little,
/// without ever asking too much.

final class WeeklyCapOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WeeklyCapSuggestion>>,
          List<WeeklyCapSuggestion>,
          FutureOr<List<WeeklyCapSuggestion>>
        >
    with
        $FutureModifier<List<WeeklyCapSuggestion>>,
        $FutureProvider<List<WeeklyCapSuggestion>> {
  /// Three caps proposed for the week starting today: a few report days, a few
  /// retreats, a few chapters. They follow the member's last week a little,
  /// without ever asking too much.
  WeeklyCapOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weeklyCapOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weeklyCapOptionsHash();

  @$internal
  @override
  $FutureProviderElement<List<WeeklyCapSuggestion>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WeeklyCapSuggestion>> create(Ref ref) {
    return weeklyCapOptions(ref);
  }
}

String _$weeklyCapOptionsHash() => r'87d510f88fa36cf52f7c6dd6cfebdd558890d4e8';

/// How far the cap of [week] went. null when no cap was chosen that week.

@ProviderFor(weeklyCapProgress)
final weeklyCapProgressProvider = WeeklyCapProgressFamily._();

/// How far the cap of [week] went. null when no cap was chosen that week.

final class WeeklyCapProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<WeeklyCapProgress?>,
          WeeklyCapProgress?,
          FutureOr<WeeklyCapProgress?>
        >
    with
        $FutureModifier<WeeklyCapProgress?>,
        $FutureProvider<WeeklyCapProgress?> {
  /// How far the cap of [week] went. null when no cap was chosen that week.
  WeeklyCapProgressProvider._({
    required WeeklyCapProgressFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'weeklyCapProgressProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$weeklyCapProgressHash();

  @override
  String toString() {
    return r'weeklyCapProgressProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<WeeklyCapProgress?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WeeklyCapProgress?> create(Ref ref) {
    final argument = this.argument as DateTime;
    return weeklyCapProgress(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WeeklyCapProgressProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$weeklyCapProgressHash() => r'1613e29498278ffedcf1ac0e810a35a9d7c181b3';

/// How far the cap of [week] went. null when no cap was chosen that week.

final class WeeklyCapProgressFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<WeeklyCapProgress?>, DateTime> {
  WeeklyCapProgressFamily._()
    : super(
        retry: null,
        name: r'weeklyCapProgressProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// How far the cap of [week] went. null when no cap was chosen that week.

  WeeklyCapProgressProvider call(DateTime week) =>
      WeeklyCapProgressProvider._(argument: week, from: this);

  @override
  String toString() => r'weeklyCapProgressProvider';
}
