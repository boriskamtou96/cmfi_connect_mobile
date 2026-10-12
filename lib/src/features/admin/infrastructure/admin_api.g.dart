// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StaffMember _$StaffMemberFromJson(Map<String, dynamic> json) => _StaffMember(
  username: json['username'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String? ?? '',
  role: $enumDecode(
    _$MemberRoleEnumMap,
    json['role'],
    unknownValue: MemberRole.user,
  ),
);

Map<String, dynamic> _$StaffMemberToJson(_StaffMember instance) =>
    <String, dynamic>{
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'role': _$MemberRoleEnumMap[instance.role]!,
    };

const _$MemberRoleEnumMap = {
  MemberRole.user: 'user',
  MemberRole.admin: 'admin',
  MemberRole.superadmin: 'superadmin',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminApi)
final adminApiProvider = AdminApiProvider._();

final class AdminApiProvider
    extends $FunctionalProvider<AdminApi, AdminApi, AdminApi>
    with $Provider<AdminApi> {
  AdminApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminApiHash();

  @$internal
  @override
  $ProviderElement<AdminApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AdminApi create(Ref ref) {
    return adminApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminApi>(value),
    );
  }
}

String _$adminApiHash() => r'3136ace11869fc0347e66d17c144c1b3cc405af2';

/// The admins and superadmins.

@ProviderFor(Staff)
final staffProvider = StaffProvider._();

/// The admins and superadmins.
final class StaffProvider
    extends $AsyncNotifierProvider<Staff, List<StaffMember>> {
  /// The admins and superadmins.
  StaffProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffHash();

  @$internal
  @override
  Staff create() => Staff();
}

String _$staffHash() => r'ccabb58fdec533b7fb361b447b8f2fd74440bb0a';

/// The admins and superadmins.

abstract class _$Staff extends $AsyncNotifier<List<StaffMember>> {
  FutureOr<List<StaffMember>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<StaffMember>>, List<StaffMember>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<StaffMember>>, List<StaffMember>>,
              AsyncValue<List<StaffMember>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
