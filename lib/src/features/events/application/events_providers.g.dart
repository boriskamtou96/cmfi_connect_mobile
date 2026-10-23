// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Upcoming or past events ([FetchPolicy.cacheAndNetwork]): the last list
/// kept on the phone at once, then the server's; without network, the list
/// kept stays.

@ProviderFor(EventList)
final eventListProvider = EventListFamily._();

/// Upcoming or past events ([FetchPolicy.cacheAndNetwork]): the last list
/// kept on the phone at once, then the server's; without network, the list
/// kept stays.
final class EventListProvider
    extends $AsyncNotifierProvider<EventList, List<CommunityEvent>> {
  /// Upcoming or past events ([FetchPolicy.cacheAndNetwork]): the last list
  /// kept on the phone at once, then the server's; without network, the list
  /// kept stays.
  EventListProvider._({
    required EventListFamily super.from,
    required EventPeriod super.argument,
  }) : super(
         retry: null,
         name: r'eventListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventListHash();

  @override
  String toString() {
    return r'eventListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventList create() => EventList();

  @override
  bool operator ==(Object other) {
    return other is EventListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventListHash() => r'153a340ba6f0adb615d3fd89774a130bbdcf5063';

/// Upcoming or past events ([FetchPolicy.cacheAndNetwork]): the last list
/// kept on the phone at once, then the server's; without network, the list
/// kept stays.

final class EventListFamily extends $Family
    with
        $ClassFamilyOverride<
          EventList,
          AsyncValue<List<CommunityEvent>>,
          List<CommunityEvent>,
          FutureOr<List<CommunityEvent>>,
          EventPeriod
        > {
  EventListFamily._()
    : super(
        retry: null,
        name: r'eventListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Upcoming or past events ([FetchPolicy.cacheAndNetwork]): the last list
  /// kept on the phone at once, then the server's; without network, the list
  /// kept stays.

  EventListProvider call(EventPeriod period) =>
      EventListProvider._(argument: period, from: this);

  @override
  String toString() => r'eventListProvider';
}

/// Upcoming or past events ([FetchPolicy.cacheAndNetwork]): the last list
/// kept on the phone at once, then the server's; without network, the list
/// kept stays.

abstract class _$EventList extends $AsyncNotifier<List<CommunityEvent>> {
  late final _$args = ref.$arg as EventPeriod;
  EventPeriod get period => _$args;

  FutureOr<List<CommunityEvent>> build(EventPeriod period);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<CommunityEvent>>, List<CommunityEvent>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CommunityEvent>>,
                List<CommunityEvent>
              >,
              AsyncValue<List<CommunityEvent>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// The event of the home card: the one going on, or the next one.

@ProviderFor(nextEvent)
final nextEventProvider = NextEventProvider._();

/// The event of the home card: the one going on, or the next one.

final class NextEventProvider
    extends
        $FunctionalProvider<
          AsyncValue<CommunityEvent?>,
          CommunityEvent?,
          FutureOr<CommunityEvent?>
        >
    with $FutureModifier<CommunityEvent?>, $FutureProvider<CommunityEvent?> {
  /// The event of the home card: the one going on, or the next one.
  NextEventProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nextEventProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nextEventHash();

  @$internal
  @override
  $FutureProviderElement<CommunityEvent?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CommunityEvent?> create(Ref ref) {
    return nextEvent(ref);
  }
}

String _$nextEventHash() => r'bb35a81715b77d944638eeed209ebc66148ea75c';

/// The whole event (program, news, photos, the user's registration).

@ProviderFor(EventDetail)
final eventDetailProvider = EventDetailFamily._();

/// The whole event (program, news, photos, the user's registration).
final class EventDetailProvider
    extends $AsyncNotifierProvider<EventDetail, CommunityEvent> {
  /// The whole event (program, news, photos, the user's registration).
  EventDetailProvider._({
    required EventDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailHash();

  @override
  String toString() {
    return r'eventDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventDetail create() => EventDetail();

  @override
  bool operator ==(Object other) {
    return other is EventDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailHash() => r'1a112e26223f57539d858f3d8d74104f3e28eb45';

/// The whole event (program, news, photos, the user's registration).

final class EventDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          EventDetail,
          AsyncValue<CommunityEvent>,
          CommunityEvent,
          FutureOr<CommunityEvent>,
          int
        > {
  EventDetailFamily._()
    : super(
        retry: null,
        name: r'eventDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The whole event (program, news, photos, the user's registration).

  EventDetailProvider call(int id) =>
      EventDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'eventDetailProvider';
}

/// The whole event (program, news, photos, the user's registration).

abstract class _$EventDetail extends $AsyncNotifier<CommunityEvent> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<CommunityEvent> build(int id);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CommunityEvent>, CommunityEvent>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CommunityEvent>, CommunityEvent>,
              AsyncValue<CommunityEvent>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
