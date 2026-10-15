// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disciples.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The members who chose the user as disciple maker or as an authority,
/// matching [search] ("Mes disciples"): the first page, then the next ones
/// added by [loadMore] as the list scrolls to its end.

@ProviderFor(DisciplesList)
final disciplesListProvider = DisciplesListFamily._();

/// The members who chose the user as disciple maker or as an authority,
/// matching [search] ("Mes disciples"): the first page, then the next ones
/// added by [loadMore] as the list scrolls to its end.
final class DisciplesListProvider
    extends $AsyncNotifierProvider<DisciplesList, DisciplesPage> {
  /// The members who chose the user as disciple maker or as an authority,
  /// matching [search] ("Mes disciples"): the first page, then the next ones
  /// added by [loadMore] as the list scrolls to its end.
  DisciplesListProvider._({
    required DisciplesListFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'disciplesListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$disciplesListHash();

  @override
  String toString() {
    return r'disciplesListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DisciplesList create() => DisciplesList();

  @override
  bool operator ==(Object other) {
    return other is DisciplesListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$disciplesListHash() => r'74ba3acd88bcad46fd8254dd4d56b4a2f30acbfc';

/// The members who chose the user as disciple maker or as an authority,
/// matching [search] ("Mes disciples"): the first page, then the next ones
/// added by [loadMore] as the list scrolls to its end.

final class DisciplesListFamily extends $Family
    with
        $ClassFamilyOverride<
          DisciplesList,
          AsyncValue<DisciplesPage>,
          DisciplesPage,
          FutureOr<DisciplesPage>,
          String
        > {
  DisciplesListFamily._()
    : super(
        retry: null,
        name: r'disciplesListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The members who chose the user as disciple maker or as an authority,
  /// matching [search] ("Mes disciples"): the first page, then the next ones
  /// added by [loadMore] as the list scrolls to its end.

  DisciplesListProvider call({String search = ''}) =>
      DisciplesListProvider._(argument: search, from: this);

  @override
  String toString() => r'disciplesListProvider';
}

/// The members who chose the user as disciple maker or as an authority,
/// matching [search] ("Mes disciples"): the first page, then the next ones
/// added by [loadMore] as the list scrolls to its end.

abstract class _$DisciplesList extends $AsyncNotifier<DisciplesPage> {
  late final _$args = ref.$arg as String;
  String get search => _$args;

  FutureOr<DisciplesPage> build({String search = ''});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DisciplesPage>, DisciplesPage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DisciplesPage>, DisciplesPage>,
              AsyncValue<DisciplesPage>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(search: _$args));
  }
}

/// The reports of the disciple [authorityId] over [pages] pages of 30 days,
/// ending today (one more page with "Voir les 30 jours précédents").

@ProviderFor(discipleReports)
final discipleReportsProvider = DiscipleReportsFamily._();

/// The reports of the disciple [authorityId] over [pages] pages of 30 days,
/// ending today (one more page with "Voir les 30 jours précédents").

final class DiscipleReportsProvider
    extends
        $FunctionalProvider<
          AsyncValue<DiscipleReports>,
          DiscipleReports,
          FutureOr<DiscipleReports>
        >
    with $FutureModifier<DiscipleReports>, $FutureProvider<DiscipleReports> {
  /// The reports of the disciple [authorityId] over [pages] pages of 30 days,
  /// ending today (one more page with "Voir les 30 jours précédents").
  DiscipleReportsProvider._({
    required DiscipleReportsFamily super.from,
    required (int, {int pages}) super.argument,
  }) : super(
         retry: null,
         name: r'discipleReportsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$discipleReportsHash();

  @override
  String toString() {
    return r'discipleReportsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<DiscipleReports> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<DiscipleReports> create(Ref ref) {
    final argument = this.argument as (int, {int pages});
    return discipleReports(ref, argument.$1, pages: argument.pages);
  }

  @override
  bool operator ==(Object other) {
    return other is DiscipleReportsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$discipleReportsHash() => r'8bdfe5af33fef35896919cc7260128e1533ef309';

/// The reports of the disciple [authorityId] over [pages] pages of 30 days,
/// ending today (one more page with "Voir les 30 jours précédents").

final class DiscipleReportsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<DiscipleReports>,
          (int, {int pages})
        > {
  DiscipleReportsFamily._()
    : super(
        retry: null,
        name: r'discipleReportsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The reports of the disciple [authorityId] over [pages] pages of 30 days,
  /// ending today (one more page with "Voir les 30 jours précédents").

  DiscipleReportsProvider call(int authorityId, {int pages = 1}) =>
      DiscipleReportsProvider._(
        argument: (authorityId, pages: pages),
        from: this,
      );

  @override
  String toString() => r'discipleReportsProvider';
}
