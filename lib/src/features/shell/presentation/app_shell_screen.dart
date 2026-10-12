import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tones.dart';
import '../../../routing/app_router.dart';
import 'signed_in_tasks.dart';

/// The signed-in app: five tabs. Each module lights its tab in its own color.
@RoutePage()
class AppShellScreen extends StatelessWidget {
  const AppShellScreen({super.key});

  static const _tabModules = [
    null,
    AppModule.reports,
    AppModule.hymns,
    AppModule.prayer,
    null,
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
        MoreRoute(),
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
            bottomNavigationBar: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: scheme.outlineVariant)),
              ),
              child: NavigationBarTheme(
                data: NavigationBarTheme.of(context).copyWith(
                  indicatorColor: indicator,
                  iconTheme: WidgetStateProperty.resolveWith(
                    (states) => IconThemeData(
                      size: 22,
                      color: states.contains(WidgetState.selected)
                          ? accent
                          : scheme.onSurfaceVariant,
                    ),
                  ),
                  labelTextStyle: WidgetStateProperty.resolveWith(
                    (states) => TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 11,
                      fontWeight: states.contains(WidgetState.selected)
                          ? FontWeight.w600
                          : FontWeight.w500,
                      letterSpacing: -0.1,
                      color: states.contains(WidgetState.selected)
                          ? accent
                          : scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                child: NavigationBar(
                  selectedIndex: tabsRouter.activeIndex,
                  onDestinationSelected: tabsRouter.setActiveIndex,
                  destinations: [
                    NavigationDestination(
                      icon: const Icon(AppIcons.home),
                      selectedIcon: const Icon(AppIcons.homeActive),
                      label: t.nav.home,
                    ),
                    NavigationDestination(
                      icon: const Icon(AppIcons.reports),
                      selectedIcon: const Icon(AppIcons.reportsActive),
                      label: t.nav.reports,
                    ),
                    NavigationDestination(
                      icon: const Icon(AppIcons.hymns),
                      selectedIcon: const Icon(AppIcons.hymnsActive),
                      label: t.nav.hymns,
                    ),
                    NavigationDestination(
                      icon: const Icon(AppIcons.prayer),
                      selectedIcon: const Icon(AppIcons.prayerActive),
                      label: t.nav.prayer,
                    ),
                    NavigationDestination(
                      icon: const Icon(AppIcons.more),
                      selectedIcon: const Icon(AppIcons.moreActive),
                      label: t.nav.more,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
