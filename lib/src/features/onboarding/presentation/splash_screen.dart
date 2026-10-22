import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/app_log.dart';
import '../../../core/services/app_update.dart';
import '../../../core/session/session.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../routing/app_router.dart';

/// First route. Looks like the native splash, decides where to go (the
/// welcome or the app), then hands over.
@RoutePage()
class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future<void> start() async {
        SessionStatus status;
        try {
          status = await ref.read(sessionProvider.future);
        } on Object catch (error, stack) {
          // unreadable secure storage: ask to sign in again
          AppLog.error(error, stack, reason: 'session unreadable: sign in');
          status = SessionStatus.unauthenticated;
        }
        // a version no longer allowed: AppUpdateGate takes over from here
        try {
          await ref
              .read(appUpdateProvider.future)
              .timeout(const Duration(seconds: 2));
        } on Object catch (error) {
          AppLog.info('update status unknown at launch: $error');
        }
        if (!context.mounted) {
          return;
        }

        final PageRouteInfo next = switch (status) {
          SessionStatus.authenticated => const AppShellRoute(),
          _ => const WelcomeRoute(),
        };
        await context.router.replaceAll([next]);
        FlutterNativeSplash.remove();
      }

      start();
      return null;
    }, const []);

    // Same as the native splash: nothing moves on screen. When the next screen
    // comes in, the logo grows a little while the splash fades out (the first
    // third of the route transition, see FadeThroughRoute).
    final leaving = ModalRoute.of(context)?.secondaryAnimation;
    final zoomOut = useMemoized(
      () => leaving?.drive(
        Tween<double>(begin: 1, end: 1.05).chain(
          CurveTween(curve: const Interval(0, 0.35, curve: Curves.easeOut)),
        ),
      ),
      [leaving],
    );

    // light status bar icons on the dark blue, in both modes
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primaryDeep,
        body: Stack(
          children: [
            Positioned(
              right: -250,
              bottom: -190,
              child: BrandRing(
                size: 560,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
            Center(
              child: ScaleTransition(
                scale: zoomOut == null || AppMotion.reduced(context)
                    ? kAlwaysCompleteAnimation
                    : zoomOut,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CmfiLogo.onDark(size: 132),
                    SizedBox(height: 22),
                    CmfiWordmark(fontSize: 34, onDark: true),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 64,
              child: Text(
                context.t.app.tagline,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.onPrimaryMuted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
