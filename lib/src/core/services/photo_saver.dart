import 'dart:typed_data';

import 'package:gal/gal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_saver.g.dart';

/// Puts an image in the phone's photos (Photos, the gallery). Behind a
/// provider so tests replace it.
class PhotoSaver {
  const PhotoSaver();

  /// False when the member refuses the access.
  Future<bool> save(Uint8List png, {required String name}) async {
    if (!await Gal.hasAccess() && !await Gal.requestAccess()) {
      return false;
    }
    await Gal.putImageBytes(png, name: name);
    return true;
  }
}

@Riverpod(keepAlive: true)
PhotoSaver photoSaver(Ref ref) => const PhotoSaver();
