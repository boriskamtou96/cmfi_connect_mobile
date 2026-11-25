import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/session/account.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../routing/app_router.dart';
// the same Google / Apple buttons as the login, round here
import '../../auth/presentation/widgets/social_buttons.dart';
import 'welcome_scenes.dart';

/// The colours of a welcome page: its gradient from [top] to [bottom], and
/// the [glow] of light in its upper corner.
typedef WelcomeColors = ({Color top, Color bottom, Color glow});

/// Signed out: three pages to swipe (25/11/2026), each on the colour of a
/// space of the app (the store pictures'): a picture of real pieces of the
/// app with Zoé ([WelcomeScene]), then a big title with its word in gold
/// italics and one sentence. The colour follows the finger from one page
/// to the next. Fixed under the pages: the dots, « Continuer » (« Créer mon
/// compte » on the last page, with Google and Apple) and « J'ai déjà un
/// compte ». « Passer » jumps to the last page.
///
/// The three pages are the presentation: shown until the user goes on
/// (either button), then only the first one, without dots (after a
/// sign-out, for instance; `OnboardingSeen`).
@RoutePage()
class WelcomeScreen extends HookConsumerWidget {
  const WelcomeScreen({super.key});

  /// The home's night blue, the hymns' teal, the events' ember.
  static const colors = <WelcomeColors>[
    (
      top: Color(0xFF0E4682),
      bottom: Color(0xFF061F40),
      glow: Color(0xFF1B5DA6),
    ),
    (
      top: Color(0xFF18A091),
      bottom: Color(0xFF0A4E48),
      glow: Color(0xFF2BB8A6),
    ),
    (
      top: Color(0xFFE0603A),
      bottom: Color(0xFF962E16),
      glow: Color(0xFFF08055),
    ),
  ];

  /// The word of each title.
  static const accent = AppColors.goldLight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    // read once: marking it seen while leaving doesn't change the page
    final seen = useMemoized(() => ref.read(onboardingSeenProvider));
    final controller = usePageController();
    final page = useState(0);
    final pages = [
      (
        before: t.welcome.seek.before,
        marked: t.welcome.seek.marked,
        after: t.welcome.seek.after,
        text: t.welcome.seek.text,
      ),
      if (!seen) ...[
        (
          before: t.welcome.worship.before,
          marked: t.welcome.worship.marked,
          after: t.welcome.worship.after,
          text: t.welcome.worship.text,
        ),
        (
          before: t.welcome.community.before,
          marked: t.welcome.community.marked,
          after: t.welcome.community.after,
          text: t.welcome.community.text,
        ),
      ],
    ];
    final last = page.value == pages.length - 1;

    Future<void> goOn(PageRouteInfo route) async {
      if (!seen) {
        await ref.read(onboardingSeenProvider.notifier).markSeen();
      }
      if (context.mounted) {
        await context.router.push(route);
      }
    }

    // signed in with Google or Apple: the app, or a new password first
    Future<void> openApp(Account account) async {
      if (!context.mounted) {
        return;
      }
      await context.router.replaceAll([
        if (account.mustChangePassword)
          ChangePasswordRoute(forced: true)
        else
          const AppShellRoute(),
      ]);
    }

    void turnTo(int index) => controller.animateToPage(
      index,
      duration: AppMotion.of(context, AppMotion.medium),
      curve: Curves.easeOutCubic,
    );

