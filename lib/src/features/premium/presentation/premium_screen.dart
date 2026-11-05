import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../../core/i18n/strings.g.dart';
import '../../../core/services/link_launcher.dart';
import '../../../core/services/premium_store.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/fade_slide_in.dart';

/// Text on the night blue of the page.
const _onNight = Colors.white;
const _onNightMuted = AppColors.onPrimaryMuted;

/// Premium, on a starry night: Zoé in a golden light beside the name, what
/// Premium opens (one line each) and what stays free, then how to get it:
/// on cmfi-connect.com (mobile money), with the same account; the golden
/// button fixed at the bottom opens it. A member who has Premium (bought on
/// the site, offered, or the team, who gets it with the role) sees it is on.
@RoutePage()
class PremiumScreen extends HookConsumerWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.premium;
    final active = ref.watch(premiumProvider).value ?? false;
    final offered = ref.watch(premiumIsOfferedProvider).value ?? false;
    final wentToSite = useRef(false);
    // back from the site: Premium bought there shows at once
    useOnAppLifecycleStateChange((_, state) {
      if (state == AppLifecycleState.resumed && wentToSite.value) {
        wentToSite.value = false;
        ref.read(premiumStoreProvider).refresh();
      }
    });
    void openSite() {
      final language = LocaleSettings.currentLocale.languageCode;
      wentToSite.value = true;
      ref
          .read(linkLauncherProvider)
          .open(
            Uri.parse(
              '${AppConfig.siteUrl}'
              '${language == 'fr' ? '' : '/$language'}/premium',
            ),
          );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.primaryDeep,
        body: Stack(
          children: [
            const Positioned.fill(
              child: RepaintBoundary(
                child: CustomPaint(painter: _StarsPainter()),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: AppSpacing.xs,
                      ),
                      child: IconButton(
                        tooltip: context.t.common.close,
                        color: _onNight,
                        onPressed: () => context.router.maybePop(),
                        icon: const Icon(AppIcons.close),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.xl,
                        0,
                        AppSpacing.xl,
                        AppSpacing.lg,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const FadeSlideIn(child: _Hero()),
                          const SizedBox(height: AppSpacing.md),
                          FadeSlideIn(
                            index: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  t.includes,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: _onNight,
                                  ),
                                ),
                                for (final (icon, title, text) in [
                                  (
                                    AppIcons.offlineTile,
                                    t.offlineTitle,
                                    t.offlineText,
                                  ),
                                  (
                                    AppIcons.yearStoryTile,
                                    t.yearTitle,
                                    t.yearText,
                                  ),
                                  (
                                    AppIcons.homeWidgetTile,
                                    t.widgetTitle,
                                    t.widgetText,
                                  ),
                                  (
                                    AppIcons.progressTile,
                                    t.statsTitle,
                                    t.statsText,
                                  ),
                                  (
                                    AppIcons.supportTile,
                                    t.supportTitle,
                                    t.supportText,
                                  ),
                                ]) ...[
                                  const SizedBox(height: AppSpacing.md),
                                  _Benefit(
                                    icon: icon,
                                    title: title,
                                    text: text,
                                  ),
                                ],
                                const SizedBox(height: AppSpacing.md),
                                // what stays free: what Premium is not
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      AppIcons.checkCircle,
                                      size: 18,
                                      color: _onNightMuted,
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: Text(
                                        t.freeForAll,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          height: 1.4,
                                          color: _onNightMuted,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          FadeSlideIn(
                            index: 4,
                            child: active
                                ? _Active(offered: offered)
                                : AppConfig.premiumOnSite
                                ? const _OnSite()
                                : const _Soon(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _Footer(
                    onSite: !active && AppConfig.premiumOnSite
                        ? openSite
                        : null,
                    onClose: () => context.router.maybePop(),
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

/// A sky of small stars, a few of them golden; the same sky each time
/// (seeded), thicker towards the top.
class _StarsPainter extends CustomPainter {
  const _StarsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(7);
    final paint = Paint();
    // fainter lower down, where the text is
    double fade(double y) => 1 - 0.75 * (y / size.height);
    for (var i = 0; i < 110; i++) {
      final x = random.nextDouble() * size.width;
      final y = math.pow(random.nextDouble(), 1.8) * size.height;
      final bright = random.nextDouble();
      paint.color = Colors.white.withValues(
        alpha: (0.12 + 0.5 * bright) * fade(y.toDouble()),
      );
      canvas.drawCircle(Offset(x, y.toDouble()), 0.5 + 1.1 * bright, paint);
    }
    for (var i = 0; i < 12; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height * 0.35;
      paint.color = AppColors.goldLight.withValues(
        alpha: (0.4 + 0.4 * random.nextDouble()) * fade(y),
      );
      canvas.drawCircle(Offset(x, y), 1 + random.nextDouble(), paint);
    }
  }

  @override
  bool shouldRepaint(_StarsPainter old) => false;
}

/// Zoé celebrating in a golden light beside the name, then the promise.
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    final t = context.t.premium;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 84,
              height: 76,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  radius: 0.6,
                  colors: [
                    AppColors.gold.withValues(alpha: 0.45),
                    AppColors.gold.withValues(alpha: 0.12),
                    AppColors.gold.withValues(alpha: 0),
                  ],
                  stops: const [0, 0.5, 1],
                ),
              ),
              child: const DoveMascot(pose: DovePose.celebrate, size: 64),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.t.app.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                      color: _onNightMuted,
                    ),
                  ),
                  // the full name for a screen reader, "Premium" in gold for
                  // the eyes
                  Semantics(
                    header: true,
                    label: t.name,
                    excludeSemantics: true,
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [AppColors.goldLight, AppColors.gold],
                      ).createShader(bounds),
                      child: Text(
                        t.pill,
                        style: const TextStyle(
                          fontSize: 34,
                          height: 1.1,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          t.subtitle,
          style: const TextStyle(
            fontSize: 15,
            height: 1.4,
            color: _onNightMuted,
          ),
        ),
      ],
    );
  }
}

