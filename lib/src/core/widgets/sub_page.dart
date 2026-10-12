import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'app_back_button.dart';

/// Page pushed above the tabs: back chevron + title.
class SubPage extends StatelessWidget {
  const SubPage({
    required this.title,
    required this.child,
    this.bottom,
    this.actions = const [],
    super.key,
  });

  final String title;
  final Widget child;

  /// Icon buttons at the end of the title row.
  final List<Widget> actions;

  /// Pinned under the content (e.g. the main button of a form).
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: bottom == null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xs,
                AppSpacing.xs,
                AppSpacing.lg,
                0,
              ),
              child: Row(
                children: [
                  const AppBackButton(),
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontSize: 22),
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
      bottomNavigationBar: bottom == null
          ? null
          : SafeArea(top: false, child: bottom!),
    );
  }
}
