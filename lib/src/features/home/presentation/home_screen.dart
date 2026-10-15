import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/animated_progress_bar.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/dashed_outline.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/goal_ring.dart';
import '../../../core/widgets/media_picture.dart';
import '../../../core/widgets/rolling_text.dart';
import '../../../core/widgets/section_card.dart';
import '../../../routing/app_router.dart';
import '../../events/application/events_providers.dart';
import '../../events/domain/event.dart';
import '../../events/infrastructure/events_api.dart';
import '../../events/presentation/widgets/event_cards.dart';
import '../../events/presentation/widgets/event_format.dart';
import '../../events/presentation/widgets/event_picture.dart';
import '../../hymns/application/hymn_collections.dart';
import '../../hymns/application/hymn_library.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../../ministry/application/nations.dart';
import '../../notifications/application/inbox.dart';
import '../../prayer/application/retreats.dart';
import '../../prayer/domain/retreat.dart';
import '../../prayer/presentation/prayer_screen.dart';
import '../../prayer/presentation/widgets/prayer_look.dart';
import '../../profile/application/current_profile.dart';
import '../../reports/application/day_report_controller.dart';
import '../../reports/application/report_goals.dart';
import '../../reports/application/reports_providers.dart';
import '../../verses/presentation/verse_card.dart';
import '../domain/week_story.dart';