/// What Premium opens, lit in gold: its icon on a tile, its title and the
/// sentence that says what it gives.
class _Benefit extends StatelessWidget {
  const _Benefit({required this.icon, required this.title, required this.text});

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.45)),
            ),
            child: PhosphorIcon(icon, color: AppColors.goldLight, size: 22),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                    color: _onNight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.4,
                    color: _onNightMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Premium is not sold in this version: said, without more.
class _Soon extends StatelessWidget {
  const _Soon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Text(
        context.t.premium.unavailable,
        textAlign: TextAlign.center,
        style: const TextStyle(color: _onNight, height: 1.4),
      ),
    );
  }
}

/// Premium is activated on the website, with the same account; the golden
/// button below opens it.
class _OnSite extends StatelessWidget {
  const _OnSite();

  @override
  Widget build(BuildContext context) {
    final t = context.t.premium.onSite;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.goldLight,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            t.text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _onNight, height: 1.45),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.note,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: _onNightMuted,
            ),
          ),
        ],
      ),
    );
  }
}

/// Premium is on: a golden card instead of the plans.
class _Active extends StatelessWidget {
  const _Active({required this.offered});

  /// Given with the role (the team), not bought.
  final bool offered;

  @override
  Widget build(BuildContext context) {
    final t = context.t.premium;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.14),
            Colors.white.withValues(alpha: 0.05),
          ],
        ),
        // no shadow: it would show through the glass
        border: Border.all(color: AppColors.gold),
      ),
      child: Column(
        children: [
          const Icon(
            AppIcons.checkCircleFilled,
            color: AppColors.gold,
            size: 36,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.activeTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: _onNight,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            offered ? t.staffText : t.activeText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _onNightMuted, height: 1.4),
          ),
        ],
      ),
    );
  }
}

/// Fixed at the bottom: the golden button (to the site, or to close), then
/// the legal links.
class _Footer extends ConsumerWidget {
  const _Footer({required this.onSite, required this.onClose});

  /// Premium is bought on the website: the button opens it.
  final VoidCallback? onSite;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.premium;

    Widget link(String label, VoidCallback onTap) => TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: _onNightMuted,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        minimumSize: const Size(0, 44),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: const TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: Text(label),
    );
    void open(String path) => ref
        .read(linkLauncherProvider)
        .open(Uri.parse('${AppConfig.siteUrl}$path'));
    const dot = Text('·', style: TextStyle(color: _onNightMuted));

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.sm,
        AppSpacing.xl,
        0,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryDeep,
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.3),
                  blurRadius: 18,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: FilledButton(
              onPressed: onSite ?? onClose,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.ink,
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                textStyle: const TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              child: Text(
                onSite != null ? t.onSite.button : context.t.common.close,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              link(t.termsShort, () => open('/terms')),
              dot,
              link(t.privacy, () => open('/privacy')),
            ],
          ),
        ],
      ),
    );
  }
}
