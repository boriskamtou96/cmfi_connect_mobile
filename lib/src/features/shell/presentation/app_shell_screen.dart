import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_tones.dart';
import '../../../routing/app_router.dart';
import '../../reports/presentation/widgets/timer_banner.dart';
import 'signed_in_tasks.dart';
import 'widgets/floating_nav_bar.dart';

/// The signed-in app: five tabs in a floating capsule (Plus opens from the
/// photo of the home screen), a stopwatch running above them. Each module
/// lights its tab in its own color.
@RoutePage()
class AppShellScreen extends StatelessWidget {
  const AppShellScreen({super.key});

  static const _tabModules = [
    null,
    AppModule.reports,
    AppModule.hymns,
    AppModule.prayer,
    AppModule.bible,
  ];

  static final _zoomIn = Tween<double>(begin: 0.98, end: 1);

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        ReportsRoute(),
        HymnsRoute(),
        PrayerRoute(),
        BibleRoute(),
      ],
      duration: AppMotion.medium,
      curve: AppMotion.emphasized,
      // fade-through: the new tab fades in with a slight zoom
      transitionBuilder: (context, child, animation) =>
          AppMotion.reduced(context)
          ? child
          : FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation.drive(_zoomIn),
                child: child,
              ),
            ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final scheme = Theme.of(context).colorScheme;
        final module = _tabModules[tabsRouter.activeIndex];
        // the reports module is the brand blue: keep the theme colors for it
        final tone = module == null || module == AppModule.reports
            ? null
            : module.tone(context);
        final accent = tone?.onSoft ?? scheme.primary;
        final indicator = tone?.soft ?? scheme.primaryContainer;

        return SignedInTasks(
          child: Scaffold(
            body: child,
            // the tabs float in a capsule; a stopwatch running shows above
            bottomNavigationBar: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TimerBanner(),
                  FloatingNavBar(
                    selectedIndex: tabsRouter.activeIndex,
                    onSelected: tabsRouter.setActiveIndex,
                    accent: accent,
                    indicator: indicator,
                    items: [
                      (
                        icon: AppIcons.home,
                        activeIcon: AppIcons.homeActive,
                        label: t.nav.home,
                      ),
                      (
                        icon: AppIcons.reports,
                        activeIcon: AppIcons.reportsActive,
                        label: t.nav.reports,
                      ),
                      (
                        icon: AppIcons.hymns,
                        activeIcon: AppIcons.hymnsActive,
                        label: t.nav.hymns,
                      ),
                      (
                        icon: AppIcons.prayer,
                        activeIcon: AppIcons.prayerActive,
                        label: t.nav.prayer,
                      ),
                      (
                        icon: AppIcons.bible,
                        activeIcon: AppIcons.bibleActive,
                        label: t.nav.bible,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
