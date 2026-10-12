// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_admin.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Every event for the admins: drafts included, latest first.

@ProviderFor(adminEvents)
final adminEventsProvider = AdminEventsProvider._();

/// Every event for the admins: drafts included, latest first.

final class AdminEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CommunityEvent>>,
          List<CommunityEvent>,
          FutureOr<List<CommunityEvent>>
        >
    with
        $FutureModifier<List<CommunityEvent>>,
        $FutureProvider<List<CommunityEvent>> {
  /// Every event for the admins: drafts included, latest first.
  AdminEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<CommunityEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CommunityEvent>> create(Ref ref) {
    return adminEvents(ref);
  }
}

String _$adminEventsHash() => r'cb38cde6e85e6cf8d30d7202f1f17ca0c6a8dc1f';

/// Who registered for an event, with the totals (admins).

@ProviderFor(eventRegistrations)
final eventRegistrationsProvider = EventRegistrationsFamily._();

/// Who registered for an event, with the totals (admins).

final class EventRegistrationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventRegistrations>,
          EventRegistrations,
          FutureOr<EventRegistrations>
        >
    with
        $FutureModifier<EventRegistrations>,
        $FutureProvider<EventRegistrations> {
  /// Who registered for an event, with the totals (admins).
  EventRegistrationsProvider._({
    required EventRegistrationsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'eventRegistrationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventRegistrationsHash();

  @override
  String toString() {
    return r'eventRegistrationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EventRegistrations> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EventRegistrations> create(Ref ref) {
    final argument = this.argument as int;
    return eventRegistrations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventRegistrationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventRegistrationsHash() =>
    r'555f1e8d88fa70e6eea1f6f74f4e70078d45cefa';

/// Who registered for an event, with the totals (admins).

final class EventRegistrationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EventRegistrations>, int> {
  EventRegistrationsFamily._()
    : super(
        retry: null,
        name: r'eventRegistrationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Who registered for an event, with the totals (admins).

  EventRegistrationsProvider call(int eventId) =>
      EventRegistrationsProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventRegistrationsProvider';
}

@ProviderFor(eventAdmin)
final eventAdminProvider = EventAdminProvider._();

final class EventAdminProvider
    extends $FunctionalProvider<EventAdmin, EventAdmin, EventAdmin>
    with $Provider<EventAdmin> {
  EventAdminProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventAdminProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventAdminHash();

  @$internal
  @override
  $ProviderElement<EventAdmin> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventAdmin create(Ref ref) {
    return eventAdmin(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventAdmin value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventAdmin>(value),
    );
  }
}

String _$eventAdminHash() => r'4e9633cdd0d9095cb67f03660d0230c427cc3cb5';
