// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_path.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The course shown in the tab (null: the first one), kept between tabs.

@ProviderFor(SelectedGameCourse)
final selectedGameCourseProvider = SelectedGameCourseProvider._();

/// The course shown in the tab (null: the first one), kept between tabs.
final class SelectedGameCourseProvider
    extends $NotifierProvider<SelectedGameCourse, String?> {
  /// The course shown in the tab (null: the first one), kept between tabs.
  SelectedGameCourseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedGameCourseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedGameCourseHash();

  @$internal
  @override
  SelectedGameCourse create() => SelectedGameCourse();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedGameCourseHash() =>
    r'8c524e72e83cc6e66c611c3816904444ba0fd733';

/// The course shown in the tab (null: the first one), kept between tabs.

abstract class _$SelectedGameCourse extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The path of the course shown, as the member walks it. Null while no
/// course is published: the tab says the games are coming.

@ProviderFor(gamePath)
final gamePathProvider = GamePathProvider._();

/// The path of the course shown, as the member walks it. Null while no
/// course is published: the tab says the games are coming.

final class GamePathProvider
    extends
        $FunctionalProvider<
          AsyncValue<GamePath?>,
          GamePath?,
          FutureOr<GamePath?>
        >
    with $FutureModifier<GamePath?>, $FutureProvider<GamePath?> {
  /// The path of the course shown, as the member walks it. Null while no
  /// course is published: the tab says the games are coming.
  GamePathProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gamePathProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gamePathHash();

  @$internal
  @override
  $FutureProviderElement<GamePath?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<GamePath?> create(Ref ref) {
    return gamePath(ref);
  }
}

String _$gamePathHash() => r'c1c230be38894517dc0ed09b11fef8ef9707f6b8';
