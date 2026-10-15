// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_topics.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The topics of the community for today: from the server, or the copy kept
/// on the phone.

@ProviderFor(PrayerTopics)
final prayerTopicsProvider = PrayerTopicsProvider._();

/// The topics of the community for today: from the server, or the copy kept
/// on the phone.
final class PrayerTopicsProvider
    extends $AsyncNotifierProvider<PrayerTopics, List<PrayerTopic>> {
  /// The topics of the community for today: from the server, or the copy kept
  /// on the phone.
  PrayerTopicsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerTopicsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerTopicsHash();

  @$internal
  @override
  PrayerTopics create() => PrayerTopics();
}

String _$prayerTopicsHash() => r'56dbea529afbcb77be0ed732e5a470e2330301d8';

/// The topics of the community for today: from the server, or the copy kept
/// on the phone.

abstract class _$PrayerTopics extends $AsyncNotifier<List<PrayerTopic>> {
  FutureOr<List<PrayerTopic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<PrayerTopic>>, List<PrayerTopic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<PrayerTopic>>, List<PrayerTopic>>,
              AsyncValue<List<PrayerTopic>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The topics that ended, the latest first.

@ProviderFor(pastPrayerTopics)
final pastPrayerTopicsProvider = PastPrayerTopicsProvider._();

/// The topics that ended, the latest first.

final class PastPrayerTopicsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PrayerTopic>>,
          List<PrayerTopic>,
          FutureOr<List<PrayerTopic>>
        >
    with
        $FutureModifier<List<PrayerTopic>>,
        $FutureProvider<List<PrayerTopic>> {
  /// The topics that ended, the latest first.
  PastPrayerTopicsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pastPrayerTopicsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pastPrayerTopicsHash();

  @$internal
  @override
  $FutureProviderElement<List<PrayerTopic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PrayerTopic>> create(Ref ref) {
    return pastPrayerTopics(ref);
  }
}

String _$pastPrayerTopicsHash() => r'bef5a265b326092826117c06d23aab47f4c4f7cc';
