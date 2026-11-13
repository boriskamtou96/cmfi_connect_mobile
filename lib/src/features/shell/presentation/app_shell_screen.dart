import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_tones.dart';
import '../../../routing/app_router.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../../profile/application/current_profile.dart';
import '../../reports/presentation/widgets/timer_banner.dart';
import 'signed_in_tasks.dart';

/// The signed-in app: five tabs (12/11/2026: the games in the middle, the
/// menu last under the photo of the member; the hymns and the prayer open
/// from the menu), a stopwatch running above them. Each module lights its
/// tab in its own color.
@RoutePage()
class AppShellScreen extends StatelessWidget {
  const AppShellScreen({super.key});

  static const _tabModules = [
    null,
    AppModule.reports,
    null,
    AppModule.bible,
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
        GamesRoute(),
        BibleRoute(),
        MenuRoute(),
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
            // a stopwatch running shows above the tabs
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TimerBanner(),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: scheme.outlineVariant),
                    ),
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
                          icon: const Icon(AppIcons.games),
                          selectedIcon: const Icon(AppIcons.gamesActive),
                          label: t.nav.games,
                        ),
                        NavigationDestination(
                          icon: const Icon(AppIcons.bible),
                          selectedIcon: const Icon(AppIcons.bibleActive),
                          label: t.nav.bible,
                        ),
                        NavigationDestination(
                          icon: const _Photo(),
                          selectedIcon: _Photo(ring: accent),
                          label: t.nav.menu,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// The tab of the menu: the photo of the member (their initials without
/// one), in a ring of the accent color when the menu is shown.
class _Photo extends ConsumerWidget {
  const _Photo({this.ring});

  final Color? ring;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(currentProfileProvider).value;

    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ring ?? Colors.transparent, width: 1.5),
      ),
      child: MemberAvatar(
        initials: profile?.initials ?? '',
        photo: profile?.avatar,
        size: 24,
      ),
    );
  }
}
