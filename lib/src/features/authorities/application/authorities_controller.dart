import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/phone.dart';
import '../domain/authority.dart';
import '../infrastructure/authorities_api.dart';

part 'authorities_controller.g.dart';

/// The user's authorities, disciple maker first.
@riverpod
class AuthoritiesController extends _$AuthoritiesController {
  @override
  Future<List<Authority>> build() async =>
      _sorted(await ref.watch(authoritiesApiProvider).list());

  /// Adds someone; throws an AppException on failure.
  Future<Authority> add({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String email,
    required bool isDiscipleMaker,
  }) async {
    final created = await ref
        .read(authoritiesApiProvider)
        .create(
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          phoneNumber: toInternationalPhone(phoneNumber),
          email: email.trim(),
          isDiscipleMaker: isDiscipleMaker,
        );
    if (ref.mounted) {
      state = AsyncData(_sorted([...?state.value, created]));
    }
    return created;
  }

  /// Asks a member found by pseudo; throws an AppException on failure.
  Future<Authority> addMember({
    required String username,
    required bool isDiscipleMaker,
  }) async {
    final created = await ref
        .read(authoritiesApiProvider)
        .createForMember(username: username, isDiscipleMaker: isDiscipleMaker);
    if (ref.mounted) {
      state = AsyncData(_sorted([...?state.value, created]));
    }
    return created;
  }

  /// Removes someone; throws an AppException on failure.
  Future<void> remove(Authority authority) async {
    await ref.read(authoritiesApiProvider).remove(authority.id);
    if (ref.mounted) {
      state = AsyncData([
        for (final other in state.value ?? const <Authority>[])
          if (other.id != authority.id) other,
      ]);
    }
  }

  static List<Authority> _sorted(List<Authority> authorities) => [
    ...authorities.where((authority) => authority.isDiscipleMaker),
    ...authorities.where((authority) => !authority.isDiscipleMaker),
  ];
}

/// The members who ask the user to accompany them.
@riverpod
class AuthorityRequests extends _$AuthorityRequests {
  @override
  Future<List<AuthorityRequest>> build() =>
      ref.watch(authoritiesApiProvider).requests();

  /// Throws an AppException on failure (the request stays).
  Future<void> answer(AuthorityRequest request, {required bool accept}) async {
    await ref.read(authoritiesApiProvider).answer(request.id, accept: accept);
    if (ref.mounted) {
      state = AsyncData([
        for (final other in state.value ?? const <AuthorityRequest>[])
          if (other.id != request.id) other,
      ]);
    }
  }
}
