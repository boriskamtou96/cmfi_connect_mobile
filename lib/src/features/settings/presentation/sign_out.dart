import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/premium_store.dart';
import '../../../core/session/session.dart';
import '../../../core/widgets/adaptive_dialogs.dart';
import '../../notifications/application/push_registration.dart';
import '../../reports/application/pending_reports.dart';

/// Signs out, from Réglages or the menu: days saved offline would be lost,
/// so it asks first. App listens to the session and goes back to the
/// welcome screen.
Future<void> signOut(BuildContext context, WidgetRef ref) async {
  final t = context.t;
  final pending = ref.read(pendingReportsProvider).length;
  if (pending > 0) {
    final confirmed = await showConfirmDialog(
      context,
      title: t.more.logoutPendingTitle,
      text: t.more.logoutPendingText(n: pending),
      confirmLabel: t.more.logoutAnyway,
      destructive: true,
    );
    if (!confirmed) {
      return;
    }
  }
  // while the session lasts: the server forgets this phone
  await ref.read(pushRegistrationProvider.notifier).stop();
  await ref.read(premiumStoreProvider).logOut();
  await ref.read(sessionProvider.notifier).signOut();
}
