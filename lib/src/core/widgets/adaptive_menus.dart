import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../i18n/strings.g.dart';
import '../theme/app_icons.dart';
import '../theme/app_spacing.dart';
import 'adaptive.dart';

/// One choice of an action sheet or of a "⋮" menu.
class AdaptiveAction<T> {
  const AdaptiveAction({
    required this.value,
    required this.label,
    this.icon,
    this.destructive = false,
    this.selected = false,
  });

  final T value;
  final String label;

  /// Android only: the iOS sheets show words alone.
  final IconData? icon;

  /// Deletes, removes or blocks: in red.
  final bool destructive;

  /// The current choice (a role, a book, a language): marked.
  final bool selected;
}

/// Offers a few actions: an iOS action sheet (with Cancel) on iPhone, a
/// bottom sheet of rows elsewhere. The value of the action chosen, or null.
Future<T?> showActionSheet<T>(
  BuildContext context, {
  required List<AdaptiveAction<T>> actions,
  String? title,
  String? message,
  String? cancelLabel,
}) {
  if (context.isCupertino) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: title == null ? null : Text(title),
        message: message == null ? null : Text(message),
        actions: [
          for (final action in actions)
            CupertinoActionSheetAction(
              isDefaultAction: action.selected,
              isDestructiveAction: action.destructive,
              onPressed: () => Navigator.of(context).pop(action.value),
              child: action.selected
                  ? _Checked(action.label)
                  : Text(action.label),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(cancelLabel ?? context.t.common.cancel),
        ),
      ),
    );
  }
  return showModalBottomSheet<T>(
    context: context,
    useSafeArea: true,
    builder: (context) =>
        _ActionList(title: title, message: message, actions: actions),
  );
}

/// A "⋮" (or [child]) that opens [actions]: a Material popup menu on
/// Android, an iOS action sheet on iPhone. The [tooltip] is the same on both:
/// screen readers and tests find the button by it.
class AdaptiveMenuButton<T> extends StatelessWidget {
  const AdaptiveMenuButton({
    required this.actions,
    required this.onSelected,
    this.icon = const Icon(AppIcons.moreOptions),
    this.tooltip,
    this.title,
    this.style,
    this.child,
    super.key,
  });

  final List<AdaptiveAction<T>> actions;
  final ValueChanged<T> onSelected;
  final Widget icon;

  /// The platform's "Show menu" when null.
  final String? tooltip;

  /// Above the actions of the iOS sheet.
  final String? title;
  final ButtonStyle? style;

  /// Opens the menu in place of the icon (a role pill).
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final tooltip =
        this.tooltip ?? MaterialLocalizations.of(context).showMenuTooltip;
    final child = this.child;

    if (!context.isCupertino) {
      return PopupMenuButton<T>(
        tooltip: tooltip,
        icon: child == null ? icon : null,
        style: style,
        initialValue: actions
            .where((action) => action.selected)
            .firstOrNull
            ?.value,
        onSelected: onSelected,
        itemBuilder: (context) => [
          for (final action in actions)
            PopupMenuItem(value: action.value, child: _MenuRow(action)),
        ],
        child: child,
      );
    }

    Future<void> open() async {
      final value = await showActionSheet<T>(
        context,
        title: title,
        actions: actions,
      );
      if (value != null && context.mounted) {
        onSelected(value);
      }
    }

    if (child != null) {
      return Tooltip(
        message: tooltip,
        child: InkWell(onTap: open, child: child),
      );
    }
    return IconButton(
      tooltip: tooltip,
      style: style,
      icon: icon,
      onPressed: open,
    );
  }
}

/// An item of the Material popup menu: the icon, then the words.
class _MenuRow extends StatelessWidget {
  const _MenuRow(this.action);

  final AdaptiveAction<Object?> action;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final icon = action.icon;
    final color = action.destructive ? scheme.error : null;
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: color ?? scheme.onSurfaceVariant),
          const SizedBox(width: AppSpacing.md),
        ],
        Flexible(
          child: Text(
            action.label,
            style: color == null ? null : TextStyle(color: color),
          ),
        ),
      ],
    );
  }
}

/// The current choice of an iOS action sheet: its words and a check, in the
/// color of the action.
class _Checked extends StatelessWidget {
  const _Checked(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Text(label)),
        const SizedBox(width: AppSpacing.sm),
        Icon(
          AppIcons.check,
          size: 20,
          color: DefaultTextStyle.of(context).style.color,
        ),
      ],
    );
  }
}

/// The Android action sheet: a title, a hint, then one row per action.
class _ActionList<T> extends StatelessWidget {
  const _ActionList({required this.actions, this.title, this.message});

  final List<AdaptiveAction<T>> actions;
  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final title = this.title;
    final message = this.message;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.xl,
                  0,
                  AppSpacing.xl,
                  AppSpacing.xs,
                ),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            if (message != null)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.xl,
                  0,
                  AppSpacing.xl,
                  AppSpacing.sm,
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 13,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            for (final action in actions)
              _ActionRow(
                action: action,
                onTap: () => Navigator.of(context).pop(action.value),
              ),
          ],
        ),
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({required this.action, required this.onTap});

  final AdaptiveAction<Object?> action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = action.destructive ? scheme.error : null;
    final icon = action.icon;
    return ListTile(
      leading: icon == null ? null : Icon(icon, color: color),
      title: Text(
        action.label,
        style: TextStyle(fontWeight: FontWeight.w600, color: color),
      ),
      trailing: action.selected
          ? Icon(AppIcons.check, color: scheme.primary)
          : null,
      selected: action.selected,
      onTap: onTap,
    );
  }
}
