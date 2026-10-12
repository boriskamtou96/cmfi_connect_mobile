import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/app_exception.dart';
import '../../../core/session/session.dart';
import '../domain/profile.dart';
import '../infrastructure/profile_api.dart';

part 'current_profile.g.dart';

/// The signed-in user's profile (greeting, avatar, "Plus" tab, profile form).
/// Name and phone fall back to the account used to sign in when the server has
/// them empty, or has no profile at all.
@riverpod
Future<Profile> currentProfile(Ref ref) async {
  final api = ref.watch(profileApiProvider);
  final account = await ref.watch(signedInAccountProvider.future);
  Profile? stored;
  try {
    stored = await api.get();
  } on ApiException catch (error) {
    if (error.code != 'NOT_FOUND') {
      rethrow;
    }
  }
  return Profile.resolve(stored, account);
}
