import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/tab_page.dart';
import '../../../routing/app_router.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../application/importunities.dart';
import '../application/prayer_people.dart';
import '../application/prayer_topics.dart';
import '../application/retreats.dart';
import '../domain/prayer.dart';
import '../domain/retreat.dart';
import 'importunity_screen.dart';
import 'retreat_reminders_sheet.dart';
import 'widgets/invitation_menu.dart';
import 'widgets/prayer_look.dart';

/// The Prière tab: the retreat of the moment, the invitations and importunity
/// topics, the topics of the community and the user's own lists.
@RoutePage()
class PrayerScreen extends ConsumerWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final importunities = ref.watch(importunitiesProvider).value ?? const [];
    final invitations = importunities.where((topic) => topic.isInvitation);
    final joined = importunities.where((topic) => !topic.isInvitation);

    Future<void> refresh() async {
      ref
        ..invalidate(retreatLogProvider)
        ..invalidate(importunitiesProvider)
        ..invalidate(prayerTopicsProvider)
        ..invalidate(prayerPeopleProvider);
      await ref.read(prayerTopicsProvider.future).catchError((Object _) {
        return const <PrayerTopic>[];
      });
    }

    return TabPage(
      title: t.nav.prayer,
      actions: [
        IconButton(
          tooltip: t.prayer.reminders.title,
          onPressed: () => showRetreatRemindersSheet(context),
          icon: Icon(AppIcons.reminder, color: scheme.onSurfaceVariant),
        ),
      ],
      child: RefreshIndicator.adaptive(
        onRefresh: refresh,
        child: ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 32),
          children: [
            for (final invitation in invitations) ...[
              _InvitationCard(topic: invitation),
              const SizedBox(height: AppSpacing.md),
            ],
            const _RetreatHero(),
            const SizedBox(height: AppSpacing.md),
            const _TodayRow(),
            const SizedBox(height: 28),
            PrayerSectionHeader(
              title: t.prayer.importunity.title,
              action: t.prayer.importunity.newTopic,
              onAction: () => showImportunityForm(context),
            ),
            const SizedBox(height: 10),
            if (joined.isEmpty)
              _ImportunityIntro(onCreate: () => showImportunityForm(context))
            else
              for (final topic in joined) ...[
                _ImportunityCard(topic: topic),
                const SizedBox(height: 10),
              ],
            const SizedBox(height: 18),
            PrayerSectionHeader(
              title: t.prayer.topics.title,
              action: t.prayer.topics.all,
              onAction: () => context.router.push(const PrayerTopicsRoute()),
            ),
            const SizedBox(height: 10),
            const _CommunityTopics(),
            const SizedBox(height: 28),
            PrayerSectionHeader(
              title: t.prayer.lists.title,
              trailing: Row(
                children: [
                  Icon(
                    AppIcons.private,
                    size: 16,
                    color: scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    t.prayer.lists.private,
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const _ListsGrid(),
            const _AnsweredBanner(),
          ],
        ),
      ),
    );
  }
}

/// The retreat to pray now: the first one not made yet from the current
/// moment of the day (null: all four are made).
RetreatMoment? nextRetreat(Set<RetreatMoment> done, DateTime now) {
  final current = momentAt(now);
  for (final moment in RetreatMoment.values.skip(current.index)) {
    if (!done.contains(moment)) {
      return moment;
    }
  }
  return null;
}

