import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/section_card.dart';
import '../../domain/event.dart';
import 'event_format.dart';
import 'event_picture.dart';

/// Hero tag of an event's poster: it grows from the list into the event page.
Object posterTag(int eventId) => 'event-poster-$eventId';

/// The pills of an event: countdown, the user's registration, the state of
/// registrations, draft or cancelled.
class EventPills extends StatelessWidget {
  const EventPills({required this.event, required this.now, super.key});

  final CommunityEvent event;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final t = context.t.events;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.events.tone(context);
    final registration = event.registration;
    final over = event.isOver(now);

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        if (event.status == EventStatus.draft)
          StatusPill(
            t.draft,
            background: scheme.surfaceContainerHighest,
            foreground: scheme.onSurfaceVariant,
          ),
        if (event.status == EventStatus.cancelled)
          StatusPill(
            t.cancelled,
            background: scheme.errorContainer,
            foreground: scheme.onErrorContainer,
          )
        else ...[
          StatusPill(
            context.countdown(event, now),
            background: tone.soft,
            foreground: tone.onSoft,
          ),
          if (registration.registered && !over)
            StatusPill(
              t.registered,
              background: AppTones.of(context).personalSoft,
              foreground: AppTones.of(context).personal,
            )
          else if (registration.state == RegistrationState.full)
            StatusPill(t.stateFull)
          else if (registration.state == RegistrationState.open)
            StatusPill(t.stateOpen),
        ],
      ],
    );
  }
}

/// The first event, large: its whole poster, then what to know at a glance.
class FeaturedEventCard extends StatelessWidget {
  const FeaturedEventCard({
    required this.event,
    required this.now,
    required this.onTap,
    super.key,
  });

  final CommunityEvent event;
  final DateTime now;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: scheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 4 / 5,
              child: Hero(
                tag: posterTag(event.id),
                child: PosterBackdrop(event.poster),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.lg,
                14,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventPills(event: event, now: now),
                  const SizedBox(height: 10),
                  Text(
                    event.title,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (event.theme.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      event.theme,
                      style: TextStyle(
                        fontFamily: 'Lora',
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  _Fact(
                    icon: AppIcons.calendar,
                    text: context.eventDates(
                      event.startsAt,
                      event.endsAt,
                      event.timeZone,
                    ),
                  ),
                  if (event.place.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    _Fact(
                      icon: AppIcons.place,
                      text: [
                        event.venue,
                        event.place,
                      ].where((part) => part.isNotEmpty).join(' · '),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(icon, size: 18, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(width: AppSpacing.sm),
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

/// An event in a list: a small poster, its title, dates and place.
class EventRow extends StatelessWidget {
  const EventRow({
    required this.event,
    required this.now,
    required this.onTap,
    this.heroed = true,
    super.key,
  });

  final CommunityEvent event;
  final DateTime now;
  final VoidCallback onTap;

  /// Whether its poster flies into the event page (one per event on screen).
  final bool heroed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final poster = ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: SizedBox(width: 64, height: 80, child: EventPicture(event.poster)),
    );

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            if (heroed)
              Hero(tag: posterTag(event.id), child: poster)
            else
              poster,
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    [
                      context.eventDates(
                        event.startsAt,
                        event.endsAt,
                        event.timeZone,
                      ),
                      event.city,
                    ].where((part) => part.isNotEmpty).join(' · '),
                    style: TextStyle(
                      fontSize: 14,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 6),
                  EventPills(event: event, now: now),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(AppIcons.chevronRight, color: scheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

/// A past edition: its poster and its title, in a row that scrolls sideways.
class EditionTile extends StatelessWidget {
  const EditionTile({
    required this.title,
    required this.poster,
    required this.dates,
    required this.onTap,
    super.key,
  });

  final String title;
  final EventImage? poster;
  final String dates;
  final VoidCallback onTap;

  static const width = 136.0;

  /// The height of a row of tiles: the poster, then two lines of title and
  /// the dates, at the user's text size.
  static double height(BuildContext context) =>
      width * 5 / 4 + MediaQuery.textScalerOf(context).scale(84);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: EventPicture(poster),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            Text(
              dates,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
