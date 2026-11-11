import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/social_photo.dart';
import '../infrastructure/profile_api.dart';
import 'current_profile.dart';

part 'social_photo_import.g.dart';

/// Makes the photo of the Google account the profile photo, once, right after
/// the account is created. Best effort: without a photo, or if it can't be
/// had or sent, nothing changes and the member picks one later.
@Riverpod(keepAlive: true)
class SocialPhotoImport extends _$SocialPhotoImport {
  @override
  void build() {}

  Future<void> run() async {
    final pending = ref.read(pendingSocialPhotoProvider);
    if (pending == null) {
      return;
    }
    // once: a failure doesn't come back at every start
    ref.read(pendingSocialPhotoProvider.notifier).set(null);
    final bytes = await ref.read(photoDownloaderProvider).download(pending);
    if (bytes == null) {
      return;
    }
    try {
      await ref.read(profileApiProvider).setAvatar(bytes);
      ref.invalidate(currentProfileProvider);
    } on Object {
      // the photo stays what it was
    }
  }
}
