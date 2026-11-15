import 'dart:typed_data';

import 'package:flutter/widgets.dart';

import '../../theme/app_colors.dart';

/// A background of the image of a verse: a photo (under a dark veil for the
/// words) or two colors in a gradient.
class VerseBackground {
  const VerseBackground.photo(
    this.id,
    String this.photo, {
    this.alignment = Alignment.center,
  }) : colors = const [],
       bytes = null;

  const VerseBackground.colors(this.id, this.colors)
    : photo = null,
      bytes = null,
      alignment = Alignment.center;

  /// A photo of the member (taken now or from the gallery), for this share
  /// only: never kept.
  const VerseBackground.own(Uint8List this.bytes)
    : id = ownId,
      photo = null,
      colors = const [],
      alignment = Alignment.center;

  static const ownId = 'own';

  final String id;

  /// The asset of the photo, or null.
  final String? photo;

  /// The member's own photo, or null.
  final Uint8List? bytes;

  /// The part of the photo kept.
  final Alignment alignment;

  /// From the top left to the bottom right, when there is no photo.
  final List<Color> colors;

  bool get isPhoto => photo != null || bytes != null;

  /// The picture of a photo; [width]: decoded that small (a thumbnail).
  ImageProvider? image({int? width}) {
    final full = switch ((photo, bytes)) {
      (final String asset, _) => AssetImage(asset) as ImageProvider,
      (_, final Uint8List data) => MemoryImage(data),
      _ => null,
    };
    return full == null || width == null
        ? full
        : ResizeImage(full, width: width, policy: ResizeImagePolicy.fit);
  }
}

/// The photos (14/11/2026: one series, « la lumière de l'aube », landscapes
/// at sunrise or sunset in warm tones; see assets/photos/CREDITS.md), then
/// the colors, all dark enough for the white words. The member can also
/// take their own photo (`VerseBackground.own`).
const verseBackgrounds = [
  VerseBackground.photo('ridge', 'assets/photos/dawn_ridge.jpg'),
  VerseBackground.photo('rays', 'assets/photos/dawn_rays.jpg'),
  VerseBackground.photo('valley', 'assets/photos/dawn_valley.jpg'),
  VerseBackground.photo('peaks', 'assets/photos/dawn_peaks.jpg'),
  VerseBackground.photo('haze', 'assets/photos/dawn_haze.jpg'),
  VerseBackground.photo('sea', 'assets/photos/dawn_sea.jpg'),
  VerseBackground.photo('clouds', 'assets/photos/dawn_clouds.jpg'),
  VerseBackground.photo('field', 'assets/photos/dawn_field.jpg'),
  VerseBackground.colors('night', [Color(0xFF0D427C), AppColors.night]),
  VerseBackground.colors('wine', [Color(0xFF8E2440), Color(0xFF3D0A1A)]),
  VerseBackground.colors('forest', [Color(0xFF1F6B4F), Color(0xFF0A2A1F)]),
  VerseBackground.colors('ocean', [Color(0xFF0E7C86), Color(0xFF06323A)]),
  VerseBackground.colors('violet', [Color(0xFF5B3A9E), Color(0xFF22113F)]),
  VerseBackground.colors('amber', [Color(0xFFB5671E), Color(0xFF4A2309)]),
  VerseBackground.colors('slate', [Color(0xFF3A4556), Color(0xFF12161D)]),
];

/// The background of [id], else the first photo.
VerseBackground verseBackgroundOf(String? id) =>
    verseBackgrounds.where((background) => background.id == id).firstOrNull ??
    verseBackgrounds.first;
