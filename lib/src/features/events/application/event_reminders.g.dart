// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_reminders.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventReminders)
final eventRemindersProvider = EventRemindersProvider._();

final class EventRemindersProvider
    extends $FunctionalProvider<EventReminders, EventReminders, EventReminders>
    with $Provider<EventReminders> {
  EventRemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventRemindersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventRemindersHash();

  @$internal
  @override
  $ProviderElement<EventReminders> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventReminders create(Ref ref) {
    return eventReminders(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventReminders value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventReminders>(value),
    );
  }
}

String _$eventRemindersHash() => r'4ffa8be43936e13fdeca71783cf49056d06a5d19';
