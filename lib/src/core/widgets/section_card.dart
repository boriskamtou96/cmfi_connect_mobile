import 'package:flutter/material.dart';

import '../theme/app_icons.dart';
import '../theme/app_spacing.dart';

/// White rounded card holding rows separated by thin lines.
class SectionCard extends StatelessWidget {
  const SectionCard({required this.children, this.header, super.key});

  /// Small uppercase title inside the card, above the first row.
  final String? header;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (header != null)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.lg,
                  14,
                  AppSpacing.lg,
                  6,
                ),
                child: SectionLabel(header!, padded: false),
              ),
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0 || header != null)
                Divider(
                  height: 1,
                  color: scheme.outlineVariant.withValues(alpha: 0.6),
                ),
              children[i],
            ],
          ],
        ),
      ),
    );
  }
}

/// "COMMUNAUTÉ", "STANDARDS"…: small uppercase group title.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {this.padded = true, super.key});

  final String text;
  final bool padded;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Padding(
        padding: padded
            ? const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xs,
                AppSpacing.xs,
                AppSpacing.xs,
                0,
              )
            : EdgeInsets.zero,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

/// Small grey "Bientôt" / status pill.
class StatusPill extends StatelessWidget {
  const StatusPill(this.text, {this.background, this.foreground, super.key});

  final String text;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: background ?? scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: foreground ?? scheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// Round avatar with the user's initials.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({required this.initials, this.size = 46, super.key});

  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        shape: BoxShape.circle,
      ),
      child: initials.isEmpty
          ? Icon(AppIcons.user, color: scheme.primary, size: size * 0.5)
          : Text(
              initials,
              style: TextStyle(
                fontSize: size * 0.34,
                fontWeight: FontWeight.w800,
                color: scheme.primary,
              ),
            ),
    );
  }
}
