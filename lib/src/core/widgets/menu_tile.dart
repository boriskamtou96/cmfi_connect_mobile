import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../theme/app_tones.dart';

/// The icon of a line of the profile, the settings or the menu: in a soft
/// square of its module's color.
class MenuIcon extends StatelessWidget {
  const MenuIcon(
    this.icon, {
    this.module = AppModule.reports,
    this.destructive = false,
    super.key,
  });

  final IconData icon;
  final AppModule module;

  /// In red (signing out).
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final tone = module.tone(context);
    final error = Theme.of(context).colorScheme.error;
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: destructive ? error.withValues(alpha: 0.12) : tone.soft,
        borderRadius: BorderRadius.circular(12),
      ),
      child: PhosphorIcon(
        icon,
        size: 20,
        color: destructive ? error : tone.onSoft,
      ),
    );
  }
}

/// A line of the profile, the settings or the menu: its icon, its name, a
/// detail under it, and what ends it ([trailing]: the chevron by default).
class MenuTile extends StatelessWidget {
  const MenuTile({
    required this.icon,
    required this.title,
    this.module = AppModule.reports,
    this.subtitle,
    this.subtitleStrong = false,
    this.trailing,
    this.onTap,
    this.destructive = false,
    super.key,
  });

  final IconData icon;
  final AppModule module;
  final String title;

  /// In red, without the chevron (signing out).
  final bool destructive;
  final String? subtitle;

  /// The detail asks for attention (requests, new reports): bold, in color.
  final bool subtitleStrong;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      leading: MenuIcon(icon, module: module, destructive: destructive),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: destructive ? scheme.error : null,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: subtitleStrong ? FontWeight.w700 : null,
                color: subtitleStrong
                    ? scheme.primary
                    : scheme.onSurfaceVariant,
              ),
            ),
      trailing:
          trailing ?? (destructive ? null : const Icon(AppIcons.chevronRight)),
      onTap: onTap,
    );
  }
}

/// A value at the end of a line ("Auto", "Français"), before the chevron.
class MenuValue extends StatelessWidget {
  const MenuValue(this.value, {super.key});

  final String value;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      const SizedBox(width: 4),
      const Icon(AppIcons.chevronRight),
    ],
  );
}

/// The badge of what is new (reports received, requests).
class MenuBadge extends StatelessWidget {
  const MenuBadge(this.count, {super.key});

  final int count;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        constraints: const BoxConstraints(minWidth: 22),
        height: 22,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(11),
        ),
        alignment: Alignment.center,
        child: Text(
          '$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      const SizedBox(width: 4),
      const Icon(AppIcons.chevronRight),
    ],
  );
}
