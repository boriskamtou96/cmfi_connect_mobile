import 'package:flutter/material.dart';

/// The app's main button. While [isLoading] it shows a spinner and ignores taps,
/// so a request can't be sent twice.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            )
          : Text(label),
    );
  }
}
