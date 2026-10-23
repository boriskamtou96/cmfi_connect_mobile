import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/deep_links.dart';
import 'package:cmfi_connect/src/features/events/presentation/event_screen.dart';
import 'package:cmfi_connect/src/features/hymns/presentation/hymn_reader_screen.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/prayer/presentation/importunity_screen.dart';
import 'package:cmfi_connect/src/features/prayer/presentation/prayer_topics_screen.dart';
import 'package:cmfi_connect/src/features/prayer/presentation/retreat_screen.dart';
import 'package:cmfi_connect/src/features/reports/presentation/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

const site = 'https://cmfi-connect.com';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('reading a link', () {
    AppLink? parse(String link) => AppLink.parse(Uri.parse(link));

    test('the site and the scheme of the app, for each screen', () {
      expect(
        parse('$site/open?to=events/42'),
        isA<EventLink>().having((link) => link.eventId, 'eventId', 42),
      );
      expect(
        parse(
          'https://www.cmfi-connect.com/open/?to=hymns/rendons-ministere-1/3',
        ),
        isA<HymnLink>()
            .having((link) => link.bookCode, 'bookCode', 'rendons-ministere-1')
            .having((link) => link.number, 'number', 3),
      );
      expect(
        parse('cmficonnect://open?to=prayer/topics/5'),
        isA<PrayerTopicLink>().having((link) => link.topicId, 'topicId', 5),
      );
      expect(
        parse('$site/open?to=prayer/importunities/7'),
        isA<ImportunityLink>().having(
          (link) => link.importunityId,
          'importunityId',
          7,
        ),
      );
      expect(parse('$site/open?to=/prayer/retreat/'), isA<RetreatLink>());
      // Siri, and a closed app on Android
      expect(parse('cmficonnect://open?to=reports/today'), isA<TodayLink>());
    });

    test('anything else is left alone', () {
      // the home screen widget reads its own links
      expect(parse('cmficonnect://today'), isNull);
      expect(parse('cmficonnect://premium'), isNull);
      expect(parse('https://example.com/open?to=events/42'), isNull);
      expect(parse('$site/events/42'), isNull);
      expect(parse('$site/open'), isNull);
      expect(parse('$site/open?to=events/abc'), isNull);
      expect(parse('$site/open?to=admin/users'), isNull);
    });

    test('a shared link opens the same screen', () {
      const links = <AppLink>[
        EventLink(42),
        HymnLink('rendons-ministere-1', 3),
        PrayerTopicLink(5),
        ImportunityLink(7),
        RetreatLink(),
      ];
      for (final link in links) {
        expect(AppLink.parse(link.uri)?.path, link.path);
      }
      expect(const EventLink(42).uri.toString(), '$site/open?to=events/42');
    });
  });

  group('opening the app', () {
    testWidgets('opened by a link: its event', (tester) async {
      await pumpApp(
        tester,
        token: 't',
        incomingLinks: FakeIncomingLinks(
          launchedWith: Uri.parse('$site/open?to=events/2'),
        ),
      );

      expect(find.byType(EventScreen), findsOneWidget);
      expect(find.text('Conférence annuelle 2026'), findsWidgets);
    });

    testWidgets('a link touched while the app runs: a hymn, a topic, an '
        'importunity, the retreat', (tester) async {
      final marc = sampleMembers['marc.tientcheu']!;
      final api = FakePrayerApi(
        topics: [sampleTopic(id: 5)],
        importunities: [
          Importunity(
            id: 7,
            title: 'Seigneur, sauve Paul',
            goal: 100,
            total: 40,
            owner: marc,
            invitedBy: marc,
            myStatus: ImportunityMemberStatus.joined,
            participants: 3,
          ),
        ],
      );
      final app = await pumpApp(tester, token: 't', prayerApi: api);

      // each one opens over the last

      app.incomingLinks.add('$site/open?to=hymns/rendons-ministere-1/1');
      await tester.pumpAndSettle();
      expect(find.byType(HymnReaderScreen), findsOneWidget);
      expect(find.text('A Toi la gloire'), findsWidgets);

      app.incomingLinks.add('cmficonnect://open?to=prayer/topics/5');
      await tester.pumpAndSettle();
      // the topics of the community, and its PDF
      expect(find.byType(PrayerTopicsScreen), findsOneWidget);
      expect(
        app.links.opened.last.toString(),
        endsWith('/v1/media/sujets.pdf'),
      );

      app.incomingLinks.add('$site/open?to=prayer/importunities/7');
      await tester.pumpAndSettle();
      expect(find.byType(ImportunityScreen), findsOneWidget);
      expect(find.text('Seigneur, sauve Paul'), findsWidgets);

      // no retreat made today: the one of the moment
      app.incomingLinks.add('$site/open?to=prayer/retreat');
      await tester.pumpAndSettle();
      expect(find.byType(RetreatScreen), findsOneWidget);
    });

    testWidgets("Siri's link: today's report", (tester) async {
      final app = await pumpApp(tester, token: 't');
      await openProfile(tester);

      app.incomingLinks.add('cmficonnect://open?to=reports/today');
      await tester.pumpAndSettle();
      expect(find.byType(ReportsScreen), findsOneWidget);
    });

    testWidgets('signed out: the link waits for the sign-in', (tester) async {
      await pumpApp(
        tester,
        incomingLinks: FakeIncomingLinks(
          launchedWith: Uri.parse('$site/open?to=events/2'),
        ),
      );
      expect(find.byType(EventScreen), findsNothing);

      await tester.tap(find.text("J'ai déjà un compte"));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).at(0), '6 90 00 00 01');
      await tester.enterText(find.byType(TextFormField).at(1), 'Secret123');
      await tester.tap(find.widgetWithText(FilledButton, 'Se connecter'));
      await tester.pumpAndSettle();

      expect(find.byType(EventScreen), findsOneWidget);
    });

    testWidgets('a link of nothing known: the app stays where it is', (
      tester,
    ) async {
      final app = await pumpApp(tester, token: 't');

      app.incomingLinks.add('$site/open?to=nowhere');
      await tester.pumpAndSettle();

      expect(find.text('Accueil'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });

  group('sharing', () {
    testWidgets('an event, with its link under it', (tester) async {
      final app = await pumpApp(tester, token: 't');
      await scrollTo(tester, find.text('Conférence annuelle 2026'));
      await tester.tap(find.text('Conférence annuelle 2026'));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Partager'));
      await tester.pumpAndSettle();

      expect(app.share.texts.single, endsWith('\n$site/open?to=events/2'));
    });

    testWidgets('a hymn, with its link under it', (tester) async {
      final app = await pumpApp(tester, token: 't');
      app.incomingLinks.add('$site/open?to=hymns/rendons-ministere-1/1');
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip("Plus d'options"));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Partager les paroles'));
      await tester.pumpAndSettle();

      expect(app.share.texts.single, startsWith('1. A Toi la gloire'));
      expect(
        app.share.texts.single,
        endsWith('\n\n$site/open?to=hymns/rendons-ministere-1/1'),
      );
    });
  });
}
