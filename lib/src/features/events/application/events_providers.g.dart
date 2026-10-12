// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Upcoming or past events: from the server, or its last answer kept on the
/// phone when there is no network.

@ProviderFor(eventList)
final eventListProvider = EventListFamily._();

/// Upcoming or past events: from the server, or its last answer kept on the
/// phone when there is no network.

final class EventListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CommunityEvent>>,
          List<CommunityEvent>,
          FutureOr<List<CommunityEvent>>
        >
    with
        $FutureModifier<List<CommunityEvent>>,
        $FutureProvider<List<CommunityEvent>> {
  /// Upcoming or past events: from the server, or its last answer kept on the
  /// phone when there is no network.
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
  $FutureProviderElement<List<CommunityEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CommunityEvent>> create(Ref ref) {
    final argument = this.argument as EventPeriod;
    return eventList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventListHash() => r'eb6ec39b1269b04785bdfa88959788dd13231d5c';

/// Upcoming or past events: from the server, or its last answer kept on the
/// phone when there is no network.

final class EventListFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<CommunityEvent>>, EventPeriod> {
  EventListFamily._()
    : super(
        retry: null,
        name: r'eventListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Upcoming or past events: from the server, or its last answer kept on the
  /// phone when there is no network.

  EventListProvider call(EventPeriod period) =>
      EventListProvider._(argument: period, from: this);

  @override
  String toString() => r'eventListProvider';
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

String _$eventDetailHash() => r'ed999983d9bb43e4b8f7fe8f466c100095b2f869';

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
