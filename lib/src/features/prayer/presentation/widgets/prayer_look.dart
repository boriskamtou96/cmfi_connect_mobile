import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../domain/prayer.dart';

/// The colors of each retreat: dawn, midday sun, dusk, night. The same in
/// light and dark mode, like a picture.
extension RetreatMomentLook on RetreatMoment {
  IconData get icon => switch (this) {
    RetreatMoment.morning => AppIcons.retreatMorning,
    RetreatMoment.noon => AppIcons.retreatNoon,
    RetreatMoment.evening => AppIcons.retreatEvening,
    RetreatMoment.night => AppIcons.retreatNight,
  };

  List<Color> get colors => switch (this) {
    RetreatMoment.morning => const [Color(0xFFF0A257), Color(0xFFD9674C)],
    RetreatMoment.noon => const [Color(0xFFE7AE35), Color(0xFFCB741B)],
    RetreatMoment.evening => const [Color(0xFFC0607E), Color(0xFF7A4A98)],
    RetreatMoment.night => const [Color(0xFF3A4DA0), Color(0xFF141E4A)],
  };

  /// Text and icons on a light surface.
  Color get ink => switch (this) {
    RetreatMoment.morning => const Color(0xFFC25A3C),
    RetreatMoment.noon => const Color(0xFFA35D0C),
    RetreatMoment.evening => const Color(0xFF9A4D7A),
    RetreatMoment.night => const Color(0xFF3A4DA0),
  };

  /// The same, readable in dark mode too.
  Color inkOf(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? colors.first : ink;

  String label(Translations t) => t.prayer.moments[name]!;
  String retreat(Translations t) => t.prayer.retreatOf[name]!;
}

extension PrayerTopicCategoryLook on PrayerTopicCategory {
  IconData get tile => switch (this) {
    PrayerTopicCategory.church => AppIcons.churchTile,
    PrayerTopicCategory.nations => AppIcons.nationsTile,
    PrayerTopicCategory.sick => AppIcons.sickTile,
    PrayerTopicCategory.event => AppIcons.eventsTile,
    PrayerTopicCategory.fasting => AppIcons.fastingTile,
    PrayerTopicCategory.other => AppIcons.prayerTile,
  };

  AppModule get module => switch (this) {
    PrayerTopicCategory.church => AppModule.reports,
    PrayerTopicCategory.nations => AppModule.hymns,
    PrayerTopicCategory.event => AppModule.events,
    _ => AppModule.prayer,
  };

  String label(Translations t) => t.prayer.topics.categories[name]!;
}

extension PrayerListLook on PrayerList {
  String label(Translations t) => t.prayer.lists.names[name]!;

  /// "A cru au Seigneur le 2 octobre", "Exaucé le 14 août"…
  String answeredOn(Translations t, String date) => switch (this) {
    PrayerList.unbelievers => t.prayer.lists.answeredOn.unbelievers(date: date),
    PrayerList.believers => t.prayer.lists.answeredOn.believers(date: date),
    PrayerList.backsliders => t.prayer.lists.answeredOn.backsliders(date: date),
    PrayerList.coworkers => t.prayer.lists.answeredOn.coworkers(date: date),
  };
}

/// A round progress: a faint ring and its filled part from the top.
class ProgressRingPainter extends CustomPainter {
  const ProgressRingPainter({
    required this.progress,
    required this.color,
    required this.track,
    this.stroke = 8,
  });

  final double progress;
  final Color color;
  final Color track;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final arc = (Offset.zero & size).deflate(stroke / 2);
    canvas
      ..drawArc(
        arc,
        0,
        math.pi * 2,
        false,
        Paint()
          ..color = track
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke,
      )
      ..drawArc(
        arc,
        -math.pi / 2,
        math.pi * 2 * progress.clamp(0, 1),
        false,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = stroke,
      );
  }

  @override
  bool shouldRepaint(ProgressRingPainter oldDelegate) =>
      progress != oldDelegate.progress ||
      color != oldDelegate.color ||
      track != oldDelegate.track;
}

/// "Sujets de la communauté" + its action, above a group of cards.
class PrayerSectionHeader extends StatelessWidget {
  const PrayerSectionHeader({
    required this.title,
    this.action,
    this.onAction,
    this.trailing,
    super.key,
  });

  final String title;
  final String? action;
  final VoidCallback? onAction;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.prayer.tone(context);
    return Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(
              title,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
          ),
        ),
        ?trailing,
        if (action != null)
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: tone.onSoft,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              minimumSize: const Size(0, 40),
            ),
            child: Text(
              action!,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }
}

/// A card of the prayer screens: white, rounded, with a thin border.
class PrayerCard extends StatelessWidget {
  const PrayerCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(14),
    this.color,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: color ?? scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        side: color == null
            ? BorderSide(color: scheme.outlineVariant)
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// A module icon on its tinted square.
class ToneTile extends StatelessWidget {
  const ToneTile({
    required this.icon,
    required this.tone,
    this.size = 50,
    super.key,
  });

  final IconData icon;
  final ModuleTone tone;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: tone.soft,
      borderRadius: BorderRadius.circular(size * 0.28),
    ),
    child: PhosphorIcon(icon, size: size * 0.56, color: tone.onSoft),
  );
}

/// The progress of an importunity topic: a bar toward its goal.
class GoalBar extends StatelessWidget {
  const GoalBar({required this.progress, this.reached = false, super.key});

  final double progress;
  final bool reached;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.prayer.tone(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        color: reached ? AppColors.gold : tone.color,
        backgroundColor: tone.soft,
      ),
    );
  }
}
