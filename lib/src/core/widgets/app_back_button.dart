import 'package:flutter/material.dart';

import '../theme/app_icons.dart';

/// Chevron back button of the design, 48 dp tap area.
class AppBackButton extends StatelessWidget {
  const AppBackButton({this.onPressed, super.key});

  /// Defaults to popping the current route.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      icon: const Icon(AppIcons.back, size: 30),
      onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
    );
  }
}
