import 'package:flutter/material.dart';

import '../../../core/theme/app_icons.dart';
import '../domain/payment.dart';

/// The logo of a mobile money operator (MTN, Orange), a rounded square; a
/// phone for the others.
class OperatorLogo extends StatelessWidget {
  const OperatorLogo({required this.provider, this.size = 32, super.key});

  final String provider;
  final double size;

  @override
  Widget build(BuildContext context) {
    final logo = operatorLogo(provider);
    final scheme = Theme.of(context).colorScheme;
    final icon = provider == cardProvider ? AppIcons.card : AppIcons.phone;
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.24),
      child: SizedBox.square(
        dimension: size,
        child: logo == null
            ? ColoredBox(
                color: scheme.surfaceContainerHighest,
                child: Icon(
                  icon,
                  size: size * 0.55,
                  color: scheme.onSurfaceVariant,
                ),
              )
            : Image.asset(logo, fit: BoxFit.cover),
      ),
    );
  }
}

/// An operator to pick: its logo and its name, outlined when chosen.
class OperatorChoice extends StatelessWidget {
  const OperatorChoice({
    required this.provider,
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String provider;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? scheme.primaryContainer : scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(
            color: selected ? scheme.primary : scheme.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 14, 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OperatorLogo(provider: provider, size: 32),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? scheme.onPrimaryContainer : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
