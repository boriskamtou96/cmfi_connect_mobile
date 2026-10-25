import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/disciples/domain/disciple.dart';
import 'package:cmfi_connect/src/features/disciples/domain/received_report.dart';
import 'package:cmfi_connect/src/features/journey/application/journey_steps.dart';
import 'package:cmfi_connect/src/features/journey/domain/journey_step.dart';
import 'package:cmfi_connect/src/features/journey/presentation/journey_screen.dart';
import 'package:cmfi_connect/src/features/members/domain/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  const awa = MemberCard(username: 'awa', firstName: 'Awa');
  const benoit = MemberCard(username: 'benoit', firstName: 'Benoît');

  ReceivedReport report(int id, MemberCard member) => ReceivedReport(
    id: id,
    authorityId: id,
    member: member,
    periodFrom: today(),
    periodTo: today(),
    sentAt: DateTime.now(),
  );

  Future<void> openJourney(WidgetTester tester) async {
    await openProfile(tester);
    await tester.tap(find.text('Mes étapes'));
    await tester.pumpAndSettle();
  }

  testWidgets('the path shows the next step, the weekly cap and the cards', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    await openJourney(tester);

    expect(find.byType(JourneyScreen), findsOneWidget);
    expect(find.text('0 sur 15'), findsOneWidget);
    expect(find.text('PROCHAIN JALON'), findsOneWidget);
    expect(find.text('Encore 1 compte rendu'), findsOneWidget);

    // the cap: one commitment, chosen by the member
    await tester.scrollUntilVisible(
      find.text('Choisir un cap'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Choisir un cap'));
    await tester.pumpAndSettle();
    expect(find.text('Ton cap de la semaine'), findsOneWidget);
    expect(find.text('3 jours de compte rendu'), findsOneWidget);
    expect(find.text('3 retraites'), findsOneWidget);
    expect(find.text('5 chapitres'), findsOneWidget);

    await tester.tap(find.text('3 jours de compte rendu'));
    await tester.pumpAndSettle();
    expect(find.text('Ton cap de la semaine'), findsNothing);
    // the card is shorter now: back up to it
    await tester.scrollUntilVisible(
      find.text('Le cap de la semaine'),
      -200,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('0 sur 3'), findsOneWidget);
    expect(find.text('Encore 3 jours de compte rendu'), findsOneWidget);

    // it can be changed, without a reproach
    await tester.tap(find.text('Changer'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('5 chapitres'));
    await tester.pumpAndSettle();
    expect(find.text('0 sur 5'), findsOneWidget);
    expect(find.text('Encore 5 chapitres'), findsOneWidget);

    // the cards: locked before, then the step's own card
    await tester.tap(find.text('Mes cartes'));
    await tester.pumpAndSettle();
    expect(find.text('0 carte sur 15'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Premier pas, À atteindre'));
    await tester.pumpAndSettle();
    expect(find.text("Cette carte t'attend"), findsOneWidget);
    expect(
      find.text('Atteins « Premier pas » pour la recevoir.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Fermer'));
    await tester.pumpAndSettle();

    await app.container
        .read(journeyStepsProvider.notifier)
        .reach(JourneyStep.firstReport, celebrate: false);
    await tester.pumpAndSettle();
    expect(find.text('1 carte sur 15'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel(RegExp('Premier pas, Atteinte le')));
    await tester.pumpAndSettle();
    expect(find.text('Ta carte'), findsOneWidget);
    expect(find.text('Partager la carte'), findsOneWidget);
    await tester.tap(find.text('Fermer'));
    await tester.pumpAndSettle();
  });

  testWidgets('the next step skips what cannot be reached yet', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await openProfile(tester);
    expect(find.textContaining('prochaine : Premier pas'), findsOneWidget);

    final steps = app.container.read(journeyStepsProvider.notifier);
    for (final step in [
      JourneyStep.firstReport,
      JourneyStep.fullDay,
      JourneyStep.streak7,
      JourneyStep.fourRetreats,
      JourneyStep.sevenFullDays,
      JourneyStep.firstSoul,
      JourneyStep.streak30,
    ]) {
      await steps.reach(step);
    }
    await tester.pumpAndSettle();

    // no reading plan and no authority: both are skipped
    expect(find.textContaining('prochaine : Un chant partagé'), findsOneWidget);
  });

  testWidgets('the group walk is an anonymous total of the week', (
    tester,
  ) async {
    final disciples = FakeDisciplesApi(
      [
        const Disciple(authorityId: 1, member: awa),
        const Disciple(authorityId: 2, member: benoit),
      ],
      [report(1, awa), report(2, benoit), report(3, awa)],
    );
    await pumpApp(tester, token: 't', disciplesApi: disciples);
    await openJourney(tester);

    await tester.scrollUntilVisible(
      find.text('La marche du groupe'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    expect(
      find.text('2 disciples sur 2 ont partagé un compte rendu cette semaine'),
      findsOneWidget,
    );
    expect(find.text('3 comptes rendus reçus cette semaine'), findsOneWidget);
    expect(
      find.text('Un total du groupe, sans nom et sans classement.'),
      findsOneWidget,
    );
    // no one is named, no one is ranked
    expect(find.text('Awa'), findsNothing);
    expect(find.text('Benoît'), findsNothing);
  });
}
