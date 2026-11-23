import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/widgets/tour/seen_tours.dart';
import 'package:cmfi_connect/src/core/widgets/tour/space_tour.dart';
import 'package:cmfi_connect/src/core/widgets/tour/tour_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

/// The time the tour waits for the screen to be drawn, and its entrance.
Future<void> _letTheTourStart(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the home presents itself the first time, step by step', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 'saved-token', tours: true);
    await _letTheTourStart(tester);

    expect(find.byType(TourBubble), findsOneWidget);
    expect(find.text("Ta journée d'un coup d'œil"), findsOneWidget);
    expect(find.text('1/4'), findsOneWidget);
    // seen as soon as it starts: it never comes back by itself
    expect(app.container.read(seenToursProvider), {TourSpace.home});

    await tester.tap(find.text('Suivant'));
    await tester.pumpAndSettle();
    expect(find.text('Ton compte rendu du jour'), findsOneWidget);
    expect(find.text('2/4'), findsOneWidget);

    await tester.tap(find.text('Passer'));
    await tester.pumpAndSettle();
    expect(find.byType(TourBubble), findsNothing);

    // the next tab presents itself in turn, once opened
    await openMenu(tester);
    await _letTheTourStart(tester);
    expect(find.text('Ta fiche'), findsOneWidget);
    expect(app.container.read(seenToursProvider), {
      TourSpace.home,
      TourSpace.you,
    });
  });

  testWidgets('the last step closes the tour', (tester) async {
    await pumpApp(
      tester,
      token: 'saved-token',
      tours: true,
      initialPreferences: {'seen_tours': <String>[]},
    );
    await _letTheTourStart(tester);

    for (var step = 0; step < 3; step++) {
      await tester.tap(find.text('Suivant'));
      await tester.pumpAndSettle();
    }
    expect(find.text('4/4'), findsOneWidget);
    // no « Passer » on the last bubble, « C'est compris » ends it
    expect(find.text('Passer'), findsNothing);
    await tester.tap(find.text("C'est compris"));
    await tester.pumpAndSettle();
    expect(find.byType(TourBubble), findsNothing);
  });

  testWidgets('the tour waits for a window of the system to close', (
    tester,
  ) async {
    // the permission of the notifications, asked at sign-in
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    await pumpApp(tester, token: 'saved-token', tours: true);
    await tester.pump(const Duration(seconds: 3));
    expect(find.byType(TourBubble), findsNothing);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await _letTheTourStart(tester);
    expect(find.text("Ta journée d'un coup d'œil"), findsOneWidget);
  });

  testWidgets('a tab already built presents itself again once forgotten', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 'saved-token', tours: true);
    await _letTheTourStart(tester);
    await tester.tap(find.text('Passer'));
    await tester.pumpAndSettle();
    expect(find.byType(TourBubble), findsNothing);

    await app.container.read(seenToursProvider.notifier).forgetAll();
    await _letTheTourStart(tester);
    expect(find.text("Ta journée d'un coup d'œil"), findsOneWidget);
  });

  testWidgets('the export presents itself when the history first opens', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 'saved-token',
      tours: true,
      initialPreferences: {
        'seen_tours': [TourSpace.home.name, TourSpace.reports.name],
      },
    );
    await _letTheTourStart(tester);
    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();
    await _letTheTourStart(tester);
    // nothing on « Aujourd'hui »: the export is on the history
    expect(find.byType(TourBubble), findsNothing);

    await tester.tap(find.text('Historique'));
    await tester.pumpAndSettle();
    await _letTheTourStart(tester);
    expect(find.text('Exporter tes comptes rendus'), findsOneWidget);
    expect(
      app.container.read(seenToursProvider),
      contains(TourSpace.reportsData),
    );
  });

  testWidgets('a space already seen does not present itself again', (
    tester,
  ) async {
    await pumpApp(
      tester,
      token: 'saved-token',
      tours: true,
      initialPreferences: {
        'seen_tours': [TourSpace.home.name],
      },
    );
    await _letTheTourStart(tester);

    expect(find.byType(TourBubble), findsNothing);
  });

  testWidgets('the settings show the tours again', (tester) async {
    final app = await pumpApp(
      tester,
      token: 'saved-token',
      initialPreferences: {
        'seen_tours': [TourSpace.home.name, TourSpace.bible.name],
      },
    );

    await openSettings(tester);
    final replay = find.text('Revoir la présentation des espaces');
    await tester.scrollUntilVisible(replay, 200);
    await tester.tap(replay);
    await tester.pumpAndSettle();

    expect(app.container.read(seenToursProvider), isEmpty);
    expect(app.toasts.messages, [
      "C'est noté : chaque espace se présentera de nouveau à ta prochaine "
          'visite.',
    ]);
  });

  testWidgets('the bubble keeps its text whole with big letters', (
    tester,
  ) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(
              size: Size(320, 640),
              textScaler: TextScaler.linear(2),
            ),
            child: Scaffold(
              body: SingleChildScrollView(
                child: TourBubble(
                  space: 'Prière',
                  icon: Icons.favorite,
                  title: 'Ta routine du jour',
                  text:
                      'Quatre retraites de 15 minutes, guidées point par '
                      'point. Chacune ajoute son temps à ton compte rendu.',
                  index: 1,
                  count: 4,
                  onNext: () {},
                  onSkip: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
  });
}
