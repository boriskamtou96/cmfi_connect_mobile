import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../i18n/strings.g.dart';
import '../theme/app_spacing.dart';
import 'adaptive.dart';
import 'motion.dart';

/// Asks before an action: an iOS alert on iPhone, a Material dialog
/// elsewhere. true when confirmed, false when cancelled or dismissed.
/// [destructive] (delete, block, remove) paints the action red.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String confirmLabel,
  String? text,
  String? cancelLabel,
  bool destructive = false,
}) async {
  final cancel = cancelLabel ?? context.t.common.cancel;
  final content = text == null ? null : Text(text);

  final answer = context.isCupertino
      ? showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(title),
            content: content,
            actions: [
              // in bold, as Apple asks: the safe way out before a
              // destructive action, else the action itself
              CupertinoDialogAction(
                isDefaultAction: destructive,
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(cancel),
              ),
              CupertinoDialogAction(
                isDefaultAction: !destructive,
                isDestructiveAction: destructive,
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(confirmLabel),
              ),
            ],
          ),
        )
      : showAppDialog<bool>(
          context: context,
          builder: (context) {
            final scheme = Theme.of(context).colorScheme;
            return AlertDialog(
              title: Text(title),
              content: content,
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(cancel),
                ),
                FilledButton(
                  style: destructive
                      ? FilledButton.styleFrom(
                          backgroundColor: scheme.error,
                          foregroundColor: scheme.onError,
                        )
                      : null,
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(confirmLabel),
                ),
              ],
            );
          },
        );
  return await answer ?? false;
}

/// Asks for a short text (a number of proclamations…): an iOS alert with a
/// field on iPhone, a Material dialog elsewhere. The text typed, or null
/// when cancelled.
Future<String?> showInputDialog(
  BuildContext context, {
  required String title,
  required String label,
  required String confirmLabel,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
  bool obscureText = false,
}) {
  Widget dialog(BuildContext context) => _InputDialog(
    title: title,
    label: label,
    confirmLabel: confirmLabel,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters,
    obscureText: obscureText,
  );

  return context.isCupertino
      ? showCupertinoDialog<String>(context: context, builder: dialog)
      : showAppDialog<String>(context: context, builder: dialog);
}

class _InputDialog extends HookWidget {
  const _InputDialog({
    required this.title,
    required this.label,
    required this.confirmLabel,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
  });

  final String title;
  final String label;
  final String confirmLabel;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  /// A password: the letters typed show as dots.
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    // lives as long as the dialog, its closing animation included
    final controller = useTextEditingController();
    final cancelLabel = context.t.common.cancel;
    void cancel() => Navigator.of(context).pop();
    void submit() => Navigator.of(context).pop(controller.text);

    if (context.isCupertino) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.md),
          child: CupertinoTextField(
            controller: controller,
            autofocus: true,
            placeholder: label,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            onSubmitted: (_) => submit(),
          ),
        ),
        actions: [
          CupertinoDialogAction(onPressed: cancel, child: Text(cancelLabel)),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: submit,
            child: Text(confirmLabel),
          ),
        ],
      );
    }
    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        decoration: InputDecoration(labelText: label),
        onSubmitted: (_) => submit(),
      ),
      actions: [
        TextButton(onPressed: cancel, child: Text(cancelLabel)),
        FilledButton(onPressed: submit, child: Text(confirmLabel)),
      ],
    );
  }
}
