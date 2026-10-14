import 'package:flutter/widgets.dart';

/// Durations and curves of the app's animations: short, soft, never looping.
abstract final class AppMotion {
  /// Small state changes: a chip, a color, a check mark.
  static const fast = Duration(milliseconds: 180);

  /// Content changing in place: counters, switchers, tabs.
  static const medium = Duration(milliseconds: 260);

  /// Entrances, progress bars and route transitions.
  static const slow = Duration(milliseconds: 380);

  /// A one-shot celebration (a streak milestone): a burst of light, once.
  static const celebration = Duration(milliseconds: 1100);

  /// Delay between two items of a staggered entrance.
  static const stagger = Duration(milliseconds: 50);

  /// Default curve: quick start, soft landing.
  static const standard = Curves.easeOutCubic;

  /// Entrances and routes: decelerates strongly (Material 3 "emphasized decelerate").
  static const emphasized = Cubic(0.05, 0.7, 0.1, 1);

  /// Small overshoot, for things that pop in (check marks).
  static const pop = Curves.easeOutBack;

  /// The system asks to reduce motion: show end states directly.
  static bool reduced(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  /// [duration], or zero when motion is reduced.
  static Duration of(BuildContext context, Duration duration) =>
      reduced(context) ? Duration.zero : duration;
}
