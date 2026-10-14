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
import 'widgets/nation_globe.dart';

/// Notre ministère: the globe in small, and its sub-menus (the nations, our
/// purpose; our missionaries and our heroes to come).
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
                child: SectionCard(
                  children: [
                    tile(
                      icon: AppIcons.ministryTile,
                      title: t.nations,
                      subtitle: t.nationsSubtitle,
                      onTap: () => context.router.push(const NationsRoute()),
                    ),
                    tile(
                      icon: AppIcons.purposeTile,
                      title: t.purpose,
                      subtitle: t.purposeSubtitle,
                      onTap: () => context.router.push(const PurposeRoute()),
                    ),
                    tile(
                      icon: AppIcons.missionariesTile,
                      title: t.missionaries,
                      subtitle: t.missionariesSubtitle,
                    ),
                    tile(
                      icon: AppIcons.heroesTile,
                      title: t.heroes,
                      subtitle: t.heroesSubtitle,
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
