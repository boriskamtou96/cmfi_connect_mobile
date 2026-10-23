import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/photo_kit.dart';
import '../../../routing/app_router.dart';

/// Signed out: three pages to swipe (23/10/2026), each a photo of real
/// people from the top to the middle, melting into the page, with two
/// frosted tags of what the app does on it; under it a headline with its
/// word in bold and one sentence. Fixed under the pages: the dots,
/// « Continuer » (« Créer mon compte » on the last page) and « J'ai déjà un
/// compte ». « Passer » jumps to the last page.
///
/// The three pages are the presentation: shown until the user goes on
/// (either button), then only the first one, without dots (after a
/// sign-out, for instance; `OnboardingSeen`).
@RoutePage()
class WelcomeScreen extends HookConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    // read once: marking it seen while leaving doesn't change the page
    final seen = useMemoized(() => ref.read(onboardingSeenProvider));
    final dark = Theme.of(context).brightness == Brightness.dark;
    final controller = usePageController();
    final page = useState(0);
    final look = _WelcomeLook.of(context);
    final pages = [
      _Slide(
        photo: StockPhotos.reading,
        alignment: Alignment.center,
        before: t.welcome.seek.before,
        marked: t.welcome.seek.marked,
        after: t.welcome.seek.after,
        text: t.welcome.seek.text,
        tags: const _SeekTags(),
      ),
      if (!seen) ...[
        _Slide(
          photo: StockPhotos.worship,
          alignment: const Alignment(0.1, 0),
          before: t.welcome.worship.before,
          marked: t.welcome.worship.marked,
          after: t.welcome.worship.after,
          text: t.welcome.worship.text,
          tags: const _WorshipTags(),
        ),
        _Slide(
          photo: StockPhotos.family,
          alignment: const Alignment(0, -0.3),
          before: t.welcome.community.before,
          marked: t.welcome.community.marked,
          after: t.welcome.community.after,
          text: t.welcome.community.text,
          tags: const _CommunityTags(),
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

    void turnTo(int index) => controller.animateToPage(
      index,
      duration: AppMotion.of(context, AppMotion.medium),
      curve: Curves.easeOutCubic,
    );

    final top = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: look.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: controller,
                  onPageChanged: (index) => page.value = index,
                  children: [for (final slide in pages) _Page(slide)],
                ),
                // the brand and « Passer », on the photo
                PositionedDirectional(
                  start: AppSpacing.xl,
                  end: AppSpacing.md,
                  top: top + AppSpacing.sm,
                  child: Row(
                    children: [
                      const CmfiLogo(size: 30, disc: true),
                      const SizedBox(width: AppSpacing.sm),
                      const CmfiWordmark(fontSize: 17, onDark: true),
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
              ],
            ),
          ),
          SafeArea(
            top: false,
            minimum: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                children: [
                  if (pages.length > 1) ...[
                    Semantics(
                      label: t.welcome.step(
                        current: page.value + 1,
                        total: pages.length,
                      ),
                      child: ExcludeSemantics(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < pages.length; i++)
                              AnimatedContainer(
                                duration: AppMotion.of(context, AppMotion.fast),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                width: i == page.value ? 22 : 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color: i == page.value
                                      ? look.ink
                                      : look.ink.withValues(alpha: 0.18),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: last
                          ? () => goOn(const RegisterRoute())
                          : () => turnTo(page.value + 1),
                      style: FilledButton.styleFrom(
                        backgroundColor: dark
                            ? AppColors.goldLight
                            : AppColors.primaryDeep,
                        foregroundColor: dark
                            ? AppColors.primaryDeep
                            : Colors.white,
                        minimumSize: const Size.fromHeight(56),
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontSize: 16.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      child: Text(
                        last ? t.welcome.createAccount : t.welcome.next,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  TextButton(
                    onPressed: () => goOn(const LoginRoute()),
                    style: TextButton.styleFrom(
                      foregroundColor: look.ink,
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
          ),
        ],
      ),
    );
  }
}

/// The colours of the page: white with night-blue words in light mode,
/// night blue with white words in dark mode.
class _WelcomeLook {
  const _WelcomeLook({
    required this.background,
    required this.ink,
    required this.body,
  });

  factory _WelcomeLook.of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? const _WelcomeLook(
          background: AppColors.night,
          ink: Colors.white,
          body: Color(0xB3FFFFFF),
        )
      : const _WelcomeLook(
          background: Colors.white,
          ink: AppColors.primaryDeep,
          body: AppColors.muted,
        );

  final Color background;
  final Color ink;
  final Color body;
}

/// What a page shows.
class _Slide {
  const _Slide({
    required this.photo,
    required this.alignment,
    required this.before,
    required this.marked,
    required this.after,
    required this.text,
    required this.tags,
  });

  final String photo;
  final Alignment alignment;
  final String before;
  final String marked;
  final String after;
  final String text;

  /// The frosted tags over the photo, placed in the photo's box.
  final Widget tags;
}

/// A page: the photo, darker at the top for the brand and melting into the
/// page at the bottom, its tags, then the headline and the sentence.
class _Page extends StatelessWidget {
  const _Page(this.slide);

  final _Slide slide;

  @override
  Widget build(BuildContext context) {
    final look = _WelcomeLook.of(context);
    final style = TextStyle(
      fontSize: 30,
      height: 1.15,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.9,
      color: look.ink,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              GradedPhoto(slide.photo, alignment: slide.alignment),
              PhotoScrim(
                colors: [
                  Colors.black.withValues(alpha: 0.45),
                  Colors.black.withValues(alpha: 0),
                  look.background.withValues(alpha: 0),
                  look.background,
                ],
                stops: const [0, 0.28, 0.72, 1],
              ),
              ExcludeSemantics(child: slide.tags),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.xl,
            0,
            AppSpacing.xl,
            AppSpacing.lg,
          ),
          child: Column(
            children: [
              Semantics(
                header: true,
                label: '${slide.before}${slide.marked}${slide.after}',
                child: ExcludeSemantics(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: slide.before),
                        TextSpan(
                          text: slide.marked,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        TextSpan(text: slide.after),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: style,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm + 2),
              Text(
                slide.text,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15, height: 1.4, color: look.body),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A frosted tag on a photo: a round icon and a few words.
class _Tag extends StatelessWidget {
  const _Tag({required this.icon, required this.text, required this.color});

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => FrostedGlass(
    radius: 99,
    tint: Colors.white.withValues(alpha: 0.18),
    padding: const EdgeInsetsDirectional.fromSTEB(6, 6, 14, 6),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Icon(icon, size: 15, color: Colors.white),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

/// The tags of a page, each placed as fractions of the photo's box (from
/// its start and its top).
class _Tags extends StatelessWidget {
  const _Tags(this.tags);

  final List<({double x, double y, Widget tag})> tags;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, box) => Stack(
      children: [
        for (final item in tags)
          PositionedDirectional(
            start: box.maxWidth * item.x,
            top: box.maxHeight * item.y,
            child: item.tag,
          ),
      ],
    ),
  );
}

class _SeekTags extends StatelessWidget {
  const _SeekTags();

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final s = t.welcome.sample;
    return _Tags([
      (
        x: 0.06,
        y: 0.30,
        tag: _Tag(
          icon: AppIcons.streak,
          text: t.welcome.streak(n: 24),
          color: const Color(0xFFFF7A1A),
        ),
      ),
      (
        x: 0.42,
        y: 0.56,
        tag: _Tag(
          icon: AppIcons.bible,
          text: '${s.bibleReading} · ${s.chapters}',
          color: AppColors.primary,
        ),
      ),
    ]);
  }
}

class _WorshipTags extends StatelessWidget {
  const _WorshipTags();

  @override
  Widget build(BuildContext context) {
    final s = context.t.welcome.sample;
    return _Tags([
      (
        x: 0.50,
        y: 0.24,
        tag: _Tag(
          icon: AppIcons.hymn,
          text: '${s.hymn} ${s.hymnNumber}',
          color: const Color(0xFF1DB954),
        ),
      ),
      (
        x: 0.06,
        y: 0.54,
        tag: _Tag(
          icon: AppIcons.prayNow,
          text: s.praying,
          color: AppColors.gold,
        ),
      ),
    ]);
  }
}

class _CommunityTags extends StatelessWidget {
  const _CommunityTags();

  @override
  Widget build(BuildContext context) {
    final s = context.t.welcome.sample;
    return _Tags([
      (
        x: 0.06,
        y: 0.26,
        tag: _Tag(
          icon: AppIcons.eventsTile,
          text: s.retreat,
          color: const Color(0xFF7C5CFF),
        ),
      ),
      (
        x: 0.60,
        y: 0.44,
        tag: _Tag(
          icon: AppIcons.announcements,
          text: s.announcement,
          color: AppColors.gold,
        ),
      ),
    ]);
  }
}
