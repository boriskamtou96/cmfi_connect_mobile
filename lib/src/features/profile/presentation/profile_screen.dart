import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/menu_tile.dart';
import '../../../core/widgets/premium_crown.dart';
import '../../../core/widgets/section_card.dart';
import '../../../routing/app_router.dart';
import '../../authorities/application/authorities_controller.dart';
import '../../disciples/application/disciples.dart';
import '../../disciples/application/received_reports.dart';
import '../../home/domain/year_story.dart';
import '../../journey/application/journey_steps.dart';
import '../../journey/domain/journey_step.dart';
import '../../journey/presentation/step_look.dart';
import '../../members/application/my_account.dart';
import '../../reports/application/reports_providers.dart';
import '../../reports/domain/time_with_god.dart';
import '../../souls/application/souls.dart';
import '../application/current_profile.dart';
import 'widgets/profile_photo.dart';

/// « Mon profil » (validated on 23/10/2026), from the photo at the top of
/// the home screen: who the member is (photo, name, church), three numbers
/// (the streak, the steps, the time with God this month), their journey and
/// the people they walk with. The gear opens the settings.
@RoutePage()
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final me = t.me;
    final profile = ref.watch(currentProfileProvider).value;
    final account = ref.watch(myAccountProvider).value;
    final streak = ref.watch(reportStreakProvider).value ?? 0;
    final reached =
        ref.watch(journeyStepsProvider).value ??
        const <JourneyStep, DateTime>{};
    final month = ref.watch(reportSummaryProvider(SummaryPeriod.month)).value;
    final minutes = month == null ? 0 : minutesOfItems(month.items);
    final souls = ref.watch(soulsProvider).value ?? const [];
    final due = souls.where((soul) => soul.dueBy(today())).length;
    final authorities = ref.watch(authoritiesControllerProvider).value;
    final requests = ref.watch(authorityRequestsProvider).value?.length ?? 0;
    // the members who chose the user as disciple maker or authority
    final disciples = ref.watch(disciplesListProvider()).value?.total ?? 0;
    // the reports they sent in the app, not opened yet
    final received = disciples > 0
        ? ref.watch(receivedReportsUnreadProvider)
        : 0;
    final discipleMaker = authorities
        ?.where((authority) => authority.isDiscipleMaker)
        .firstOrNull;
    final next = JourneyStep.values
        .where((step) => !reached.containsKey(step))
        .firstOrNull;
    // "Mon année avec Dieu": the year so far, or the one just ended
    final storyYear = latestStoryYear(DateTime.now());
    // an incomplete profile (no name on the server) invites to fill it in
    final missingName = profile != null && !profile.hasName;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.only(bottom: AppSpacing.xl),
          children: [
            _Header(
              name: missingName
                  ? t.more.completeProfile
                  : profile?.fullName ?? '',
              details: [
                if ((account?.username ?? '').isNotEmpty)
                  '@${account!.username}',
                ?profile?.church,
                ?profile?.assembly,
              ].where((part) => part.isNotEmpty).join(' · '),
              stats: [
                (
                  value: t.home.daysShort(n: streak),
                  label: me.streak,
                  gold: true,
                ),
                (
                  value: '${reached.length}/${JourneyStep.values.length}',
                  label: me.steps,
                  gold: false,
                ),
                (
                  value: minutes.toDurationLabel(),
                  label: me.timeMonth,
                  gold: false,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 22),
                  FadeSlideIn(child: SectionLabel(me.journey)),
                  const SizedBox(height: 10),
                  FadeSlideIn(
                    child: SectionCard(
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
                              me.nextStep(name: stepTexts(t, next).title),
                          ].join(' · '),
                          onTap: () =>
                              context.router.push(const JourneyRoute()),
                        ),
                        MenuTile(
                          icon: AppIcons.soulsTile,
                          module: AppModule.hymns,
                          title: t.souls.title,
                          subtitle: souls.isEmpty
                              ? t.souls.moreSubtitle
                              : [
                                  me.souls(n: souls.length),
                                  if (due > 0) me.soulsDue(n: due),
                                ].join(' · '),
                          onTap: () => context.router.push(const SoulsRoute()),
                        ),
                        MenuTile(
                          icon: AppIcons.yearStoryTile,
                          title: t.yearStory.moreTitle,
                          subtitle: storyYear < DateTime.now().year
                              ? t.yearStory.moreDone(year: storyYear)
                              : t.yearStory.moreSoFar(year: storyYear),
                          onTap: () => context.router.push(
                            YearStoryRoute(year: storyYear),
                          ),
                        ),
                        MenuTile(
                          icon: AppIcons.fastsTile,
                          module: AppModule.prayer,
                          title: t.fasts.title,
                          subtitle: t.fasts.moreSubtitle,
                          onTap: () => context.router.push(const FastsRoute()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  FadeSlideIn(
                    index: 1,
                    child: SectionLabel(t.more.accompaniment),
                  ),
                  const SizedBox(height: 10),
                  FadeSlideIn(
                    index: 1,
                    child: SectionCard(
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
                          trailing: requests > 0 ? MenuBadge(requests) : null,
                          onTap: () =>
                              context.router.push(const AuthoritiesRoute()),
                        ),
                        if (disciples > 0)
                          MenuTile(
                            icon: AppIcons.disciplesTile,
                            module: AppModule.prayer,
                            title: t.more.disciples,
                            subtitle: [
                              t.disciples.count(n: disciples),
                              if (received > 0)
                                t.received.unreadCount(n: received),
                            ].join(' · '),
                            trailing: received > 0 ? MenuBadge(received) : null,
                            onTap: () =>
                                context.router.push(const DisciplesRoute()),
                          ),
                      ],
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

typedef _Stat = ({String value, String label, bool gold});

/// The top, on the night blue: back, the title and the gear; the photo
/// (crowned with Premium), the name, the pseudo and the church, « Modifier
/// mon profil »; the three numbers.
class _Header extends StatelessWidget {
  const _Header({
    required this.name,
    required this.details,
    required this.stats,
  });

  final String name;
  final String details;
  final List<_Stat> stats;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final top = MediaQuery.paddingOf(context).top;
    return Container(
      padding: EdgeInsets.fromLTRB(0, top, 0, 22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0B3B70), AppColors.primaryDeep],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PositionedDirectional(
            end: -90,
            top: -40,
            child: BrandRing(
              size: 260,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          Column(
            children: [
              IconTheme(
                data: const IconThemeData(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      const AppBackButton(),
                      Expanded(
                        child: Text(
                          t.me.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: t.settings.title,
                        onPressed: () =>
                            context.router.push(const SettingsRoute()),
                        icon: const Icon(AppIcons.settings),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              const PremiumCrown(size: 96, child: ProfilePhotoButton()),
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Column(
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.4,
                      ),
                    ),
                    if (details.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        details,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.md),
                    Material(
                      color: Colors.white.withValues(alpha: 0.14),
                      shape: const StadiumBorder(),
                      child: InkWell(
                        customBorder: const StadiumBorder(),
                        onTap: () => context.router.push(
                          ChurchFormRoute(isEditing: true),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                AppIcons.edit,
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                t.me.edit,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final (i, stat) in stats.indexed) ...[
                        if (i > 0) const SizedBox(width: 10),
                        Expanded(child: _StatTile(stat: stat)),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.stat});

  final _Stat stat;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '${stat.label} : ${stat.value}',
    excludeSemantics: true,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              stat.value,
              maxLines: 1,
              style: TextStyle(
                color: stat.gold ? AppColors.goldLight : Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
