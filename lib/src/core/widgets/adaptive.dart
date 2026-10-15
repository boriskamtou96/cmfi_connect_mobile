import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// On iPhone the app draws the iOS widgets (dialogs, action sheets, pickers,
// switches, spinners); the rest stays Material. The platform comes from the
// theme, never from dart:io, so that a test can switch it.

extension AdaptiveContext on BuildContext {
  /// True on iPhone, iPad and Mac: the iOS widgets are used here.
  bool get isCupertino => switch (Theme.of(this).platform) {
    TargetPlatform.iOS || TargetPlatform.macOS => true,
    TargetPlatform.android ||
    TargetPlatform.fuchsia ||
    TargetPlatform.linux ||
    TargetPlatform.windows => false,
  };
}

/// The spinner of an action in progress (a button that saves, a sending):
/// the Material ring on Android, the iOS activity indicator on iPhone.
/// [CircularProgressIndicator.adaptive] has no color, needed on a button.
class AppSpinner extends StatelessWidget {
  const AppSpinner({this.size, this.color, this.strokeWidth, super.key});

  /// Width and height; null: the platform's own size.
  final double? size;
  final Color? color;

  /// Thickness of the Material ring (the iOS one is made of ticks).
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    final size = this.size;
    final spinner = context.isCupertino
        ? CupertinoActivityIndicator(
            color: color,
            radius: size == null ? 10 : size / 2,
          )
        : CircularProgressIndicator(color: color, strokeWidth: strokeWidth);
    return size == null
        ? spinner
        : SizedBox.square(dimension: size, child: spinner);
  }
}
