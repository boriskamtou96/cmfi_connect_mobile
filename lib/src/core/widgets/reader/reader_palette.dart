import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// The background of a reading screen (hymns, Bible): auto follows the app.
enum ReaderTheme { auto, light, sepia, dark }

/// Colors of a reading screen (hymns, Bible), for each background the user can
/// pick.
class ReaderPalette {
  const ReaderPalette({
    required this.background,
    required this.text,
    required this.muted,
    required this.accent,
    required this.chorusBar,
    required this.brightness,
  });

  /// [ReaderTheme.auto] follows the app (light or dark).
  factory ReaderPalette.of(ReaderTheme theme, Brightness appBrightness) =>
      switch (theme) {
        ReaderTheme.light => light,
        ReaderTheme.sepia => sepia,
        ReaderTheme.dark => dark,
        ReaderTheme.auto => appBrightness == Brightness.dark ? dark : light,
      };

  /// The same background with another accent (the Bible's blue).
  ReaderPalette withAccent(Color light, Color dark) => ReaderPalette(
    background: background,
    text: text,
    muted: muted,
    accent: brightness == Brightness.dark ? dark : light,
    chorusBar: chorusBar,
    brightness: brightness,
  );

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
