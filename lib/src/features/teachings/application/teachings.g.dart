// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teachings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The teachings that answer [query], a page at a time: the first one at
/// once, the next ones at the end of the list. Without a search nor the
/// advanced filters, the first page kept on the phone shows at once
/// ([FetchPolicy.cacheAndNetwork]); a search or a filter asks the server.
/// Without network the copy gives way to the error: the screen then lists
/// the messages downloaded, the only ones that play offline.

@ProviderFor(Teachings)
final teachingsProvider = TeachingsFamily._();

/// The teachings that answer [query], a page at a time: the first one at
/// once, the next ones at the end of the list. Without a search nor the
/// advanced filters, the first page kept on the phone shows at once
/// ([FetchPolicy.cacheAndNetwork]); a search or a filter asks the server.
/// Without network the copy gives way to the error: the screen then lists
/// the messages downloaded, the only ones that play offline.
final class TeachingsProvider
    extends $AsyncNotifierProvider<Teachings, TeachingsState> {
  /// The teachings that answer [query], a page at a time: the first one at
  /// once, the next ones at the end of the list. Without a search nor the
  /// advanced filters, the first page kept on the phone shows at once
  /// ([FetchPolicy.cacheAndNetwork]); a search or a filter asks the server.
  /// Without network the copy gives way to the error: the screen then lists
  /// the messages downloaded, the only ones that play offline.
  TeachingsProvider._({
    required TeachingsFamily super.from,
    required TeachingQuery super.argument,
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
        '($argument)';
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

String _$teachingsHash() => r'f65d8e23e118c66d264b93f85089936121b26664';

/// The teachings that answer [query], a page at a time: the first one at
/// once, the next ones at the end of the list. Without a search nor the
/// advanced filters, the first page kept on the phone shows at once
/// ([FetchPolicy.cacheAndNetwork]); a search or a filter asks the server.
/// Without network the copy gives way to the error: the screen then lists
/// the messages downloaded, the only ones that play offline.

final class TeachingsFamily extends $Family
    with
        $ClassFamilyOverride<
          Teachings,
          AsyncValue<TeachingsState>,
          TeachingsState,
          FutureOr<TeachingsState>,
          TeachingQuery
        > {
  TeachingsFamily._()
    : super(
        retry: null,
        name: r'teachingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The teachings that answer [query], a page at a time: the first one at
  /// once, the next ones at the end of the list. Without a search nor the
  /// advanced filters, the first page kept on the phone shows at once
  /// ([FetchPolicy.cacheAndNetwork]); a search or a filter asks the server.
  /// Without network the copy gives way to the error: the screen then lists
  /// the messages downloaded, the only ones that play offline.

  TeachingsProvider call(TeachingQuery query) =>
      TeachingsProvider._(argument: query, from: this);

  @override
  String toString() => r'teachingsProvider';
}

/// The teachings that answer [query], a page at a time: the first one at
/// once, the next ones at the end of the list. Without a search nor the
/// advanced filters, the first page kept on the phone shows at once
/// ([FetchPolicy.cacheAndNetwork]); a search or a filter asks the server.
/// Without network the copy gives way to the error: the screen then lists
/// the messages downloaded, the only ones that play offline.

abstract class _$Teachings extends $AsyncNotifier<TeachingsState> {
  late final _$args = ref.$arg as TeachingQuery;
  TeachingQuery get query => _$args;

  FutureOr<TeachingsState> build(TeachingQuery query);
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
    element.handleCreate(ref, () => build(_$args));
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

/// The speakers, the years, the editions and the days of [editionId]: what
/// the filters offer. Empty without network.

@ProviderFor(teachingFacets)
final teachingFacetsProvider = TeachingFacetsFamily._();

/// The speakers, the years, the editions and the days of [editionId]: what
/// the filters offer. Empty without network.

final class TeachingFacetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<TeachingFacets>,
          TeachingFacets,
          FutureOr<TeachingFacets>
        >
    with $FutureModifier<TeachingFacets>, $FutureProvider<TeachingFacets> {
  /// The speakers, the years, the editions and the days of [editionId]: what
  /// the filters offer. Empty without network.
  TeachingFacetsProvider._({
    required TeachingFacetsFamily super.from,
    required int? super.argument,
  }) : super(
         retry: null,
         name: r'teachingFacetsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$teachingFacetsHash();

  @override
  String toString() {
    return r'teachingFacetsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TeachingFacets> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TeachingFacets> create(Ref ref) {
    final argument = this.argument as int?;
    return teachingFacets(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TeachingFacetsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$teachingFacetsHash() => r'183b4c995db29dce348bd10b5f5a82177915d48c';

/// The speakers, the years, the editions and the days of [editionId]: what
/// the filters offer. Empty without network.

final class TeachingFacetsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TeachingFacets>, int?> {
  TeachingFacetsFamily._()
    : super(
        retry: null,
        name: r'teachingFacetsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The speakers, the years, the editions and the days of [editionId]: what
  /// the filters offer. Empty without network.

  TeachingFacetsProvider call(int? editionId) =>
      TeachingFacetsProvider._(argument: editionId, from: this);

  @override
  String toString() => r'teachingFacetsProvider';
}

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