/// Dashboard: today's report, the week, and what's coming in the community.
@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final now = today();
    final profile = ref.watch(currentProfileProvider).value;

    void openReports(ReportsView view) {
      ref.read(selectedReportsViewProvider.notifier).select(view);
      if (view == ReportsView.today) {
        ref.read(selectedReportDayProvider.notifier).select(now);
      }
      context.navigateTo(const ReportsRoute());
    }

    Future<void> refresh() async {
      ref
        ..invalidate(currentProfileProvider)
        ..invalidate(dayReportControllerProvider(now))
        ..invalidate(reportHistoryProvider)
        ..invalidate(eventListProvider);
      await ref
          .read(dayReportControllerProvider(now).future)
          .then((_) {}, onError: (_) {});
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: refresh,
          child: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              18,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              FadeSlideIn(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context
                                  .formatDate(now, 'EEEE d MMMM')
                                  .capitalized,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Semantics(
                              header: true,
                              child: Text(
                                profile == null
                                    ? t.home.greetingNoName
                                    : t.home.greeting(name: profile.firstName),
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const _Bell(),
                      const SizedBox(width: AppSpacing.xs),
                      Tooltip(
                        message: t.home.profile,
                        child: InkResponse(
                          onTap: () => context.navigateTo(const MoreRoute()),
                          radius: 28,
                          child: MemberAvatar(
                            initials: profile?.initials ?? '',
                            photo: profile?.avatar,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Sunday evening and Monday: the week told, first
              if (storyWeekAt(DateTime.now()) case final week?) ...[
                const SizedBox(height: 14),
                FadeSlideIn(index: 1, child: _WeekStoryCard(monday: week)),
              ],
              const SizedBox(height: 14),
              FadeSlideIn(
                index: 1,
                child: _TodayCard(onOpen: () => openReports(ReportsView.today)),
              ),
              const SizedBox(height: 14),
              FadeSlideIn(
                index: 2,
                child: _WeekCard(
                  onOpen: () => openReports(ReportsView.history),
                ),
              ),
              const SizedBox(height: 14),
              const FadeSlideIn(index: 3, child: VerseOfTheDayCard()),
              const SizedBox(height: 14),
              const FadeSlideIn(index: 3, child: _HymnsCard()),
              const SizedBox(height: 20),
              FadeSlideIn(
                index: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  child: Text(
                    t.home.community,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const FadeSlideIn(index: 5, child: _EventsCarousel()),
              const SizedBox(height: 10),
              FadeSlideIn(
                index: 6,
                child: _TeaserCard(
                  module: AppModule.events,
                  icon: const PhosphorIcon(AppIcons.ministryTile, size: 20),
                  title: t.ministry.title,
                  text: t.ministry.homeText(
                    n: ref.watch(nationsProvider).value?.length ?? 154,
                  ),
                  soon: false,
                  onTap: () => context.router.push(const MinistryRoute()),
                ),
              ),
              const SizedBox(height: 10),
              const FadeSlideIn(index: 7, child: _PrayerCard()),
            ],
          ),
        ),
      ),
    );
  }
}

/// The retreat of the moment (morning, noon, evening, night) and what it
/// prays for; a tap opens it. Once the four of the day are made, the
/// Prayer tab.
class _PrayerCard extends ConsumerWidget {
  const _PrayerCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final now = DateTime.now();
    final moment = nextRetreat(ref.watch(retreatsTodayProvider), now);

    return _TeaserCard(
      module: AppModule.prayer,
      icon: PhosphorIcon(moment?.icon ?? AppIcons.prayerTile, size: 20),
      title: switch (moment) {
        null => t.nav.prayer,
        _ when moment == momentAt(now) => t.prayer.hero.now(
          retreat: moment.retreat(t),
        ),
        _ => moment.retreat(t),
      },
      text: moment == null
          ? t.prayer.hero.allDone
          : t.prayer.hero.preview[moment.name]!,
      filled: true,
      soon: false,
      onTap: () => moment == null
          ? context.navigateTo(const PrayerRoute())
          : context.router.push(RetreatRoute(moment: moment)),
    );
  }
}

/// The next events of the community (up to [_max]) as large posters, one
/// after the other with a swipe; the last card opens them all. With one event
/// or none, [_EventCard].
class _EventsCarousel extends HookConsumerWidget {
  const _EventsCarousel();

  static const _max = 5;
  static const _fraction = 0.78;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcoming =
        ref.watch(eventListProvider(EventPeriod.upcoming)).value ?? const [];
    final events = [
      for (final event in upcoming)
        if (event.status == EventStatus.published) event,
    ];
    final controller = usePageController(viewportFraction: _fraction);
    final page = useState(0);

    if (events.length < 2) {
      return const _EventCard();
    }
    final shown = events.take(_max).toList();
    final now = DateTime.now();
    final scaler = MediaQuery.textScalerOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth * _fraction - AppSpacing.md;
        // the poster, then two lines of title and one of dates, whatever
        // the title: the cards keep the same height
        final height =
            width * 5 / 4 +
            AppSpacing.md * 2 +
            scaler.scale(_EventSlide.titleLine) * 2 +
            AppSpacing.xs +
            scaler.scale(_EventSlide.factLine);

        return Column(
          children: [
            SizedBox(
              height: height,
              child: PageView.builder(
                controller: controller,
                padEnds: false,
                itemCount: shown.length + 1,
                onPageChanged: (index) => page.value = index,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(end: AppSpacing.md),
                  child: index < shown.length
                      ? Semantics(
                          label: context.t.events.slide(
                            current: index + 1,
                            total: shown.length,
                          ),
                          child: _EventSlide(event: shown[index], now: now),
                        )
                      : _AllEventsSlide(count: events.length),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            _PageDots(count: shown.length + 1, current: page.value),
          ],
        );
      },
    );
  }
}

/// An event of the carousel: its whole poster with its pills, the title and
/// the dates.
class _EventSlide extends StatelessWidget {
  const _EventSlide({required this.event, required this.now});

  final CommunityEvent event;
  final DateTime now;

  static const titleLine = 20.0;
  static const factLine = 18.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        onTap: () => context.router.push(EventRoute(eventId: event.id)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 4 / 5,
              // the blurred copy behind the poster stays inside it
              child: ClipRect(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: posterTag(event.id),
                      child: PosterBackdrop(event.poster),
                    ),
                    PositionedDirectional(
                      start: AppSpacing.sm,
                      end: AppSpacing.sm,
                      top: AppSpacing.sm,
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: EventPills(event: event, now: now),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    strutStyle: const StrutStyle(
                      fontSize: 16,
                      height: titleLine / 16,
                      forceStrutHeight: true,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    [
                      context.eventDates(
                        event.startsAt,
                        event.endsAt,
                        event.timeZone,
                      ),
                      event.city,
                    ].where((part) => part.isNotEmpty).join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    strutStyle: const StrutStyle(
                      fontSize: 13,
                      height: factLine / 13,
                      forceStrutHeight: true,
                    ),
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The last card of the carousel: all the events.
class _AllEventsSlide extends StatelessWidget {
  const _AllEventsSlide({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final t = context.t.events;
    final tone = AppModule.events.tone(context);

    return Material(
      color: tone.soft,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: () => context.router.push(const EventsRoute()),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PhosphorIcon(AppIcons.eventsTile, size: 40, color: tone.onSoft),
              const SizedBox(height: AppSpacing.md),
              Text(
                t.seeAll,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: tone.onSoft,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                t.upcomingCount(n: count),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: tone.onSoft),
              ),
              const SizedBox(height: AppSpacing.md),
              Icon(AppIcons.arrowRight, color: tone.onSoft),
            ],
          ),
        ),
      ),
    );
  }
}

