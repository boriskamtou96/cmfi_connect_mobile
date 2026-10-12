// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_people.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's own lists (those who have not believed yet, believers,
/// backsliders, co-workers): from the server, or the copy kept on the phone.

@ProviderFor(PrayerPeople)
final prayerPeopleProvider = PrayerPeopleProvider._();

/// The user's own lists (those who have not believed yet, believers,
/// backsliders, co-workers): from the server, or the copy kept on the phone.
final class PrayerPeopleProvider
    extends $AsyncNotifierProvider<PrayerPeople, List<PrayerPerson>> {
  /// The user's own lists (those who have not believed yet, believers,
  /// backsliders, co-workers): from the server, or the copy kept on the phone.
  PrayerPeopleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerPeopleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerPeopleHash();

  @$internal
  @override
  PrayerPeople create() => PrayerPeople();
}

String _$prayerPeopleHash() => r'f4b33cb83f6d96ae941c88169fc36540a5b7386a';

/// The user's own lists (those who have not believed yet, believers,
/// backsliders, co-workers): from the server, or the copy kept on the phone.

abstract class _$PrayerPeople extends $AsyncNotifier<List<PrayerPerson>> {
  FutureOr<List<PrayerPerson>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PrayerPerson>>, List<PrayerPerson>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PrayerPerson>>, List<PrayerPerson>>,
              AsyncValue<List<PrayerPerson>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// This month's answered prayers, the latest first (the Prière tab).

@ProviderFor(answeredThisMonth)
final answeredThisMonthProvider = AnsweredThisMonthProvider._();

/// This month's answered prayers, the latest first (the Prière tab).

final class AnsweredThisMonthProvider
    extends
        $FunctionalProvider<
          List<PrayerPerson>,
          List<PrayerPerson>,
          List<PrayerPerson>
        >
    with $Provider<List<PrayerPerson>> {
  /// This month's answered prayers, the latest first (the Prière tab).
  AnsweredThisMonthProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'answeredThisMonthProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$answeredThisMonthHash();

  @$internal
  @override
  $ProviderElement<List<PrayerPerson>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PrayerPerson> create(Ref ref) {
    return answeredThisMonth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PrayerPerson> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PrayerPerson>>(value),
    );
  }
}

String _$answeredThisMonthHash() => r'99a8f698a84eddb0c217fb5e44408134a2642352';
