import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/app_version.dart';
import '../../../core/services/premium_store.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/menu_tile.dart';
import '../../../core/widgets/premium_mark.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/tour/space_tour.dart';
import '../../../routing/app_router.dart';
import '../../authorities/application/authorities_controller.dart';
import '../../disciples/application/disciples.dart';
import '../../disciples/application/received_reports.dart';
import '../../home/domain/year_story.dart';
import '../../journey/application/journey_progress.dart';
import '../../journey/application/journey_steps.dart';
import '../../journey/domain/journey_step.dart';
import '../../journey/presentation/step_look.dart';
import '../../members/application/my_account.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../../profile/application/current_profile.dart';
import '../../reports/application/reading_books.dart';
import '../../reports/application/reports_providers.dart';
import '../../reports/domain/reading_book.dart';
import '../../reports/domain/time_with_god.dart';
import '../../settings/presentation/sign_out.dart';
import '../../souls/application/souls.dart';

/// « Vous », the last tab (the photo of the member, 12/11/2026; it was a
/// drawer before), the one place of the member (critique of 19/11/2026): at
/// the top, the member with their pseudo (it opens « Mon profil », their
/// card) and their three numbers; then Premium, the people they walk with
/// (authorities, disciples, with what waits for them), their own way (the
/// steps, the year, the souls, the fasts, the readings), what the community
/// offers, the administration for the admins, the gift, the settings,
/// signing out and the version.
@RoutePage()
class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  static const _night = Color(0xFF0B3B70);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final profile = ref.watch(currentProfileProvider).value;
    final account = ref.watch(myAccountProvider).value;
    final isAdmin = account?.isAdmin ?? false;
    final username = account?.username ?? '';
    final souls = ref.watch(soulsProvider).value ?? const [];
    final due = souls.where((soul) => soul.dueBy(today())).length;
    // the books being read
    final reading =
        (ref.watch(readingBooksProvider).value ?? const <ReadingBook>[])
            .where((book) => book.isReading)
            .length;
    final version = ref.watch(appVersionProvider).value ?? '';
    final premium = ref.watch(premiumProvider).value ?? false;
    final premiumForEveryone = ref.watch(premiumForEveryoneProvider);
    final devSubscription = ref.watch(devSubscriptionProvider);
    final top = MediaQuery.paddingOf(context).top;
    final dark = Theme.of(context).brightness == Brightness.dark;

    // the three numbers of the member
    final streak = ref.watch(reportStreakProvider).value ?? 0;
    final reached =
        ref.watch(journeyStepsProvider).value ??
        const <JourneyStep, DateTime>{};
    final month = ref.watch(reportSummaryProvider(SummaryPeriod.month)).value;
    final minutes = month == null ? 0 : minutesOfItems(month.items);
    // nothing yet: an invitation instead of three zeros
    final firstDay =
        streak == 0 && reached.isEmpty && minutes == 0 && month != null;
    final next = ref.watch(nextJourneyStepProvider);
    // "Mon année avec Dieu": the year so far, or the one just ended
    final storyYear = latestStoryYear(DateTime.now());

    // the people they walk with, and what waits for them
    final authorities = ref.watch(authoritiesControllerProvider).value;
    final requests = ref.watch(authorityRequestsProvider).value?.length ?? 0;
    final disciples = ref.watch(disciplesListProvider()).value?.total ?? 0;
    final received = disciples > 0
        ? ref.watch(receivedReportsUnreadProvider)
        : 0;
    final discipleMaker = authorities
        ?.where((authority) => authority.isDiscipleMaker)
        .firstOrNull;

    // a page above the tabs
    void go(PageRouteInfo<Object?> route) => context.router.push(route);

    // the first visit: « Vous » presents itself, the tab in view
    final tabs = AutoTabsRouter.of(context, watch: true);
    final inView = tabs.current.name == context.routeData.name;

    return SpaceTour(
      space: TourSpace.you,
      active: inView,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        // the member is on night blue, under the status bar
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.only(bottom: AppSpacing.xl),
                children: [
                  // the member (their card, « Mon profil ») and their numbers
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_night, AppColors.primaryDeep],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: top + 8, bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TourTarget(
                            step: TourStep.youCard,
                            radius: AppRadius.xl,
                            padding: EdgeInsets.zero,
                            child: Material(
                              type: MaterialType.transparency,
                              child: Tooltip(
                                message: t.menu.seeProfile,
                                child: InkWell(
                                  onTap: () => go(const ProfileRoute()),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          20,
                                          14,
                                          14,
                                          14,
                                        ),
                                    child: Row(
                                      children: [
                                        PremiumMark(
                                          size: 58,
                                          child: MemberAvatar(
                                            initials: profile?.initials ?? '',
                                            photo: profile?.avatar,
                                            size: 58,
                                            background: Colors.white,
                                            foreground: AppColors.primary,
                                          ),
                                        ),
                                        const SizedBox(width: AppSpacing.md),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Semantics(
                                                header: true,
                                                child: Text(
                                                  profile?.fullName ?? '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w800,
                                                    letterSpacing: -0.2,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                // their pseudo, as the others
                                                // find them
                                                username.isEmpty
                                                    ? t.menu.seeProfile
                                                    : '@$username',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.75),
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          AppIcons.chevronRight,
                                          color: Colors.white70,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TourTarget(
                            step: TourStep.youNumbers,
                            padding: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                              ),
                              child: firstDay
                                  ? _FirstDay(
                                      onTap: () => context.navigateTo(
                                        const ReportsRoute(),
                                      ),
                                    )
                                  : _Numbers(
                                      stats: [
                                        (
                                          value: t.home.daysShort(n: streak),
                                          label: t.me.streak,
                                          // gold rewards: not for a zero
                                          gold: streak > 0,
                                        ),
                                        (
                                          value:
                                              '${reached.length}/${JourneyStep.values.length}',
                                          label: t.me.steps,
                                          gold: false,
                                        ),
                                        (
                                          value: minutes.toDurationLabel(),
                                          label: t.me.timeMonth,
                                          gold: false,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.lg,
                      AppSpacing.lg,
                      0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Premium first (asked on 18/11/2026): « Devenir
                        // Premium », or that it is on
                        if (!premiumForEveryone) ...[
                          SectionCard(
                            children: [
                              MenuTile(
                                icon: AppIcons.premiumTile,
                                title: premium
                                    ? t.premium.name
                                    : t.premium.become,
                                subtitle: premium
                                    ? t.premium.moreActive
                                    : t.premium.moreSubtitle,
                                subtitleStrong: premium,
                                onTap: () => go(const PremiumRoute()),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                        // the people they walk with (moved from « Mon profil »
                        // on 19/11/2026: what waits for them shows here)
                        SectionLabel(t.more.accompaniment),
                        const SizedBox(height: AppSpacing.xs),
                        SectionCard(
                          children: [
                            MenuTile(
                              icon: AppIcons.authoritiesTile,
                              title: t.authorities.title,
                              subtitle: requests > 0
                                  ? t.authorities.requestsCount(n: requests)
                                  : authorities == null
                                  ? null
                                  : discipleMaker != null
                                  ? t.authorities.discipleMakerOf(
                                      name: discipleMaker.fullName,
                                    )
                                  : t.authorities.count(n: authorities.length),
                              subtitleStrong: requests > 0,
                              trailing: requests > 0
                                  ? MenuBadge(requests)
                                  : null,
                              onTap: () => go(const AuthoritiesRoute()),
                            ),
                            if (disciples > 0)
                              MenuTile(
                                icon: AppIcons.disciplesTile,
                                title: t.more.disciples,
                                subtitle: [
                                  t.disciples.count(n: disciples),
                                  if (received > 0)
                                    t.received.unreadCount(n: received),
                                ].join(' · '),
                                subtitleStrong: received > 0,
                                trailing: received > 0
                                    ? MenuBadge(received)
                                    : null,
                                onTap: () => go(const DisciplesRoute()),
                              ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        // their own way: the steps and the year (from « Mon
                        // profil »), the souls, the fasts, the readings. The
                        // tiles keep the neutral tone: a module color is for
                        // its module only (DESIGN.md)
                        SectionLabel(t.me.journey),
                        const SizedBox(height: AppSpacing.xs),
                        SectionCard(
                          children: [
                            MenuTile(
                              icon: AppIcons.journeyTile,
                              title: t.journey.title,
                              subtitle: [
                                t.journey.count(
                                  n: reached.length,
                                  total: JourneyStep.values.length,
                                ),
                                if (next != null)
                                  t.me.nextStep(
                                    name: stepTexts(t, next.step).title,
                                  ),
                              ].join(' · '),
                              onTap: () => go(const JourneyRoute()),
                            ),
                            MenuTile(
                              icon: AppIcons.yearStoryTile,
                              title: t.yearStory.moreTitle,
                              subtitle: storyYear < DateTime.now().year
                                  ? t.yearStory.moreDone(year: storyYear)
                                  : t.yearStory.moreSoFar(year: storyYear),
                              onTap: () => go(YearStoryRoute(year: storyYear)),
                            ),
                            MenuTile(
                              icon: AppIcons.soulsTile,
                              title: t.souls.title,
                              subtitle: souls.isEmpty
                                  ? t.souls.moreSubtitle
                                  : [
                                      t.me.souls(n: souls.length),
                                      if (due > 0) t.me.soulsDue(n: due),
                                    ].join(' · '),
                              onTap: () => go(const SoulsRoute()),
                            ),
                            MenuTile(
                              icon: AppIcons.fastsTile,
                              title: t.fasts.title,
                              subtitle: t.fasts.moreSubtitle,
                              onTap: () => go(const FastsRoute()),
                            ),
                            MenuTile(
                              icon: AppIcons.readingTile,
                              title: t.reading.title,
                              subtitle: reading == 0
                                  ? t.reading.moreSubtitle
                                  : t.reading.moreCount(n: reading),
                              onTap: () => go(const ReadingRoute()),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        SectionLabel(t.menu.discover),
                        const SizedBox(height: AppSpacing.xs),
                        TourTarget(
                          step: TourStep.youDiscover,
                          radius: AppRadius.xl,
                          padding: EdgeInsets.zero,
                          child: SectionCard(
                            children: [
                              MenuTile(
                                icon: AppIcons.eventsTile,
                                module: AppModule.events,
                                title: t.more.events,
                                onTap: () => go(const EventsRoute()),
                              ),
                              MenuTile(
                                icon: AppIcons.ministryTile,
                                title: t.ministry.title,
                                onTap: () => go(const MinistryRoute()),
                              ),
                              MenuTile(
                                icon: AppIcons.teachingsTile,
                                title: t.teachings.title,
                                onTap: () => go(const TeachingsRoute()),
                              ),
                              MenuTile(
                                icon: AppIcons.documentsTile,
                                title: t.documents.title,
                                onTap: () => go(const DocumentsRoute()),
                              ),
                            ],
                          ),
                        ),
                        if (isAdmin) ...[
                          const SizedBox(height: AppSpacing.lg),
                          SectionLabel(t.more.admin),
                          const SizedBox(height: AppSpacing.xs),
                          SectionCard(
                            children: [
                              MenuTile(
                                icon: AppIcons.adminTile,
                                title: t.more.staff,
                                onTap: () => go(const AdminRoute()),
                              ),
                              MenuTile(
                                icon: AppIcons.eventsTile,
                                title: t.more.manageEvents,
                                onTap: () => go(const AdminEventsRoute()),
                              ),
                              MenuTile(
                                icon: AppIcons.documentsTile,
                                title: t.more.manageDocuments,
                                onTap: () => go(const AdminDocumentsRoute()),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: AppSpacing.lg),
                        SectionCard(
                          children: [
                            MenuTile(
                              icon: AppIcons.donateTile,
                              title: t.donation.title,
                              subtitle: t.donation.menuHint,
                              onTap: () => go(const DonationRoute()),
                            ),
                          ],
                        ),
                        // the dev app only: Premium bought in the Test Store
                        // forgotten, to buy it again (18/11/2026)
                        if (devSubscription.dev &&
                            premium &&
                            account != null) ...[
                          const SizedBox(height: AppSpacing.lg),
                          SectionCard(
                            children: [
                              MenuTile(
                                icon: AppIcons.close,
                                title: t.premium.devCancel,
                                destructive: true,
                                onTap: () => _cancelDevSubscription(
                                  context,
                                  ref,
                                  account.id,
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: AppSpacing.lg),
                        SectionCard(
                          children: [
                            TourTarget(
                              step: TourStep.youSettings,
                              radius: AppRadius.xl,
                              padding: EdgeInsets.zero,
                              child: MenuTile(
                                icon: AppIcons.settings,
                                title: t.settings.title,
                                onTap: () => go(const SettingsRoute()),
                              ),
                            ),
                            MenuTile(
                              icon: AppIcons.signOut,
                              title: t.more.logout,
                              destructive: true,
                              // App listens to the session and goes back to
                              // welcome
                              onTap: () => signOut(context, ref),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        // centred under the menu (asked on 13/11/2026)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (dark)
                              const CmfiLogo.onDark(size: 30)
                            else
                              const CmfiLogo(size: 30),
                            const SizedBox(width: AppSpacing.sm),
                            Flexible(
                              child: Text(
                                [
                                  t.app.name,
                                  if (version.isNotEmpty)
                                    t.more.version(version: version),
                                ].join(' · '),
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // the status bar stays on night blue when the page scrolls
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: top,
                child: const ColoredBox(color: _night),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// « Annuler la souscription (dev) »: see [DevSubscription].
Future<void> _cancelDevSubscription(
  BuildContext context,
  WidgetRef ref,
  int accountId,
) async {
  final t = context.t;
  final toast = ref.read(toasterProvider).of(context);
  final confirmed = await showConfirmDialog(
    context,
    title: t.premium.devCancelTitle,
    text: t.premium.devCancelText,
    confirmLabel: t.premium.devCancelTitle,
    destructive: true,
  );
  if (!confirmed) {
    return;
  }
  try {
    await ref.read(devSubscriptionProvider).cancel(accountId);
    ref.invalidate(premiumProvider);
    toast.success(t.premium.devCancelDone);
  } on Object catch (error) {
    toast.error(userMessageFor(error, t));
  }
}

typedef _Stat = ({String value, String label, bool gold});

/// The three numbers of the member on the night blue: the streak (gold once
/// it runs), the steps, the time with God this month. Their labels wrap on
/// two lines with a large text rather than shrink.
class _Numbers extends StatelessWidget {
  const _Numbers({required this.stats});

  final List<_Stat> stats;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(AppRadius.lg),
    ),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, stat) in stats.indexed) ...[
            if (i > 0)
              VerticalDivider(
                width: 1,
                thickness: 1,
                indent: 4,
                endIndent: 4,
                color: Colors.white.withValues(alpha: 0.15),
              ),
            Expanded(
              child: Semantics(
                label: '${stat.label} : ${stat.value}',
                excludeSemantics: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          stat.value,
                          maxLines: 1,
                          style: TextStyle(
                            color: stat.gold
                                ? AppColors.goldLight
                                : Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        stat.label,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 11,
                          height: 1.2,
                          fontWeight: FontWeight.w600,
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
    ),
  );
}

/// A member who has not filled anything yet: an invitation to the first
/// report rather than three zeros (never a reproach).
class _FirstDay extends StatelessWidget {
  const _FirstDay({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white.withValues(alpha: 0.1),
    borderRadius: BorderRadius.circular(AppRadius.lg),
    child: InkWell(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 10, 10),
          child: Row(
            children: [
              const Icon(AppIcons.streak, color: AppColors.goldLight, size: 22),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  context.t.me.firstDay,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(AppIcons.chevronRight, color: Colors.white70),
            ],
          ),
        ),
      ),
    ),
  );
}
