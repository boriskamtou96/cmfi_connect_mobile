import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../routing/app_router.dart';

/// Signed-out home: create an account or sign in.
@RoutePage()
class WelcomeScreen extends HookWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // first show: the logo fades in and grows a little, the white panel rises
    final entrance = useAnimationController(
      duration: AppMotion.slow + AppMotion.stagger * 2,
      initialValue: AppMotion.reduced(context) ? 1 : 0,
    );
    useEffect(() {
      if (!entrance.isCompleted) {
        entrance.forward();
      }
      return null;
    }, [entrance]);
    final logo = useMemoized(
      () => entrance.drive(
        CurveTween(curve: const Interval(0, 0.8, curve: AppMotion.emphasized)),
      ),
      [entrance],
    );
    final panel = useMemoized(
      () => entrance.drive(
        CurveTween(curve: const Interval(0.2, 1, curve: AppMotion.emphasized)),
      ),
      [entrance],
    );

    // light status bar icons on the dark blue, in both modes
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primaryDeep,
        body: Stack(
          children: [
            Positioned(
              left: -210,
              top: -170,
              child: BrandRing(
                size: 520,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SafeArea(
                    bottom: false,
                    child: FadeTransition(
                      opacity: logo,
                      child: ScaleTransition(
                        scale: logo.drive(Tween(begin: 0.92, end: 1)),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CmfiLogo.onDark(size: 108),
                            SizedBox(height: 20),
                            CmfiWordmark(onDark: true),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SlideTransition(
                  position: panel.drive(
                    Tween(begin: const Offset(0, 1), end: Offset.zero),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadius.xxl),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          AppSpacing.xl,
                          AppSpacing.xxl,
                          AppSpacing.xl,
                          AppSpacing.xl,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              t.welcome.title,
                              style: textTheme.headlineSmall?.copyWith(
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              t.welcome.text,
                              style: textTheme.bodyLarge?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            FilledButton(
                              onPressed: () =>
                                  context.router.push(const RegisterRoute()),
                              child: Text(t.welcome.createAccount),
                            ),
                            const SizedBox(height: 14),
                            OutlinedButton(
                              onPressed: () =>
                                  context.router.push(const LoginRoute()),
                              child: Text(t.welcome.haveAccount),
                            ),
                          ],
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
    );
  }
}
