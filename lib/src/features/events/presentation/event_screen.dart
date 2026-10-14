import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/calendar_service.dart';
import '../../../core/services/deep_links.dart';
import '../../../core/services/link_launcher.dart';
import '../../../core/services/share_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/text_direction.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/motion.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/segmented_tabs.dart';
import '../../members/application/my_account.dart';
import '../application/events_providers.dart';
import '../domain/event.dart';
import '../infrastructure/events_api.dart';
import 'admin/event_admin_menu.dart';
import 'widgets/event_cards.dart';
import 'widgets/event_format.dart';
import 'widgets/event_picture.dart';
import 'widgets/event_tabs.dart';
import 'widgets/program_view.dart';
import 'widgets/registration.dart';

/// One event: its poster large, what to know, then the program, the news,
/// the practical information and the photos; "Je participe" stays at hand.
@RoutePage()
class EventScreen extends ConsumerWidget {
  const EventScreen({@PathParam('eventId') required this.eventId, super.key});

  final int eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(eventDetailProvider(eventId));
    // the list already has the poster and the title: the page shows them
    // while the rest arrives
    final summary = [
      ...?ref.watch(eventListProvider(EventPeriod.upcoming)).value,
      ...?ref.watch(eventListProvider(EventPeriod.past)).value,
    ].where((event) => event.id == eventId).firstOrNull;

    return switch (detail) {
      AsyncValue(value: final event?) => _EventPage(event: event),
      AsyncValue(:final error?) => Scaffold(
        appBar: AppBar(leading: const AppBackButton()),
        body: ErrorView(
          error: error,
          onRetry: () => ref.invalidate(eventDetailProvider(eventId)),
        ),
      ),
      _ when summary != null => _EventPage(event: summary, loading: true),
      _ => Scaffold(
        appBar: AppBar(leading: const AppBackButton()),
        body: const Center(child: CircularProgressIndicator()),
      ),
    };
  }
}

enum _Tab { program, news, info, photos }

class _EventPage extends HookConsumerWidget {
  const _EventPage({required this.event, this.loading = false});

  final CommunityEvent event;

  /// Only the summary of the list is known yet.
  final bool loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events;
    final scheme = Theme.of(context).colorScheme;
    final media = MediaQuery.of(context);
    final isAdmin = ref.watch(myAccountProvider).value?.isAdmin ?? false;
    final now = DateTime.now();
    final scroll = useScrollController();
    final tab = useState(_Tab.program);

    final tabs = [
      _Tab.program,
      _Tab.news,
      _Tab.info,
      if (event.photos.isNotEmpty) _Tab.photos,
    ];
    final selected = tabs.contains(tab.value) ? tab.value : _Tab.program;

    // the poster, whole on a phone; a little less on a short screen
    final posterHeight = math.min(
      media.size.width * 5 / 4,
      media.size.height * 0.62,
    );
    final collapseAt = posterHeight - kToolbarHeight - media.padding.top - 24;
    final collapsed = useListenableSelector(
      scroll,
      () => scroll.hasClients && scroll.offset > collapseAt,
    );

    void viewPoster() {
      final poster = event.poster;
      if (poster != null) {
        showImageViewer(
          context,
          images: [poster],
          heroTags: [posterTag(event.id)],
        );
      }
    }

    Future<void> share(Rect? origin) => ref
        .read(shareServiceProvider)
        .shareText(
          EventLink(event.id).under(
            t.shareText(
              title: [
                event.title,
                event.theme,
              ].where((part) => part.isNotEmpty).join(' · '),
              dates: context.eventDates(
                event.startsAt,
                event.endsAt,
                event.timeZone,
              ),
              place: event.place,
            ),
          ),
          subject: event.title,
          origin: origin,
        );

    Future<void> addToCalendar() async {
      final toast = ref.read(toasterProvider).of(context);
      final added = await ref
          .read(calendarServiceProvider)
          .add(
            title: event.title,
            start: event.startsAt.toLocal(),
            end: event.endsAt.toLocal(),
            description: [
              event.theme,
              event.themeVerse,
            ].where((part) => part.isNotEmpty).join('\n'),
            location: [
              event.venue,
              event.address,
              event.place,
            ].where((part) => part.isNotEmpty).join(', '),
          );
      if (!added) {
        toast.error(t.calendarFailed);
      }
    }

    Future<void> directions() async {
      final toast = ref.read(toasterProvider).of(context);
      final opened = await ref
          .read(linkLauncherProvider)
          .directions(
            mapsUrl: event.mapsUrl,
            place: [
              event.venue,
              event.address,
              event.place,
            ].where((part) => part.isNotEmpty).join(', '),
          );
      if (!opened) {
        toast.error(t.linkFailed);
      }
    }

    // round buttons over the poster, plain once the bar is collapsed
    Widget barButton({
      required String tooltip,
      required IconData icon,
      required void Function(BuildContext context) onPressed,
    }) => Builder(
      builder: (context) => IconButton(
        tooltip: tooltip,
        style: collapsed
            ? null
            : IconButton.styleFrom(
                backgroundColor: Colors.black.withValues(alpha: 0.32),
                foregroundColor: Colors.white,
              ),
        icon: Icon(icon),
        onPressed: () => onPressed(context),
      ),
    );

