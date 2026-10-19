import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../../core/i18n/strings.g.dart';
import '../../../core/services/app_log.dart';
import '../../../core/services/link_launcher.dart';
import '../../../core/services/premium_store.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../application/premium_plans.dart';

/// Text on the night blue of the page.
const _onNight = Colors.white;
const _onNightMuted = AppColors.onPrimaryMuted;

/// The Premium subscription, on a starry night, on one screen (a little
/// scroll at most on a small phone or with large text): Zoé in a golden
/// light beside the name, what Premium opens in three lines, the plans two
/// by two, what the stores ask to say, and the golden button fixed at the
/// bottom. A member who has Premium (or the team, who gets it with the role)
/// sees it is on instead of the plans.
@RoutePage()
class PremiumScreen extends HookConsumerWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.premium;
    final active = ref.watch(premiumProvider).value ?? false;
    final offered = ref.watch(premiumIsOfferedProvider).value ?? false;
    final plans = ref.watch(premiumPlansProvider);
    final chosen = useState(PremiumPeriod.annual);
    final busy = useState(false);

    final available = plans.value ?? const <PremiumPlan>[];
    final selected =
        available.where((plan) => plan.period == chosen.value).firstOrNull ??
        available.firstOrNull;

    // a purchase or a restore: Premium on, or why not
    Future<void> run(
      Future<bool> Function(PremiumStore store) action, {
      required String done,
      String? none,
    }) async {
      final toast = ref.read(toasterProvider).of(context);
      final failed = t.failed;
      busy.value = true;
      try {
        if (await action(ref.read(premiumStoreProvider))) {
          ref.read(premiumProvider.notifier).activated();
          toast.success(done);
        } else if (none != null) {
          toast.info(none);
        }
      } on PlatformException {
        toast.error(failed);
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (final (i, (icon, title, text)) in [
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
                                ].indexed) ...[
                                  if (i > 0)
                                    const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: _Benefit(
                                      icon: icon,
                                      title: title,
                                      text: text,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          FadeSlideIn(
                            index: 4,
                            child: active
                                ? _Active(
                                    offered: offered,
                                    onManage: () => manage(context, ref),
                                  )
                                : switch (plans) {
                                    AsyncData() when available.isEmpty =>
                                      _Unavailable(
                                        onRetry: () => ref.invalidate(
                                          premiumPlansProvider,
                                        ),
                                      ),
                                    AsyncData() => _Plans(
                                      plans: available,
                                      selected: selected,
                                      onChoose: (plan) =>
                                          chosen.value = plan.period,
                                    ),
                                    _ => const Padding(
                                      padding: EdgeInsets.all(AppSpacing.xl),
                                      child: Center(
                                        child: AppSpinner(
                                          color: AppColors.gold,
                                        ),
                                      ),
                                    ),
                                  },
                          ),
                          if (!active) ...[
                            const SizedBox(height: AppSpacing.md),
                            _FinePrint(
                              lifetime:
                                  selected?.period == PremiumPeriod.lifetime,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  _Footer(
                    active: active,
                    plan: selected,
                    busy: busy.value,
                    onBuy: selected == null
                        ? null
                        : () => run(
                            (store) => store.buy(selected),
                            done: t.thanks,
                          ),
                    onRestore: () => run(
                      (store) => store.restore(),
                      done: t.restored,
                      none: t.nothingToRestore,
                    ),
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
/// The Customer Center of RevenueCat; a message when it can't open.
Future<void> manage(BuildContext context, WidgetRef ref) async {
  final toast = ref.read(toasterProvider).of(context);
  final failed = context.t.premium.manageFailed;
  try {
    await ref.read(premiumStoreProvider).manage();
  } on PlatformException catch (error, stack) {
    AppLog.error(error, stack, reason: 'customer center did not open');
    toast.error(failed);
  }
}

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

/// What Premium opens, lit in gold: one of three side by side, its icon
/// and its title (the sentence that explains it is read by screen readers).
class _Benefit extends StatelessWidget {
  const _Benefit({required this.icon, required this.title, required this.text});

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$title. $text',
      excludeSemantics: true,
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.gold.withValues(alpha: 0.45)),
            ),
            child: PhosphorIcon(icon, color: AppColors.goldLight, size: 21),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.25,
              fontWeight: FontWeight.w700,
              color: _onNight,
            ),
          ),
        ],
      ),
    );
  }
}

