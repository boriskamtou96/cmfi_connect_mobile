import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/utils/date_extensions.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/widgets/cmfi_logo.dart';
import '../../../../core/widgets/code_chip.dart';

// Mock screens of each module, drawn on a 350×400 board scaled to the free space.
// Decorative: screen readers get the page title and text instead.

class _Board extends StatelessWidget {
  const _Board({
    required this.module,
    required this.ring,
    required this.children,
  });

  final AppModule module;

  /// Where the faint ring sits, relative to the board.
  final ({double? left, double? top, double? right, double? bottom}) ring;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;

    return ExcludeSemantics(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: module.tone(context).soft,
          borderRadius: BorderRadius.circular(32),
        ),
        child: FittedBox(
          child: SizedBox(
            width: 350,
            height: 400,
            child: Stack(
              children: [
                Positioned(
                  left: ring.left,
                  top: ring.top,
                  right: ring.right,
                  bottom: ring.bottom,
                  child: BrandRing(
                    size: 300,
                    color: Colors.white.withValues(alpha: dark ? 0.05 : 0.55),
                    strokeWidth: 8,
                  ),
                ),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.shadow,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 22,
  });

  final Color shadow;
  final Widget child;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: shadow.withValues(alpha: 0.38),
            blurRadius: 30,
            spreadRadius: -12,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: scheme.onSurface),
        child: child,
      ),
    );
  }
}

TextStyle _muted(BuildContext context) => TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: Theme.of(context).colorScheme.onSurfaceVariant,
);

class ReportsIllustration extends StatelessWidget {
  const ReportsIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.t.onboarding.sample;
    final scheme = Theme.of(context).colorScheme;
    final now = DateTime.now();

    Widget row(String code, String label, String? value) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
          CodeChip(code: code, filled: value != null, minWidth: 40),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: value == null
                    ? scheme.onSurfaceVariant
                    : scheme.onSurface,
              ),
            ),
          ),
          Text(
            value ?? '+',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: value == null ? scheme.onSurfaceVariant : scheme.primary,
            ),
          ),
        ],
      ),
    );

    // a week with four days filled, today (the 5th) in gold
    const bars = [30.0, 22.0, 40.0, 0.0, 54.0, 0.0, 0.0];

    return _Board(
      module: AppModule.reports,
      ring: (left: -110, top: -90, right: null, bottom: null),
      children: [
        Positioned(
          left: 22,
          top: 34,
          width: 286,
          child: _Card(
            shadow: AppColors.primaryDeep,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 8),
                  child: Text(
                    '${s.today} · ${context.formatDate(now, 'EEEE d')}',
                    style: _muted(context).copyWith(fontSize: 13),
                  ),
                ),
                row('LB', s.bibleReading, s.chapters),
                row('PS', s.prayerAlone, 120.toDurationLabel()),
                row('RDQAD', s.meditation, 30.toDurationLabel()),
                row('PG', s.groupPrayer, null),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 26,
          width: 196,
          child: _Card(
            shadow: AppColors.primaryDeep,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            radius: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.thisWeek, style: _muted(context)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 54,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (var i = 0; i < bars.length; i++) ...[
                        if (i > 0) const SizedBox(width: 6),
                        Expanded(
                          child: Container(
                            height: bars[i] == 0 ? 4 : bars[i],
                            decoration: BoxDecoration(
                              color: switch (bars[i]) {
                                0 => scheme.outline,
                                _ when i == 4 => AppColors.gold,
                                _ => scheme.primary,
                              },
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  s.weekScore,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WorshipIllustration extends StatelessWidget {
  const WorshipIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.t.onboarding.sample;
    final hymns = AppModule.hymns.tone(context);
    final prayer = AppModule.prayer.tone(context);

    Widget pill(String text) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: hymns.soft,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: hymns.onSoft,
        ),
      ),
    );

    Widget line(double widthFactor) => FractionallySizedBox(
      widthFactor: widthFactor,
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        height: 8,
        decoration: BoxDecoration(
          color: Color.lerp(hymns.soft, hymns.onSoft, 0.08),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );

    return _Board(
      module: AppModule.hymns,
      ring: (left: null, top: -100, right: -120, bottom: null),
      children: [
        Positioned(
          left: 22,
          top: 30,
          width: 252,
          child: _Card(
            shadow: hymns.color,
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: hymns.soft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: PhosphorIcon(
                        AppIcons.hymnsTile,
                        size: 20,
                        color: hymns.onSoft,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.hymn, style: _muted(context)),
                        Text(
                          s.hymnNumber,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                line(0.92),
                const SizedBox(height: 9),
                line(0.78),
                const SizedBox(height: 9),
                line(0.86),
                const SizedBox(height: 9),
                line(0.6),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [pill('Aa'), pill(s.fullScreen)],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 26,
          width: 238,
          child: _Card(
            shadow: prayer.color,
            radius: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: prayer.soft,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: PhosphorIcon(
                        AppIcons.prayerTile,
                        size: 18,
                        color: prayer.onSoft,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        s.prayerOfTheDay,
                        overflow: TextOverflow.ellipsis,
                        style: _muted(context).copyWith(color: prayer.onSoft),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  s.prayerTopic,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        s.praying,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: prayer.color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        s.iPray,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CommunityIllustration extends StatelessWidget {
  const CommunityIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.t.onboarding.sample;
    final events = AppModule.events.tone(context);
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    // next Friday and the Saturday after
    final now = today();
    final friday = now.add(
      Duration(days: (DateTime.friday - now.weekday) % 7 + 7),
    );
    final saturday = friday.add(const Duration(days: 8));

    Widget dateBadge(
      DateTime date, {
      required bool strong,
      required double width,
      required double day,
    }) => Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: strong ? 8 : 6),
      decoration: BoxDecoration(
        color: strong ? events.color : events.soft,
        borderRadius: BorderRadius.circular(strong ? 14 : 12),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: strong ? Colors.white : events.onSoft,
          height: 1.05,
        ),
        child: Column(
          children: [
            Text(
              context.formatDate(date, 'EEE').toUpperCase(),
              style: TextStyle(
                fontSize: strong ? 11 : 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
            ),
            Text(
              '${date.day}',
              style: TextStyle(fontSize: day, fontWeight: FontWeight.w800),
            ),
            Text(
              context.formatDate(date, 'MMM').toUpperCase(),
              style: TextStyle(
                fontSize: strong ? 11 : 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );

    return _Board(
      module: AppModule.events,
      ring: (left: -120, top: null, right: null, bottom: -120),
      children: [
        Positioned(
          left: 22,
          right: 22,
          top: 30,
          child: _Card(
            shadow: events.color,
            child: Row(
              children: [
                dateBadge(friday, strong: true, width: 56, day: 22),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.vigil,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        s.vigilMeta,
                        style: TextStyle(fontSize: 13, color: muted),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: events.soft,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          s.join,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: events.onSoft,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 46,
          right: 22,
          top: 172,
          child: _Card(
            shadow: events.color,
            radius: 20,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                dateBadge(saturday, strong: false, width: 50, day: 19),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.retreat,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        s.retreatMeta,
                        style: TextStyle(fontSize: 13, color: muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 22,
          right: 60,
          bottom: 28,
          child: _Card(
            shadow: events.color,
            radius: 18,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.announcement.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.7,
                    color: events.onSoft,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  s.announcementText,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
