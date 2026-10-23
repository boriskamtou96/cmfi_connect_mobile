import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/i18n/strings.g.dart';
import '../domain/journey_step.dart';

/// The two colors of a step's medal, by what it rewards.
List<Color> stepColors(JourneyGroup group) => switch (group) {
  JourneyGroup.faithfulness => const [Color(0xFFF4D682), Color(0xFFC9962E)],
  JourneyGroup.prayer => const [Color(0xFFB9A0E0), Color(0xFF6B4A93)],
  JourneyGroup.word => const [Color(0xFFE28A93), Color(0xFF8E2C3A)],
  JourneyGroup.souls => const [Color(0xFF7FD1C4), Color(0xFF2B7A72)],
  JourneyGroup.together => const [Color(0xFF7FB4EC), Color(0xFF0A5EA8)],
};

IconData stepIcon(JourneyStep step) => switch (step) {
  JourneyStep.firstReport => PhosphorIconsFill.footprints,
  JourneyStep.streak7 ||
  JourneyStep.streak30 ||
  JourneyStep.streak100 ||
  JourneyStep.streak365 => PhosphorIconsFill.flame,
  JourneyStep.fullDay => PhosphorIconsFill.sunHorizon,
  JourneyStep.sevenFullDays => PhosphorIconsFill.calendarCheck,
  JourneyStep.fourRetreats => PhosphorIconsFill.handsPraying,
  JourneyStep.planDone => PhosphorIconsFill.bookOpenText,
  JourneyStep.lyricsShared => PhosphorIconsFill.musicNotes,
  JourneyStep.firstSoul => PhosphorIconsFill.plant,
  JourneyStep.tenSouls => PhosphorIconsFill.usersThree,
  JourneyStep.soulBaptized => PhosphorIconsFill.drop,
  JourneyStep.firstSending => PhosphorIconsFill.paperPlaneTilt,
  JourneyStep.firstEncouragement => PhosphorIconsFill.handHeart,
};

/// The name of a step and how it is reached.
({String title, String text}) stepTexts(Translations t, JourneyStep step) {
  final s = t.journey.steps;
  final texts = switch (step) {
    JourneyStep.firstReport => (s.firstReport.title, s.firstReport.text),
    JourneyStep.streak7 => (s.streak7.title, s.streak7.text),
    JourneyStep.streak30 => (s.streak30.title, s.streak30.text),
    JourneyStep.streak100 => (s.streak100.title, s.streak100.text),
    JourneyStep.streak365 => (s.streak365.title, s.streak365.text),
    JourneyStep.fullDay => (s.fullDay.title, s.fullDay.text),
    JourneyStep.sevenFullDays => (s.sevenFullDays.title, s.sevenFullDays.text),
    JourneyStep.fourRetreats => (s.fourRetreats.title, s.fourRetreats.text),
    JourneyStep.planDone => (s.planDone.title, s.planDone.text),
    JourneyStep.lyricsShared => (s.lyricsShared.title, s.lyricsShared.text),
    JourneyStep.firstSoul => (s.firstSoul.title, s.firstSoul.text),
    JourneyStep.tenSouls => (s.tenSouls.title, s.tenSouls.text),
    JourneyStep.soulBaptized => (s.soulBaptized.title, s.soulBaptized.text),
    JourneyStep.firstSending => (s.firstSending.title, s.firstSending.text),
    JourneyStep.firstEncouragement => (
      s.firstEncouragement.title,
      s.firstEncouragement.text,
    ),
  };
  return (title: texts.$1, text: texts.$2);
}

String groupName(Translations t, JourneyGroup group) {
  final g = t.journey.groups;
  return switch (group) {
    JourneyGroup.faithfulness => g.faithfulness,
    JourneyGroup.prayer => g.prayer,
    JourneyGroup.word => g.word,
    JourneyGroup.souls => g.souls,
    JourneyGroup.together => g.together,
  };
}
