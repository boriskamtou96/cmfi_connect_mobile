import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/session/session.dart';
import 'package:cmfi_connect/src/features/teachings/application/now_playing.dart';
import 'package:cmfi_connect/src/features/teachings/domain/teaching.dart';
import 'package:cmfi_connect/src/features/teachings/presentation/teaching_player_screen.dart';
import 'package:cmfi_connect/src/features/teachings/presentation/teachings_screen.dart';
import 'package:cmfi_connect/src/features/teachings/presentation/widgets/teaching_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  const croix = FakeTeachingsApi.sampleTeachings;

  Future<TestApp> openTeachings(
    WidgetTester tester, {
    FakeTeachingsApi? api,
    FakeTeachingFiles? files,
    Map<String, Object> preferences = const {},
    bool premium = true,
  }) async {
    final app = await pumpApp(
      tester,
      token: 't',
      premium: FakePremiumStore(active: premium),
      teachingsApi: api,
      teachingFiles: files,
      initialPreferences: preferences,
    );
    await openMenu(tester);
    await scrollTo(tester, find.text('Enseignements'));
    await tester.tap(find.text('Enseignements'));
    await tester.pumpAndSettle();
    return app;
  }

  test('the length of a message', () {
    expect(formatClock(const Duration(seconds: 3125)), '52:05');
    expect(
      formatClock(const Duration(hours: 1, minutes: 2, seconds: 5)),
      '1:02:05',
    );
  });

  testWidgets('the messages, searched and by category', (tester) async {
    await openTeachings(tester);

    expect(find.byType(TeachingsScreen), findsOneWidget);
    expect(find.text('2 messages'), findsOneWidget);
    expect(find.text('Le message de la croix'), findsOneWidget);
    expect(find.textContaining('Pr Zacharias Tanee Fomum'), findsOneWidget);
    expect(find.textContaining('52:05'), findsOneWidget);

    // the chips scroll sideways
    await tester.ensureVisible(find.text('Vie chrétienne'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Vie chrétienne'));
    await tester.pumpAndSettle();
    expect(find.text('Le message de la croix'), findsNothing);
    expect(find.text('La prière'), findsOneWidget);

    await tester.ensureVisible(find.text('Tous'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tous'));
    await tester.enterText(find.byType(TextField), 'fomum');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(find.text('1 message'), findsOneWidget);
  });

  testWidgets('a tap plays it, the player opens; it goes on in the mini '
      'player', (tester) async {
    final app = await openTeachings(tester);

    await tester.tap(find.text('Le message de la croix'));
    await tester.pumpAndSettle();
    expect(find.byType(TeachingPlayerScreen), findsOneWidget);
    final opened = app.player.opened.single;
    expect(opened.teaching.id, 1);
    expect(opened.source.path, '/v1/media/croix.mp3');
    expect(opened.start, Duration.zero);

    await tester.tap(find.byTooltip('Avancer de 15 secondes'));
    await tester.pumpAndSettle();
    expect(app.player.snapshot.position, const Duration(seconds: 15));
    await tester.tap(find.text('1×'));
    await tester.pumpAndSettle();
    expect(app.player.snapshot.speed, 1.25);
    expect(app.preferences.getDouble(NowPlaying.speedKey), 1.25);
    await tester.tap(find.byTooltip('Pause'));
    await tester.pumpAndSettle();
    expect(app.player.snapshot.playing, isFalse);

    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    // the mini player at the foot of the list
    expect(find.byType(MiniPlayer), findsOneWidget);
    expect(find.byTooltip('Écouter'), findsOneWidget);

    // the cross: the player goes away, the place is kept
    await tester.tap(find.byTooltip('Fermer le lecteur'));
    await tester.pumpAndSettle();
    expect(app.player.snapshot.teaching, isNull);
    expect(find.byTooltip('Écouter'), findsNothing);
  });

  testWidgets('started again where it stopped', (tester) async {
    final app = await openTeachings(
      tester,
      preferences: {'teaching_progress': '{"1": [600, 3125]}'},
    );

    await tester.tap(find.text('Le message de la croix'));
    await tester.pumpAndSettle();
    expect(app.player.opened.single.start, const Duration(seconds: 597));

    // heard to the end: « Écouté »
    app.player.emit(
      app.player.snapshot.copyWith(
        position: const Duration(seconds: 3125),
        playing: false,
        completed: true,
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    expect(find.text('Écouté'), findsOneWidget);
  });

  testWidgets('without Premium, downloading opens the Premium page', (
    tester,
  ) async {
    final files = FakeTeachingFiles();
    await openTeachings(tester, files: files, premium: false);

    await tester.tap(find.byTooltip('Télécharger avec Premium').first);
    await tester.pumpAndSettle();
    expect(files.kept, isEmpty);
    expect(find.text('Les enseignements hors ligne'), findsOneWidget);
  });

  testWidgets('kept on the phone: played from the file, listed offline', (
    tester,
  ) async {
    final api = FakeTeachingsApi();
    final files = FakeTeachingFiles();
    final app = await openTeachings(tester, api: api, files: files);

    await tester.tap(
      find.byTooltip('Télécharger pour écouter sans réseau').first,
    );
    await tester.pumpAndSettle();
    expect(app.toasts.messages, contains('Gardé sur ton téléphone'));
    expect(files.kept, {1});
    expect(find.text('Téléchargés'), findsOneWidget);

    await tester.tap(find.text('Le message de la croix'));
    await tester.pumpAndSettle();
    expect(app.player.opened.single.source.scheme, 'file');

    // without network, the message kept is still there
    api.offline = true;
    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text('Enseignements'));
    await tester.tap(find.text('Enseignements'));
    await tester.pumpAndSettle();
    expect(
      find.text('Sans réseau : voici les messages gardés sur ton téléphone.'),
      findsOneWidget,
    );
    // in the list and in the mini player
    expect(find.text('Le message de la croix'), findsNWidgets(2));
    expect(find.text('La prière'), findsNothing);

    await tester.tap(find.byTooltip('Retirer du téléphone'));
    await tester.pumpAndSettle();
    expect(files.kept, isEmpty);

    // the network back: the automatic retry finds the list again
    api.offline = false;
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('La prière'), findsOneWidget);
  });

  testWidgets('signing out stops the message', (tester) async {
    final app = await openTeachings(tester);
    await tester.tap(find.text('La prière'));
    await tester.pumpAndSettle();
    expect(app.player.snapshot.teaching, croix[1]);

    await app.container.read(sessionProvider.notifier).signOut();
    await tester.pumpAndSettle();
    expect(app.player.snapshot.teaching, isNull);
  });
}
