import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/app_log.dart';
import '../../../core/services/app_shortcuts.dart';
import '../../../core/services/app_update.dart';
import '../../../core/services/crash_reporting.dart';
import '../../../core/services/deep_links.dart';
import '../../../core/services/home_widgets.dart';
import '../../../core/services/local_notifications.dart';
import '../../../core/services/premium_store.dart';
import '../../../core/services/push_messaging.dart';
import '../../../core/session/session.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../routing/app_router.dart';
import '../../authorities/application/authorities_controller.dart';
import '../../bible/application/bible_plan.dart';
import '../../bible/application/bible_position.dart';
import '../../bible/application/memory_verses.dart';
import '../../bible/domain/bible.dart';
import '../../disciples/application/disciples.dart';
import '../../disciples/application/received_reports.dart';
import '../../events/application/event_reminders.dart';
import '../../fasts/application/fasts.dart';
import '../../home/application/week_story.dart';
import '../../home/application/year_story.dart';
import '../../home/domain/week_story.dart';
import '../../home/domain/year_story.dart';
import '../../notifications/application/inbox.dart';
import '../../notifications/application/push_registration.dart';
import '../../prayer/application/importunities.dart';
import '../../prayer/application/prayer_topics.dart';
import '../../prayer/application/retreat_reminders.dart';
import '../../prayer/application/retreats.dart';
import '../../prayer/domain/prayer.dart';
import '../../prayer/presentation/prayer_screen.dart';
import '../../prayer/presentation/widgets/topic_row.dart';
import '../../reports/application/in_app_sendings.dart';
import '../../reports/application/pending_reports.dart';
import '../../reports/application/report_reminder.dart';
import '../../reports/application/report_sending.dart';
import '../../reports/application/report_timer.dart';
import '../../reports/application/reports_providers.dart';
import '../../reports/application/today_widget.dart';
import '../../reports/domain/report_sending.dart';
import '../../seek_first/application/seek_first.dart';
import '../../souls/application/souls.dart';
import '../../teachings/application/now_playing.dart';
import '../../update/presentation/update_prompts.dart';
import '../../verses/application/verse_of_the_day.dart';
import '../../verses/domain/verse.dart';