    return Scaffold(
      body: CustomScrollView(
        controller: scroll,
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: posterHeight,
            backgroundColor: scheme.surface,
            surfaceTintColor: Colors.transparent,
            systemOverlayStyle: collapsed ? null : SystemUiOverlayStyle.light,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.all(AppSpacing.xs),
              child: barButton(
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                icon: AppIcons.back,
                onPressed: (context) => context.router.maybePop(),
              ),
            ),
            title: AnimatedOpacity(
              opacity: collapsed ? 1 : 0,
              duration: const Duration(milliseconds: 160),
              child: Text(
                event.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            actions: [
              barButton(
                tooltip: t.share,
                icon: AppIcons.share,
                onPressed: (context) {
                  final box = context.findRenderObject() as RenderBox?;
                  share(
                    box == null
                        ? null
                        : box.localToGlobal(Offset.zero) & box.size,
                  );
                },
              ),
              if (isAdmin && !loading)
                EventAdminMenu(event: event, overPoster: !collapsed),
              const SizedBox(width: AppSpacing.xs),
            ],
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              stretchModes: const [StretchMode.zoomBackground],
              background: Semantics(
                button: event.poster != null,
                label: t.viewPoster,
                child: GestureDetector(
                  onTap: viewPoster,
                  child: Hero(
                    tag: posterTag(event.id),
                    child: PosterBackdrop(event.poster),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.xxl,
            ),
            sliver: SliverList.list(
              children: [
                if (event.status == EventStatus.cancelled) ...[
                  _Banner(text: t.cancelledBanner),
                  const SizedBox(height: AppSpacing.md),
                ],
                EventPills(event: event, now: now),
                const SizedBox(height: AppSpacing.md),
                Text(
                  event.title,
                  textDirection: contentDirection(event.title),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (event.theme.isNotEmpty || event.themeVerse.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  _Theme(theme: event.theme, verse: event.themeVerse),
                ],
                const SizedBox(height: AppSpacing.lg),
                _Facts(event: event, onDirections: directions),
                if (!event.isOver(now) &&
                    event.status != EventStatus.cancelled) ...[
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.tonalIcon(
                          onPressed: addToCalendar,
                          icon: const Icon(AppIcons.addToCalendar, size: 20),
                          label: Text(t.addToCalendar),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: AppSpacing.xl),
                SegmentedTabs(
                  labels: [
                    for (final tab in tabs)
                      switch (tab) {
                        _Tab.program => t.tabs.program,
                        _Tab.news => t.tabs.news,
                        _Tab.info => t.tabs.info,
                        _Tab.photos => t.tabs.photos,
                      },
                  ],
                  selectedIndex: tabs.indexOf(selected),
                  onChanged: (index) => tab.value = tabs[index],
                ),
                const SizedBox(height: AppSpacing.lg),
                if (loading)
                  const Padding(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  SharedAxisSwitcher(
                    index: tabs.indexOf(selected),
                    expand: false,
                    child: KeyedSubtree(
                      key: ValueKey(selected),
                      child: switch (selected) {
                        _Tab.program => ProgramView(event: event, now: now),
                        _Tab.news => NewsView(
                          event: event,
                          onDelete: isAdmin
                              ? (post) => deletePost(context, ref, event, post)
                              : null,
                        ),
                        _Tab.info => InfoView(event: event),
                        _Tab.photos => PhotosView(
                          event: event,
                          onDelete: isAdmin
                              ? (photo) =>
                                    deletePhoto(context, ref, event, photo)
                              : null,
                        ),
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: !loading && showsRegistrationBar(event)
          ? RegistrationBar(event: event)
          : null,
    );
  }
}

/// The theme in serif italics, and its verse.
class _Theme extends StatelessWidget {
  const _Theme({required this.theme, required this.verse});

  final String theme;
  final String verse;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.events.tone(context);

    return Container(
      padding: const EdgeInsetsDirectional.only(start: 14),
      decoration: BoxDecoration(
        border: BorderDirectional(
          start: BorderSide(color: tone.color, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (theme.isNotEmpty)
            Text(
              theme,
              textDirection: contentDirection(theme),
              style: TextStyle(
                fontFamily: 'Lora',
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 21,
                height: 1.25,
                color: tone.onSoft,
              ),
            ),
          if (verse.isNotEmpty) ...[
            if (theme.isNotEmpty) const SizedBox(height: 6),
            Text(
              verse,
              textDirection: contentDirection(verse),
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: 15,
                height: 1.5,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// When, where, how many: the essentials in one card.
class _Facts extends StatelessWidget {
  const _Facts({required this.event, required this.onDirections});

  final CommunityEvent event;
  final VoidCallback onDirections;

  @override
  Widget build(BuildContext context) {
    final t = context.t.events;
    final registration = event.registration;
    final note = context.venueTimeNote(event);
    final placesLeft = event.placesLeft;
    final where = [
      event.venue,
      event.place,
    ].where((part) => part.isNotEmpty).toList();

    return SectionCard(
      children: [
        _FactRow(
          icon: AppIcons.calendar,
          title: context.eventDatesLong(event),
          subtitle: [
            context.eventHours(event),
            if (note.isNotEmpty) note,
          ].join(' · '),
        ),
        if (where.isNotEmpty)
          _FactRow(
            icon: AppIcons.place,
            title: where.first,
            subtitle: where.skip(1).join(),
            trailing: TextButton(
              onPressed: onDirections,
              child: Text(t.directions),
            ),
          ),
        if (event.status == EventStatus.published)
          _FactRow(
            icon: AppIcons.people,
            title: t.registrations(
              n: registration.registrations,
              count: context.count(registration.registrations),
            ),
            subtitle: [
              if (registration.people > registration.registrations)
                t.people(
                  n: registration.people,
                  count: context.count(registration.people),
                ),
              if (placesLeft != null &&
                  registration.state != RegistrationState.ended)
                t.placesLeft(n: placesLeft, count: context.count(placesLeft)),
            ].join(' · '),
          ),
      ],
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({
    required this.icon,
    required this.title,
    this.subtitle = '',
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.events.tone(context);

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: tone.soft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: tone.onSoft),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Icon(AppIcons.error, color: scheme.onErrorContainer),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: scheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
