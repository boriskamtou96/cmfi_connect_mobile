import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../i18n/strings.g.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_motion.dart';
import '../../theme/app_spacing.dart';
import 'seen_tours.dart';
import 'tour_bubble.dart';
import 'tour_look.dart';
import 'tour_step.dart';

export 'tour_step.dart';

/// The first time the member arrives in a space, the space presents itself:
/// its key elements lit one after the other (paquet showcaseview), each with
/// a bubble that says what it does (23/11/2026). Once per space and per
/// phone ([SeenTours]); « Réglages › Revoir la présentation des espaces »
/// shows them again.
///
/// Wraps the screen of the space; its elements are wrapped in [TourTarget].
/// The tour waits until the screen is really in front (no page, sheet or
/// dialog above it, the tab shown) and its first element is drawn; it never
/// starts over another one.
class SpaceTour extends ConsumerStatefulWidget {
  const SpaceTour({
    required this.space,
    required this.child,
    this.active = true,
    super.key,
  });

  final TourSpace space;
  final Widget child;

  /// Whether the space is the one shown: a tab of the shell stays built
  /// (and animated) behind the others.
  final bool active;

  /// Off in the tests (`pumpApp`): a tour would cover the screens they tap.
  static bool enabled = true;

  static bool _registered = false;

  /// Registers the tours once, when the first space is drawn.
  static void _ensureRegistered() {
    if (_registered) return;
    _registered = true;
    ShowcaseView.register(
      enableAutoScroll: true,
      skipIfTargetNotPresent: true,
      // the bubble stays still: nothing loops in the app
      disableMovingAnimation: true,
      semanticEnable: true,
      onFinish: () => _running = null,
      onDismiss: (_) => _running = null,
    );
  }

  /// The steps of the tour on screen, to number the bubbles.
  static List<TourStep> get _steps => _running ?? const [];
  static List<TourStep>? _running;

  @override
  ConsumerState<SpaceTour> createState() => _SpaceTourState();
}

class _SpaceTourState extends ConsumerState<SpaceTour> {
  Timer? _retry;

  /// Two tries a second for a minute: the screen may wait for a dialog, a
  /// sheet or its data.
  int _tries = 0;

  /// The tries in a row with the app in front: a window of the system (the
  /// permission of the notifications, asked at sign-in) leaves the app
  /// inactive, and the tour waits a second after it closes.
  int _activeTries = 0;

  @override
  void initState() {
    super.initState();
    if (!SpaceTour.enabled) return;
    SpaceTour._ensureRegistered();
    _schedule(const Duration(milliseconds: 700));
  }

  @override
  void didUpdateWidget(SpaceTour oldWidget) {
    super.didUpdateWidget(oldWidget);
    // a tab shown again, while its tour is still to see
    if (SpaceTour.enabled && widget.active && !oldWidget.active) _again();
  }

  /// Tries again from the start (a tab shown again, the tours forgotten).
  void _again() {
    if (ref.read(seenToursProvider).contains(widget.space)) return;
    _tries = 0;
    _activeTries = 0;
    _schedule(const Duration(milliseconds: 700));
  }

  void _schedule(Duration after) {
    _retry?.cancel();
    _retry = Timer(after, _tryStart);
  }

  void _tryStart() {
    if (!mounted || !SpaceTour.enabled) return;
    if (ref.read(seenToursProvider).contains(widget.space)) return;
    if (++_tries > 120) return;

    final showcase = ShowcaseView.get();
    final route = ModalRoute.of(context);
    final lifecycle = WidgetsBinding.instance.lifecycleState;
    _activeTries = lifecycle == null || lifecycle == AppLifecycleState.resumed
        ? _activeTries + 1
        : 0;
    final inFront =
        _activeTries >= 2 &&
        widget.active &&
        (route?.isCurrent ?? true) &&
        !showcase.isShowcaseRunning;
    final steps = [
      for (final step in widget.space.steps)
        if (showcase.isTargetRendered(step.key)) step,
    ];
    // the first element (the space's own) tells the screen is drawn
    if (!inFront || steps.isEmpty || steps.first != widget.space.steps.first) {
      _schedule(const Duration(milliseconds: 500));
      return;
    }

    SpaceTour._running = steps;
    showcase.disableScaleAnimation = AppMotion.reduced(context);
    unawaited(ref.read(seenToursProvider.notifier).markSeen(widget.space));
    showcase.startShowCase([for (final step in steps) step.key]);
  }

  @override
  void dispose() {
    _retry?.cancel();
    // the screen goes (back button): its tour goes with it
    final running = SpaceTour._running;
    if (SpaceTour.enabled &&
        running != null &&
        running.first.space == widget.space) {
      ShowcaseView.get().dismiss();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // « Revoir la présentation des espaces »: the screens already built
    // present themselves again
    ref.listen(seenToursProvider, (_, seen) {
      if (SpaceTour.enabled && !seen.contains(widget.space)) _again();
    });
    return widget.child;
  }
}

/// An element of a space lit by its tour, with the bubble that says what it
/// does. Outside a tour, only [child].
class TourTarget extends StatelessWidget {
  const TourTarget({
    required this.step,
    required this.child,
    this.round = false,
    this.radius = AppRadius.lg,
    this.padding = const EdgeInsets.all(AppSpacing.xs + 2),
    super.key,
  });

  final TourStep step;
  final Widget child;

  /// A round button (an icon in a bar): a circle of light around it.
  final bool round;
  final double radius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (!SpaceTour.enabled) return child;
    SpaceTour._ensureRegistered();
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Showcase.withWidget(
      key: step.key,
      targetShapeBorder: round
          ? const CircleBorder()
          : RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      targetBorderRadius: round ? null : BorderRadius.circular(radius),
      targetPadding: padding,
      overlayColor: dark ? const Color(0xFF02060C) : AppColors.night,
      overlayOpacity: dark ? 0.78 : 0.72,
      disableMovingAnimation: true,
      toolTipMargin: AppSpacing.lg,
      targetTooltipGap: AppSpacing.md,
      container: Builder(
        builder: (context) {
          final t = context.t;
          final steps = SpaceTour._steps;
          final index = steps.indexOf(step);
          final look = TourLook.of(step, t);
          return TourBubble(
            space: look.space,
            icon: TourLook.iconOf(step.space),
            title: look.title,
            text: look.text,
            index: index < 0 ? 0 : index,
            count: steps.isEmpty ? 1 : steps.length,
            withDove: step.space == TourSpace.home && index == 0,
            onNext: () => ShowcaseView.get().next(force: true),
            onSkip: () => ShowcaseView.get().dismiss(),
          );
        },
      ),
      child: child,
    );
  }
}
