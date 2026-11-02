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
    await scrollTo(tester, inMenu('Enseignements'));
    await tester.tap(inMenu('Enseignements'));
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
    // a length to read, not a clock
    expect(find.text('53 min'), findsOneWidget);

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
    await tester.pumpAndSettle();
    // the field comes with the magnifier
    expect(find.byType(TextField), findsNothing);
    await tester.tap(find.byTooltip('Rechercher'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'fomum');
    // the field rebuilt, then the wait of the typing
    await tester.pump();
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

  testWidgets('the player shares the audio, downloaded first when not kept', (
    tester,
  ) async {
    final app = await openTeachings(tester);

    await tester.tap(find.text('Le message de la croix'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Partager'));
    await tester.pumpAndSettle();
    final shared = app.share.paths.single;
    expect(shared.path, '/tmp/shared_teachings/1.mp3');
    expect(
      shared.name,
      'Le message de la croix – Pr Zacharias Tanee Fomum.mp3',
    );
    expect(shared.mimeType, 'audio/mpeg');
  });

  testWidgets('kept on the phone: the file kept is shared', (tester) async {
    final files = FakeTeachingFiles()..kept.add(1);
    final app = await openTeachings(tester, files: files);

    await tester.tap(find.text('Le message de la croix'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Partager'));
    await tester.pumpAndSettle();
    expect(app.share.paths.single.path, '/tmp/teachings/1.mp3');
  });

  testWidgets('without network, sharing says why', (tester) async {
    final files = FakeTeachingFiles()..fail = true;
    final app = await openTeachings(tester, files: files);

    await tester.tap(find.text('Le message de la croix'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Partager'));
    await tester.pumpAndSettle();
    expect(app.share.paths, isEmpty);
    expect(
      app.toasts.messages,
      contains('Pas de connexion à internet. Vérifie ton réseau et réessaie.'),
    );
    // the arrow is back
    expect(find.byTooltip('Partager'), findsOneWidget);
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
    await openMenu(tester);
    await tester.tap(inMenu('Enseignements'));
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

  testWidgets('the advanced filters: a speaker, the edition and its first '
      'day, then everything is cleared', (tester) async {
    const crusade = TeachingEditionBrief(
      id: 7,
      title: 'Croisades de prière et de jeûne 2026',
      year: 2026,
    );
    final api = FakeTeachingsApi(
      teachings: const [
        Teaching(
          id: 11,
          title: 'La sainteté',
          speaker: 'Théodore Andoseh',
          category: 'Croisades de prière et de jeûne',
          categorySlug: 'croisades-de-priere-et-de-jeune',
          year: 2026,
          dayNumber: 1,
          edition: crusade,
          audio: TeachingAudio(id: 31, url: '/v1/media/saintete.mp3'),
        ),
        Teaching(
          id: 12,
          title: 'Le pardon',
          speaker: 'Théodore Andoseh',
          category: 'Croisades de prière et de jeûne',
          categorySlug: 'croisades-de-priere-et-de-jeune',
          year: 2026,
          dayNumber: 1,
          edition: crusade,
          audio: TeachingAudio(id: 32, url: '/v1/media/pardon.mp3'),
        ),
        Teaching(
          id: 13,
          title: 'La mission',
          speaker: 'Un autre orateur',
          category: 'Croisades de prière et de jeûne',
          categorySlug: 'croisades-de-priere-et-de-jeune',
          year: 2026,
          dayNumber: 2,
          edition: crusade,
          audio: TeachingAudio(id: 33, url: '/v1/media/mission.mp3'),
        ),
      ],
    );
    await openTeachings(tester, api: api);
    expect(find.text('3 messages'), findsOneWidget);

    await tester.tap(find.byTooltip('Filtres'));
    await tester.pumpAndSettle();
    expect(find.text('Affiner la liste'), findsOneWidget);
    // all in sight: the speakers with their initials, the editions
    expect(find.text('TA'), findsOneWidget);
    expect(find.text('Afficher 3 messages'), findsOneWidget);

    // in the sheet, over the list
    await tester.tap(find.text('Théodore Andoseh').last);
    await tester.pumpAndSettle();
    expect(find.text('Afficher 2 messages'), findsOneWidget);
    await tester.tap(find.text('Croisades de prière et de jeûne').last);
    await tester.pumpAndSettle();
    // the days of the edition: two messages on the first
    await tester.ensureVisible(find.text('Jour 1'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Jour 1'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Afficher 2 messages'));
    await tester.pumpAndSettle();

    // the edition as a season: its card, its days as tabs
    expect(find.text('Croisades de prière et de jeûne 2026'), findsOneWidget);
    // the speaker of the season, and the filter's chip
    expect(find.text('Théodore Andoseh'), findsNWidgets(2));
    expect(find.text('La sainteté'), findsOneWidget);
    expect(find.text('Le pardon'), findsOneWidget);
    expect(find.text('La mission'), findsNothing);

    // the speaker stays as a chip; « Tout effacer » lets everything go
    await tester.ensureVisible(find.text('Tout effacer'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tout effacer'));
    await tester.pumpAndSettle();
    expect(find.text('3 messages'), findsOneWidget);
    expect(find.text('La mission'), findsOneWidget);
  });

  testWidgets('a category with messages outside its editions lists them all', (
    tester,
  ) async {
    const crusade = TeachingEditionBrief(
      id: 7,
      title: 'Croisades de prière et de jeûne 2026',
      year: 2026,
    );
    await openTeachings(
      tester,
      api: FakeTeachingsApi(
        teachings: const [
          Teaching(
            id: 1,
            title: 'Dans l\'édition',
            category: 'Croisades',
            categorySlug: 'croisades',
            year: 2026,
            dayNumber: 1,
            edition: crusade,
            audio: TeachingAudio(id: 11, url: '/v1/media/1.mp3'),
          ),
          Teaching(
            id: 2,
            title: 'Hors édition',
            category: 'Croisades',
            categorySlug: 'croisades',
            audio: TeachingAudio(id: 12, url: '/v1/media/2.mp3'),
          ),
        ],
      ),
    );

    await tester.tap(find.text('Croisades'));
    await tester.pumpAndSettle();
    // no season card: nothing left out
    expect(find.text('Croisades de prière et de jeûne 2026'), findsNothing);
    expect(find.text('2 messages'), findsOneWidget);
    expect(find.text('Hors édition'), findsOneWidget);
  });

  testWidgets('a category with editions opens its latest one, like a season', (
    tester,
  ) async {
    const crusade2025 = TeachingEditionBrief(
      id: 6,
      title: 'Croisades de prière et de jeûne 2025',
      year: 2025,
    );
    const crusade2026 = TeachingEditionBrief(
      id: 7,
      title: 'Croisades de prière et de jeûne 2026',
      year: 2026,
    );
    Teaching message(
      int id,
      String title,
      TeachingEditionBrief edition,
      int day,
    ) => Teaching(
      id: id,
      title: title,
      speaker: 'Théodore Andoseh',
      category: 'Croisades de prière et de jeûne',
      categorySlug: 'croisades',
      year: edition.year,
      dayNumber: day,
      edition: edition,
      durationSeconds: 1044,
      audio: TeachingAudio(id: 100 + id, url: '/v1/media/$id.mp3'),
    );
    final app = await openTeachings(
      tester,
      api: FakeTeachingsApi(
        teachings: [
          message(
            1,
            'Jour 1_1 croisade de prière et de jeûne 2026',
            crusade2026,
            1,
          ),
          message(
            2,
            'Jour 1_2 croisade de prière et de jeûne 2026',
            crusade2026,
            1,
          ),
          message(3, 'La prière qui persévère', crusade2026, 2),
          message(4, 'Jour 1_1 croisade 2025', crusade2025, 1),
        ],
      ),
    );

    await tester.tap(find.text('Croisades de prière et de jeûne'));
    await tester.pumpAndSettle();
    // the latest edition, its messages under the names they mean
    expect(find.text('Croisades de prière et de jeûne 2026'), findsOneWidget);
    expect(find.text('Jour 1, message 1'), findsOneWidget);
    expect(find.text('Jour 1, message 2'), findsOneWidget);
    expect(find.text('La prière qui persévère'), findsOneWidget);
    expect(find.text('Jour 1_1 croisade 2025'), findsNothing);
    expect(find.text('3 messages · 2 jours · 53 min'), findsOneWidget);

    // its days as tabs
    await tester.tap(find.text('Jour 2'));
    await tester.pumpAndSettle();
    expect(find.text('Jour 1, message 1'), findsNothing);
    expect(find.text('La prière qui persévère'), findsOneWidget);
    await tester.tap(find.text('Tous').last);
    await tester.pumpAndSettle();

    // « Écouter » plays the first message not heard
    await tester.tap(find.text('Écouter'));
    await tester.pumpAndSettle();
    expect(app.player.opened.single.teaching.id, 1);
    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();

    // the other editions
    await tester.tap(find.text('Éditions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Croisades de prière et de jeûne 2025'));
    await tester.pumpAndSettle();
    // the one of 2025 in the list, the one of 2026 in the mini player: both
    // under the name they mean
    expect(find.text('Jour 1, message 1'), findsNWidgets(2));
    expect(
      find.descendant(
        of: find.byType(MiniPlayer),
        matching: find.text('Jour 1, message 1'),
      ),
      findsOneWidget,
    );
    expect(find.text('La prière qui persévère'), findsNothing);
  });
}
