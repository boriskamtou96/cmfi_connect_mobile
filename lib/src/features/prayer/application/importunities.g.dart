// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'importunities.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The importunity topics the user prays for or is invited to. The
/// proclamations counted without network are added to what the server says,
/// and sent as soon as it comes back.

@ProviderFor(Importunities)
final importunitiesProvider = ImportunitiesProvider._();

/// The importunity topics the user prays for or is invited to. The
/// proclamations counted without network are added to what the server says,
/// and sent as soon as it comes back.
final class ImportunitiesProvider
    extends $AsyncNotifierProvider<Importunities, List<Importunity>> {
  /// The importunity topics the user prays for or is invited to. The
  /// proclamations counted without network are added to what the server says,
  /// and sent as soon as it comes back.
  ImportunitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'importunitiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$importunitiesHash();

  @$internal
  @override
  Importunities create() => Importunities();
}

String _$importunitiesHash() => r'f6e56ee9c4e36e9c0a885de64fb19d2ad0b1c8b7';

/// The importunity topics the user prays for or is invited to. The
/// proclamations counted without network are added to what the server says,
/// and sent as soon as it comes back.

abstract class _$Importunities extends $AsyncNotifier<List<Importunity>> {
  FutureOr<List<Importunity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Importunity>>, List<Importunity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Importunity>>, List<Importunity>>,
              AsyncValue<List<Importunity>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// One topic as the server has it, with who prays (names only). The counts
/// shown come from [importunitiesProvider], which adds the taps not sent yet:
/// counting doesn't ask the server again.

@ProviderFor(importunityDetail)
final importunityDetailProvider = ImportunityDetailFamily._();

/// One topic as the server has it, with who prays (names only). The counts
/// shown come from [importunitiesProvider], which adds the taps not sent yet:
/// counting doesn't ask the server again.

final class ImportunityDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Importunity>,
          Importunity,
          FutureOr<Importunity>
        >
    with $FutureModifier<Importunity>, $FutureProvider<Importunity> {
  /// One topic as the server has it, with who prays (names only). The counts
  /// shown come from [importunitiesProvider], which adds the taps not sent yet:
  /// counting doesn't ask the server again.
  ImportunityDetailProvider._({
    required ImportunityDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'importunityDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$importunityDetailHash();

  @override
  String toString() {
    return r'importunityDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Importunity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Importunity> create(Ref ref) {
    final argument = this.argument as int;
    return importunityDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ImportunityDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$importunityDetailHash() => r'2e25e449dee8d4d434dbab561f0906a0a24f96b1';

/// One topic as the server has it, with who prays (names only). The counts
/// shown come from [importunitiesProvider], which adds the taps not sent yet:
/// counting doesn't ask the server again.

final class ImportunityDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Importunity>, int> {
  ImportunityDetailFamily._()
    : super(
        retry: null,
        name: r'importunityDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One topic as the server has it, with who prays (names only). The counts
  /// shown come from [importunitiesProvider], which adds the taps not sent yet:
  /// counting doesn't ask the server again.

  ImportunityDetailProvider call(int id) =>
      ImportunityDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'importunityDetailProvider';
}

/// Whom "invite my spiritual family" reaches.

@ProviderFor(prayerFamily)
final prayerFamilyProvider = PrayerFamilyProvider._();

/// Whom "invite my spiritual family" reaches.

final class PrayerFamilyProvider
    extends
        $FunctionalProvider<
          AsyncValue<PrayerFamily>,
          PrayerFamily,
          FutureOr<PrayerFamily>
        >
    with $FutureModifier<PrayerFamily>, $FutureProvider<PrayerFamily> {
  /// Whom "invite my spiritual family" reaches.
  PrayerFamilyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'prayerFamilyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$prayerFamilyHash();

  @$internal
  @override
  $FutureProviderElement<PrayerFamily> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PrayerFamily> create(Ref ref) {
    return prayerFamily(ref);
  }
}

String _$prayerFamilyHash() => r'0d62b70fac0ce6e6b82c73255ab416bdd2d659df';

/// The members the user blocked (Plus › Membres bloqués): their invitations
/// to pray don't reach the user any more.

@ProviderFor(BlockedMembers)
final blockedMembersProvider = BlockedMembersProvider._();

/// The members the user blocked (Plus › Membres bloqués): their invitations
/// to pray don't reach the user any more.
final class BlockedMembersProvider
    extends $AsyncNotifierProvider<BlockedMembers, List<MemberCard>> {
  /// The members the user blocked (Plus › Membres bloqués): their invitations
  /// to pray don't reach the user any more.
  BlockedMembersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blockedMembersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blockedMembersHash();

  @$internal
  @override
  BlockedMembers create() => BlockedMembers();
}

String _$blockedMembersHash() => r'9fe5e27a2449e31c3d8ee70582f695f8f6316c08';

/// The members the user blocked (Plus › Membres bloqués): their invitations
/// to pray don't reach the user any more.

abstract class _$BlockedMembers extends $AsyncNotifier<List<MemberCard>> {
  FutureOr<List<MemberCard>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<MemberCard>>, List<MemberCard>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MemberCard>>, List<MemberCard>>,
              AsyncValue<List<MemberCard>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
