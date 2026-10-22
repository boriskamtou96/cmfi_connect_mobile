import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/app_update.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../../core/widgets/app_toast.dart';

/// "Nouvelle version disponible", once per version (SignedInTasks): the
/// word of the admins, or a default one. Plus keeps a button for later.
Future<void> offerUpdate(BuildContext context, WidgetRef ref) async {
  final update = ref.read(appUpdateProvider.notifier);
  final status = ref.read(appUpdateProvider).value;
  if (!update.toOffer() || status == null) {
    return;
  }
  // at once, before the dialog: never offered twice
  unawaited(update.offered());
  final t = context.t;
  final message = status.messageIn(
    TranslationProvider.of(context).locale.languageCode,
  );
  final accepted = await showConfirmDialog(
    context,
    title: t.update.availableTitle,
    text: message.isNotEmpty
        ? message
        : t.update.availableText(version: '${status.target}'),
    confirmLabel: t.update.update,
    cancelLabel: t.update.later,
  );
  if (accepted && context.mounted) {
    await startUpdate(context, ref);
  }
}

/// Google Play's update, or the store page; a toast when Google Play
/// downloads it in the background, or when nothing could be opened.
Future<void> startUpdate(BuildContext context, WidgetRef ref) async {
  final t = context.t;
  final toast = ref.read(toasterProvider).of(context);
  final started = await ref.read(appUpdateProvider.notifier).start();
  switch (started) {
    case UpdateStart.downloading:
      toast.info(t.update.downloading);
    case UpdateStart.failed:
      toast.error(t.update.failed);
    case UpdateStart.started:
      break;
  }
}

/// Google Play downloaded the update: installed now (the app restarts) or,
/// "Plus tard", as soon as the app is left.
Future<void> offerInstall(BuildContext context, WidgetRef ref) async {
  final t = context.t;
  final installer = ref.read(appInstallerProvider);
  final now = await showConfirmDialog(
    context,
    title: t.update.readyTitle,
    text: t.update.readyText,
    confirmLabel: t.update.restart,
    cancelLabel: t.update.later,
  );
  if (now) {
    await installer.install();
    return;
  }
  late final AppLifecycleListener listener;
  listener = AppLifecycleListener(
    onHide: () {
      listener.dispose();
      unawaited(installer.install());
    },
  );
}