class _RetreatHero extends ConsumerWidget {
  const _RetreatHero();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final done = ref.watch(retreatsTodayProvider);
    final moment = nextRetreat(done, DateTime.now());
    final shown = moment ?? RetreatMoment.night;
    final current = momentAt(DateTime.now());

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: shown.colors,
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl + 4),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => context.router.push(RetreatRoute(moment: shown)),
          child: Stack(
            children: [
              PositionedDirectional(
                end: -50,
                top: -60,
                child: BrandRing(
                  size: 190,
                  color: Colors.white.withValues(alpha: 0.16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(shown.icon, color: Colors.white, size: 22),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            moment == null
                                ? shown.retreat(t)
                                : moment == current
                                ? t.prayer.hero.now(retreat: moment.retreat(t))
                                : moment.retreat(t),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      t.prayer.hero.title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                        letterSpacing: -0.5,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      moment == null
                          ? t.prayer.hero.allDone
                          : t.prayer.hero.preview[moment.name]!,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.35,
                        color: Colors.white.withValues(alpha: 0.92),
                      ),
                    ),
                    if (moment != null) ...[
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              t.prayer.hero.meta,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withValues(alpha: 0.88),
                              ),
                            ),
                          ),
                          FilledButton.icon(
                            onPressed: () => context.router.push(
                              RetreatSessionRoute(moment: moment),
                            ),
                            icon: const Icon(AppIcons.play, size: 18),
                            label: Text(t.prayer.hero.start),
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: moment.ink,
                              minimumSize: const Size(0, 46),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: const TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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

/// The four retreats of the day: made, to pray now, or later.
class _TodayRow extends ConsumerWidget {
  const _TodayRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final done = ref.watch(retreatsTodayProvider);
    final next = nextRetreat(done, DateTime.now());

    return Row(
      children: [
        for (final (i, moment) in RetreatMoment.values.indexed) ...[
          if (i > 0) const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Material(
              color: scheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                side: BorderSide(
                  color: moment == next
                      ? moment.colors.first
                      : scheme.outlineVariant,
                  width: moment == next ? 1.6 : 1,
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                onTap: () => context.router.push(RetreatRoute(moment: moment)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    children: [
                      Icon(
                        moment.icon,
                        size: 22,
                        color: done.contains(moment) || moment == next
                            ? moment.colors.first
                            : scheme.onSurfaceVariant.withValues(alpha: 0.55),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        moment.label(t),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      SizedBox(
                        height: 16,
                        child: done.contains(moment)
                            ? Icon(
                                AppIcons.checkCircleFilled,
                                size: 16,
                                color: scheme.primary,
                                semanticLabel: t.prayer.retreat.done,
                              )
                            : moment == next
                            ? Text(
                                t.prayer.today.toPray,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: moment.inkOf(context),
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _InvitationCard extends ConsumerWidget {
  const _InvitationCard({required this.topic});

  final Importunity topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final tone = AppModule.prayer.tone(context);
    final inviter = topic.inviter;

    Future<void> answer({required bool join}) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      try {
        final joined = await ref
            .read(importunitiesProvider.notifier)
            .answer(topic, join: join);
        if (joined != null) {
          toast.success(messages.prayer.importunity.joined);
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      }
    }

    return PrayerCard(
      color: tone.soft,
      // the menu's 48 dp button stands in the top padding
      padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 4, 16),
      onTap: () =>
          context.router.push(ImportunityRoute(importunityId: topic.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MemberAvatar(
                initials: inviter.initials,
                photo: inviter.avatar,
                size: 28,
                background: Theme.of(context).colorScheme.surface,
                foreground: tone.onSoft,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  t.prayer.importunity.invitedBy(
                    name: '${inviter.firstName} ${inviter.lastName}'.trim(),
                  ),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: tone.onSoft,
                  ),
                ),
              ),
              // report it, or block whoever sent it
              InvitationMenu(topic: topic, color: tone.onSoft),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (topic.goal case final goal?) ...[
                  const SizedBox(height: 4),
                  Text(
                    t.prayer.importunity.progress(
                      total: context.formatNumber(topic.total),
                      goal: context.formatNumber(goal),
                    ),
                    style: TextStyle(fontSize: 14, color: tone.onSoft),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () => answer(join: true),
                        style: FilledButton.styleFrom(
                          backgroundColor: tone.color,
                        ),
                        child: Text(t.prayer.importunity.join),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    TextButton(
                      onPressed: () => answer(join: false),
                      style: TextButton.styleFrom(foregroundColor: tone.onSoft),
                      child: Text(t.prayer.importunity.decline),
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

class _ImportunityIntro extends StatelessWidget {
  const _ImportunityIntro({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final tone = AppModule.prayer.tone(context);
    final scheme = Theme.of(context).colorScheme;
    return PrayerCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToneTile(icon: AppIcons.prayerTile, tone: tone, size: 44),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  t.prayer.importunity.intro,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(AppIcons.add, size: 18),
              label: Text(t.prayer.importunity.newTopic),
              style: FilledButton.styleFrom(backgroundColor: tone.color),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImportunityCard extends StatelessWidget {
  const _ImportunityCard({required this.topic});

  final Importunity topic;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    final progress = topic.progress;

    return PrayerCard(
      onTap: () =>
          context.router.push(ImportunityRoute(importunityId: topic.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  topic.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (topic.reached)
                StatusPill(
                  t.prayer.importunity.reached,
                  background: AppTones.of(context).personalSoft,
                  foreground: AppTones.of(context).personal,
                )
              else if (!topic.isOpen)
                StatusPill(t.prayer.importunity.closed),
            ],
          ),
          const SizedBox(height: 8),
          if (progress != null) ...[
            GoalBar(progress: progress, reached: topic.reached),
            const SizedBox(height: 8),
          ],
          Row(
            children: [
              Expanded(
                child: Text(
                  topic.goal == null
                      ? t.prayer.importunity.total(
                          n: topic.total,
                          count: context.formatNumber(topic.total),
                        )
                      : t.prayer.importunity.progress(
                          total: context.formatNumber(topic.total),
                          goal: context.formatNumber(topic.goal!),
                        ),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: tone.onSoft,
                  ),
                ),
              ),
              Text(
                t.prayer.importunity.participants(n: topic.participants),
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommunityTopics extends ConsumerWidget {
  const _CommunityTopics();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final topics = ref.watch(prayerTopicsProvider);

    return switch (topics) {
      AsyncData(:final value) when value.isEmpty => Text(
        t.prayer.topics.empty,
        style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
      ),
      AsyncData(:final value) => Column(
        children: [
          for (final topic in value.take(3)) ...[
            PrayerTopicCard(topic: topic),
            const SizedBox(height: 10),
          ],
        ],
      ),
      AsyncError(:final error) => Text(
        userMessageFor(error, t),
        style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
      ),
      // the cards of the topics
      _ => const Shimmer(child: SkeletonCards(count: 2, height: 96)),
    };
  }
}

/// A topic of the community in a list.
class PrayerTopicCard extends StatelessWidget {
  const PrayerTopicCard({required this.topic, super.key});

  final PrayerTopic topic;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = topic.category.module.tone(context);
    final prayer = AppModule.prayer.tone(context);
    final isNew = DateTime.now().difference(topic.startsOn).inDays < 3;
    final when = topic.endsOn == null
        ? t.prayer.topics.since(
            date: context.formatDate(topic.startsOn, 'd MMM'),
          )
        : t.prayer.topics.until(
            date: context.formatDate(topic.endsOn!, 'd MMM'),
          );

    return PrayerCard(
      onTap: () => context.router.push(PrayerTopicRoute(topicId: topic.id)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ToneTile(icon: topic.category.tile, tone: tone),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        topic.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                    ),
                    if (topic.allPrayed)
                      Icon(
                        AppIcons.checkCircleFilled,
                        color: prayer.color,
                        size: 22,
                      )
                    else if (isNew)
                      StatusPill(
                        t.prayer.topics.isNew,
                        background: prayer.soft,
                        foreground: prayer.onSoft,
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '${t.prayer.topics.points(n: topic.points.length)} · $when',
                  style: TextStyle(
                    fontSize: 14,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        t.prayer.topics.people(n: topic.people),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    if (topic.document != null) ...[
                      Icon(
                        AppIcons.pdf,
                        size: 16,
                        color: scheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        t.prayer.topics.withPdf,
                        style: TextStyle(
                          fontSize: 12,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
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

class _ListsGrid extends ConsumerWidget {
  const _ListsGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    final people = ref.watch(prayerPeopleProvider).value ?? const [];

    Widget tile(PrayerList list) {
      final count = people
          .where((person) => person.list == list && !person.answered)
          .length;
      return PrayerCard(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        onTap: () => context.router.push(PrayerListRoute(list: list)),
        child: Row(
          children: [
            Text(
              '$count',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: tone.onSoft,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                list.label(t),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        for (var row = 0; row < 2; row++) ...[
          if (row > 0) const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: tile(PrayerList.values[row * 2])),
              const SizedBox(width: 10),
              Expanded(child: tile(PrayerList.values[row * 2 + 1])),
            ],
          ),
        ],
      ],
    );
  }
}

/// "3 prayers answered this month": the joy of the lists.
class _AnsweredBanner extends ConsumerWidget {
  const _AnsweredBanner();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final answered = ref.watch(answeredThisMonthProvider);
    if (answered.isEmpty) {
      return const SizedBox.shrink();
    }
    final last = answered.first;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: PrayerCard(
        color: tones.personalSoft,
        padding: const EdgeInsets.all(16),
        onTap: () => context.router.push(PrayerListRoute(list: last.list)),
        child: Row(
          children: [
            PhosphorIcon(
              AppIcons.answeredTile,
              size: 30,
              color: tones.personal,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.prayer.lists.answeredBanner(n: answered.length),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    t.prayer.lists.lastAnswered(
                      name: last.name,
                      what: last.list.answeredOn(
                        t,
                        context.formatDate(last.answeredOn!, 'd MMMM'),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(AppIcons.chevronRight, color: AppColors.gold),
          ],
        ),
      ),
    );
  }
}
