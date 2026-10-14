import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_picking.g.dart';

typedef PickedImage = ({Uint8List bytes, String name});

/// Pictures chosen in the phone's gallery (or taken with its camera), made
/// smaller first (2048 px, JPEG): the server takes 8 MB at most. Behind a
/// provider so tests replace it.
class ImagePicking {
  ImagePicking();

  final _picker = ImagePicker();

  static const _maxSide = 2048.0;
  static const _quality = 85;

  /// null when the user gives up. [camera]: a photo taken now (the front
  /// camera first, for a profile photo).
  Future<PickedImage?> pickOne({bool camera = false}) async {
    final file = await _picker.pickImage(
      source: camera ? ImageSource.camera : ImageSource.gallery,
      preferredCameraDevice: CameraDevice.front,
      maxWidth: _maxSide,
      maxHeight: _maxSide,
      imageQuality: _quality,
      requestFullMetadata: false,
    );
    return file == null
        ? null
        : (bytes: await file.readAsBytes(), name: file.name);
  }

  /// Empty when the user gives up.
  Future<List<PickedImage>> pickMany({int limit = 20}) async {
    final files = await _picker.pickMultiImage(
      maxWidth: _maxSide,
      maxHeight: _maxSide,
      imageQuality: _quality,
      limit: limit,
      requestFullMetadata: false,
    );
    return [
      for (final file in files)
        (bytes: await file.readAsBytes(), name: file.name),
    ];
  }
}

@Riverpod(keepAlive: true)
ImagePicking imagePicking(Ref ref) => ImagePicking();
