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
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/cmfi_logo.dart';
import '../../../core/widgets/photo_kit.dart';
import '../../../routing/app_router.dart';

/// Signed out: three pages to swipe, each a big headline with one word on a
/// gold marker, a photo in an arch with stickers around it (what the app
/// does: the streak, the report, a hymn, a prayer topic, the community),
/// and the two buttons always under them: create an account, sign in.
/// Cream in light mode, night blue in dark mode.
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
      (
        before: t.welcome.seek.before,
        marked: t.welcome.seek.marked,
        after: t.welcome.seek.after,
        text: t.welcome.seek.text,
        illustration: const _SeekIllustration() as Widget,
      ),
      if (!seen) ...[
        (
          before: t.welcome.worship.before,
          marked: t.welcome.worship.marked,
          after: t.welcome.worship.after,
          text: t.welcome.worship.text,
          illustration: const _WorshipIllustration() as Widget,
        ),
        (
          before: t.welcome.community.before,
          marked: t.welcome.community.marked,
          after: t.welcome.community.after,
          text: t.welcome.community.text,
          illustration: const _CommunityIllustration() as Widget,
        ),
      ],
    ];

    Future<void> goOn(PageRouteInfo route) async {
      if (!seen) {
        await ref.read(onboardingSeenProvider.notifier).markSeen();
      }
      if (context.mounted) {
        await context.router.push(route);
      }
    }

    return Scaffold(
      backgroundColor: look.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl,
                AppSpacing.sm,
                AppSpacing.xl,
                0,
              ),
              child: Row(
                children: [
                  CmfiLogo(size: 30, disc: dark),
                  const SizedBox(width: AppSpacing.sm),
                  CmfiWordmark(fontSize: 17, onDark: dark),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (index) => page.value = index,
                children: [
                  for (final item in pages)
                    _Page(
                      before: item.before,
                      marked: item.marked,
                      after: item.after,
                      illustration: item.illustration,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl,
                AppSpacing.sm,
                AppSpacing.xl,
                AppSpacing.md,
              ),
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: AppMotion.of(context, AppMotion.fast),
                    child: Text(
                      pages[page.value].text,
                      key: ValueKey(page.value),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        color: look.body,
                      ),
                    ),
                  ),
                  if (pages.length > 1) ...[
                    const SizedBox(height: AppSpacing.lg),
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
                                  horizontal: AppSpacing.xs,
                                ),
                                width: i == page.value ? 26 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color: i == page.value
                                      ? AppColors.gold
                                      : look.ink.withValues(alpha: 0.18),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg + 2),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => goOn(const RegisterRoute()),
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
                      child: Text(t.welcome.createAccount),
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
          ],
        ),
      ),
    );
  }
}

/// The colours of the page: cream with night-blue words in light mode,
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
          body: Color(0xCCFFFFFF),
        )
      : const _WelcomeLook(
          background: AppColors.cream,
          ink: AppColors.primaryDeep,
          body: Color(0xFF5B4A2E),
        );

  final Color background;
  final Color ink;
  final Color body;
}

/// A page: the headline, its word on a gold marker, then the illustration,
/// scaled down on a small phone.
class _Page extends StatelessWidget {
  const _Page({
    required this.before,
    required this.marked,
    required this.after,
    required this.illustration,
  });

  final String before;
  final String marked;
  final String after;
  final Widget illustration;

  @override
  Widget build(BuildContext context) {
    final look = _WelcomeLook.of(context);
    final style = TextStyle(
      fontSize: 36,
      height: 1.12,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.2,
      color: look.ink,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.xl,
            AppSpacing.lg + 2,
            AppSpacing.xl,
            AppSpacing.md,
          ),
          child: Semantics(
            header: true,
            label: '$before$marked$after',
            child: ExcludeSemantics(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: before),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: AppColors.goldLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          marked,
                          style: style.copyWith(color: AppColors.primaryDeep),
                        ),
                      ),
                    ),
                    TextSpan(text: after),
                  ],
                ),
                style: style,
              ),
            ),
          ),
        ),
        Expanded(
          child: ExcludeSemantics(
            child: FittedBox(
              child: SizedBox.fromSize(size: _canvas, child: illustration),
            ),
          ),
        ),
      ],
    );
  }
}

/// The size the illustrations are drawn at (scaled to the room left).
const _canvas = Size(360, 350);

/// The arch in the middle of the canvas, the stickers around it.
class _Illustration extends StatelessWidget {
  const _Illustration({
    required this.photo,
    required this.alignment,
    required this.backdrop,
    required this.stickers,
  });

