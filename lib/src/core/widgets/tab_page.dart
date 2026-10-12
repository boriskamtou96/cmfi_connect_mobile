import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Page of a bottom tab: big title on the left, optional actions on the right.
class TabPage extends StatelessWidget {
  const TabPage({
    required this.title,
    required this.child,
    this.actions = const [],
    this.bottom,
    super.key,
  });

  final String title;
  final List<Widget> actions;
  final Widget child;

  /// Pinned under the content (e.g. the save bar of the report).
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                20,
                18,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  ...actions,
                ],
              ),
            ),
            Expanded(child: child),
          ],
        ),
      ),
      bottomNavigationBar: bottom,
    );
  }
}
