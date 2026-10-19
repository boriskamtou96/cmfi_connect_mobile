import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/theme/app_icons.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/prayer/application/importunities.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/prayer/domain/retreat.dart';
import 'package:cmfi_connect/src/features/prayer/presentation/prayer_screen.dart';
import 'package:cmfi_connect/src/features/reports/application/report_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

PrayerPerson person(
  int id,
  String name, {
  PrayerList list = PrayerList.unbelievers,
  DateTime? lastPrayedOn,
  DateTime? answeredOn,
}) => PrayerPerson(
  id: id,
  list: list,
  name: name,
  lastPrayedOn: lastPrayedOn,
  answeredOn: answeredOn,
);

/// Opens the Prière tab.
Future<void> openPrayer(WidgetTester tester) async {
  await tester.tap(find.text('Prière').last);
  await tester.pumpAndSettle();
}

/// Scrolls the tab until [finder] is in the middle of the screen (not under
/// the tab bar).
Future<void> scrollToMiddle(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    300,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
  unawaited(Scrollable.ensureVisible(tester.element(finder), alignment: 0.4));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('retreats, the rules', () {
    test('the next people: never prayed first, then the oldest', () {
      final yesterday = today().subtract(const Duration(days: 1));
      final people = [
        person(1, 'Prié hier', lastPrayedOn: yesterday),
        person(2, 'Jamais prié'),
        person(3, 'A cru', answeredOn: yesterday),
        person(4, 'Prié il y a longtemps', lastPrayedOn: DateTime(2026)),
        person(5, 'Croyant', list: PrayerList.believers),
      ];

      expect(nextPeople(people, PrayerList.unbelievers).map((p) => p.id), [
        2,
        4,
        1,
      ]);
      expect(
        nextPeople(
          people,
          PrayerList.unbelievers,
          group: 1,
          count: 2,
        ).map((p) => p.id),
        [1],
      );
      expect(nextPeople(people, PrayerList.believers).map((p) => p.id), [5]);
    });

    test('the retreat of the moment', () {
      expect(momentAt(DateTime(2026, 10, 10, 6)), RetreatMoment.morning);
      expect(momentAt(DateTime(2026, 10, 10, 12, 30)), RetreatMoment.noon);
      expect(momentAt(DateTime(2026, 10, 10, 18)), RetreatMoment.evening);
      expect(momentAt(DateTime(2026, 10, 10, 22)), RetreatMoment.night);
      // done: the next one of the day; all done: none
      expect(
        nextRetreat({RetreatMoment.noon}, DateTime(2026, 10, 10, 12)),
        RetreatMoment.evening,
      );
      expect(
        nextRetreat(RetreatMoment.values.toSet(), DateTime(2026, 10, 10, 8)),
        isNull,
      );
    });

    test('every language has the four retreats and the same lists', () {
      final french = RetreatContent.fromJson(
        jsonDecode(File('assets/prayer/retreats_fr.json').readAsStringSync())
            as Map<String, dynamic>,
      );
      for (final language in ['fr', 'en', 'de', 'es', 'ar', 'zh', 'hi']) {
        final content = RetreatContent.fromJson(
          jsonDecode(
                File(
                  'assets/prayer/retreats_$language.json',
                ).readAsStringSync(),
              )
              as Map<String, dynamic>,
        );
        for (final moment in RetreatMoment.values) {
          expect(
            content.points[moment],
            hasLength(retreatPoints),
            reason: language,
          );
          expect(
            content.points[moment]!.every((text) => text.trim().isNotEmpty),
            isTrue,
            reason: language,
          );
        }
        for (final kind in NationKind.values) {
          expect(
            content.nations[kind],
            hasLength(french.nations[kind]!.length),
            reason: '$language $kind',
          );
        }
      }
    });

    test('the country of the day changes every day, the same all day', () {
      const content = RetreatContent(
        points: {},
        nations: {
          NationKind.unreached: ['A', 'B', 'C'],
        },
      );
      final monday = content.nationOfDay(
        NationKind.unreached,
        DateTime(2026, 10, 12, 8),
      );
      expect(
        content.nationOfDay(NationKind.unreached, DateTime(2026, 10, 12, 22)),
        monday,
      );
      expect(
        content.nationOfDay(NationKind.unreached, DateTime(2026, 10, 13)),
        isNot(monday),
      );
      expect(content.nationOfDay(NationKind.muslim, DateTime(2026)), isNull);
    });
  });

  group('the Prière tab', () {
    testWidgets('the four retreats as cards, the one made checked', (
      tester,
    ) async {
      final api = FakePrayerApi()
        ..retreatList.add(
          RetreatRecord(day: today(), moment: RetreatMoment.morning),
        );
      await pumpApp(tester, token: 't', prayerApi: api);
      await openPrayer(tester);
      await scrollTo(tester, find.text('Retraite de la nuit'));

      for (final name in [
        'Retraite du matin',
        'Retraite de midi',
        'Retraite du soir',
        'Retraite de la nuit',
      ]) {
        expect(find.text(name), findsOneWidget);
      }
      expect(find.text('Faite · 15 min'), findsOneWidget);
      expect(find.byIcon(AppIcons.checkCircleFilled), findsOneWidget);
      expect(find.text('1 sur 4'), findsOneWidget);

      await tester.tap(find.text('Retraite de la nuit'));
      await tester.pumpAndSettle();
      expect(find.text('Retraites de 15 minutes'), findsOneWidget);
    });

    testWidgets('the photo at the top: the days prayed and "Commencer"', (
      tester,
    ) async {
      await pumpApp(tester, token: 't');
      await openPrayer(tester);

      expect(find.text('15 minutes\navec le Seigneur'), findsOneWidget);
      expect(find.textContaining('jour'), findsWidgets);
      expect(find.text('Commencer'), findsOneWidget);
      await tester.tap(find.text('Commencer'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Point 1 sur 15'), findsOneWidget);
    });

    testWidgets('a retreat at my pace: 15 points, then the day and report', (
      tester,
    ) async {
      final api = FakePrayerApi(
        people: [
          for (var i = 1; i <= 7; i++) person(i, 'Personne $i'),
          person(20, 'Marc', list: PrayerList.believers),
        ],
      );
      final app = await pumpApp(tester, token: 't', prayerApi: api);
      await openPrayer(tester);

      expect(find.text('Ta routine du jour'), findsOneWidget);
      // the midday retreat, at its own pace
      await scrollTo(tester, find.text('Retraite de midi'));
      await tester.tap(find.text('Retraite de midi'));
      await tester.pumpAndSettle();
      expect(find.text('Retraites de 15 minutes'), findsOneWidget);
      // the names the retreat will pray for
      expect(
        find.textContaining('Personne 1, Personne 2, Personne 3'),
        findsOneWidget,
      );
      await tester.tap(find.text('Lire à mon rythme, sans minuteur'));
      await tester.pumpAndSettle();

      expect(find.text('Point 1 sur 15'), findsOneWidget);
      for (var i = 0; i < 15; i++) {
        await tester.tap(
          find
              .bySemanticsLabel(RegExp('Point suivant|Terminer la retraite'))
              .first,
        );
        await tester.pumpAndSettle();
      }

      expect(find.text('Retraite de midi terminée'), findsOneWidget);
      expect(find.text('1 retraite sur 4'), findsOneWidget);
      expect(api.retreatList.single.moment, RetreatMoment.noon);
      // the people prayed for go to the end of their lists
      expect(api.markedPrayed.single, containsAll([1, 2, 3, 4, 5, 6, 7, 20]));
      // 15 minutes of "Prière seule" in today's report
      final saved = app.reportsApi.saves.last;
      final alone = saved.entries.firstWhere((entry) => entry.code == 'PS');
      expect(alone.durationMinutes, 15);
      expect(
        find.text('Prière seule : +15 min · 15 min aujourd\'hui'),
        findsOneWidget,
      );

      // marked by mistake: the day and the report go back
      await tester.tap(find.text('Annuler'));
      await tester.pumpAndSettle();
      expect(api.retreatList, isEmpty);
      // "Prière seule" is empty again
      expect(
        app.reportsApi.saves.last.entries.where((entry) => entry.code == 'PS'),
        isEmpty,
      );
    });

    testWidgets('read aloud: each point as it comes, kept for next time', (
      tester,
    ) async {
      final app = await pumpApp(tester, token: 't');
      await openPrayer(tester);
      await scrollTo(tester, find.text('Retraite de midi'));
      await tester.tap(find.text('Retraite de midi'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Lire à mon rythme, sans minuteur'));
      await tester.pumpAndSettle();
      expect(app.voice.spoken, isEmpty);

      await tester.tap(find.byTooltip('Lire à voix haute'));
      await tester.pumpAndSettle();
      expect(app.voice.spoken.single.language, 'fr');
      final first = app.voice.spoken.single.text;
      expect(first, isNotEmpty);
      expect(app.preferences.getBool('retreat_voice'), isTrue);
      expect(find.byTooltip('Lecture à voix haute activée'), findsOneWidget);

      // the next point, read in turn
      await tester.tap(find.bySemanticsLabel('Point suivant').first);
      await tester.pumpAndSettle();
      expect(app.voice.spoken, hasLength(2));
      expect(app.voice.spoken.last.text, isNot(first));

      // off: silent at once
      final stops = app.voice.stops;
      await tester.tap(find.byTooltip('Lecture à voix haute activée'));
      await tester.pumpAndSettle();
      expect(app.voice.stops, greaterThan(stops));
      expect(app.preferences.getBool('retreat_voice'), isFalse);
      expect(app.voice.spoken, hasLength(2));
    });

    testWidgets('the routine: the retreat made, the days prayed, the week', (
      tester,
    ) async {
      final now = momentAt(DateTime.now());
      final api = FakePrayerApi()
        ..retreatList.add(RetreatRecord(day: today(), moment: now));
      await pumpApp(tester, token: 't', prayerApi: api);
      await openPrayer(tester);

      expect(find.text('1 jour sur 7'), findsOneWidget);
      expect(find.text('15 min cette semaine'), findsOneWidget);
      expect(find.text('1 sur 4'), findsOneWidget);
      expect(find.text('Faite · 15 min'), findsOneWidget);
      // the one after it opens with "Commencer" (none once the night is made)
      expect(
        find.text('Commencer'),
        now == RetreatMoment.night ? findsNothing : findsOneWidget,
      );
    });

    testWidgets('guided: a minute per point, a soft sound to the next', (
      tester,
    ) async {
      final app = await pumpApp(tester, token: 't');
      await openPrayer(tester);
      await scrollToMiddle(tester, find.text('Commencer'));
      await tester.tap(find.text('Commencer'));
      // not pumpAndSettle: the clock of the retreat would run
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Point 1 sur 15'), findsOneWidget);
      expect(find.text('1:00'), findsOneWidget);
      await tester.pump(const Duration(seconds: 30));
      expect(find.text('0:30'), findsOneWidget);
      await tester.pump(const Duration(seconds: 30));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Point 2 sur 15'), findsOneWidget);
      expect(app.chime.played, 1);

      // a pause stops the clock
      await tester.tap(find.bySemanticsLabel('Pause'));
      await tester.pump();
      await tester.pump(const Duration(seconds: 10));
      expect(find.text('1:00'), findsOneWidget);
      expect(find.text('en pause'), findsOneWidget);

      // leaving asks first, and counts nothing
      await tester.tap(find.byTooltip('Fermer'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Arrêter la retraite ?'), findsOneWidget);
      await tester.tap(find.text('Arrêter'));
      await tester.pumpAndSettle();
      expect(app.prayerApi.retreatList, isEmpty);
      expect(find.text('Ta routine du jour'), findsOneWidget);
    });

    testWidgets('a topic of the community: its PDF opens, and downloads', (
      tester,
    ) async {
      final api = FakePrayerApi(topics: [sampleTopic()]);
      final app = await pumpApp(tester, token: 't', prayerApi: api);
      await openPrayer(tester);

      final topic = find.text('Conférence annuelle 2026 : prions ensemble');
      await scrollToMiddle(tester, topic);
      // its name and its PDF, nothing else
      expect(find.text('180 Ko · jusqu\'au 22 nov.'), findsOneWidget);
      await tester.tap(topic);
      await tester.pumpAndSettle();
      expect(
        app.links.opened.single.toString(),
        endsWith('/v1/media/sujets.pdf'),
      );

      await tester.tap(find.byTooltip('Télécharger le PDF'));
      await tester.pumpAndSettle();
      expect(api.documents.single, endsWith('/v1/media/sujets.pdf'));
      final file = app.share.files.single;
      expect(file.name, 'sujets.pdf');
      expect(file.mimeType, 'application/pdf');
    });

    testWidgets('my lists: someone added, then believed in the Lord', (
      tester,
    ) async {
      final api = FakePrayerApi();
      await pumpApp(tester, token: 't', prayerApi: api);
      await openPrayer(tester);
      await tester.scrollUntilVisible(find.text('Pas encore cru'), 200);
      // above the tab bar
      await tester.ensureVisible(find.text('Pas encore cru'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pas encore cru'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Ajouter une personne'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'Paul M.');
      await tester.enterText(find.byType(TextField).at(1), 'Collègue');
      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();
      expect(api.peopleList.single.name, 'Paul M.');
      expect(find.text('Paul M.'), findsOneWidget);
      expect(find.text('Collègue'), findsOneWidget);

      await tester.tap(find.text('Paul M.'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('A cru au Seigneur !'));
      await tester.pumpAndSettle();
      expect(api.peopleList.single.answeredOn, today());
      // a section title, in capitals
      expect(find.text('ONT CRU AU SEIGNEUR'), findsOneWidget);
    });
  });

  group('importunity', () {
    final topic = Importunity(
      id: 7,
      title: 'Seigneur, sauve Paul',
      goal: 100,
      total: 40,
      myCount: 10,
      owner: sampleMembers.values.first,
      isOwner: true,
      participants: 3,
      members: [sampleMembers.values.first],
    );

    testWidgets('each tap counts, sent together a moment after', (
      tester,
    ) async {
      final api = FakePrayerApi(importunities: [topic]);
      await pumpApp(tester, token: 't', prayerApi: api);
      await openPrayer(tester);
      await scrollToMiddle(tester, find.text('Seigneur, sauve Paul'));
      await tester.tap(find.text('Seigneur, sauve Paul'));
      await tester.pumpAndSettle();
      expect(find.text('40 sur 100'), findsOneWidget);

      for (var i = 0; i < 3; i++) {
        await tester.tap(find.text('Touche à chaque proclamation'));
        await tester.pump();
      }
      expect(find.text('43 sur 100'), findsOneWidget);
      expect(find.text('Toi : 13'), findsOneWidget);
      expect(api.counts, isEmpty);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(api.counts, [(7, 3)]);
      expect(find.text('43 sur 100'), findsOneWidget);
    });

    testWidgets('a time of prayer for the topic, added to « Prière seule »', (
      tester,
    ) async {
      final api = FakePrayerApi(importunities: [topic]);
      final app = await pumpApp(tester, token: 't', prayerApi: api);
      await openPrayer(tester);
      await scrollToMiddle(tester, find.text('Seigneur, sauve Paul'));
      await tester.tap(find.text('Seigneur, sauve Paul'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Chronométrer ma prière'));
      // the seconds go by: no pumpAndSettle while it runs
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.text('Temps de prière pour ce sujet'), findsOneWidget);
      expect(app.container.read(reportTimerProvider)?.source, 'importunity:7');

      await tester.tap(find.byTooltip('Mettre en pause'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Terminer'));
      await tester.pumpAndSettle();

      expect(app.toasts.messages.last, '1 min ajoutées à « Prière seule »');
      expect(find.text('Toi : 10 · 1 min de prière'), findsOneWidget);
      final entry = app.reportsApi.days[today()]!.entries.firstWhere(
        (entry) => entry.code == 'PS',
      );
      expect(entry.durationMinutes, 1);
    });

    testWidgets('"Proclamer" counts from the tab, without opening it', (
      tester,
    ) async {
      final api = FakePrayerApi(importunities: [topic]);
      await pumpApp(tester, token: 't', prayerApi: api);
      await openPrayer(tester);
      await scrollToMiddle(tester, find.text('Proclamer'));

      await tester.tap(find.text('Proclamer'));
      await tester.pump();
      await tester.tap(find.text('Proclamer'));
      await tester.pump();
      expect(find.text('42 sur 100 · 3 prient'), findsOneWidget);
      expect(api.counts, isEmpty);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(api.counts, [(7, 2)]);
    });

    testWidgets('without network the taps wait, then leave', (tester) async {
      final api = FakePrayerApi(importunities: [topic]);
      final app = await pumpApp(tester, token: 't', prayerApi: api);
      await openPrayer(tester);
      await scrollToMiddle(tester, find.text('Seigneur, sauve Paul'));
      await tester.tap(find.text('Seigneur, sauve Paul'));
      await tester.pumpAndSettle();

      api.offline = true;
      await tester.tap(find.text('Touche à chaque proclamation'));
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(api.counts, isEmpty);
      expect(find.text('41 sur 100'), findsOneWidget);

      api.offline = false;
      await app.container.read(importunitiesProvider.notifier).sendCounts();
      expect(api.counts, [(7, 1)]);
    });

    testWidgets('a new topic, and the spiritual family invited', (
      tester,
    ) async {
      final api = FakePrayerApi(
        spiritualFamily: PrayerFamily(
          discipleMaker: sampleMembers.values.last,
          members: 23,
        ),
      );
      await pumpApp(tester, token: 't', prayerApi: api);
      await openPrayer(tester);
      // the action of the section title
      final create = find.widgetWithText(TextButton, 'Nouveau sujet');
      await scrollToMiddle(tester, create);
      await tester.tap(create);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextField).first,
        'Seigneur, sauve Paul',
      );
      await tester.enterText(find.byType(TextField).last, '10000');
      await tester.tap(find.text('Créer'));
      await tester.pumpAndSettle();
      expect(api.importunityList.single.goal, 10000);
      expect(
        find.text('0 sur ${NumberFormat.decimalPattern('fr').format(10000)}'),
        findsOneWidget,
      );

      await tester.tap(find.text('Inviter'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('et ses disciples : 23 personnes'),
        findsOneWidget,
      );
      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      await tester.tap(find.text('Envoyer les invitations'));
      await tester.pumpAndSettle();
      expect(api.invitations.single.family, isTrue);
      expect(find.text('23 invitations en attente'), findsOneWidget);
    });

    testWidgets('an invitation: join and pray', (tester) async {
      final invitation = topic.copyWith(
        isOwner: false,
        myStatus: ImportunityMemberStatus.invited,
        invitedBy: sampleMembers.values.first,
        myCount: 0,
      );
      final api = FakePrayerApi(importunities: [invitation]);
      await pumpApp(tester, token: 't', prayerApi: api);
      await openPrayer(tester);

      final inviter = sampleMembers.values.first;
      expect(
        find.text('${inviter.firstName} ${inviter.lastName} t\'invite à prier'),
        findsOneWidget,
      );
      await scrollTo(tester, find.text('Je prie avec vous'));
      await tester.tap(find.text('Je prie avec vous'));
      await tester.pumpAndSettle();
      expect(
        api.importunityList.single.myStatus,
        ImportunityMemberStatus.joined,
      );
      expect(find.text('Je prie avec vous'), findsNothing);
      await scrollToMiddle(tester, find.text('Seigneur, sauve Paul'));
      expect(find.text('Seigneur, sauve Paul'), findsOneWidget);
    });
  });

  test('the report item the retreats fill exists in the samples', () {
    expect(
      sampleActivities.where((a) => a.code == 'PS' && a.tracksDuration),
      hasLength(1),
    );
  });
}
