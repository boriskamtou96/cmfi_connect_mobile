import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/section_card.dart';
import '../../../routing/app_router.dart';
import '../application/land.dart';
import '../application/nations.dart';
import '../domain/ministry_lives.dart';
import '../domain/ministry_person.dart';
import 'widgets/nation_globe.dart';

/// Notre ministère: the globe in small, our founder and our leader side by
/// side, and the sub-menus (the nations, our purpose, our missionaries, our
/// heroes).
@RoutePage()
class MinistryScreen extends ConsumerWidget {
  const MinistryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.ministry;
    final nations = ref.watch(nationsProvider).value ?? const [];
    final land = ref.watch(landDotsProvider).value ?? const [];
    final tone = AppModule.events.tone(context);

    Widget tile({
      required IconData icon,
      required String title,
      required String subtitle,
      VoidCallback? onTap,
    }) => ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xs,
      ),
      leading: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: tone.soft,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: PhosphorIcon(icon, color: tone.onSoft, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle),
      trailing: onTap == null
          ? StatusPill(context.t.common.soon)
          : const Icon(AppIcons.chevronRight),
      onTap: onTap,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: AppColors.primaryDeep,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(AppRadius.xxl),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xs,
                    AppSpacing.xs,
                    AppSpacing.lg,
                    AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const IconTheme(
                        data: IconThemeData(color: Colors.white),
                        child: AppBackButton(),
                      ),
                      Row(
                        children: [
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Semantics(
                                  header: true,
                                  child: Text(
                                    t.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  t.tagline,
                                  style: const TextStyle(
                                    fontFamily: 'Lora',
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16,
                                    color: AppColors.goldLight,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  t.count(n: nations.length),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  t.fromYaounde,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.onPrimaryMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // the globe in small: the nations page opens it whole
                          SizedBox.square(
                            dimension: 150,
                            child: GestureDetector(
                              onTap: () =>
                                  context.router.push(const NationsRoute()),
                              child: AbsorbPointer(
                                child: NationGlobe(
                                  nations: nations,
                                  land: land,
                                  selected: null,
                                  onSelect: (_) {},
                                  semanticLabel: t.globeLabel(
                                    n: nations.length,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: FadeSlideIn(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _LeaderCard(
                              label: t.founder,
                              name: t.lives.founder.name,
                              asset: MinistryLife.founder.asset,
                              onTap: () =>
                                  context.router.push(const FounderRoute()),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: _LeaderCard(
                              label: t.leader,
                              name: t.lives.leader.name,
                              asset: MinistryLife.leader.asset,
                              onTap: () =>
                                  context.router.push(const LeaderRoute()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    SectionCard(
                      children: [
                        tile(
                          icon: AppIcons.ministryTile,
                          title: t.nations,
                          subtitle: t.nationsSubtitle,
                          onTap: () =>
                              context.router.push(const NationsRoute()),
                        ),
                        tile(
                          icon: AppIcons.purposeTile,
                          title: t.purpose,
                          subtitle: t.purposeSubtitle,
                          onTap: () =>
                              context.router.push(const PurposeRoute()),
                        ),
                        tile(
                          icon: AppIcons.missionariesTile,
                          title: t.missionaries,
                          subtitle: t.missionariesSubtitle,
                          onTap: () => context.router.push(
                            MinistryPeopleRoute(
                              kind: MinistryPersonKind.missionary.name,
                            ),
                          ),
                        ),
                        tile(
                          icon: AppIcons.heroesTile,
                          title: t.heroes,
                          subtitle: t.heroesSubtitle,
                          onTap: () => context.router.push(
                            MinistryPeopleRoute(
                              kind: MinistryPersonKind.hero.name,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Notre fondateur, Notre leader: a round portrait in a gold ring, what
/// they are to us and their name.
class _LeaderCard extends StatelessWidget {
  const _LeaderCard({
    required this.label,
    required this.name,
    required this.asset,
    required this.onTap,
  });

  final String label;
  final String name;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
          ),
          child: Column(
            children: [
              Container(
                width: 76,
                height: 76,
                padding: const EdgeInsets.all(2.5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.goldLight, AppColors.gold],
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    asset,
                    fit: BoxFit.cover,
                    excludeFromSemantics: true,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.25,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
