import 'dart:convert';
import 'dart:io';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/storage/preferences.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/authorities/domain/authority.dart';
import 'package:cmfi_connect/src/features/disciples/domain/disciple.dart';
import 'package:cmfi_connect/src/features/disciples/presentation/disciples_screen.dart';
import 'package:cmfi_connect/src/features/home/presentation/home_screen.dart';
import 'package:cmfi_connect/src/features/members/domain/member.dart';
import 'package:cmfi_connect/src/features/reports/presentation/widgets/entry_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

Future<void> openMore(WidgetTester tester) async {
  await tester.tap(find.text('Plus'));
  await tester.pumpAndSettle();
}

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
      await openMore(tester);

      expect(find.text('Mes disciples'), findsNothing);
    });

    testWidgets('their regularity, never their reports; one who doesn\'t '
        'share it says so', (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        disciplesApi: FakeDisciplesApi([paul, marie]),
      );
      await openMore(tester);

      expect(find.text('2 disciples'), findsOneWidget);
      await tester.tap(find.text('Mes disciples'));
      await tester.pumpAndSettle();

      expect(find.byType(DisciplesScreen), findsOneWidget);
      expect(app.disciplesApi.asked.last, today());
      expect(find.text('Paul Ndi'), findsOneWidget);
      expect(find.text('18 jours remplis sur 30'), findsOneWidget);
      expect(find.text("12 jours d'affilée"), findsOneWidget);
      expect(find.text('Dernier : hier'), findsOneWidget);
      expect(find.text('Objectifs : 78 %'), findsOneWidget);

      expect(find.text('Marie'), findsOneWidget);
      expect(find.text('Ne partage pas sa régularité'), findsOneWidget);
    });

    testWidgets('filled in today, no goals, no streak', (tester) async {
      await pumpApp(
        tester,
        token: 't',
        disciplesApi: FakeDisciplesApi([
          Disciple(
            authorityId: 13,
            member: const MemberCard(username: 'jean.ako', firstName: 'Jean'),
            regularity: DiscipleRegularity(
              streak: 1,
              days: [today()],
              filledLast30: 1,
              lastDay: today(),
            ),
          ),
          const Disciple(
            authorityId: 14,
            member: MemberCard(username: 'luc.mba', firstName: 'Luc'),
            regularity: DiscipleRegularity(),
          ),
        ]),
      );
      await openMore(tester);
      await tester.tap(find.text('Mes disciples'));
      await tester.pumpAndSettle();

      expect(find.text('Rempli aujourd\'hui'), findsOneWidget);
      expect(find.text("1 jour d'affilée"), findsOneWidget);
      expect(find.textContaining('Objectifs'), findsNothing);
      expect(find.text('Pas de série en cours'), findsOneWidget);
      expect(find.text('Aucun compte rendu cette année'), findsOneWidget);
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
    await openMore(tester);
    await tester.tap(find.text('Mes autorités spirituelles'));
    await tester.pumpAndSettle();

    expect(find.text('Partager ma régularité'), findsOneWidget);
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isTrue,
    );

    await tester.tap(find.text('Partager ma régularité'));
    await tester.pumpAndSettle();

    expect(app.authoritiesApi.sharing, {3: false});
    expect(
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
      isFalse,
    );
    expect(app.toasts.messages, contains('Marc ne voit plus ta régularité.'));
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
    await openMore(tester);
    await tester.tap(find.text('Mes autorités spirituelles'));
    await tester.pumpAndSettle();

    expect(find.text('Partager ma régularité'), findsNothing);
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

    testWidgets('a touch on it opens the home screen', (tester) async {
      final app = await pumpApp(tester, token: 't');
      await openMore(tester);

      app.homeWidgets.clicksController.add(Uri.parse('cmficonnect://verse'));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
