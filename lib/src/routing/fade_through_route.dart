import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_motion.dart';

/// Route of the root flows: launch, presentation, welcome, the app, and the
/// church step after sign-up. These screens replace the whole stack
/// (`replaceAll`) instead of going deeper, so rather than the platform slide
/// they fade through: the screen below fades out (over a plain color), then
/// this one fades in with a slight zoom.
///
/// A regular page pushed above a root screen (items, authorities…) keeps its
/// platform transition and back swipe; on iOS the root screen moves aside with
/// the usual parallax. With [root] false (the church form opened from "Plus"),
/// this route is itself such a regular page.
class FadeThroughRoute<T> extends PageRoute<T> {
  FadeThroughRoute({
    required AutoRoutePage<T> page,
    this.root = true,
    this.fill,
  }) : super(settings: page, allowSnapshotting: page.allowSnapshotting);

  /// For `CustomRoute.customRouteBuilder`.
  static Route<T> builder<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) => FadeThroughRoute<T>(page: page);

  /// Same, for the dark blue splash: it fades to dark blue.
  static Route<T> darkBuilder<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) => FadeThroughRoute<T>(page: page, fill: AppColors.primaryDeep);

  /// False: a regular page with the platform transition.
  final bool root;

  /// Shown while the content fades out. Defaults to the scaffold background.
  final Color? fill;

  AutoRoutePage<T> get _page => settings as AutoRoutePage<T>;

  /// The screen above is a root screen replacing this one (else a pushed page).
  bool _replacedByRoot = false;

  static bool get _cupertino =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;

  PageTransitionsBuilder get _platformTransitions {
    final theme = Theme.of(navigator!.context);
    return theme.pageTransitionsTheme.builders[theme.platform] ??
        const ZoomPageTransitionsBuilder();
  }

  @override
  Duration get transitionDuration =>
      root ? AppMotion.slow : _platformTransitions.transitionDuration;

  @override
  Duration get reverseTransitionDuration =>
      root ? AppMotion.slow : _platformTransitions.reverseTransitionDuration;

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get opaque => _page.opaque;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';

  /// Any other page below (a sign-in form…) fades out the same way.
  @override
  DelegatedTransitionBuilder? get delegatedTransition =>
      root ? _fadeOutBelow : null;

  @override
  void install() {
    super.install();
    // like auto_route's own routes (guards wait for the end of the transition)
    _page.routeData.setAnimation(animation);
  }

  @override
  void didChangeNext(Route<dynamic>? nextRoute) {
    _replacedByRoot = nextRoute is FadeThroughRoute && nextRoute.root;
    super.didChangeNext(nextRoute);
  }

  @override
  void didPopNext(Route<dynamic> nextRoute) {
    _replacedByRoot = false;
    super.didPopNext(nextRoute);
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Semantics(
      scopesRoute: true,
      explicitChildNodes: true,
      child: _page.buildPage(context),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (!root) {
      return Theme.of(context).pageTransitionsTheme.buildTransitions<T>(
        this,
        context,
        animation,
        secondaryAnimation,
        child,
      );
    }
    if (AppMotion.reduced(context)) {
      return child;
    }
    // rebuilt on every tick of either animation: plain values are enough
    return _FadeThrough(
      enter: animation.value,
      exit: _replacedByRoot ? secondaryAnimation.value : 0,
      parallax: !_replacedByRoot && _cupertino
          ? _parallax(secondaryAnimation)
          : 0,
      fill: fill ?? Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  /// The curve of the iOS page transition, linear while the finger drags.
  double _parallax(Animation<double> secondaryAnimation) {
    final value = secondaryAnimation.value;
    if (navigator?.userGestureInProgress ?? false) {
      return value;
    }
    return secondaryAnimation.status == AnimationStatus.reverse
        ? Curves.easeInToLinear.transform(value)
        : Curves.linearToEaseOut.transform(value);
  }

  static Widget? _fadeOutBelow(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    bool allowSnapshotting,
    Widget? child,
  ) {
    if (child == null || AppMotion.reduced(context)) {
      return child;
    }
    return _FadeThrough(
      enter: 1,
      exit: secondaryAnimation.value,
      parallax: 0,
      fill: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }
}

class _FadeThrough extends StatelessWidget {
  const _FadeThrough({
    required this.enter,
    required this.exit,
    required this.parallax,
    required this.fill,
    required this.child,
  });

  /// 0 → 1 while this screen comes in.
  final double enter;

  /// 0 → 1 while a root screen replaces this one.
  final double exit;

  /// 0 → 1 while a page is pushed above this one (iOS).
  final double parallax;

  final Color fill;
  final Widget child;

  // the old screen is gone after a third of the time, then the new one comes
  static const _fadeOut = Interval(0, 0.35, curve: Curves.easeIn);
  static const _fadeIn = Interval(0.3, 1, curve: Curves.easeOut);
  static const _zoomIn = Interval(0.3, 1, curve: AppMotion.emphasized);

  @override
  Widget build(BuildContext context) {
    final opacity = _fadeIn.transform(enter) * (1 - _fadeOut.transform(exit));
    final scale = 0.98 + 0.02 * _zoomIn.transform(enter);
    final towardsStart = Directionality.of(context) == TextDirection.ltr
        ? -1
        : 1;

    return DecoratedBox(
      decoration: exit > 0 ? BoxDecoration(color: fill) : const BoxDecoration(),
      child: FadeTransition(
        opacity: AlwaysStoppedAnimation(opacity),
        child: Transform.scale(
          scale: scale,
          child: FractionalTranslation(
            translation: Offset(towardsStart * parallax / 3, 0),
            child: child,
          ),
        ),
      ),
    );
  }
}
