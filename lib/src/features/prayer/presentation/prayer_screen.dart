import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/tab_page.dart';
import '../../../routing/app_router.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../application/importunities.dart';
import '../application/prayer_people.dart';
import '../application/prayer_topics.dart';
import '../application/retreat_reminders.dart';
import '../application/retreats.dart';
import '../domain/prayer.dart';
import '../domain/retreat.dart';
import 'importunity_screen.dart';
import 'retreat_reminders_sheet.dart';
import 'widgets/invitation_menu.dart';
import 'widgets/prayer_look.dart';
import 'widgets/topic_row.dart';

/// The Prière tab, like a routine (after Hallow): the days prayed, the four
/// retreats of the day one under the other, the importunity topics to
/// proclaim, the topics of the community on a shelf and the user's lists.
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
            const _Summary(),
            const SizedBox(height: 20),
            const _Routine(),
            const SizedBox(height: 28),
            PrayerSectionHeader(
              title: t.prayer.together,
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
            const _ListsCard(),
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

/// The colour of the words of [moment] on the page (lighter on dark: the
/// night blue would be lost on it).
Color _momentInk(RetreatMoment moment, BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? Color.lerp(moment.colors.first, Colors.white, 0.45)!
    : moment.ink;

/// The days prayed out of the last seven, and the time prayed this week.
class _Summary extends ConsumerWidget {
  const _Summary();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final log = ref.watch(retreatLogProvider).value ?? const <RetreatRecord>[];
    final days = {for (final record in log) record.day.dateOnly}.length;
    final monday = today().startOfWeek;
    final minutes = log
        .where((record) => !record.day.dateOnly.isBefore(monday))
        .fold(0, (sum, record) => sum + record.minutes);

    // side by side, one under the other when the words are long
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _SummaryChip(
          icon: AppIcons.streak,
          color: AppColors.gold,
          text: t.prayer.routine.days(n: days),
        ),
        _SummaryChip(
          icon: AppIcons.time,
          color: AppModule.prayer.tone(context).onSoft,
          text: t.prayer.routine.week(time: minutes.toDurationLabel()),
        ),
      ],
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(minHeight: 34),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    decoration: ShapeDecoration(
      color: Theme.of(context).colorScheme.surface,
      shape: const StadiumBorder(),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}

/// The four retreats of the day, one under the other like a routine: made,
/// to pray now (what it prays for, "Commencer"), or later (its reminder).
class _Routine extends ConsumerWidget {
  const _Routine();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final done = ref.watch(retreatsTodayProvider);
    final reminders = ref.watch(retreatRemindersProvider);
    final now = DateTime.now();
    final next = nextRetreat(done, now);
    final current = momentAt(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrayerSectionHeader(
          title: t.prayer.routine.title,
          trailing: Text(
            t.prayer.routine.count(done: done.length),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppModule.prayer.tone(context).onSoft,
            ),
          ),
        ),
        if (next == null) ...[
          const SizedBox(height: 4),
          Text(
            t.prayer.hero.allDone,
            style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
          ),
        ],
        const SizedBox(height: 10),
        Material(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (final (i, moment) in RetreatMoment.values.indexed)
                _RoutineRow(
                  moment: moment,
                  first: i == 0,
                  last: i == RetreatMoment.values.length - 1,
                  done: done.contains(moment),
                  next: moment == next,
                  status: done.contains(moment)
                      ? t.prayer.routine.done
                      : moment == next
                      ? (moment == current
                            ? t.prayer.routine.now
                            : t.prayer.routine.next)
                      : reminders[moment] != null &&
                            moment.index > current.index
                      ? t.prayer.routine.reminder(
                          time: reminders[moment]!.format(context),
                        )
                      : t.prayer.routine.later[moment.name]!,
                  reminder: reminders[moment] != null,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoutineRow extends StatelessWidget {
  const _RoutineRow({
    required this.moment,
    required this.first,
    required this.last,
    required this.done,
    required this.next,
    required this.status,
    required this.reminder,
  });

  final RetreatMoment moment;
  final bool first;
  final bool last;
  final bool done;

  /// The one to pray now: it opens up, with "Commencer".
  final bool next;
  final String status;

  /// A reminder is set for it.
  final bool reminder;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final line = scheme.outlineVariant;

    return InkWell(
      onTap: () => context.router.push(RetreatRoute(moment: moment)),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(14, 0, 6, 0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // the cover of the retreat, on the line of the day
              SizedBox(
                width: 56,
                child: Column(
                  children: [
                    Container(
                      width: 2,
                      height: 12,
                      color: first ? Colors.transparent : line,
                    ),
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: moment.colors,
                        ),
                      ),
                      child: Icon(moment.icon, color: Colors.white, size: 26),
                    ),
                    Expanded(
                      child: Container(
                        width: 2,
                        color: last ? Colors.transparent : line,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 16, bottom: last ? 16 : 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moment.retreat(t),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: next ? FontWeight.w700 : FontWeight.w500,
                          color: done
                              ? scheme.primary
                              : next
                              ? _momentInk(moment, context)
                              : scheme.onSurfaceVariant,
                        ),
                      ),
                      if (next) ...[
                        const SizedBox(height: 8),
                        Text(
                          t.prayer.hero.preview[moment.name]!,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.35,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 12),
                        FilledButton.icon(
                          onPressed: () => context.router.push(
                            RetreatSessionRoute(moment: moment),
                          ),
                          icon: const Icon(AppIcons.play, size: 16),
                          label: Text(t.prayer.hero.start),
                          style: FilledButton.styleFrom(
                            backgroundColor: moment.ink,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 42),
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            shape: const StadiumBorder(),
                            textStyle: const TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: done
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Icon(
                          AppIcons.checkCircleFilled,
                          color: scheme.primary,
                          size: 24,
                          semanticLabel: t.prayer.retreat.done,
                        ),
                      )
                    : next
                    ? const SizedBox(width: 48)
                    : SizedBox(
                        height: 40,
                        child: IconButton(
                          tooltip: t.prayer.reminders.title,
                          onPressed: () => showRetreatRemindersSheet(context),
                          icon: Icon(
                            AppIcons.reminder,
                            size: 20,
                            color: reminder
                                ? _momentInk(moment, context)
                                : scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A topic of importunity: its progress, and "Proclamer" to count without
/// opening it (sent together a moment after the last tap).
class _ImportunityCard extends HookConsumerWidget {
  const _ImportunityCard({required this.topic});

  final Importunity topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final tone = AppModule.prayer.tone(context);
    final progress = topic.progress;
    final notifier = ref.read(importunitiesProvider.notifier);
    final sendTimer = useRef<Timer?>(null);
    // leaving the tab: what was counted goes now
    useEffect(
      () => () {
        if (sendTimer.value?.isActive ?? false) {
          sendTimer.value!.cancel();
          unawaited(notifier.sendCounts());
        }
      },
      const [],
    );

    void proclaim() {
      unawaited(HapticFeedback.lightImpact());
      unawaited(notifier.count(topic, 1));
      sendTimer.value?.cancel();
      sendTimer.value = Timer(
        ImportunityScreen.sendDelay,
        () => unawaited(notifier.sendCounts()),
      );
    }

    return Material(
      color: tones.personalSoft,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () =>
            context.router.push(ImportunityRoute(importunityId: topic.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      AppIcons.streak,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.prayer.importunity.eyebrow.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: tones.personal,
                          ),
                        ),
                        Text(
                          topic.title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (topic.reached)
                    StatusPill(
                      t.prayer.importunity.reached,
                      background: scheme.surface,
                      foreground: tones.personal,
                    )
                  else if (!topic.isOpen)
                    StatusPill(t.prayer.importunity.closed),
                ],
              ),
              const SizedBox(height: 14),
              if (progress != null) ...[
                GoalBar(progress: progress, reached: topic.reached),
                const SizedBox(height: 8),
              ],
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${topic.goal == null ? t.prayer.importunity.total(n: topic.total, count: context.formatNumber(topic.total)) : t.prayer.importunity.progress(total: context.formatNumber(topic.total), goal: context.formatNumber(topic.goal!))}'
                      ' · ${t.prayer.importunity.participants(n: topic.participants)}',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  if (topic.isOpen) ...[
                    const SizedBox(width: AppSpacing.sm),
                    FilledButton(
                      onPressed: proclaim,
                      style: FilledButton.styleFrom(
                        backgroundColor: tone.color,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 40),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: Text(t.prayer.importunity.proclaim),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The topics of the community of the moment: their name and their PDF.
class _CommunityTopics extends ConsumerWidget {
  const _CommunityTopics();

  /// The rest is in "Tout voir".
  static const _max = 3;

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
      AsyncData(:final value) => PrayerTopicsCard(
        topics: value.take(_max).toList(),
      ),
      AsyncError(:final error) => Text(
        userMessageFor(error, t),
        style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
      ),
      // the rows of the topics
      _ => const Shimmer(child: SkeletonCards(count: 1, height: 152)),
    };
  }
}

/// The four lists in one card: the first faces of each, how many.
class _ListsCard extends ConsumerWidget {
  const _ListsCard();

  static const _faces = [
    Color(0xFF0E7A72),
    Color(0xFFA85F1E),
    Color(0xFF3A4DA0),
    Color(0xFF9A2E3D),
    Color(0xFF7A4A98),
    Color(0xFF0A5EA8),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.prayer.tone(context);
    final people = ref.watch(prayerPeopleProvider).value ?? const [];

    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (final (i, list) in PrayerList.values.indexed) ...[
            if (i > 0)
              Divider(
                height: 1,
                indent: 14,
                endIndent: 14,
                color: scheme.outlineVariant,
              ),
            Builder(
              builder: (context) {
                final names = [
                  for (final person in people)
                    if (person.list == list && !person.answered) person.name,
                ];
                return InkWell(
                  onTap: () => context.router.push(PrayerListRoute(list: list)),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 62),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        14,
                        10,
                        10,
                        10,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 74,
                            height: 32,
                            child: names.isEmpty
                                ? Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: tone.soft,
                                      ),
                                      child: Icon(
                                        AppIcons.add,
                                        size: 16,
                                        color: tone.onSoft,
                                      ),
                                    ),
                                  )
                                : Stack(
                                    children: [
                                      for (final (j, name)
                                          in names.take(3).indexed)
                                        PositionedDirectional(
                                          start: j * 20.0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: scheme.surface,
                                                width: 2,
                                              ),
                                            ),
                                            child: MemberAvatar(
                                              initials: _initials(name),
                                              size: 28,
                                              background:
                                                  _faces[(i + j) %
                                                      _faces.length],
                                              foreground: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                          ),
                          Expanded(
                            child: Text(
                              list.label(t),
                              style: const TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            names.isEmpty
                                ? t.prayer.lists.addShort
                                : '${names.length}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: names.isEmpty
                                  ? tone.onSoft
                                  : scheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            AppIcons.chevronRight,
                            size: 16,
                            color: scheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  /// "Thierry B." → "TB", "Mme Essomba" → "ME".
  static String _initials(String name) => name
      .split(RegExp(r'[\s.]+'))
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part.characters.first.toUpperCase())
      .join();
}
