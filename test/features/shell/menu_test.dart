import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/authorities/domain/authority.dart';
import 'package:cmfi_connect/src/features/fasts/presentation/fasts_screen.dart';
import 'package:cmfi_connect/src/features/games/presentation/games_screen.dart';
import 'package:cmfi_connect/src/features/hymns/presentation/hymns_screen.dart';
import 'package:cmfi_connect/src/features/members/domain/member.dart';
import 'package:cmfi_connect/src/features/prayer/presentation/prayer_screen.dart';
import 'package:cmfi_connect/src/features/profile/presentation/profile_screen.dart';
import 'package:cmfi_connect/src/features/reports/presentation/reading/reading_screen.dart';
import 'package:cmfi_connect/src/features/shell/presentation/menu_screen.dart';
import 'package:cmfi_connect/src/features/souls/presentation/souls_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('five tabs: the games in the middle, « Vous » last, no drawer', (
    tester,
  ) async {
    await pumpApp(tester, token: 't');

    expect(
      tester
          .widgetList<NavigationDestination>(find.byType(NavigationDestination))
          .map((tab) => tab.label),
      ['Accueil', 'Compte rendu', 'Jeux', 'Bible', 'Vous'],
    );
    expect(find.byType(Drawer), findsNothing);

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Jeux'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(GamesScreen), findsOneWidget);
    expect(find.text('Bientôt disponible'), findsOneWidget);
  });

  testWidgets('« Vous »: the member with their pseudo, which opens the '
      'profile', (tester) async {
    await pumpApp(tester, token: 't', account: sampleAccount);
    await openMenu(tester);

    expect(inMenu('@${sampleAccount.username}'), findsOneWidget);
    expect(inMenu('Voir mon profil'), findsNothing);
    await tester.tap(inMenu('@${sampleAccount.username}'));
    await tester.pumpAndSettle();
    expect(find.byType(ProfileScreen), findsOneWidget);
  });

  testWidgets('« Vous »: the souls, the fasts and the readings, not the '
      'hymns nor the prayer', (tester) async {
    await pumpApp(tester, token: 't');
    await openMenu(tester);

    expect(inMenu('Cantiques'), findsNothing);
    expect(inMenu('Prière'), findsNothing);
    for (final (title, screen) in [
      ('Suivi des âmes', SoulsScreen),
      ('Mes jeûnes', FastsScreen),
      ('Mes lectures', ReadingScreen),
    ]) {
      await scrollTo(tester, inMenu(title));
      await tester.tap(inMenu(title));
      await tester.pumpAndSettle();
      expect(find.byType(screen), findsOneWidget, reason: title);
      await tester.tap(find.byTooltip('Retour'));
      await tester.pumpAndSettle();
      expect(find.byType(MenuScreen), findsOneWidget);
    }
    await scrollTo(tester, inMenu('Réglages'));
    expect(inMenu('Réglages'), findsOneWidget);
  });

  testWidgets('« Vous »: the people the member walks with, and what waits '
      'for them, also on the tab', (tester) async {
    await pumpApp(
      tester,
      token: 't',
      authoritiesApi: FakeAuthoritiesApi(const [], [
        AuthorityRequest(
          id: 9,
          from: MemberCard(
            username: 'clarisse.nguele',
            firstName: 'Clarisse',
            lastName: 'Nguele',
          ),
          isDiscipleMaker: true,
        ),
      ]),
    );
    await openMenu(tester);

    await scrollTo(tester, inMenu('Mes autorités spirituelles'));
    expect(inMenu('1 demande à voir'), findsOneWidget);
    // the tab tells it too
    expect(
      find.descendant(of: find.byType(NavigationBar), matching: find.text('1')),
      findsOneWidget,
    );
  });

  testWidgets('« Vous »: one way of the member, the steps and the year '
      'with the souls, the fasts and the readings', (tester) async {
    await pumpApp(tester, token: 't');
    await openMenu(tester);

    for (final title in [
      'Mes étapes',
      'Mon année avec Dieu',
      'Suivi des âmes',
      'Mes jeûnes',
      'Mes lectures',
    ]) {
      await scrollTo(tester, inMenu(title));
      expect(inMenu(title), findsOneWidget, reason: title);
    }
  });

  testWidgets('« Vous »: a member who has filled nothing is invited to '
      'their first report, without three zeros', (tester) async {
    await pumpApp(tester, token: 't');
    await openMenu(tester);

    expect(
      inMenu(
        'Remplis ton premier compte rendu : ta série commence '
        "aujourd'hui.",
      ),
      findsOneWidget,
    );
    expect(inMenu('0 j'), findsNothing);
  });

  testWidgets('« Mon profil » is the card: no numbers, no settings', (
    tester,
  ) async {
    await pumpApp(tester, token: 't', account: sampleAccount);
    await openProfile(tester);

    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.text('Modifier mon profil'), findsOneWidget);
    expect(find.byTooltip('Réglages'), findsNothing);
    expect(find.text('Mes étapes'), findsNothing);
  });

  testWidgets('the photo of the home screen opens « Vous »', (tester) async {
    await pumpApp(tester, token: 't');

    await tester.tap(find.byTooltip('Ouvrir le menu'));
    await tester.pumpAndSettle();

    expect(find.byType(MenuScreen), findsOneWidget);
  });

  testWidgets('the home screen keeps the hymns and the prayer one touch '
      'away, each with a way back', (tester) async {
    await pumpApp(tester, token: 't');

    await openFromHome(tester, 'Cantiques');
    expect(find.byType(HymnsScreen), findsOneWidget);
    // a page above the tabs
    expect(find.byType(NavigationBar), findsNothing);

    await openFromHome(tester, 'Prière');
    expect(find.byType(PrayerScreen), findsOneWidget);
    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