/// Where the carousel is: one dot per card, the current one longer.
class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    final tone = AppModule.events.tone(context);
    final duration = AppMotion.of(context, AppMotion.fast);

    return ExcludeSemantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: duration,
              curve: AppMotion.standard,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == current ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: i == current ? tone.color : tone.soft,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
        ],
      ),
    );
  }
}

/// The next event of the community: its poster, when, where and how long
/// until it starts. Without one yet, a card that opens the events.
class _EventCard extends ConsumerWidget {
  const _EventCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.events.tone(context);
    final event = ref.watch(nextEventProvider).value;

    if (event == null) {
      return _TeaserCard(
        module: AppModule.events,
        icon: const PhosphorIcon(AppIcons.eventsTile, size: 20),
        title: t.home.eventsTitle,
        text: t.events.homeText,
        soon: false,
        onTap: () => context.router.push(const EventsRoute()),
      );
    }

    final now = DateTime.now();
    final days = event.daysUntil(now);
    final countdown = event.isOn(now)
        ? t.events.onNow
        : switch (days) {
            <= 0 => t.events.today,
            1 => t.events.tomorrow,
            _ => t.events.daysLeft(n: days),
          };
    final poster = event.poster;

    return Material(
      color: scheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => context.router.push(EventRoute(eventId: event.id)),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    child: SizedBox(
                      width: 84,
                      height: 105,
                      child: poster == null
                          ? ColoredBox(
                              color: tone.soft,
                              child: PhosphorIcon(
                                AppIcons.eventsTile,
                                color: tone.onSoft,
                              ),
                            )
                          : MediaPicture(url: poster.url, argb: poster.argb),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.events.next.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            color: tone.onSoft,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
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
                            context.formatDayRange(
                              event.startsAt,
                              event.endsAt,
                              timeZone: event.timeZone,
                            ),
                            event.city,
                          ].where((part) => part.isNotEmpty).join(' · '),
                          style: TextStyle(
                            fontSize: 14,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            StatusPill(
                              countdown,
                              background: tone.soft,
                              foreground: tone.onSoft,
                            ),
                            if (event.registration.registered)
                              StatusPill(
                                t.events.registered,
                                background: AppTones.of(context).personalSoft,
                                foreground: AppTones.of(context).personal,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: scheme.outlineVariant),
          InkWell(
            onTap: () => context.router.push(const EventsRoute()),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 48),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        t.events.seeAll,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: tone.onSoft,
                        ),
                      ),
                    ),
                    Icon(AppIcons.arrowRight, size: 18, color: tone.onSoft),
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

