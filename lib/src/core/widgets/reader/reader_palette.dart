import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../application/hymn_reader_settings.dart';

/// Colors of the reading screen, for each background the user can pick.
class ReaderPalette {
  const ReaderPalette({
    required this.background,
    required this.text,
    required this.muted,
    required this.accent,
    required this.chorusBar,
    required this.brightness,
  });

  /// [HymnReaderTheme.auto] follows the app (light or dark).
  factory ReaderPalette.of(HymnReaderTheme theme, Brightness appBrightness) =>
      switch (theme) {
        HymnReaderTheme.light => light,
        HymnReaderTheme.sepia => sepia,
        HymnReaderTheme.dark => dark,
        HymnReaderTheme.auto => appBrightness == Brightness.dark ? dark : light,
      };

  static const light = ReaderPalette(
    background: Colors.white,
    text: AppColors.ink,
    muted: AppColors.muted,
    accent: Color(0xFF0E7A72),
    chorusBar: Color(0xFFD5ECE8),
    brightness: Brightness.light,
  );

  static const sepia = ReaderPalette(
    background: Color(0xFFF5EEDF),
    text: Color(0xFF3A2E1F),
    muted: Color(0xFF7A6A55),
    accent: Color(0xFF8A5A0F),
    chorusBar: Color(0xFFE6D8BC),
    brightness: Brightness.light,
  );

  /// Warm black, easier on the eyes in a dark church than pure black.
  static const dark = ReaderPalette(
    background: Color(0xFF14130F),
    text: Color(0xFFECE6D8),
    muted: Color(0xFFA39C8C),
    accent: Color(0xFF8FD8CE),
    chorusBar: Color(0xFF34322B),
    brightness: Brightness.dark,
  );

  final Color background;
  final Color text;
  final Color muted;
  final Color accent;
  final Color chorusBar;
  final Brightness brightness;
}
