import 'package:flutter/material.dart';

/// Brand palette (see the design canvas). Widgets read general colors from
/// Theme.of(context).colorScheme, and the colors that change in dark mode
/// (modules, personal items, missed days) from AppTones. AppColors is for the
/// light theme and what looks the same in both modes (logo, blue hero cards).
abstract final class AppColors {
  // Brand
  static const primary = Color(0xFF0A5EA8); // Bleu CMFI, from the logo
  static const primaryDeep = Color(
    0xFF072D5A,
  ); // Bleu nuit: splash, dark surfaces
  static const primarySoft = Color(0xFFE2EEFA); // Bleu ciel
  static const onPrimaryMuted = Color(0xFFB8D6F2);
  static const gold = Color(0xFFE2A93B); // Or lumière: the flame, rare accents
  static const goldLight = Color(0xFFF6D27A);

  // Neutrals
  static const ink = Color(0xFF0F1A2A);
  static const muted = Color(0xFF556375);
  static const background = Color(0xFFF3F6FA);
  static const surface = Color(0xFFFFFFFF);
  static const line = Color(0xFFDFE6EF);
  static const inputBorder = Color(0xFFD2DCE8);

  static const error = Color(0xFFA0362A);
  static const errorSoft = Color(0xFFFBEAE6);
}

/// The app's modules. Each has its identity color, same lightness so none
/// dominates: `module.tone(context)` (app_tones.dart).
enum AppModule { reports, hymns, prayer, events }
