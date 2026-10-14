import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/app_shortcuts.dart';
import '../../../core/services/crash_reporting.dart';
import '../../../core/services/deep_links.dart';
import '../../../core/services/home_widgets.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/services/premium_store.dart';
import '../../../core/services/push_messaging.dart';
import '../../../core/session/session.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../routing/app_router.dart';
import '../../events/application/event_reminders.dart';
import '../../notifications/application/inbox.dart';
import '../../notifications/application/push_registration.dart';
import '../../prayer/application/importunities.dart';
import '../../prayer/application/retreat_reminders.dart';
import '../../prayer/application/retreats.dart';
import '../../prayer/domain/prayer.dart';
import '../../prayer/presentation/prayer_screen.dart';
import '../../reports/application/pending_reports.dart';
import '../../reports/application/report_reminder.dart';
import '../../reports/application/report_sending.dart';
import '../../reports/application/reports_providers.dart';
import '../../reports/application/today_widget.dart';
import '../../reports/domain/report_sending.dart';

/// What runs while the user is signed in: the days, retreats and
/// proclamations kept offline are sent, the reminders are planned again, and
/// a tapped reminder opens the day (or the event, or the retreat it is about).
/// The phone receives the notifications of the admins: a touched push opens
/// it, one arriving while the app is open pops up. The shortcuts of the app
/// icon are set (in the app language) and open what they say. A link
/// (cmfi-connect.com/open?to=…) opens its event, hymn or prayer topic.
class SignedInTasks extends HookConsumerWidget {
  const SignedInTasks({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plannedOn = useRef<DateTime?>(null);
    final language = TranslationProvider.of(context).locale;

    // the shortcuts of the app icon, set again when the language changes
    // (App clears them at sign-out)
    useEffect(() {
      final t = language.buildSync();
      unawaited(
        ref.read(appShortcutsProvider).show({
          AppShortcut.today: t.shortcuts.today,
          AppShortcut.hymns: t.shortcuts.hymns,
          AppShortcut.retreat: t.shortcuts.retreat,
        }),
      );
      return null;
    }, [language]);

    // the home-screen widget follows the day as it is filled in
    useEffect(() {
      final subscription = ref.listenManual(todayWidgetProvider, (_, data) {
        // signing out: App has emptied the widget, nothing comes back in it
        final signedIn =
            ref.read(sessionProvider).value == SessionStatus.authenticated;
        if (data != null && signedIn) {
          unawaited(ref.read(homeWidgetsProvider).show(data));
        }
      }, fireImmediately: true);
      return subscription.close;
    }, const []);

    useEffect(() {
      final pending = ref.read(pendingReportsProvider.notifier);
      final reminder = ref.read(reportReminderProvider.notifier);
      final notifications = ref.read(localNotificationsProvider);
      final push = ref.read(pushMessagingProvider);
      final homeWidgets = ref.read(homeWidgetsProvider);
      final toast = ref.read(toasterProvider);

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
        final sendDay = sendingDayOf(payload);
        if (payload == ReportReminder.payload) {
          openToday();
        } else if (sendDay != null && context.mounted) {
          context.router.push(ReportSendRoute(day: sendDay.toApiDate()));
        } else if (eventId != null) {
          openEvent(eventId);
        } else if (retreat != null) {
          openRetreat(retreat);
        }
      }

      // a push touched: an announcement of the leaders, or an invitation to
      // pray for an importunity topic
      void openAnnouncement(Map<String, String>? data) {
        final id = int.tryParse(data?['id'] ?? '');
        if (id == null) {
          return;
        }
        switch (data?['type']) {
          case 'announcement':
            ref.invalidate(inboxProvider);
            if (context.mounted) {
              context.router.push(NotificationRoute(notificationId: id));
            }
          case 'importunity_invite':
            ref.invalidate(importunitiesProvider);
            if (context.mounted) {
              context.router.push(ImportunityRoute(importunityId: id));
            }
        }
      }

      // the widgets: today's report (or the Premium page when it is locked),
      // or the verse of the day, on the home screen
      void openFromWidget(Uri? uri) {
        switch (uri?.host) {
          case 'today':
            openToday();
          case 'verse' when context.mounted:
            context.navigateTo(const HomeRoute());
          case 'premium' when context.mounted:
            context.router.push(const PremiumRoute());
        }
      }

      // a shortcut of the app icon: today's report, the hymns, or the retreat
      // of the moment (the Prayer tab once the four are done)
      Future<void> openShortcut(AppShortcut? shortcut) async {
        switch (shortcut) {
          case null:
            return;
          case AppShortcut.today:
            openToday();
          case AppShortcut.hymns:
            if (context.mounted) {
              context.navigateTo(const HymnsRoute());
            }
          case AppShortcut.retreat:
            // the retreats made today, as the server knows them
            await ref
                .read(retreatLogProvider.future)
                .then((_) {}, onError: (Object _) {});
            if (!context.mounted) {
              return;
            }
            final moment = nextRetreat(
              ref.read(retreatsTodayProvider),
              DateTime.now(),
            );
            if (moment == null) {
              context.navigateTo(const PrayerRoute());
            } else {
              unawaited(context.router.push(RetreatRoute(moment: moment)));
            }
        }
      }

      // a link: an event, a hymn, a prayer topic, the retreat of the moment
      void openLink(AppLink? link) {
        if (link == null || !context.mounted) {
          return;
        }
        ref.read(pendingDeepLinkProvider.notifier).clear();
        switch (link) {
          case EventLink(:final eventId):
            openEvent(eventId);
          case HymnLink(:final bookCode, :final number):
            unawaited(
              context.router.push(
                HymnReaderRoute(bookCode: bookCode, number: number),
              ),
            );
          case PrayerTopicLink(:final topicId):
            unawaited(context.router.push(PrayerTopicRoute(topicId: topicId)));
          case ImportunityLink(:final importunityId):
            // shared with the member: the topic is in the list now
            ref.invalidate(importunitiesProvider);
            unawaited(
              context.router.push(
                ImportunityRoute(importunityId: importunityId),
              ),
            );
          case RetreatLink():
            unawaited(openShortcut(AppShortcut.retreat));
        }
      }

      // Premium follows the account, from one phone to another; a crash says
      // which account it happened in (its number)
      Future<void> identifyPremium() async {
        final account = await ref.read(signedInAccountProvider.future);
        if (account == null || account.id == 0) {
          return;
        }
        unawaited(ref.read(crashReportingProvider).identify('${account.id}'));
        try {
          await ref.read(premiumStoreProvider).logIn('${account.id}');
        } on Object {
          // the store is unreachable: Premium stays as it was
        }
      }

      void plan() {
        plannedOn.value = today();
        unawaited(reminder.reschedule());
        unawaited(ref.read(retreatRemindersProvider.notifier).reschedule());
        unawaited(ref.read(reportSendingProvider.notifier).reschedule());
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
      unawaited(ref.read(pushRegistrationProvider.notifier).start());
      unawaited(identifyPremium());
      unawaited(push.takeLaunchData().then(openAnnouncement));
      unawaited(homeWidgets.takeLaunchUri().then(openFromWidget));
      final shortcuts = ref.read(appShortcutsProvider);
      final shortcutTaps = shortcuts.taps.listen(
        (shortcut) => unawaited(openShortcut(shortcut)),
      );
      unawaited(shortcuts.takeLaunchShortcut().then(openShortcut));

      // a link that opened the app (or came while signed out), then the next;
      // opened once the frame is built
      final links = ref.listenManual(
        pendingDeepLinkProvider,
        (_, link) => scheduleMicrotask(() => openLink(link)),
        fireImmediately: true,
      );

      final taps = notifications.taps.listen(open);
      final pushTaps = push.taps.listen(openAnnouncement);
      final widgetTaps = homeWidgets.clicks.listen(openFromWidget);
      final received = push.received.listen((message) {
        unawaited(ref.read(inboxProvider.notifier).refresh());
        if (message.data['type'] == 'importunity_invite') {
          ref.invalidate(importunitiesProvider);
        }
        if (context.mounted && message.title.isNotEmpty) {
          toast
              .of(context)
              .info(context.t.notifications.received(title: message.title));
        }
      });
      final lifecycle = AppLifecycleListener(
        onResume: () {
          unawaited(pending.send());
          unawaited(ref.read(inboxProvider.notifier).refresh());
          sendPrayer();
          // a new day: the reminders reach two weeks ahead again
          if (plannedOn.value != today()) {
            plan();
          }
        },
      );
      return () {
        unawaited(taps.cancel());
        unawaited(pushTaps.cancel());
        unawaited(widgetTaps.cancel());
        unawaited(shortcutTaps.cancel());
        unawaited(received.cancel());
        lifecycle.dispose();
        links.close();
      };
    }, const []);

    return child;
  }
}
