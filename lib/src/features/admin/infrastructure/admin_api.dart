import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../../events/domain/event.dart';

part 'admin_api.freezed.dart';
part 'admin_api.g.dart';

/// The roles, from the least rights to the most.
enum MemberRole { user, admin, superadmin }

/// An admin or superadmin (GET /v1/admin/staff).
@freezed
abstract class StaffMember with _$StaffMember {
  const factory StaffMember({
    required String username,
    required String firstName,
    @Default('') String lastName,
    @JsonKey(unknownEnumValue: MemberRole.user) required MemberRole role,
    EventImage? avatar,
  }) = _StaffMember;

  const StaffMember._();

  factory StaffMember.fromJson(Map<String, dynamic> json) =>
      _$StaffMemberFromJson(json);

  String get fullName =>
      [firstName, lastName].where((part) => part.isNotEmpty).join(' ');

  String get initials => [firstName, lastName]
      .where((part) => part.isNotEmpty)
      .map((part) => String.fromCharCode(part.runes.first).toUpperCase())
      .join();
}

/// /v1/admin: for admins and superadmins (403 FORBIDDEN for the others).
class AdminApi {
  const AdminApi(this._dio);

  final Dio _dio;

  Future<List<StaffMember>> staff() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/admin/staff');
    return [
      for (final json in response.contentList)
        StaffMember.fromJson(json as Map<String, dynamic>),
    ];
  });

  /// Superadmins only. 404 when nobody has this pseudo, 400 for one's own role.
  Future<StaffMember> setRole(String username, MemberRole role) =>
      apiCall(() async {
        final response = await _dio.put<Map<String, dynamic>>(
          '/admin/members/${Uri.encodeComponent(username)}/role',
          data: {'role': role.name},
        );
        return StaffMember.fromJson(response.content);
      });
}

@riverpod
AdminApi adminApi(Ref ref) => AdminApi(ref.watch(dioProvider));

/// The admins and superadmins.
@riverpod
class Staff extends _$Staff {
  @override
  Future<List<StaffMember>> build() => ref.watch(adminApiProvider).staff();

  /// Throws an AppException when refused.
  Future<StaffMember> setRole(String username, MemberRole role) async {
    final updated = await ref.read(adminApiProvider).setRole(username, role);
    ref.invalidateSelf();
    return updated;
  }
}
