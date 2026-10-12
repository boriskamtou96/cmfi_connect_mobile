import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../theme/app_motion.dart';

// The Material motion patterns (package:animations), with the app's durations
// and "reduce motion":
// - SharedAxisSwitcher: contents side by side (segmented tabs);
// - FadeThroughSwitcher: contents with no spatial link (a list, then results);
// - OpenPage: a button that opens a form grows into it, and back;
// - showAppDialog: dialogs fade and scale in.

/// Swaps contents that sit side by side (segmented tabs): the new one slides
/// in from the side of the tab tapped, the old one leaves towards the other.
class SharedAxisSwitcher extends HookWidget {
  const SharedAxisSwitcher({
    required this.index,
    required this.child,
    this.expand = true,
    super.key,
  });

  /// Position of [child] among its siblings: its key, and the direction.
  final int index;
  final Widget child;

  /// Fills the space given (a tab's page). false inside a scrolling list:
  /// as tall as the content.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final previous = usePrevious(index);
    final reverse = useRef(false);
    if (previous != null && previous != index) {
      reverse.value = index < previous;
    }

    return PageTransitionSwitcher(
      duration: AppMotion.of(context, AppMotion.slow),
      reverse: reverse.value,
      layoutBuilder: expand ? _fill : _wrap,
      transitionBuilder: (child, animation, secondaryAnimation) =>
          SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            fillColor: Colors.transparent,
            child: child,
          ),
      child: KeyedSubtree(key: ValueKey(index), child: child),
    );
  }
}

/// Swaps contents with no spatial link: the old one fades out, then the new
/// one fades in while growing slightly. [id] changes when the content does.
class FadeThroughSwitcher extends StatelessWidget {
  const FadeThroughSwitcher({required this.id, required this.child, super.key});

  final Object id;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: AppMotion.of(context, AppMotion.slow),
      layoutBuilder: _fill,
      transitionBuilder: (child, animation, secondaryAnimation) =>
          FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            fillColor: Colors.transparent,
            child: child,
          ),
      child: KeyedSubtree(key: ValueKey(id), child: child),
    );
  }
}

Widget _fill(List<Widget> entries) =>
    Stack(fit: StackFit.expand, children: entries);

Widget _wrap(List<Widget> entries) =>
    Stack(alignment: Alignment.topCenter, children: entries);

/// A button or row that opens a form by growing into it (Material container
/// transform); closing the form shrinks it back into the button, where the new
/// element appears. For forms only: a page reached from a list keeps the
/// platform transition and the iOS back swipe.
class OpenPage extends StatelessWidget {
  const OpenPage({
    required this.page,
    required this.builder,
    this.shape = const RoundedRectangleBorder(),
    this.color,
    super.key,
  });

  /// The form opened.
  final Widget page;

  /// The closed look: a button whose action is [open].
  final Widget Function(BuildContext context, VoidCallback open) builder;

  /// Shape and color of the closed element (the button's), so that the
  /// transform starts exactly from it.
  final ShapeBorder shape;
  final Color? color;

  static const _duration = Duration(milliseconds: 420);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OpenContainer<void>(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: AppMotion.of(context, _duration),
      closedElevation: 0,
      openElevation: 0,
      closedShape: shape,
      closedColor: color ?? theme.colorScheme.surface,
      openColor: theme.scaffoldBackgroundColor,
      middleColor: theme.scaffoldBackgroundColor,
      // the button inside opens it: its own ripple and accessibility
      tappable: false,
      closedBuilder: (context, open) => builder(context, open),
      openBuilder: (context, _) => page,
    );
  }
}

/// [showDialog] with the Material "fade" pattern: the dialog fades in while
/// growing from 80 %, and fades out.
Future<T?> showAppDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) => showModal<T>(
  context: context,
  configuration: FadeScaleTransitionConfiguration(
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: AppMotion.of(context, AppMotion.fast),
    reverseTransitionDuration: AppMotion.of(
      context,
      const Duration(milliseconds: 90),
    ),
  ),
  builder: builder,
);
