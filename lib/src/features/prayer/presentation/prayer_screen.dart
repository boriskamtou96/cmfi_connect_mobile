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
import '../../../core/widgets/photo_kit.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
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
import 'widgets/free_prayer_card.dart';
import 'widgets/invitation_menu.dart';
import 'widgets/prayer_look.dart';
import 'widgets/topic_row.dart';

/// The Prière tab, like a routine (after Hallow), photographic: the retreat
/// of the moment over a photo of someone praying, graded night blue (the
/// days prayed and the time of the week in frosted chips, "Commencer"), the
/// four retreats of the day as photo cards tinted with their moment, then
/// the importunity topics to proclaim, the topics of the community and the
/// user's lists.
@RoutePage()
class PrayerScreen extends HookConsumerWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final top = MediaQuery.paddingOf(context).top;
    final scroll = useScrollController();
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

    return Scaffold(
      body: Stack(
        children: [
          RefreshIndicator.adaptive(
            onRefresh: refresh,
            edgeOffset: top,
            child: ListView(
              controller: scroll,
              padding: const EdgeInsets.only(bottom: 32),
              children: [
                const _Hero(),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final invitation in invitations) ...[
                        _InvitationCard(topic: invitation),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                      const _RetreatGrid(),
                      const SizedBox(height: AppSpacing.md),
                      // to pray without a retreat: the time of « Prière seule »
                      const FreePrayerCard(),
                      const SizedBox(height: 28),
                      PrayerSectionHeader(
                        title: t.prayer.together,
                        action: t.prayer.importunity.newTopic,
                        onAction: () => showImportunityForm(context),
                      ),
                      const SizedBox(height: 10),
                      if (joined.isEmpty)
                        _ImportunityIntro(
                          onCreate: () => showImportunityForm(context),
                        )
                      else
                        for (final topic in joined) ...[
                          _ImportunityCard(topic: topic),
                          const SizedBox(height: 10),
                        ],
                      const SizedBox(height: 18),
                      PrayerSectionHeader(
                        title: t.prayer.topics.title,
                        action: t.prayer.topics.all,
                        onAction: () =>
                            context.router.push(const PrayerTopicsRoute()),
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
              ],
            ),
          ),
          // under the status bar, the page once the photo has gone up
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: top,
            child: ListenableBuilder(
              listenable: scroll,
              builder: (context, _) {
                final offset = scroll.hasClients ? scroll.offset : 0.0;
                return Opacity(
                  opacity: ((offset - _Hero.height + 60) / 40).clamp(0, 1),
                  child: ColoredBox(color: scheme.surfaceContainerLowest),
                );
              },
            ),
          ),
        ],
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

/// The photos of the four retreats: someone reading at dawn, worship at
/// noon, a sister praying in the evening, praying hands at night.
const _momentPhotos = {
  RetreatMoment.morning: (StockPhotos.reading, Alignment(0.05, -0.3)),
  RetreatMoment.noon: (StockPhotos.worship, Alignment(0.2, -0.2)),
  RetreatMoment.evening: (StockPhotos.womanWorshipping, Alignment(0, -0.4)),
  RetreatMoment.night: (StockPhotos.prayingHands, Alignment(0, -0.3)),
};

/// What the line under a retreat says: made, to pray now or next, its
/// reminder, or when it is prayed.
String _retreatStatus(
  BuildContext context, {
  required RetreatMoment moment,
  required Set<RetreatMoment> done,
  required RetreatMoment? next,
  required Map<RetreatMoment, TimeOfDay?> reminders,
}) {
  final t = context.t;
  final current = momentAt(DateTime.now());
  if (done.contains(moment)) {
    return t.prayer.routine.done;
  }
  if (moment == next) {
    return moment == current ? t.prayer.routine.now : t.prayer.routine.next;
  }
  if (reminders[moment] case final time? when moment.index > current.index) {
    return t.prayer.routine.reminder(time: time.format(context));
  }
  return t.prayer.routine.later[moment.name]!;
}

/// The top of the tab, on a photo of a sister praying by a window (graded
/// night blue): the title and the reminders, the days prayed out of the last
/// seven and the time prayed this week in frosted chips, then the retreat
/// to pray now, what it prays for and "Commencer" (once the four are made,
/// a word of blessing).
class _Hero extends ConsumerWidget {
  const _Hero();

  /// Below the status bar; taller with big letters.
  static const height = 470.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final top = MediaQuery.paddingOf(context).top;
    final log = ref.watch(retreatLogProvider).value ?? const <RetreatRecord>[];
    final days = {for (final record in log) record.day.dateOnly}.length;
    final monday = today().startOfWeek;
    final minutes = log
        .where((record) => !record.day.dateOnly.isBefore(monday))
        .fold(0, (sum, record) => sum + record.minutes);
    final now = DateTime.now();
    final next = nextRetreat(ref.watch(retreatsTodayProvider), now);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // white status bar on the photo, in both modes
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          const Positioned.fill(
            child: GradedPhoto(
              StockPhotos.prayingByWindow,
              grade: PhotoGrade.night,
              alignment: Alignment(0.6, -0.5),
            ),
          ),
          const Positioned.fill(
            child: PhotoScrim(
              colors: [
                Color(0x99061F40),
                Color(0x00061F40),
                Color(0x40061F40),
                Color(0xFA061F40),
              ],
              stops: [0, 0.2, 0.4, 0.74],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: top + height),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, top + 12, 20, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Semantics(
                          header: true,
                          child: Text(
                            t.nav.prayer,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.6,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: t.prayer.reminders.title,
                        color: Colors.white,
                        onPressed: () => showRetreatRemindersSheet(context),
                        icon: const Icon(AppIcons.reminder),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      _GlassChip(
                        icon: AppIcons.streak,
                        color: AppColors.goldLight,
                        text: t.prayer.routine.days(n: days),
                      ),
                      _GlassChip(
                        icon: AppIcons.time,
                        color: const Color(0xFFD9BCEB),
                        text: t.prayer.routine.week(
                          time: minutes.toDurationLabel(),
                        ),
                      ),
                    ],
                  ),
                  // the face of the photo
                  const SizedBox(height: 170),
                  if (next == null)
                    Text(
                      t.prayer.hero.allDone,
                      style: const TextStyle(
                        fontFamily: 'Lora',
                        fontSize: 24,
                        height: 1.25,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )
                  else ...[
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: next.colors),
                          ),
                          child: Icon(next.icon, size: 16, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '${next.retreat(t)} · '
                            '${next == momentAt(now) ? t.prayer.routine.now : t.prayer.routine.next}',
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.goldLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      t.prayer.hero.title,
                      style: const TextStyle(
                        fontFamily: 'Lora',
                        fontSize: 30,
                        height: 1.15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      t.prayer.hero.preview[next.name]!,
                      style: TextStyle(
                        fontSize: 14.5,
                        height: 1.4,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Wrap(
                      spacing: 14,
                      runSpacing: AppSpacing.sm,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        FilledButton.icon(
                          onPressed: () => context.router.push(
                            RetreatSessionRoute(moment: next),
                          ),
                          icon: const Icon(AppIcons.play, size: 16),
                          label: Text(t.prayer.hero.start),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.goldLight,
                            foregroundColor: AppColors.primaryDeep,
                            minimumSize: const Size(0, 48),
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            shape: const StadiumBorder(),
                            textStyle: const TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Text(
                          t.prayer.hero.meta,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassChip extends StatelessWidget {
  const _GlassChip({
    required this.icon,
    required this.color,
    required this.text,
  });

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) => FrostedGlass(
    radius: 99,
    padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 14, 6),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

/// "Ta routine du jour": the four retreats two by two, each on its photo
/// tinted with the colours of its moment. The one to pray has a gold
/// border, a made one its check; a touch opens the retreat.
class _RetreatGrid extends ConsumerWidget {
  const _RetreatGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final done = ref.watch(retreatsTodayProvider);
    final reminders = ref.watch(retreatRemindersProvider);
    final next = nextRetreat(done, DateTime.now());

    Widget card(RetreatMoment moment) => _RetreatCard(
      moment: moment,
      done: done.contains(moment),
      next: moment == next,
      status: _retreatStatus(
        context,
        moment: moment,
        done: done,
        next: next,
        reminders: reminders,
      ),
    );

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
        const SizedBox(height: AppSpacing.md),
        for (final (i, pair) in const [
          (RetreatMoment.morning, RetreatMoment.noon),
          (RetreatMoment.evening, RetreatMoment.night),
        ].indexed) ...[
          if (i > 0) const SizedBox(height: 10),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: card(pair.$1)),
                const SizedBox(width: 10),
                Expanded(child: card(pair.$2)),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _RetreatCard extends StatelessWidget {
  const _RetreatCard({
    required this.moment,
    required this.done,
    required this.next,
    required this.status,
  });

  final RetreatMoment moment;
  final bool done;

  /// The one to pray now (or next): a gold border.
  final bool next;
  final String status;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final (photo, alignment) = _momentPhotos[moment]!;
    return Semantics(
      button: true,
      label: '${moment.retreat(t)}, $status',
      excludeSemantics: true,
      child: Material(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: next
              ? const BorderSide(color: AppColors.goldLight, width: 3)
              : BorderSide.none,
        ),
        child: InkWell(
          onTap: () => context.router.push(RetreatRoute(moment: moment)),
          child: Stack(
            children: [
              Positioned.fill(
                child: GradedPhoto(
                  photo,
                  alignment: alignment,
                  grade: PhotoGrade.night,
                ),
              ),
              Positioned.fill(
                child: PhotoScrim(
                  colors: [
                    moment.colors.first.withValues(alpha: 0.25),
                    moment.colors.last.withValues(alpha: 0.92),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 170),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 10, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.22),
                            ),
                            child: Icon(
                              moment.icon,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          if (done)
                            const Icon(
                              AppIcons.checkCircleFilled,
                              color: Colors.white,
                              size: 26,
                            ),
                        ],
                      ),
                      const SizedBox(height: 62),
                      Text(
                        moment.retreat(t),
                        style: const TextStyle(
                          fontSize: 15.5,
                          height: 1.15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: next ? FontWeight.w800 : FontWeight.w600,
                          color: next
                              ? AppColors.goldLight
                              : Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
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
    final faces = [
      if (!topic.isOwner) topic.owner,
      for (final member in topic.members)
        if (member.username != topic.owner.username) member,
    ].take(3).toList();
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
                  // who prays too: real members (their photo, else their
                  // initials), when the server names them
                  if (faces.isNotEmpty && !topic.reached && topic.isOpen)
                    FaceStack(
                      faces: [
                        for (final member in faces)
                          MemberAvatar(
                            initials: member.initials,
                            photo: member.avatar,
                            size: 28,
                          ),
                      ],
                      ring: tones.personalSoft,
                      size: 32,
                      overlap: 0.18,
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
