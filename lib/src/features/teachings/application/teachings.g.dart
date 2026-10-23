// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teachings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The teachings that answer [search] in [category] ('' for all), a page at
/// a time: the first one at once, the next ones at the end of the list.
/// Without a search, the first page kept on the phone shows at once
/// ([FetchPolicy.cacheAndNetwork]); a search asks the server. Without
/// network the copy gives way to the error: the screen then lists the
/// messages downloaded, the only ones that play offline.

@ProviderFor(Teachings)
final teachingsProvider = TeachingsFamily._();

/// The teachings that answer [search] in [category] ('' for all), a page at
/// a time: the first one at once, the next ones at the end of the list.
/// Without a search, the first page kept on the phone shows at once
/// ([FetchPolicy.cacheAndNetwork]); a search asks the server. Without
/// network the copy gives way to the error: the screen then lists the
/// messages downloaded, the only ones that play offline.
final class TeachingsProvider
    extends $AsyncNotifierProvider<Teachings, TeachingsState> {
  /// The teachings that answer [search] in [category] ('' for all), a page at
  /// a time: the first one at once, the next ones at the end of the list.
  /// Without a search, the first page kept on the phone shows at once
  /// ([FetchPolicy.cacheAndNetwork]); a search asks the server. Without
  /// network the copy gives way to the error: the screen then lists the
  /// messages downloaded, the only ones that play offline.
  TeachingsProvider._({
    required TeachingsFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'teachingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$teachingsHash();

  @override
  String toString() {
    return r'teachingsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  Teachings create() => Teachings();

  @override
  bool operator ==(Object other) {
    return other is TeachingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$teachingsHash() => r'27011961166db8410c3cc49a11f6ffb5cf21f65a';

/// The teachings that answer [search] in [category] ('' for all), a page at
/// a time: the first one at once, the next ones at the end of the list.
/// Without a search, the first page kept on the phone shows at once
/// ([FetchPolicy.cacheAndNetwork]); a search asks the server. Without
/// network the copy gives way to the error: the screen then lists the
/// messages downloaded, the only ones that play offline.

final class TeachingsFamily extends $Family
    with
        $ClassFamilyOverride<
          Teachings,
          AsyncValue<TeachingsState>,
          TeachingsState,
          FutureOr<TeachingsState>,
          (String, String)
        > {
  TeachingsFamily._()
    : super(
        retry: null,
        name: r'teachingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The teachings that answer [search] in [category] ('' for all), a page at
  /// a time: the first one at once, the next ones at the end of the list.
  /// Without a search, the first page kept on the phone shows at once
  /// ([FetchPolicy.cacheAndNetwork]); a search asks the server. Without
  /// network the copy gives way to the error: the screen then lists the
  /// messages downloaded, the only ones that play offline.

  TeachingsProvider call(String search, String category) =>
      TeachingsProvider._(argument: (search, category), from: this);

  @override
  String toString() => r'teachingsProvider';
}

/// The teachings that answer [search] in [category] ('' for all), a page at
/// a time: the first one at once, the next ones at the end of the list.
/// Without a search, the first page kept on the phone shows at once
/// ([FetchPolicy.cacheAndNetwork]); a search asks the server. Without
/// network the copy gives way to the error: the screen then lists the
/// messages downloaded, the only ones that play offline.

abstract class _$Teachings extends $AsyncNotifier<TeachingsState> {
  late final _$args = ref.$arg as (String, String);
  String get search => _$args.$1;
  String get category => _$args.$2;

  FutureOr<TeachingsState> build(String search, String category);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<TeachingsState>, TeachingsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TeachingsState>, TeachingsState>,
              AsyncValue<TeachingsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

/// The categories of the published teachings: the chips above the list;
/// none without network (the list says why).

@ProviderFor(teachingCategories)
final teachingCategoriesProvider = TeachingCategoriesProvider._();

/// The categories of the published teachings: the chips above the list;
/// none without network (the list says why).

final class TeachingCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TeachingCategory>>,
          List<TeachingCategory>,
          FutureOr<List<TeachingCategory>>
        >
    with
        $FutureModifier<List<TeachingCategory>>,
        $FutureProvider<List<TeachingCategory>> {
  /// The categories of the published teachings: the chips above the list;
  /// none without network (the list says why).
  TeachingCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teachingCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teachingCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<TeachingCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TeachingCategory>> create(Ref ref) {
    return teachingCategories(ref);
  }
}

String _$teachingCategoriesHash() =>
    r'9aa0a40712cda02837dc2ade27eef7caf6e0c17a';

/// The latest teachings, for « À écouter » on the home screen (its own
/// list: the Enseignements page keeps loading its own); none without
/// network.

@ProviderFor(latestTeachings)
final latestTeachingsProvider = LatestTeachingsProvider._();

/// The latest teachings, for « À écouter » on the home screen (its own
/// list: the Enseignements page keeps loading its own); none without
/// network.

final class LatestTeachingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Teaching>>,
          List<Teaching>,
          FutureOr<List<Teaching>>
        >
    with $FutureModifier<List<Teaching>>, $FutureProvider<List<Teaching>> {
  /// The latest teachings, for « À écouter » on the home screen (its own
  /// list: the Enseignements page keeps loading its own); none without
  /// network.
  LatestTeachingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'latestTeachingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$latestTeachingsHash();

  @$internal
  @override
  $FutureProviderElement<List<Teaching>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Teaching>> create(Ref ref) {
    return latestTeachings(ref);
  }
}

String _$latestTeachingsHash() => r'e06ae84ed9cbfd621ed3755843ebed3de1dd3c7e';
