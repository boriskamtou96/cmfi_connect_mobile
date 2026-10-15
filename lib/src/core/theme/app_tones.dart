import 'package:flutter/material.dart';

import 'app_colors.dart';

/// A module's colors in the current mode.
@immutable
class ModuleTone {
  const ModuleTone({
    required this.color,
    required this.soft,
    required this.onSoft,
  });

  /// Solid fill, with white content on it (buttons, big icon tiles).
  final Color color;

  /// Tinted background (icon tiles, pills, cards).
  final Color soft;

  /// Icons and text, on [soft] or on a surface.
  final Color onSoft;

  static ModuleTone lerp(ModuleTone a, ModuleTone b, double t) => ModuleTone(
    color: Color.lerp(a.color, b.color, t)!,
    soft: Color.lerp(a.soft, b.soft, t)!,
    onSoft: Color.lerp(a.onSoft, b.onSoft, t)!,
  );
}

/// Brand colors that change between light and dark mode. The theme carries
/// them, so they animate with it when the mode changes:
/// `AppTones.of(context).personal`, `AppModule.hymns.tone(context).soft`.
@immutable
class AppTones extends ThemeExtension<AppTones> {
  const AppTones({
    required this.reports,
    required this.hymns,
    required this.prayer,
    required this.events,
    required this.bible,
    required this.personal,
    required this.personalSoft,
    required this.missing,
    required this.missingDash,
    required this.disabled,
  });

  static const light = AppTones(
    reports: ModuleTone(
      color: Color(0xFF0A5EA8),
      soft: Color(0xFFE2EEFA),
      onSoft: Color(0xFF0A5EA8),
    ),
    // teal: an indigo would be lost next to the blue of the reports
    hymns: ModuleTone(
      color: Color(0xFF0E7A72),
      soft: Color(0xFFDFF2EF),
      onSoft: Color(0xFF0B6B64),
    ),
    prayer: ModuleTone(
      color: Color(0xFF7A4A98),
      soft: Color(0xFFF0E8F5),
      onSoft: Color(0xFF7A4A98),
    ),
    events: ModuleTone(
      color: Color(0xFFA85F1E),
      soft: Color(0xFFF8ECDD),
      onSoft: Color(0xFF8A4A12),
    ),
    // burgundy, like the cover of a Bible
    bible: ModuleTone(
      color: Color(0xFF9A2E3D),
      soft: Color(0xFFF8E6E8),
      onSoft: Color(0xFF8A2534),
    ),
    personal: Color(0xFF8A5A0F),
    personalSoft: Color(0xFFFBF1DC),
    missing: Color(0xFFA0562A),
    missingDash: Color(0xFFC69A7C),
    disabled: Color(0xFFA3AEBB),
  );

  // Same hues, dimmed backgrounds and lighter inks: nothing glows on a dark screen
  static const dark = AppTones(
    reports: ModuleTone(
      color: Color(0xFF0A5EA8),
      soft: Color(0xFF16304E),
      onSoft: Color(0xFF9DCBF5),
    ),
    hymns: ModuleTone(
      color: Color(0xFF0E7A72),
      soft: Color(0xFF163936),
      onSoft: Color(0xFF8FD8CE),
    ),
    prayer: ModuleTone(
      color: Color(0xFF7E4E9C),
      soft: Color(0xFF2F2339),
      onSoft: Color(0xFFD9BCEB),
    ),
    events: ModuleTone(
      color: Color(0xFFA85F1E),
      soft: Color(0xFF3A2918),
      onSoft: Color(0xFFF2C69C),
    ),
    bible: ModuleTone(
      color: Color(0xFF9A2E3D),
      soft: Color(0xFF3B1D22),
      onSoft: Color(0xFFF2AEB7),
    ),
    personal: Color(0xFFE8C27E),
    personalSoft: Color(0xFF3A2C12),
    missing: Color(0xFFE3A27C),
    missingDash: Color(0xFF8A6450),
    disabled: Color(0xFF5E6A78),
  );

  final ModuleTone reports;
  final ModuleTone hymns;
  final ModuleTone prayer;
  final ModuleTone events;
  final ModuleTone bible;

  /// Personal items (vs standard ones): text / icons, and their background.
  final Color personal;
  final Color personalSoft;

  /// A past day without report: a warm outline, not an error red.
  final Color missing;
  final Color missingDash;

  /// Days still to come.
  final Color disabled;

  static AppTones of(BuildContext context) =>
      Theme.of(context).extension<AppTones>()!;

  ModuleTone module(AppModule module) => switch (module) {
    AppModule.reports => reports,
    AppModule.hymns => hymns,
    AppModule.prayer => prayer,
    AppModule.events => events,
    AppModule.bible => bible,
  };

  @override
  AppTones copyWith() => this;

  @override
  AppTones lerp(AppTones? other, double t) {
    if (other == null) {
      return this;
    }
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppTones(
      reports: ModuleTone.lerp(reports, other.reports, t),
      hymns: ModuleTone.lerp(hymns, other.hymns, t),
      prayer: ModuleTone.lerp(prayer, other.prayer, t),
      events: ModuleTone.lerp(events, other.events, t),
      bible: ModuleTone.lerp(bible, other.bible, t),
      personal: mix(personal, other.personal),
      personalSoft: mix(personalSoft, other.personalSoft),
      missing: mix(missing, other.missing),
      missingDash: mix(missingDash, other.missingDash),
      disabled: mix(disabled, other.disabled),
    );
  }
}

extension AppModuleTone on AppModule {
  /// This module's colors in the current light / dark mode.
  ModuleTone tone(BuildContext context) => AppTones.of(context).module(this);
}