/// "24,99 € / an", "14,99 € / 6 mois", "2,99 € / mois", "49,99 € une fois".
String _periodPrice(BuildContext context, PremiumPlan plan) {
  final t = context.t.premium;
  return switch (plan.period) {
    PremiumPeriod.monthly => t.perMonth(price: plan.price),
    PremiumPeriod.semiannual => t.perSemester(price: plan.price),
    PremiumPeriod.annual => t.perYear(price: plan.price),
    PremiumPeriod.lifetime => t.once(price: plan.price),
  };
}

/// The plans two by two, the longest subscription first and the lifetime
/// one last (alone on its line when the count is odd), each subscription
/// with what it saves on the months paid one by one.
class _Plans extends StatelessWidget {
  const _Plans({
    required this.plans,
    required this.selected,
    required this.onChoose,
  });

  final List<PremiumPlan> plans;
  final PremiumPlan? selected;
  final ValueChanged<PremiumPlan> onChoose;

  @override
  Widget build(BuildContext context) {
    final t = context.t.premium;
    final monthly = plans
        .where((plan) => plan.period == PremiumPeriod.monthly)
        .firstOrNull;
    int rank(PremiumPlan plan) =>
        plan.period == PremiumPeriod.lifetime ? -1 : plan.period.months;
    final ordered = [...plans]..sort((a, b) => rank(b).compareTo(rank(a)));

    String? badge(PremiumPlan plan) {
      if (monthly == null ||
          monthly.amount <= 0 ||
          plan == monthly ||
          plan.period == PremiumPeriod.lifetime) {
        return null;
      }
      final saving = 1 - plan.amount / (monthly.amount * plan.period.months);
      return saving < 0.05
          ? null
          : t.savePercent(
              percent: context.formatPercent((saving * 100).floor() / 100),
            );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          t.choose,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: _onNight,
          ),
        ),
        // room for the saving badges on the top edge
        const SizedBox(height: AppSpacing.lg),
        for (var i = 0; i < ordered.length; i += 2) ...[
          if (i > 0) const SizedBox(height: AppSpacing.md),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final plan in ordered.skip(i).take(2)) ...[
                  if (plan != ordered[i]) const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _PlanTile(
                      plan: plan,
                      selected: plan == selected,
                      badge: badge(plan),
                      onTap: () => onChoose(plan),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// A plan as a pane of glass, half the width: its name and what it saves,
/// the price large with its period, what it makes a month; the chosen one
/// framed in gold with a check.
class _PlanTile extends StatelessWidget {
  const _PlanTile({
    required this.plan,
    required this.selected,
    required this.badge,
    required this.onTap,
  });

  final PremiumPlan plan;
  final bool selected;
  final String? badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t.premium;
    final radius = BorderRadius.circular(AppRadius.lg);
    // "24,99 €" large, "/ an" small beside it; read whole ("24,99 € / an")
    final full = _periodPrice(context, plan);
    final period = full.replaceFirst(plan.price, '').trim();
    final tile = Semantics(
      selected: selected,
      button: true,
      child: AnimatedContainer(
        duration: AppMotion.of(context, AppMotion.fast),
        decoration: BoxDecoration(
          borderRadius: radius,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withValues(alpha: selected ? 0.16 : 0.09),
              Colors.white.withValues(alpha: selected ? 0.07 : 0.03),
            ],
          ),
          border: Border.all(
            color: selected
                ? AppColors.gold
                : Colors.white.withValues(alpha: 0.16),
            width: selected ? 2 : 1,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          switch (plan.period) {
                            PremiumPeriod.monthly => t.monthly,
                            PremiumPeriod.semiannual => t.semiannual,
                            PremiumPeriod.annual => t.annual,
                            PremiumPeriod.lifetime => t.lifetime,
                          }.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: selected
                                ? AppColors.goldLight
                                : _onNightMuted,
                          ),
                        ),
                      ),
                      Icon(
                        selected
                            ? AppIcons.checkCircleFilled
                            : AppIcons.radioOff,
                        size: 20,
                        color: selected
                            ? AppColors.gold
                            : Colors.white.withValues(alpha: 0.4),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Semantics(
                    label: full,
                    excludeSemantics: true,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: 4,
                      children: [
                        Text(
                          plan.price,
                          style: const TextStyle(
                            fontSize: 20,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                            color: _onNight,
                          ),
                        ),
                        if (period.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              period,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: _onNightMuted,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (plan.pricePerMonth case final perMonth?) ...[
                    const SizedBox(height: 2),
                    Text(
                      t.annualPerMonth(price: perMonth),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _onNight,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
    final badge = this.badge;
    if (badge == null) {
      return tile;
    }
    // what it saves, on the top edge of the tile
    return Stack(
      clipBehavior: Clip.none,
      // as tall as the other tile of the row
      fit: StackFit.passthrough,
      children: [
        tile,
        PositionedDirectional(top: -9, end: 30, child: _SavingBadge(badge)),
      ],
    );
  }
}

/// "★ −30 %": what a plan saves, in gold.
class _SavingBadge extends StatelessWidget {
  const _SavingBadge(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(AppIcons.starFilled, size: 11, color: AppColors.ink),
          const SizedBox(width: 3),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The store gave no plan (not configured yet, or no network).
class _Unavailable extends StatelessWidget {
  const _Unavailable({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Column(
        children: [
          Text(
            context.t.premium.unavailable,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _onNight, height: 1.4),
          ),
          const SizedBox(height: AppSpacing.xs),
          TextButton(
            onPressed: onRetry,
            style: TextButton.styleFrom(foregroundColor: AppColors.goldLight),
            child: Text(context.t.common.retry),
          ),
        ],
      ),
    );
  }
}

/// Premium is on: a golden card instead of the plans.
class _Active extends StatelessWidget {
  const _Active({required this.offered, required this.onManage});

  /// Given with the role (the team), not bought.
  final bool offered;

  /// Bought: "Gérer mon abonnement" opens the Customer Center.
  final VoidCallback onManage;

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
          if (!offered) ...[
            const SizedBox(height: AppSpacing.md),
            OutlinedButton.icon(
              onPressed: onManage,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.goldLight,
                side: const BorderSide(color: AppColors.gold),
                minimumSize: const Size(0, 44),
              ),
              icon: const Icon(AppIcons.settings, size: 18),
              label: Text(t.manage),
            ),
          ],
        ],
      ),
    );
  }
}

/// What the stores ask to say, at the end of the page.
class _FinePrint extends StatelessWidget {
  const _FinePrint({required this.lifetime});

  /// The lifetime plan is chosen: paid once, nothing renews.
  final bool lifetime;

  @override
  Widget build(BuildContext context) {
    final t = context.t.premium;

    return Column(
      children: [
        Text(
          t.cancelAnytime,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: _onNight,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          t.renews(
            store: defaultTargetPlatform == TargetPlatform.iOS
                ? 'App Store'
                : 'Google Play',
          ),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11.5,
            height: 1.35,
            color: _onNightMuted,
          ),
        ),
        if (lifetime) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            t.lifetimeNote,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              height: 1.4,
              color: AppColors.goldLight,
            ),
          ),
        ],
      ],
    );
  }
}