/// What runs while the user is signed in: the days, retreats and
/// proclamations kept offline are sent, the reminders are planned again, and
/// a tapped reminder opens the day (or the event, or the retreat it is about).
/// The phone receives the notifications of the admins: a touched push opens
/// it, one arriving while the app is open pops up. The shortcuts of the app
/// icon are set (in the app language) and open what they say. A link
/// (cmfi-connect.com/open?to=…) opens its event, hymn, prayer topic or
/// Bible verse. A new version of the app is offered once (Firebase Remote
/// Config), and the one Google Play downloaded is installed when asked.
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
      // Cherche d'abord Dieu: the phone gets the settings again, and what a
      // closed app says in this language
      unawaited(ref.read(seekFirstProvider.notifier).sync());
      return null;
    }, [language]);

    // Cherche d'abord Dieu: signing out opens every app, the settings go
    useEffect(() {
      final subscription = ref.listenManual(sessionProvider, (_, next) {
        if (next.value == SessionStatus.unauthenticated) {
          unawaited(ref.read(seekFirstProvider.notifier).forget());
          // the reading plan was the account's
          unawaited(ref.read(biblePlanProvider.notifier).stop());
          // the verses and the souls stay on the phone, their reminders go;
          // the teaching heard stops
          unawaited(ref.read(memoryVersesProvider.notifier).forget());
          unawaited(ref.read(soulsProvider.notifier).forget());
          unawaited(ref.read(nowPlayingProvider.notifier).stop());
          // the fasts were the account's
          unawaited(ref.read(fastsProvider.notifier).forget());
          // and its stopwatch
          unawaited(ref.read(reportTimerProvider.notifier).discard());
        }
      });
      return subscription.close;
    }, const []);

    // the home-screen widget follows the day as it is filled in
    useEffect(() {
      final subscription = ref.listenManual(todayWidgetProvider, (_, data) {
        // signing out: App has emptied the widget, nothing comes back in it
        final signedIn =
            ref.read(sessionProvider).value == SessionStatus.authenticated;
        if (data != null && signedIn) {
          unawaited(ref.read(homeWidgetsProvider).show(data));
          // the day is saved (or waits to be sent): the closed apps open
          if ((data.done, data.day) case (true, final day?)) {
            unawaited(ref.read(seekFirstProvider.notifier).reportSaved(day));
          }
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

      // a tab, above which nothing stays (Plus, a hymn read)
      void showTab(PageRouteInfo tab) {
        if (!context.mounted) {
          return;
        }
        context.router.root.popUntilRouteWithName(AppShellRoute.name);
        context.navigateTo(tab);
      }

      void openToday() {
        if (!context.mounted) {
          return;
        }
        ref
            .read(selectedReportsViewProvider.notifier)
            .select(ReportsView.today);
        ref.read(selectedReportDayProvider.notifier).select(today());
        showTab(const ReportsRoute());
      }

      // the Bible tab, on [place] (its verse lit)
      Future<void> openBible(BibleRef? place) async {
        if (place != null) {
          await ref.read(bibleFocusProvider.notifier).show(place);
        }
        showTab(const BibleRoute());
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
        final week = weekStoryOf(payload);
        final year = yearStoryOf(payload);
        if (payload == ReportReminder.payload) {
          openToday();
        } else if (payload == BiblePlan.payload && context.mounted) {
          context.router.push(const BiblePlanRoute());
        } else if (payload == MemoryVerses.payload && context.mounted) {
          context.router.push(MemoryReviewRoute());
        } else if (payload == Souls.payload && context.mounted) {
          context.router.push(const SoulsRoute());
        } else if (payload == Fasts.payload && context.mounted) {
          context.router.push(const FastsRoute());
        } else if (week != null && context.mounted) {
          context.router.push(WeekStoryRoute(monday: week.toApiDate()));
        } else if (year != null && context.mounted) {
          context.router.push(YearStoryRoute(year: year));
        } else if (sendDay != null && context.mounted) {
          context.router.push(ReportSendRoute(day: sendDay.toApiDate()));
        } else if (eventId != null) {
          openEvent(eventId);
        } else if (retreat != null) {
          openRetreat(retreat);
        }
      }

      // a push touched: an announcement of the leaders, an invitation to
      // pray for an importunity topic, a report a disciple sent in the app,
      // the answer of an authority to the user's, or a new content of the
      // community (a teaching, a document, an event, a prayer topic: their
      // page, the new one first)
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
          case 'report_sending':
            ref.invalidate(receivedReportsProvider);
            if (context.mounted) {
              context.router.push(const ReceivedReportsRoute());
            }
          case 'report_reply':
            ref.invalidate(sentInAppProvider);
            if (context.mounted) {
              context.router.push(const ReportSendingRoute());
            }
          // asked to accompany someone, a request accepted
          case 'authority_request' || 'authority_accepted':
            ref
              ..invalidate(authorityRequestsProvider)
              ..invalidate(authoritiesControllerProvider);
            if (context.mounted) {
              context.router.push(const AuthoritiesRoute());
            }
          // chosen as disciple maker
          case 'disciple_maker_chosen':
            ref.invalidate(disciplesListProvider);
            if (context.mounted) {
              context.router.push(const DisciplesRoute());
            }
          // Premium offered by the admins: shown at once
          case 'premium_gift':
            unawaited(ref.read(premiumStoreProvider).refresh());
            if (context.mounted) {
              context.router.push(const PremiumRoute());
            }
          case 'teaching' when context.mounted:
            context.router.push(const TeachingsRoute());
          case 'document' when context.mounted:
            context.router.push(const DocumentsRoute());
          case 'event':
            openEvent(id);
          case 'prayer_topic':
            ref.invalidate(prayerTopicsProvider);
            if (context.mounted) {
              context.router.push(const PrayerTopicsRoute());
            }
        }
      }

      // a notification of the phone touched: the app's own, or a push shown
      // while the app was open (Android)
      void openPayload(String? payload) {
        if (LocalNotifications.pushDataOf(payload) case final data?) {
          openAnnouncement(data);
        } else {
          open(payload);
        }
      }

      // the widgets: today's report (or the Premium page when it is locked),
      // or the verse of the day, on the home screen
      Future<void> openFromWidget(Uri? uri) async {
        switch (uri?.host) {
          case 'today':
            openToday();
          case 'verse':
            // today's verse, in the Bible
            final verse = await ref
                .read(verseOfTheDayProvider.future)
                .then<Verse?>((verse) => verse, onError: (Object _) => null);
            if (BibleRef.parse(verse?.osis) case final place?) {
              await openBible(place);
            } else {
              showTab(const HomeRoute());
            }
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
            showTab(const HymnsRoute());
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
              showTab(const PrayerRoute());
            } else {
              unawaited(context.router.push(RetreatRoute(moment: moment)));
            }
        }
      }

      // a topic of the community (a link shared before the topics were only
      // their PDF): the list of the topics, then its PDF
      Future<void> openTopic(int id) async {
        if (!context.mounted) {
          return;
        }
        unawaited(context.router.push(const PrayerTopicsRoute()));
        final topics = await ref
            .read(prayerTopicsProvider.future)
            .then<List<PrayerTopic>>(
              (topics) => topics,
              onError: (Object _) => const [],
            );
        final topic = topics.where((topic) => topic.id == id).firstOrNull;
        if (topic?.document case final document?) {
          await openPrayerDocument(ref, document);
        }
      }

      // a link: an event, a hymn, a prayer topic, the retreat of the moment,
      // today's report
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
            unawaited(openTopic(topicId));
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
          case TodayLink():
            unawaited(openShortcut(AppShortcut.today));
          case BibleLink(:final reference):
            unawaited(openBible(BibleRef.parse(reference)));
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
        } on Object catch (error) {
          // the store is unreachable: Premium stays as it was
          AppLog.info('premium: store unreachable ($error)');
        }
      }

      void plan() {
        plannedOn.value = today();
        unawaited(reminder.reschedule());
        unawaited(ref.read(retreatRemindersProvider.notifier).reschedule());
        unawaited(ref.read(reportSendingProvider.notifier).reschedule());
        unawaited(ref.read(biblePlanProvider.notifier).reschedule());
        unawaited(ref.read(memoryVersesProvider.notifier).reschedule());
        // the days of fasting kept go to the report
        unawaited(
          ref
              .read(fastsProvider.notifier)
              .catchUp()
              .then((_) => ref.read(fastsProvider.notifier).reschedule()),
        );
        // the souls are read from the Keychain first
        unawaited(
          ref
              .read(soulsProvider.future)
              .then((_) => ref.read(soulsProvider.notifier).reschedule()),
        );
        unawaited(planWeekStories(notifications, now: DateTime.now()));
        unawaited(planYearStory(notifications, now: DateTime.now()));
      }

      // what was prayed without network
      void sendPrayer() {
        unawaited(ref.read(retreatLogProvider.notifier).sendPending());
        unawaited(ref.read(importunitiesProvider.notifier).sendCounts());
      }

      unawaited(pending.send());
      sendPrayer();
      plan();
      unawaited(notifications.takeLaunchPayload().then(openPayload));
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

      final taps = notifications.taps.listen(openPayload);
      final pushTaps = push.taps.listen(openAnnouncement);
      final widgetTaps = homeWidgets.clicks.listen(
        (uri) => unawaited(openFromWidget(uri)),
      );
      final received = push.received.listen((message) {
        unawaited(ref.read(inboxProvider.notifier).refresh());
        switch (message.data['type']) {
          case 'importunity_invite':
            ref.invalidate(importunitiesProvider);
          case 'report_sending':
            ref.invalidate(receivedReportsProvider);
          case 'report_reply':
            ref.invalidate(sentInAppProvider);
          case 'premium_gift':
            unawaited(ref.read(premiumStoreProvider).refresh());
          case 'authority_request' || 'authority_accepted':
            ref
              ..invalidate(authorityRequestsProvider)
              ..invalidate(authoritiesControllerProvider);
          case 'disciple_maker_chosen':
            ref.invalidate(disciplesListProvider);
        }
        // shown as when the app is closed: iOS does it, Android needs the app
        if (defaultTargetPlatform == TargetPlatform.android &&
            message.title.isNotEmpty) {
          unawaited(
            notifications.showPush(
              title: message.title,
              body: message.body,
              data: message.data,
              channelId: PushRegistration.channelId,
              channelName: LocaleSettings
                  .instance
                  .currentTranslations
                  .notifications
                  .channel,
            ),
          );
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

    // the new version, offered once; the one Google Play downloaded,
    // installed when the user says so
    useEffect(() {
      void offer() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          unawaited(offerUpdate(context, ref));
        }
      });
      final status = ref.listenManual(appUpdateProvider, (_, next) {
        if (next.hasValue) {
          offer();
        }
      }, fireImmediately: true);
      final downloads = ref.read(appInstallerProvider).downloaded.listen((_) {
        if (context.mounted) {
          unawaited(offerInstall(context, ref));
        }
      });
      return () {
        status.close();
        unawaited(downloads.cancel());
      };
    }, const []);

    return child;
  }
}
