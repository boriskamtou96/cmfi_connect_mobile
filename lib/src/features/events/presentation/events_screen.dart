import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../../members/application/my_account.dart';
import '../application/events_providers.dart';
import '../domain/event.dart';
import '../infrastructure/events_api.dart';
import 'widgets/event_cards.dart';
import 'widgets/event_format.dart';

/// The events of the whole community: the next one large, the others below,
/// then the past editions.
@RoutePage()
class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events;
    final upcoming = ref.watch(eventListProvider(EventPeriod.upcoming));
    final past =
        ref.watch(eventListProvider(EventPeriod.past)).value ??
        const <CommunityEvent>[];
    final isAdmin = ref.watch(myAccountProvider).value?.isAdmin ?? false;
    final now = DateTime.now();

    void open(CommunityEvent event) =>
        context.router.push(EventRoute(eventId: event.id));

    // the server's lists, the ones shown stay without network
    Future<void> refresh() => Future.wait([
      for (final period in EventPeriod.values)
        ref.read(eventListProvider(period).notifier).refresh(),
    ]);

    return SubPage(
      title: t.title,
      actions: [
        if (isAdmin)
          IconButton(
            tooltip: t.manage,
            icon: const Icon(AppIcons.admin),
            onPressed: () => context.router.push(const AdminEventsRoute()),
          ),
      ],
      child: switch (upcoming) {
        AsyncValue(value: final events?) => RefreshIndicator.adaptive(
          onRefresh: refresh,
          child: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.xxl,
            ),
            children: [
              if (events.isEmpty)
                const FadeSlideIn(child: _NoUpcomingEvent())
              else ...[
                FadeSlideIn(child: SectionLabel(t.featured)),
                const SizedBox(height: AppSpacing.md),
                FadeSlideIn(
                  index: 1,
                  child: FeaturedEventCard(
                    event: events.first,
                    now: now,
                    onTap: () => open(events.first),
                  ),
                ),
                if (events.length > 1) ...[
                  const SizedBox(height: AppSpacing.xl),
                  FadeSlideIn(index: 2, child: SectionLabel(t.upcoming)),
                  const SizedBox(height: AppSpacing.md),
                  FadeSlideIn(
                    index: 2,
                    child: SectionCard(
                      children: [
                        for (final event in events.skip(1))
                          EventRow(
                            event: event,
                            now: now,
                            onTap: () => open(event),
                          ),
                      ],
                    ),
                  ),
                ],
              ],
              if (past.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xl),
                FadeSlideIn(index: 3, child: SectionLabel(t.past)),
                const SizedBox(height: AppSpacing.md),
                FadeSlideIn(
                  index: 3,
                  child: SizedBox(
                    height: EditionTile.height(context),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemCount: past.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final event = past[index];
                        return EditionTile(
                          title: event.title,
                          poster: event.poster,
                          dates: context.eventDates(
                            event.startsAt,
                            event.endsAt,
                            event.timeZone,
                          ),
                          onTap: () => open(event),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        AsyncValue(:final error?) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(eventListProvider),
        ),
        // the next event large: its poster (4:5), then its text
        _ => LoadingDetail(
          picture:
              (MediaQuery.sizeOf(context).width - 2 * AppSpacing.lg) * 5 / 4,
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
        ),
      },
    );
  }
}

class _NoUpcomingEvent extends StatelessWidget {
  const _NoUpcomingEvent();

  @override
  Widget build(BuildContext context) {
    final t = context.t.events;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.events.tone(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: tone.soft,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: PhosphorIcon(
              AppIcons.eventsTile,
              size: 32,
              color: tone.onSoft,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            t.emptyTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            t.emptyText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
