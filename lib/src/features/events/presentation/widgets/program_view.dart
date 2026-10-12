import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/utils/date_format.dart';
import '../../../../core/utils/zoned_time.dart';
import '../../../../core/widgets/motion.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../routing/app_router.dart';
import '../../domain/event.dart';
import 'event_format.dart';

/// The sessions of [sessions] grouped by day on the venue's calendar.
List<({DateTime day, List<EventSession> sessions})> programDays(
  List<EventSession> sessions,
  String timeZone,
) {
  final days = <DateTime, List<EventSession>>{};
  final sorted = [...sessions]
    ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
  for (final session in sorted) {
    final local = session.startsAt.inZone(timeZone);
    days
        .putIfAbsent(DateTime(local.year, local.month, local.day), () => [])
        .add(session);
  }
  return [
    for (final entry in days.entries) (day: entry.key, sessions: entry.value),
  ];
}

/// The program, one day at a time: the day of today during the event, the
/// first day otherwise. The session going on is marked.
class ProgramView extends HookWidget {
  const ProgramView({required this.event, required this.now, super.key});

  final CommunityEvent event;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final t = context.t.events;
    final days = programDays(event.sessions, event.timeZone);
    final today = now.inZone(event.timeZone);
    final todayIndex = days.indexWhere(
      (day) =>
          day.day.year == today.year &&
          day.day.month == today.month &&
          day.day.day == today.day,
    );
    final selected = useState(todayIndex < 0 ? 0 : todayIndex);

    if (days.isEmpty) {
      return TabEmpty(t.noProgram);
    }
    final index = selected.value.clamp(0, days.length - 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (days.length > 1) ...[
          _DayPicker(
            days: [for (final day in days) day.day],
            selected: index,
            onSelected: (day) => selected.value = day,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        SharedAxisSwitcher(
          index: index,
          expand: false,
          child: Column(
            key: ValueKey(index),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (i, session) in days[index].sessions.indexed)
                _SessionTile(
                  session: session,
                  timeZone: event.timeZone,
                  now: now,
                  last: i == days[index].sessions.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Ven. 20 · Sam. 21 · Dim. 22": the selected one filled.
class _DayPicker extends StatelessWidget {
  const _DayPicker({
    required this.days,
    required this.selected,
    required this.onSelected,
  });

  final List<DateTime> days;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.events.tone(context);
    final duration = AppMotion.of(context, AppMotion.fast);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final (i, day) in days.indexed) ...[
            if (i > 0) const SizedBox(width: AppSpacing.sm),
            Semantics(
              selected: i == selected,
              button: true,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadius.md),
                onTap: () => onSelected(i),
                child: AnimatedContainer(
                  duration: duration,
                  curve: AppMotion.standard,
                  constraints: const BoxConstraints(minWidth: 64),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: i == selected ? tone.color : scheme.surface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: i == selected ? tone.color : scheme.outlineVariant,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        context.formatDate(day, 'EEE').capitalized,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: i == selected
                              ? Colors.white.withValues(alpha: 0.85)
                              : scheme.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '${day.day}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: i == selected
                              ? Colors.white
                              : scheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// One moment: its hours, a dot on the timeline, what and who, the hymns.
class _SessionTile extends StatelessWidget {
  const _SessionTile({
    required this.session,
    required this.timeZone,
    required this.now,
    required this.last,
  });

  final EventSession session;
  final String timeZone;
  final DateTime now;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final t = context.t.events;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.events.tone(context);
    final start = session.startsAt.inZone(timeZone);
    final end = session.endsAt?.inZone(timeZone);
    final current =
        !session.startsAt.isAfter(now) &&
        (session.endsAt?.isAfter(now) ?? false);
    final muted = TextStyle(fontSize: 14, color: scheme.onSurfaceVariant);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 52,
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.time(start),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                  if (end != null)
                    Text(
                      context.time(end),
                      style: muted.copyWith(
                        fontSize: 13,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                ],
              ),
            ),
          ),
          // the timeline
          SizedBox(
            width: 24,
            child: Column(
              children: [
                const SizedBox(height: 18),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: current ? tone.color : scheme.surface,
                    border: Border.all(color: tone.color, width: 2.5),
                  ),
                ),
                if (!last)
                  Expanded(
                    child: Container(width: 2, color: scheme.outlineVariant),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Container(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: current ? tone.soft : null,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (current) ...[
                      StatusPill(
                        t.now,
                        background: tone.color,
                        foreground: Colors.white,
                      ),
                      const SizedBox(height: 6),
                    ],
                    Text(
                      session.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    if (session.speaker.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      _Line(icon: AppIcons.speaker, text: session.speaker),
                    ],
                    if (session.place.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      _Line(icon: AppIcons.place, text: session.place),
                    ],
                    if (session.description.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(session.description, style: muted),
                    ],
                    if (session.hymns.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final hymn in session.hymns)
                            ActionChip(
                              avatar: Icon(
                                AppIcons.hymn,
                                size: 16,
                                color: AppModule.hymns.tone(context).onSoft,
                              ),
                              label: Text(t.hymn(number: hymn.number)),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppModule.hymns.tone(context).onSoft,
                              ),
                              backgroundColor: AppModule.hymns
                                  .tone(context)
                                  .soft,
                              side: BorderSide.none,
                              shape: const StadiumBorder(),
                              visualDensity: VisualDensity.compact,
                              onPressed: () => context.router.push(
                                HymnReaderRoute(
                                  bookCode: hymn.book,
                                  number: hymn.number,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, size: 16, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

/// The empty state of a tab ("Pas encore d'actualité…").
class TabEmpty extends StatelessWidget {
  const TabEmpty(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    ),
  );
}
