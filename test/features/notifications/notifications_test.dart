import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/core/theme/app_icons.dart';
import 'package:cmfi_connect/src/features/documents/presentation/documents_screen.dart';
import 'package:cmfi_connect/src/features/notifications/domain/announcement.dart';
import 'package:cmfi_connect/src/features/notifications/presentation/notification_screen.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/prayer/presentation/prayer_topics_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<void> openBell(WidgetTester tester) async {
    await tester.tap(find.byIcon(AppIcons.notifications));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'signed in, the phone is given to the server; signed out, taken back',
    (tester) async {
      final app = await pumpApp(tester, token: 't');

      expect(app.push.permissionAsked, isTrue);
      expect(app.notificationsApi.registered.single.token, 'push-token');
      expect(app.notificationsApi.registered.single.platform, 'android');
      expect(app.notificationsApi.registered.single.language, 'fr');
      expect(app.notifications.pushChannels, ['announcements']);

      await openMore(tester);
      await tester.pumpAndSettle();
      await scrollToEnd(tester);
      await tester.tap(find.text('Se déconnecter'));
      await tester.pumpAndSettle();

      expect(app.notificationsApi.unregistered, ['push-token']);
    },
  );

  testWidgets('refused notifications: nothing is given to the server', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      push: FakePushMessaging(granted: false),
    );

    expect(app.notificationsApi.registered, isEmpty);
  });

  testWidgets('the bell counts the unread ones; opening one reads it', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      notificationsApi: FakeNotificationsApi(
        items: [
          sampleAnnouncement(
            id: 2,
            title: 'Conférence de Pâques',
            body: 'Les inscriptions sont ouvertes.',
            attachments: const [
              AnnouncementFile(
                id: 9,
                kind: 'pdf',
                url: '/v1/media/programme.pdf',
                name: 'Programme.pdf',
                sizeBytes: 812000,
              ),
            ],
          ),
          sampleAnnouncement(id: 1, read: true),
        ],
      ),
    );

    expect(find.text('1'), findsOneWidget);
    await openBell(tester);

    expect(find.text('Conférence de Pâques'), findsOneWidget);
    expect(find.text('Veillée de prière'), findsOneWidget);
    expect(find.text('1 document PDF'), findsOneWidget);

    await tester.tap(find.text('Conférence de Pâques'));
    await tester.pumpAndSettle();

    expect(find.text('Les inscriptions sont ouvertes.'), findsOneWidget);
    expect(find.text('Programme.pdf'), findsOneWidget);
    expect(app.notificationsApi.read, [2]);

    await tester.tap(find.text('Programme.pdf'));
    await tester.pumpAndSettle();
    expect(app.links.opened.single.path, '/v1/media/programme.pdf');

    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsNothing);
  });

  testWidgets('nothing yet: the dove rests', (tester) async {
    await pumpApp(
      tester,
      token: 't',
      notificationsApi: FakeNotificationsApi(items: []),
    );
    await openBell(tester);

    expect(find.text('Aucune notification pour l\'instant'), findsOneWidget);
  });

  testWidgets('a touched push opens its notification', (tester) async {
    final app = await pumpApp(tester, token: 't');

    app.push.tapsController.add({'type': 'announcement', 'id': '1'});
    await tester.pumpAndSettle();

    expect(
      find.text('Vendredi à 21 h, à l\'assemblée de Biyem-Assi.'),
      findsOneWidget,
    );
  });

  testWidgets('a touched invitation opens the importunity topic', (
    tester,
  ) async {
    final inviter = sampleMembers.values.first;
    final app = await pumpApp(
      tester,
      token: 't',
      prayerApi: FakePrayerApi(
        importunities: [
          Importunity(
            id: 7,
            title: 'Seigneur, sauve Paul',
            goal: 100,
            total: 40,
            owner: inviter,
            invitedBy: inviter,
            myStatus: ImportunityMemberStatus.invited,
            participants: 3,
            members: [inviter],
          ),
        ],
      ),
    );

    app.push.tapsController.add({'type': 'importunity_invite', 'id': '7'});
    await tester.pumpAndSettle();

    expect(find.text('Seigneur, sauve Paul'), findsWidgets);
    expect(find.text('Je prie avec vous'), findsOneWidget);
  });

  testWidgets('a push received in the app shows as when it is closed', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');

    app.push.receivedController.add((
      title: 'Jeûne de 3 jours',
      body: 'À partir de lundi.',
      data: {'type': 'announcement', 'id': '3'},
    ));
    await tester.pumpAndSettle();

    // the tests run as Android: the app shows it (iOS does it itself)
    final shown = app.notifications.pushes.single;
    expect(shown.title, 'Jeûne de 3 jours');
    expect(shown.body, 'À partir de lundi.');
    expect(app.toasts.messages, isEmpty);

    // touched: the announcement opens, as from a push of the phone
    app.notifications.tapsController.add(
      '${LocalNotifications.pushPrefix}{"type":"announcement","id":"3"}',
    );
    await tester.pumpAndSettle();
    expect(find.byType(NotificationScreen), findsOneWidget);
  });

  testWidgets('a new content of the community opens its page', (tester) async {
    final app = await pumpApp(tester, token: 't');

    app.push.tapsController.add({'type': 'document', 'id': '4'});
    await tester.pumpAndSettle();
    expect(find.byType(DocumentsScreen), findsOneWidget);

    app.push.tapsController.add({'type': 'prayer_topic', 'id': '5'});
    await tester.pumpAndSettle();
    expect(find.byType(PrayerTopicsScreen), findsOneWidget);
  });

  testWidgets('without network: the notifications kept on the phone', (
    tester,
  ) async {
    final kept = sampleAnnouncement(id: 3, title: 'Jeûne de la semaine');
    await pumpApp(
      tester,
      token: 't',
      notificationsApi: FakeNotificationsApi(offline: true),
      initialPreferences: {
        'inbox_first_page': jsonEncode({
          'items': [kept],
          'unread': 1,
          'total': 1,
        }),
      },
    );

    // the badge and the list, from the copy
    expect(find.text('1'), findsOneWidget);
    await openBell(tester);
    expect(find.text('Jeûne de la semaine'), findsOneWidget);
  });
}