  final String photo;
  final Alignment alignment;
  final Color backdrop;
  final List<Widget> stickers;

  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
    children: [
      Positioned(
        left: (_canvas.width - 266) / 2,
        top: 0,
        child: ArchPhoto(
          asset: photo,
          alignment: alignment,
          backdrop: backdrop,
        ),
      ),
      ...stickers,
    ],
  );
}

class _SeekIllustration extends StatelessWidget {
  const _SeekIllustration();

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final s = t.welcome.sample;
    return _Illustration(
      photo: StockPhotos.joyful,
      alignment: const Alignment(0, -0.5),
      backdrop: AppColors.goldLight,
      stickers: [
        PositionedDirectional(
          start: 4,
          top: 24,
          child: Sticker(
            icon: AppIcons.streak,
            text: t.welcome.streak(n: 24),
            color: const Color(0xFFFF7A1A),
            angle: -0.08,
            big: true,
          ),
        ),
        PositionedDirectional(
          end: 2,
          top: 168,
          child: _MiniCard(
            angle: 0.05,
            title: s.bibleReading,
            meta: s.chapters,
            icon: AppIcons.bible,
            color: AppModule.bible.tone(context).color,
          ),
        ),
        PositionedDirectional(
          start: 6,
          top: 262,
          child: _MiniCard(
            angle: -0.04,
            title: s.prayerAlone,
            meta: 45.toDurationLabel(),
            icon: AppIcons.prayNow,
            color: AppModule.prayer.tone(context).color,
          ),
        ),
      ],
    );
  }
}

class _WorshipIllustration extends StatelessWidget {
  const _WorshipIllustration();

  @override
  Widget build(BuildContext context) {
    final s = context.t.welcome.sample;
    final prayer = AppModule.prayer.tone(context).color;
    return _Illustration(
      photo: StockPhotos.womanWorshipping,
      alignment: const Alignment(0.05, 0),
      backdrop: const Color(0xFFF4B8A0),
      stickers: [
        PositionedDirectional(
          end: 2,
          top: 28,
          child: Sticker(
            icon: AppIcons.hymn,
            text: '${s.hymn} ${s.hymnNumber}',
            color: AppModule.hymns.tone(context).color,
            angle: 0.07,
            big: true,
          ),
        ),
        PositionedDirectional(
          start: 2,
          top: 214,
          child: Transform.rotate(
            angle: -0.04,
            child: Container(
              width: 214,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                // a printed card: white in both modes
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: floatingShadow(1.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.prayerOfTheDay.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                      color: prayer,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    s.prayerTopic,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      FaceStack(
                        faces: [
                          for (final face in const [
                            StockPhotos.manSmiling,
                            StockPhotos.womanLaughing,
                            StockPhotos.elder,
                          ])
                            CroppedFace(face, size: 18),
                        ],
                        ring: Colors.white,
                        size: 22,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          s.praying,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: ShapeDecoration(
                          color: prayer,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          s.iPray,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
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
      ],
    );
  }
}

class _CommunityIllustration extends StatelessWidget {
  const _CommunityIllustration();

  @override
  Widget build(BuildContext context) {
    final s = context.t.welcome.sample;
    return _Illustration(
      photo: StockPhotos.family,
      alignment: const Alignment(0, -0.3),
      backdrop: const Color(0xFFBFE3C8),
      stickers: [
        PositionedDirectional(
          start: 4,
          top: 28,
          child: Sticker(
            icon: AppIcons.eventsTile,
            text: s.retreat,
            color: AppModule.events.tone(context).color,
            angle: -0.07,
            big: true,
          ),
        ),
        PositionedDirectional(
          end: 0,
          top: 224,
          child: _MiniCard(
            angle: 0.05,
            title: s.announcement,
            meta: s.announcementText,
            icon: AppIcons.announcements,
            color: AppColors.gold,
            width: 252,
          ),
        ),
      ],
    );
  }
}

/// A small white card of the illustration: an icon, two lines, a green
/// check.
class _MiniCard extends StatelessWidget {
  const _MiniCard({
    required this.angle,
    required this.title,
    required this.meta,
    required this.icon,
    required this.color,
    this.width,
  });

  final double angle;
  final String title;
  final String meta;
  final IconData icon;
  final Color color;
  final double? width;

  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: angle,
    child: Container(
      width: width,
      padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 14, 10),
      decoration: BoxDecoration(
        // a printed card: white in both modes
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: floatingShadow(1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 19, color: color),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  meta,
                  style: const TextStyle(fontSize: 12, color: AppColors.muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF1FA36B),
            ),
            child: const Icon(AppIcons.check, size: 13, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
