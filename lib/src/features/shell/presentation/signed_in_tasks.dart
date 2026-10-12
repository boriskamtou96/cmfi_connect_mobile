import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/services/local_notifications.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../routing/app_router.dart';
import '../../events/application/event_reminders.dart';
import '../../prayer/application/importunities.dart';
import '../../prayer/application/retreat_reminders.dart';
import '../../prayer/application/retreats.dart';
import '../../prayer/domain/prayer.dart';
import '../../reports/application/pending_reports.dart';
import '../../reports/application/report_reminder.dart';
import '../../reports/application/reports_providers.dart';

/// What runs while the user is signed in: the days, retreats and
/// proclamations kept offline are sent, the reminders are planned again, and
/// a tapped reminder opens the day (or the event, or the retreat it is about).
class SignedInTasks extends HookConsumerWidget {
  const SignedInTasks({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plannedOn = useRef<DateTime?>(null);

    useEffect(() {
      final pending = ref.read(pendingReportsProvider.notifier);
      final reminder = ref.read(reportReminderProvider.notifier);
      final notifications = ref.read(localNotificationsProvider);

      void openToday() {
        if (!context.mounted) {
          return;
        }
        ref
            .read(selectedReportsViewProvider.notifier)
            .select(ReportsView.today);
        ref.read(selectedReportDayProvider.notifier).select(today());
        context.navigateTo(const ReportsRoute());
      }

      void openEvent(int id) {
        if (context.mounted) {
          context.router.push(EventRoute(eventId: id));
        }
      }

      void openRetreat(RetreatMoment moment) {
        if (context.mounted) {
          context.router.push(RetreatRoute(moment: moment));
        }
      }

      void open(String? payload) {
        final eventId = eventIdOf(payload);
        final retreat = retreatOf(payload);
        if (payload == ReportReminder.payload) {
          openToday();
        } else if (eventId != null) {
          openEvent(eventId);
        } else if (retreat != null) {
          openRetreat(retreat);
        }
      }

      void plan() {
        plannedOn.value = today();
        unawaited(reminder.reschedule());
        unawaited(ref.read(retreatRemindersProvider.notifier).reschedule());
      }

      // what was prayed without network
      void sendPrayer() {
        unawaited(ref.read(retreatLogProvider.notifier).sendPending());
        unawaited(ref.read(importunitiesProvider.notifier).sendCounts());
      }

      unawaited(pending.send());
      sendPrayer();
      plan();
      unawaited(notifications.takeLaunchPayload().then(open));

      final taps = notifications.taps.listen(open);
      final lifecycle = AppLifecycleListener(
        onResume: () {
          unawaited(pending.send());
          sendPrayer();
          // a new day: the reminders reach two weeks ahead again
          if (plannedOn.value != today()) {
            plan();
          }
        },
      );
      return () {
        unawaited(taps.cancel());
        lifecycle.dispose();
      };
    }, const []);

    return child;
  }
}
