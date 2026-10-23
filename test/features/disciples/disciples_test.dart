import 'dart:convert';
import 'dart:io';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/storage/preferences.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/core/widgets/app_back_button.dart';
import 'package:cmfi_connect/src/features/authorities/domain/authority.dart';
import 'package:cmfi_connect/src/features/bible/application/bible_position.dart';
import 'package:cmfi_connect/src/features/bible/domain/bible.dart';
import 'package:cmfi_connect/src/features/bible/presentation/bible_screen.dart';
import 'package:cmfi_connect/src/features/disciples/domain/disciple.dart';
import 'package:cmfi_connect/src/features/disciples/domain/received_report.dart';
import 'package:cmfi_connect/src/features/disciples/presentation/disciples_screen.dart';
import 'package:cmfi_connect/src/features/disciples/presentation/received_reports_screen.dart';
import 'package:cmfi_connect/src/features/members/domain/member.dart';
import 'package:cmfi_connect/src/features/reports/presentation/widgets/entry_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

DateTime daysAgo(int n) {
  final now = today();
  return DateTime(now.year, now.month, now.day - n);
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('my disciples', () {
    final paul = Disciple(
      authorityId: 11,
      member: const MemberCard(
        username: 'paul.ndi',
        firstName: 'Paul',
        lastName: 'Ndi',
        church: 'PSU-Yaoundé',
      ),
      regularity: DiscipleRegularity(
        streak: 12,
        days: [for (var i = 1; i <= 18; i++) daysAgo(i)],
        filledLast30: 18,
        lastDay: daysAgo(1),
        goalPercent: 78,
      ),
    );
    const marie = Disciple(
      authorityId: 12,
      member: MemberCard(username: 'marie.ebo', firstName: 'Marie'),
      sharesRegularity: false,
    );

    testWidgets('nobody chose me: no entry in Plus', (tester) async {
      await pumpApp(tester, token: 't');
      await openProfile(tester);

      expect(find.text('Mes disciples'), findsNothing);
    });

    testWidgets('who they are; one who doesn\'t share says so', (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        disciplesApi: FakeDisciplesApi([paul, marie]),
      );
      await openProfile(tester);

      expect(find.text('2 disciples'), findsOneWidget);
      await scrollTo(tester, find.text('Mes disciples'));
      await tester.tap(find.text('Mes disciples'));
      await tester.pumpAndSettle();

      expect(find.byType(DisciplesScreen), findsOneWidget);
      expect(app.disciplesApi.asked.last, today());
      expect(find.text('Paul Ndi'), findsOneWidget);
      // only who they are: their days are on their page
      expect(find.textContaining('jours remplis'), findsNothing);
      expect(find.textContaining("d'affilée"), findsNothing);

      expect(find.text('Marie'), findsOneWidget);
      expect(find.text('Ne partage pas ses comptes rendus'), findsOneWidget);
    });
  });

  testWidgets('the disciple turns off what their disciple maker sees', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      authoritiesApi: FakeAuthoritiesApi([
        const Authority(
          id: 3,
          firstName: 'Marc',
          lastName: 'Tientcheu',
          username: 'marc.tientcheu',
          isDiscipleMaker: true,
        ),
      ]),
    );
    await openProfile(tester);
    await scrollTo(tester, find.text('Mes autorités spirituelles'));
    await tester.tap(find.text('Mes autorités spirituelles'));
    await tester.pumpAndSettle();

    expect(find.text('Partager mes comptes rendus'), findsOneWidget);
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isTrue,
    );

    await tester.tap(find.text('Partager mes comptes rendus'));
    await tester.pumpAndSettle();

    expect(app.authoritiesApi.sharing, {3: false});
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isFalse,
    );
    expect(
      app.toasts.messages,
      contains('Marc ne voit plus tes comptes rendus.'),
    );
  });

  testWidgets('a disciple maker typed by hand: nothing to share', (
    tester,
  ) async {
    await pumpApp(
      tester,
      token: 't',
      authoritiesApi: FakeAuthoritiesApi([
        const Authority(id: 3, firstName: 'Marc', isDiscipleMaker: true),
      ]),
    );
    await openProfile(tester);
    await scrollTo(tester, find.text('Mes autorités spirituelles'));
    await tester.tap(find.text('Mes autorités spirituelles'));
    await tester.pumpAndSettle();

    expect(find.text('Partager mes comptes rendus'), findsNothing);
  });

  group('many disciples', () {
    List<Disciple> many(int n) => [
      for (var i = 1; i <= n; i++)
        Disciple(
          authorityId: 100 + i,
          member: MemberCard(
            username: 'membre.$i',
            firstName: 'Membre',
            lastName: 'N$i',
          ),
          sharesRegularity: false,
        ),
    ];

    Future<TestApp> openMany(WidgetTester tester, int n) async {
      final app = await pumpApp(
        tester,
        token: 't',
        disciplesApi: FakeDisciplesApi(many(n)),
      );
      await openProfile(tester);
      await scrollTo(tester, find.text('Mes disciples'));
      await tester.tap(find.text('Mes disciples'));
      await tester.pumpAndSettle();
      return app;
    }

    testWidgets('20 at a time: the next ones come at the end of the list', (
      tester,
    ) async {
      final app = await openMany(tester, 45);

      expect(find.text('45 disciples'), findsNothing);
      expect(app.disciplesApi.pages.last, (search: '', page: 1));

      await tester.scrollUntilVisible(
        find.text('Membre N25'),
        400,
        scrollable: find.byType(Scrollable).last,
      );
      expect(app.disciplesApi.pages.last, (search: '', page: 2));

      await tester.scrollUntilVisible(
        find.text('Membre N45'),
        400,
        scrollable: find.byType(Scrollable).last,
      );
      expect(app.disciplesApi.pages.last, (search: '', page: 3));
      // all there: nothing more asked
      await tester.drag(find.byType(Scrollable).last, const Offset(0, -2000));
      await tester.pumpAndSettle();
      expect(app.disciplesApi.pages.where((asked) => asked.page == 4), isEmpty);
    });

    testWidgets('a search asks the server, after a short pause', (
      tester,
    ) async {
      final app = await openMany(tester, 45);

      await tester.enterText(find.byType(TextField), 'n4');
      await tester.pump(const Duration(milliseconds: 100));
      expect(app.disciplesApi.pages.last.search, '');
      // the pause ends: the server is asked
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();

      expect(app.disciplesApi.pages.last, (search: 'n4', page: 1));
      // N4 and N40 to N45
      expect(find.text('Membre N4'), findsOneWidget);
      expect(find.text('Membre N1'), findsNothing);
      await tester.scrollUntilVisible(
        find.text('Membre N45'),
        400,
        scrollable: find.byType(Scrollable).last,
      );
      expect(find.text('Membre N45'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'personne');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pumpAndSettle();
      expect(
        find.text('Aucun disciple ne correspond à « personne ».'),
        findsOneWidget,
      );
    });
  });

  group('the reports of a disciple', () {
    final paul = Disciple(
      authorityId: 11,
      member: const MemberCard(username: 'paul.ndi', firstName: 'Paul'),
      regularity: DiscipleRegularity(
        streak: 2,
        days: [today(), daysAgo(1)],
        filledLast30: 2,
        lastDay: today(),
        goalPercent: 75,
        itemsPercent: 67,
      ),
    );
    const claire = Disciple(
      authorityId: 12,
      member: MemberCard(username: 'claire.ebo', firstName: 'Claire'),
      isDiscipleMaker: false,
      regularity: DiscipleRegularity(),
    );
    final reports = DiscipleReports(
      authorityId: 11,
      member: const MemberCard(username: 'paul.ndi', firstName: 'Paul'),
      totalItems: 12,
      days: [
        DiscipleDay(
          date: today(),
          goalPercent: 75,
          filled: 8,
          total: 12,
          itemsPercent: 67,
          entries: const [
            DiscipleEntry(
              activityTypeId: 1,
              code: 'LB',
              label: 'Lecture biblique',
              quantityUnit: 'Chapitres',
              quantity: 3,
            ),
            DiscipleEntry(
              activityTypeId: 40,
              code: 'EVG',
              label: 'Évangélisation au marché',
              durationMinutes: 45,
            ),
          ],
        ),
        DiscipleDay(date: daysAgo(40), filled: 1, total: 12, itemsPercent: 8),
      ],
    );

    Future<TestApp> openDisciples(WidgetTester tester) async {
      final api = FakeDisciplesApi([paul, claire])..reportsOf[11] = reports;
      final app = await pumpApp(tester, token: 't', disciplesApi: api);
      await openProfile(tester);
      await scrollTo(tester, find.text('Mes disciples'));
      await tester.tap(find.text('Mes disciples'));
      await tester.pumpAndSettle();
      return app;
    }

    testWidgets('disciple maker or authority', (tester) async {
      await openDisciples(tester);

      expect(find.text('Tu es son faiseur de disciples'), findsOneWidget);
      expect(find.text("Tu es l'une de ses autorités"), findsOneWidget);
    });

    testWidgets('a touch opens their days: the items with their values and '
        'both percentages, then the 30 days before', (tester) async {
      final app = await openDisciples(tester);

      await tester.tap(find.text('Paul'));
      await tester.pumpAndSettle();

      expect(app.disciplesApi.ranges.single.id, 11);
      expect(app.disciplesApi.ranges.single.from, daysAgo(29));
      expect(find.text('Objectifs 75 %'), findsOneWidget);
      expect(find.text('8 sur 12 éléments · 67 %'), findsOneWidget);
      expect(find.text('Lecture biblique'), findsOneWidget);
      expect(find.text('3 chapitres'), findsOneWidget);
      expect(find.text('Évangélisation au marché'), findsOneWidget);
      expect(find.text('45 min'), findsOneWidget);
      // not filled in: 0, with what it measures
      expect(find.text('Prière seule'), findsOneWidget);
      expect(find.text('0 min'), findsOneWidget);
      // older than 30 days: not yet
      expect(find.text('1 sur 12 éléments · 8 %'), findsNothing);

      await tester.scrollUntilVisible(
        find.text('Voir les 30 jours précédents'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Voir les 30 jours précédents'));
      await tester.pumpAndSettle();

      expect(app.disciplesApi.ranges.last.from, daysAgo(59));
      await tester.scrollUntilVisible(
        find.text('1 sur 12 éléments · 8 %'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('1 sur 12 éléments · 8 %'), findsOneWidget);
    });

    testWidgets('filtered by date: the days of the period only, then all '
        'again', (tester) async {
      final app = await openDisciples(tester);
      await tester.tap(find.text('Paul'));
      await tester.pumpAndSettle();

      String typed(DateTime day) =>
          '${day.day.toString().padLeft(2, '0')}/'
          '${day.month.toString().padLeft(2, '0')}/${day.year}';
      await tester.tap(find.text('Filtrer par date'));
      await tester.pumpAndSettle();
      // the square glyphs of the test font overflow Material's own header of
      // the picker (the export screen's picker does the same)
      expect(tester.takeException(), isFlutterError);
      await tester.tap(find.byIcon(Icons.edit_outlined));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(0), typed(daysAgo(45)));
      await tester.enterText(find.byType(TextField).at(1), typed(daysAgo(35)));
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(app.disciplesApi.ranges.last.from, daysAgo(45));
      expect(app.disciplesApi.ranges.last.to, daysAgo(35));
      expect(find.text('1 sur 12 éléments · 8 %'), findsOneWidget);
      expect(find.text('8 sur 12 éléments · 67 %'), findsNothing);
      expect(find.text('Voir les 30 jours précédents'), findsNothing);
      // nothing filled that day: each item at 0 with its unit
      expect(find.text('0 chapitre'), findsOneWidget);

      await tester.tap(find.byTooltip('Retirer le filtre'));
      await tester.pumpAndSettle();
      expect(find.text('8 sur 12 éléments · 67 %'), findsOneWidget);
      expect(find.text('Filtrer par date'), findsOneWidget);
    });

    testWidgets('a week sent in the app: new in Plus, opened, encouraged', (
      tester,
    ) async {
      final sent = ReceivedReport(
        id: 5,
        authorityId: 11,
        member: paul.member,
        periodFrom: daysAgo(6),
        periodTo: today(),
        sentAt: DateTime.now(),
      );
      final api = FakeDisciplesApi([paul, claire], [sent])
        ..reportsOf[11] = reports;
      final app = await pumpApp(tester, token: 't', disciplesApi: api);
      await openProfile(tester);
      // in Mes disciples, on top
      await scrollTo(tester, find.text('Mes disciples'));
      await tester.tap(find.text('Mes disciples'));
      await tester.pumpAndSettle();

      expect(find.text('Comptes rendus reçus'), findsOneWidget);
      expect(find.text('1 nouveau'), findsOneWidget);
      await tester.tap(find.text('Comptes rendus reçus'));
      await tester.pumpAndSettle();
      expect(find.byType(ReceivedReportsScreen), findsOneWidget);
      expect(find.text('Paul'), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('Nouveau')), findsOneWidget);

      // « Voir »: their days, and it is no longer new
      await tester.tap(find.text('Voir'));
      await tester.pumpAndSettle();
      expect(app.disciplesApi.opened, [5]);
      expect(find.text('Lecture biblique'), findsOneWidget);
      await tester.tap(find.byType(AppBackButton));
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel(RegExp('Nouveau')), findsNothing);

      // a ready-made word, sent
      await tester.tap(find.text('Encourager'));
      await tester.pumpAndSettle();
      expect(find.text('Un mot pour Paul'), findsOneWidget);
      await tester.tap(find.text('Je prie pour toi.'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Envoyer'));
      await tester.pumpAndSettle();
      expect(app.disciplesApi.receivedList.single.reply, 'Je prie pour toi.');
      expect(app.toasts.messages, contains('Paul a reçu ton mot'));
      expect(find.text('Ta réponse : « Je prie pour toi. »'), findsOneWidget);
      expect(find.text('Modifier'), findsOneWidget);
    });

    testWidgets('the push of a disciple opens the reports received', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        token: 't',
        disciplesApi: FakeDisciplesApi([paul]),
      );
      app.push.tapsController.add({'type': 'report_sending', 'id': '5'});
      await tester.pumpAndSettle();

      expect(find.byType(ReceivedReportsScreen), findsOneWidget);
      expect(
        find.textContaining('Aucun compte rendu reçu pour l'),
        findsOneWidget,
      );
    });

    testWidgets('they stopped sharing meanwhile: said', (tester) async {
      await openDisciples(tester);

      // Claire's reports were never given to the fake: 403
      await tester.tap(find.text('Claire'));
      await tester.pumpAndSettle();

      expect(find.text('Ne partage pas ses comptes rendus'), findsOneWidget);
    });

    testWidgets('one who doesn\'t share them: nothing to open', (tester) async {
      final api = FakeDisciplesApi([
        const Disciple(
          authorityId: 13,
          member: MemberCard(username: 'luc.mba', firstName: 'Luc'),
          sharesRegularity: false,
        ),
      ]);
      final app = await pumpApp(tester, token: 't', disciplesApi: api);
      await openProfile(tester);
      await scrollTo(tester, find.text('Mes disciples'));
      await tester.tap(find.text('Mes disciples'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Luc'));
      await tester.pumpAndSettle();

      expect(app.disciplesApi.ranges, isEmpty);
    });
  });

  testWidgets('every member authority gets the reports, not only the '
      'disciple maker', (tester) async {
    await pumpApp(
      tester,
      token: 't',
      authoritiesApi: FakeAuthoritiesApi([
        const Authority(
          id: 3,
          firstName: 'Marc',
          username: 'marc.tientcheu',
          isDiscipleMaker: true,
        ),
        const Authority(id: 4, firstName: 'Clarisse', username: 'clarisse.n'),
      ]),
    );
    await openProfile(tester);
    await scrollTo(tester, find.text('Mes autorités spirituelles'));
    await tester.tap(find.text('Mes autorités spirituelles'));
    await tester.pumpAndSettle();

    expect(find.text('Partager mes comptes rendus'), findsNWidgets(2));
  });

  testWidgets('a saved day sends how far its goals go, never the items', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      initialPreferences: {'report_goals': '{"1":{"quantity":4}}'},
    );
    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lecture biblique'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byType(EntrySheet),
        matching: find.byType(TextField),
      ),
      '2',
    );
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enregistrer la journée'));
    await tester.pumpAndSettle();

    expect(app.reportsApi.goalPercents[today()], 50);
  });

  testWidgets('without goals: none sent', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lecture biblique'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byType(EntrySheet),
        matching: find.byType(TextField),
      ),
      '2',
    );
    await tester.tap(find.text('Valider'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enregistrer la journée'));
    await tester.pumpAndSettle();

    expect(app.reportsApi.goalPercents.containsKey(today()), isTrue);
    expect(app.reportsApi.goalPercents[today()], isNull);
  });

  group('the "Verset du jour" widget', () {
    Map<String, dynamic> calendar(String language) =>
        jsonDecode(
              File('assets/verses/verses_$language.json').readAsStringSync(),
            )
            as Map<String, dynamic>;

    String key(DateTime day) =>
        '${day.month.toString().padLeft(2, '0')}-'
        '${day.day.toString().padLeft(2, '0')}';

    testWidgets('two weeks of verses, from today, even signed out', (
      tester,
    ) async {
      final app = await pumpApp(tester);

      final verses = app.homeWidgets.verses.last;
      final french = calendar('fr');
      expect(verses.title, 'Verset du jour');
      expect(verses.source, french['source']);
      expect(verses.rightToLeft, isFalse);
      expect(verses.days.length, 14);
      expect(verses.days.keys.first, today());
      final tomorrow = DateTime(today().year, today().month, today().day + 1);
      expect(
        verses.days[tomorrow]!.text,
        (french['days'] as Map<String, dynamic>)[key(tomorrow)]['text'],
      );
      // what the native widgets read
      final stored = verses.toStorage();
      expect(
        (jsonDecode(stored['verse_days']! as String) as Map).keys.first,
        today().toApiDate(),
      );
    });

    testWidgets('in the language of the app', (tester) async {
      final app = await pumpApp(tester, token: 't');

      // as the language picker of Plus does
      await LocaleSettings.setLocale(AppLocale.ar);
      await app.container.read(savedLanguageProvider.notifier).save('ar');
      await tester.pumpAndSettle();

      final verses = app.homeWidgets.verses.last;
      expect(verses.title, 'آية اليوم');
      expect(verses.rightToLeft, isTrue);
      expect(verses.source, calendar('ar')['source']);
      await LocaleSettings.setLocale(AppLocale.fr);
    });

    testWidgets('a touch on it opens the verse in the Bible', (tester) async {
      final app = await pumpApp(tester, token: 't');
      await openProfile(tester);

      app.homeWidgets.clicksController.add(Uri.parse('cmficonnect://verse'));
      await tester.pumpAndSettle();

      // Plus closed, the Bible on the chapter of the day's verse
      expect(find.byType(BibleScreen), findsOneWidget);
      final days = calendar('fr')['days'] as Map<String, dynamic>;
      final osis = (days[key(today())] as Map<String, dynamic>)['osis'];
      expect(
        app.container.read(biblePositionProvider),
        BibleRef.parse(osis as String)!.chapterRef,
      );
    });
  });
}
