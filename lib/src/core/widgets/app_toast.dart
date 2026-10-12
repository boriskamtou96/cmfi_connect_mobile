import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:toastification/toastification.dart';

import '../theme/app_icons.dart';
import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';

part 'app_toast.g.dart';

enum ToastKind { error, success, info }

/// Shows short messages for one screen: get it before an `await`, like
/// ScaffoldMessenger.of(context), and use it after.
class ToastMessenger {
  const ToastMessenger(this._show);

  final void Function(ToastKind kind, String message) _show;

  void error(String message) => _show(ToastKind.error, message);

  void success(String message) => _show(ToastKind.success, message);

  void info(String message) => _show(ToastKind.info, message);
}

/// Messages that pop at the top of the screen, above pages, sheets and dialogs
/// (toastification): errors in red for 5 s, the rest 3 s. Swiped away, read out
/// by screen readers. Behind a provider: tests record them instead.
class Toaster {
  const Toaster();

  ToastMessenger of(BuildContext context) {
    final overlay = Overlay.of(context, rootOverlay: true);
    final scheme = Theme.of(context).colorScheme;
    final direction = Directionality.of(context);
    final view = View.of(context);
    final reduced = AppMotion.reduced(context);

    return ToastMessenger((kind, message) {
      final (background, foreground, icon) = switch (kind) {
        ToastKind.error => (
          scheme.errorContainer,
          scheme.onErrorContainer,
          AppIcons.error,
        ),
        ToastKind.success => (
          scheme.primaryContainer,
          scheme.onPrimaryContainer,
          AppIcons.checkCircle,
        ),
        ToastKind.info => (
          scheme.surfaceContainerHighest,
          scheme.onSurface,
          AppIcons.info,
        ),
      };

      toastification.show(
        overlayState: overlay,
        alignment: Alignment.topCenter,
        type: switch (kind) {
          ToastKind.error => ToastificationType.error,
          ToastKind.success => ToastificationType.success,
          ToastKind.info => ToastificationType.info,
        },
        // "flat" keeps the given colors (flatColored lightens them: unreadable in dark)
        style: ToastificationStyle.flat,
        autoCloseDuration: Duration(seconds: kind == ToastKind.error ? 5 : 3),
        animationDuration: reduced ? const Duration(milliseconds: 1) : null,
        title: Text(
          message,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 14,
            height: 1.35,
            fontWeight: FontWeight.w600,
            color: foreground,
          ),
        ),
        // a small pop of the icon draws the eye to the message
        icon: reduced
            ? Icon(icon, color: foreground)
            : Icon(icon, color: foreground).animate().scale(
                begin: const Offset(0.5, 0.5),
                duration: AppMotion.medium,
                curve: AppMotion.pop,
              ),
        primaryColor: foreground,
        backgroundColor: background,
        foregroundColor: foreground,
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 24,
            spreadRadius: -4,
            offset: Offset(0, 8),
          ),
        ],
        showProgressBar: false,
        closeButton: const ToastCloseButton(showType: CloseButtonShowType.none),
        dragToClose: true,
        closeOnClick: true,
      );
      unawaited(SemanticsService.sendAnnouncement(view, message, direction));
    });
  }
}

@Riverpod(keepAlive: true)
Toaster toaster(Ref ref) => const Toaster();