/// Hymns: back to the last one opened, or to the hymn book.
class _HymnsCard extends ConsumerWidget {
  const _HymnsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final module = AppModule.hymns.tone(context);
    final last = ref.watch(recentHymnsProvider).firstOrNull;
    // the books are only loaded when there is a hymn to go back to
    final hymn = last == null
        ? null
        : ref.watch(hymnBookProvider(last.bookCode))?.hymn(last.number);

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: () => last != null && hymn != null
            ? context.router.push(
                HymnReaderRoute(bookCode: last.bookCode, number: last.number),
              )
            : context.navigateTo(const HymnsRoute()),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: module.soft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PhosphorIcon(AppIcons.hymnsTile, color: module.onSoft),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.home.hymnsTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      last != null && hymn != null
                          ? '${t.home.hymnsResume(number: hymn.number)} · ${hymn.title}'
                          : t.home.hymnsOpen,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(AppIcons.chevronRight, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodayCard extends ConsumerWidget {
  const _TodayCard({required this.onOpen});

  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final draft = ref.watch(dayReportControllerProvider(today())).value;
    final filled =
        draft?.entries.where((entry) => entry.isFilled).toList() ?? const [];
    final total = draft?.entries.length ?? 0;
    final goalsOfDay = ref.watch(goalsOfDayProvider(today()));
    const onCard = Color(0xFFDCE9F7);

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppRadius.xl + 4),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -60,
            top: -60,
            child: BrandRing(
              size: 190,
              color: Colors.white.withValues(alpha: 0.12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.home.todayTitle,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.onPrimaryMuted,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.end,
                            spacing: AppSpacing.sm,
                            children: [
                              RollingText(
                                draft == null
                                    ? '—'
                                    : t.home.progress(
                                        filled: filled.length,
                                        total: total,
                                      ),
                                value: filled.length,
                                style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                  letterSpacing: -0.6,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                t.home.progressLabel,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: onCard,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (goalsOfDay != null) ...[
                      const SizedBox(width: AppSpacing.md),
                      Column(
                        children: [
                          GoalRing(
                            value: goalsOfDay.progress,
                            label: t.reports.dayGoals,
                            size: 60,
                            color: Colors.white,
                            trackColor: Colors.white.withValues(alpha: 0.22),
                            textColor: Colors.white,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            t.home.goals,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: onCard,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 14),
                AnimatedProgressBar(
                  value: total == 0 ? 0 : filled.length / total,
                  minHeight: 8,
                  color: AppColors.gold,
                  backgroundColor: Colors.white.withValues(alpha: 0.22),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final entry in filled.take(3))
                            _WhiteChip(entry.code),
                          if (filled.length > 3)
                            _WhiteChip('+${filled.length - 3}'),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    FilledButton(
                      onPressed: onOpen,
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        minimumSize: const Size(0, 44),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: Text(
                        filled.isEmpty
                            ? t.home.startReport
                            : t.home.continueReport,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The notifications of the admins, with the number not read yet.
class _Bell extends ConsumerWidget {
  const _Bell();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.notifications;
    final unread = ref.watch(inboxProvider).value?.unread ?? 0;

    return IconButton(
      tooltip: unread > 0 ? '${t.title} · ${t.unread(n: unread)}' : t.title,
      onPressed: () => context.router.push(const NotificationsRoute()),
      icon: Badge(
        isLabelVisible: unread > 0,
        label: Text(unread > 9 ? '9+' : '$unread'),
        child: const Icon(AppIcons.notifications),
      ),
    );
  }
}

class _WhiteChip extends StatelessWidget {
  const _WhiteChip(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _WeekCard extends ConsumerWidget {
  const _WeekCard({required this.onOpen});

  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final now = today();
    final reported =
        ref.watch(reportedDaysOfWeekProvider(now)).value ?? const <DateTime>{};
    final todayFilled =
        ref.watch(dayReportControllerProvider(now)).value?.filledCount ?? 0;
    final monday = now.startOfWeek;
    final week = [
      for (var i = 0; i < 7; i++)
        DateTime(monday.year, monday.month, monday.day + i),
    ];
    final filledDays = reported.where((day) => !day.isAfter(now)).length;
    final streak = ref.watch(reportStreakProvider).value ?? 0;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: Text(
                      t.home.weekTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  RollingText(
                    t.home.weekScore(filled: filledDays, total: now.weekday),
                    value: filledDays,
                    alignment: AlignmentDirectional.centerEnd,
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  for (final (index, day) in week.indexed)
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            context.formatDate(day, 'EEEEE').toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: day.isSameDay(now)
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: day.isAfter(now)
                                  ? AppTones.of(context).disabled
                                  : scheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 6),
                          _DayDot(
                            index: index,
                            done: reported.contains(day),
                            isToday: day.isSameDay(now),
                            isFuture: day.isAfter(now),
                            todayCount: todayFilled,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              // a series of 2 days or more is worth showing
              AnimatedSize(
                duration: AppMotion.of(context, AppMotion.medium),
                curve: AppMotion.standard,
                child: streak >= 2
                    ? _Streak(days: streak, todayDone: reported.contains(now))
                    : const SizedBox(width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "🔥 12 jours d'affilée · Remplis aujourd'hui pour continuer"
class _Streak extends StatelessWidget {
  const _Streak({required this.days, required this.todayDone});

  final int days;
  final bool todayDone;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: AppTones.of(context).personalSoft,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            const Icon(AppIcons.streak, size: 20, color: AppColors.gold),
            const SizedBox(width: AppSpacing.sm),
            RollingText(
              t.home.streak(n: days),
              value: days,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                todayDone ? t.home.streakToday : t.home.streakKeep,
                textAlign: TextAlign.end,
                maxLines: 2,
                style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({
    required this.index,
    required this.done,
    required this.isToday,
    required this.isFuture,
    required this.todayCount,
  });

  /// Day of the week (0: Monday): the check marks pop in one after the other.
  final int index;
  final bool done;
  final bool isToday;
  final bool isFuture;
  final int todayCount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const size = 30.0;

    if (done) {
      // a new element each time a day gets done: it pops in once
      final wait = AppMotion.stagger * index;
      final total = wait + AppMotion.slow;
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: AppMotion.of(context, total),
        curve: Interval(
          wait.inMicroseconds / total.inMicroseconds,
          1,
          curve: AppMotion.pop,
        ),
        builder: (context, scale, child) =>
            Transform.scale(scale: scale, child: child),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: scheme.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(AppIcons.check, size: 18, color: scheme.onPrimary),
        ),
      );
    }
    if (isToday) {
      return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.gold, width: 2.5),
        ),
        child: todayCount == 0
            ? null
            : Text(
                '$todayCount',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppTones.of(context).personal,
                ),
              ),
      );
    }
    if (isFuture) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          shape: BoxShape.circle,
        ),
      );
    }
    return DashedOutline(
      color: scheme.outline,
      strokeWidth: 2,
      child: const SizedBox.square(dimension: size),
    );
  }
}

/// "Ta semaine avec Dieu est prête": from Sunday 18:00 to Monday evening.
class _WeekStoryCard extends StatelessWidget {
  const _WeekStoryCard({required this.monday});

  final DateTime monday;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final sunday = DateTime(monday.year, monday.month, monday.day + 6);
    void open() =>
        context.router.push(WeekStoryRoute(monday: monday.toApiDate()));
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl + 4),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2F6BFF), Color(0xFF6A2FB8)],
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: open,
          child: Stack(
            children: [
              PositionedDirectional(
                end: -40,
                top: -50,
                child: BrandRing(
                  size: 160,
                  color: Colors.white.withValues(alpha: 0.14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CmfiLogo(size: 26, disc: true),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            t.weekStory.range(
                              from: context.formatDate(monday, 'd MMM'),
                              to: context.formatDate(sunday, 'd MMM'),
                            ),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFD6DCFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      t.weekStory.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.weekStory.homeText,
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.35,
                        color: Color(0xE6FFFFFF),
                      ),
                    ),
                    const SizedBox(height: 14),
                    FilledButton.icon(
                      onPressed: open,
                      icon: const Icon(AppIcons.play, size: 18),
                      label: Text(t.weekStory.open),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF3A2A9A),
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
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
    );
  }
}

class _TeaserCard extends StatelessWidget {
  const _TeaserCard({
    required this.module,
    required this.icon,
    required this.title,
    required this.text,
    this.filled = false,
    this.soon = true,
    this.onTap,
  });

  final AppModule module;
  final Widget icon;
  final String title;
  final String text;

  /// Shows the "Bientôt" pill.
  final bool soon;

  /// Card in the module's soft color, instead of white.
  final bool filled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tone = module.tone(context);

    return Material(
      color: filled ? tone.soft : scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        side: filled
            ? BorderSide.none
            : BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: filled ? scheme.surface : tone.soft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconTheme(
                  data: IconThemeData(color: tone.onSoft, size: 20),
                  child: icon,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (soon)
                          StatusPill(
                            context.t.common.soon,
                            background: filled ? scheme.surface : null,
                            foreground: tone.onSoft,
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
