// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ministry_people.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nos missionnaires, Nos héros: the copy of the phone at once (the last
/// one seen), then the server's when it answers. Never seen and no network:
/// the error, with "Réessayer".

@ProviderFor(MinistryPeople)
final ministryPeopleProvider = MinistryPeopleFamily._();

/// Nos missionnaires, Nos héros: the copy of the phone at once (the last
/// one seen), then the server's when it answers. Never seen and no network:
/// the error, with "Réessayer".
final class MinistryPeopleProvider
    extends $AsyncNotifierProvider<MinistryPeople, List<MinistryPerson>> {
  /// Nos missionnaires, Nos héros: the copy of the phone at once (the last
  /// one seen), then the server's when it answers. Never seen and no network:
  /// the error, with "Réessayer".
  MinistryPeopleProvider._({
    required MinistryPeopleFamily super.from,
    required MinistryPersonKind super.argument,
  }) : super(
         retry: null,
         name: r'ministryPeopleProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ministryPeopleHash();

  @override
  String toString() {
    return r'ministryPeopleProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MinistryPeople create() => MinistryPeople();

  @override
  bool operator ==(Object other) {
    return other is MinistryPeopleProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ministryPeopleHash() => r'd1ec309fa3116de934030cb728496d872f2d9eef';

/// Nos missionnaires, Nos héros: the copy of the phone at once (the last
/// one seen), then the server's when it answers. Never seen and no network:
/// the error, with "Réessayer".

final class MinistryPeopleFamily extends $Family
    with
        $ClassFamilyOverride<
          MinistryPeople,
          AsyncValue<List<MinistryPerson>>,
          List<MinistryPerson>,
          FutureOr<List<MinistryPerson>>,
          MinistryPersonKind
        > {
  MinistryPeopleFamily._()
    : super(
        retry: null,
        name: r'ministryPeopleProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Nos missionnaires, Nos héros: the copy of the phone at once (the last
  /// one seen), then the server's when it answers. Never seen and no network:
  /// the error, with "Réessayer".

  MinistryPeopleProvider call(MinistryPersonKind kind) =>
      MinistryPeopleProvider._(argument: kind, from: this);

  @override
  String toString() => r'ministryPeopleProvider';
}

/// Nos missionnaires, Nos héros: the copy of the phone at once (the last
/// one seen), then the server's when it answers. Never seen and no network:
/// the error, with "Réessayer".

abstract class _$MinistryPeople extends $AsyncNotifier<List<MinistryPerson>> {
  late final _$args = ref.$arg as MinistryPersonKind;
  MinistryPersonKind get kind => _$args;

  FutureOr<List<MinistryPerson>> build(MinistryPersonKind kind);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<MinistryPerson>>, List<MinistryPerson>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MinistryPerson>>,
                List<MinistryPerson>
              >,
              AsyncValue<List<MinistryPerson>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