/// Fixed at the bottom: the trial, the golden button, then restore and the
/// legal links.
class _Footer extends ConsumerWidget {
  const _Footer({
    required this.active,
    required this.plan,
    required this.busy,
    required this.onBuy,
    required this.onRestore,
    required this.onClose,
  });

  final bool active;
  final PremiumPlan? plan;
  final bool busy;
  final VoidCallback? onBuy;
  final VoidCallback onRestore;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.premium;
    final plan = this.plan;
    final trial = switch ((plan?.trialDays, plan?.trialMonths)) {
      (final days?, _) => t.trialDays(n: days),
      (_, final months?) => t.trialMonths(n: months),
      _ => null,
    };

    Widget link(String label, VoidCallback? onTap) => TextButton(
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
          if (!active && plan != null && trial != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Text(
                t.trialThen(trial: trial, price: _periodPrice(context, plan)),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.goldLight,
                ),
              ),
            ),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              boxShadow: [
                if (active || onBuy != null)
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.3),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: FilledButton(
              onPressed: active ? onClose : (busy ? () {} : onBuy),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.ink,
                disabledBackgroundColor: Colors.white.withValues(alpha: 0.12),
                disabledForegroundColor: _onNightMuted,
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
              child: busy
                  ? const AppSpinner(
                      size: 22,
                      strokeWidth: 2.4,
                      color: AppColors.ink,
                    )
                  : Text(
                      active
                          ? context.t.common.close
                          : plan?.period == PremiumPeriod.lifetime
                          ? t.buyLifetime
                          : trial != null
                          ? t.startTrial
                          : t.subscribe,
                    ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          // one line in most languages, two when the words are long
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (!active) ...[
                link(t.restoreShort, busy ? null : onRestore),
                dot,
              ],
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