    final rtl = Directionality.of(context) == TextDirection.rtl;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: colors.first.bottom,
        body: Stack(
          children: [
            Positioned.fill(
              child: _Backdrop(controller: controller, page: page.value),
            ),
            SafeArea(
              minimum: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // the brand and « Passer »
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpacing.lg,
                      AppSpacing.xs,
                      AppSpacing.sm,
                      0,
                    ),
                    child: SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          const CmfiLogo(size: 30, disc: true),
                          const SizedBox(width: AppSpacing.sm),
                          // smaller rather than cut, before a long « Passer »
                          const Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: AlignmentDirectional.centerStart,
                              child: CmfiWordmark(fontSize: 17, onDark: true),
                            ),
                          ),
                          const Spacer(),
                          if (pages.length > 1)
                            AnimatedOpacity(
                              opacity: last ? 0 : 1,
                              duration: AppMotion.of(context, AppMotion.fast),
                              child: TextButton(
                                onPressed: last
                                    ? null
                                    : () => turnTo(pages.length - 1),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                child: Text(t.welcome.skip),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: controller,
                      onPageChanged: (index) => page.value = index,
                      children: [
                        for (final (index, slide) in pages.indexed)
                          _Page(
                            scene: WelcomeScene(index),
                            before: slide.before,
                            marked: slide.marked,
                            after: slide.after,
                            text: slide.text,
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (pages.length > 1) ...[
                          _Dots(current: page.value, total: pages.length),
                          const SizedBox(height: AppSpacing.lg - 4),
                        ],
                        FilledButton(
                          onPressed: last
                              ? () => goOn(const RegisterRoute())
                              : () => turnTo(page.value + 1),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: colors[page.value].bottom,
                            minimumSize: const Size.fromHeight(56),
                            shape: const StadiumBorder(),
                            textStyle: const TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  last
                                      ? t.welcome.createAccount
                                      : t.welcome.next,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Transform.flip(
                                flipX: rtl,
                                child: const Icon(
                                  AppIcons.arrowRight,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // on the page of « Créer mon compte »
                        AnimatedSize(
                          duration: AppMotion.of(context, AppMotion.fast),
                          alignment: Alignment.topCenter,
                          child: last
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: AppSpacing.md,
                                  ),
                                  child: Theme(
                                    data: _onColour(),
                                    child: SocialButtons(
                                      compact: true,
                                      onSignedIn: openApp,
                                    ),
                                  ),
                                )
                              : const SizedBox(width: double.infinity),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        TextButton(
                          onPressed: () => goOn(const LoginRoute()),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(48),
                            textStyle: const TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontSize: 15.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: Text(t.welcome.haveAccount),
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

  /// The light theme with white lines and words, for « ou continuer avec »
  /// on the colour of the page (the buttons stay white and black).
  static ThemeData _onColour() {
    final light = AppTheme.light();
    return light.copyWith(
      colorScheme: light.colorScheme.copyWith(
        outlineVariant: Colors.white.withValues(alpha: 0.32),
        onSurfaceVariant: Colors.white.withValues(alpha: 0.88),
      ),
    );
  }
}

/// The background: the colours of the page under the finger, blended with
/// the next one while swiping, a glow in the upper corner and a faint ring
/// (the halo of the store pictures).
class _Backdrop extends StatelessWidget {
  const _Backdrop({required this.controller, required this.page});

  final PageController controller;
  final int page;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: controller,
    builder: (context, _) {
      final colors = WelcomeScreen.colors;
      final position =
          controller.hasClients && controller.position.haveDimensions
          ? controller.page ?? page.toDouble()
          : page.toDouble();
      final clamped = position.clamp(0.0, colors.length - 1.0);
      final from = clamped.floor();
      final to = (from + 1).clamp(0, colors.length - 1);
      final f = clamped - from;
      Color mix(Color Function(WelcomeColors c) pick) =>
          Color.lerp(pick(colors[from]), pick(colors[to]), f)!;
      final glow = mix((c) => c.glow);
      return DecoratedBox(
        key: const ValueKey('welcome-background'),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(-0.18, -1),
            end: const Alignment(0.18, 1),
            colors: [mix((c) => c.top), mix((c) => c.bottom)],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const AlignmentDirectional(
                      0.7,
                      -0.84,
                    ).resolve(Directionality.of(context)),
                    radius: 0.85,
                    colors: [glow, glow.withValues(alpha: 0)],
                  ),
                ),
              ),
            ),
            PositionedDirectional(
              end: -250,
              top: 40,
              child: Container(
                width: 520,
                height: 520,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.06),
                    width: 64,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

/// The dots of the pages, the current one long.
class _Dots extends StatelessWidget {
  const _Dots({required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) => Semantics(
    label: context.t.welcome.step(current: current + 1, total: total),
    child: ExcludeSemantics(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 4),
        child: Row(
          children: [
            for (var i = 0; i < total; i++)
              AnimatedContainer(
                duration: AppMotion.of(context, AppMotion.fast),
                margin: const EdgeInsetsDirectional.only(end: 6),
                width: i == current ? 24 : 7,
                height: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: i == current
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.3),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

/// A page: its picture, as big as the room allows, then the title and the
/// sentence.
class _Page extends StatelessWidget {
  const _Page({
    required this.scene,
    required this.before,
    required this.marked,
    required this.after,
    required this.text,
  });

  final Widget scene;
  final String before;
  final String marked;
  final String after;
  final String text;

  @override
  Widget build(BuildContext context) {
    // smaller words on a small phone (an iPhone SE: 667 points high)
    final small = MediaQuery.sizeOf(context).height < 740;
    final size = small ? 32.0 : 40.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: scene,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(28, 0, 28, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                label: '$before$marked$after',
                child: ExcludeSemantics(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: before),
                        TextSpan(
                          text: marked,
                          style: TextStyle(
                            fontFamily: 'Lora',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w400,
                            fontSize: size * 1.1,
                            letterSpacing: -0.4,
                            color: WelcomeScreen.accent,
                          ),
                        ),
                        TextSpan(text: after),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: size,
                      height: 1.06,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -size * 0.025,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: small ? AppSpacing.sm : 14),
              Text(
                text,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: small ? 15 : 16,
                  height: 1.45,
                  color: Colors.white.withValues(alpha: 0.82),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
