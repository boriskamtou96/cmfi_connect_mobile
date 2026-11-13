import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/teachings/application/listening.dart';
import 'package:cmfi_connect/src/features/teachings/domain/teaching.dart';
import 'package:cmfi_connect/src/features/teachings/presentation/teaching_player_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

Teaching _message(int id, String title) => Teaching(
  id: id,
  title: title,
  speaker: 'Théodore Andoseh',
  category: 'Prédications',
  audio: TeachingAudio(id: 100 + id, url: '/v1/media/$id.mp3'),
  durationSeconds: 600,
);

final _four = [
  _message(1, 'Premier message'),
  _message(2, 'Deuxième message'),
  _message(3, 'Troisième message'),
  _message(4, 'Quatrième message'),
];

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<TestApp> openTeachings(
    WidgetTester tester, {
    List<Teaching>? teachings,
    FakeTeachingFiles? files,
    Map<String, Object> preferences = const {},
  }) async {
    final app = await pumpApp(
      tester,
      token: 't',
      premium: FakePremiumStore(active: true),
      teachingsApi: FakeTeachingsApi(teachings: teachings ?? _four),
      teachingFiles: files,
      initialPreferences: preferences,
    );
    await openMenu(tester);
    await scrollTo(tester, inMenu('Enseignements'));
    await tester.tap(inMenu('Enseignements'));
    await tester.pumpAndSettle();
    return app;
  }

  /// The message heard reaches its end, as the real player says it.
  Future<void> end(WidgetTester tester, TestApp app) async {
    final now = app.player.snapshot;
    app.player.emit(
      now.copyWith(playing: false, completed: true, position: now.duration),
    );
    await tester.pumpAndSettle();
  }

  List<int> played(TestApp app) => [
    for (final one in app.player.opened) one.teaching.id,
  ];

  Finder inPlayer(Finder finder) =>
      find.descendant(of: find.byType(TeachingPlayerScreen), matching: finder);

  Future<void> show(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('at the end of a message the next one of the list plays, down '
      'to the last', (tester) async {
    final app = await openTeachings(tester);

    await tester.tap(find.text('Deuxième message'));
    await tester.pumpAndSettle();
    expect(played(app), [2]);

    await end(tester, app);
    expect(played(app), [2, 3]);
    expect(app.player.opened.last.start, Duration.zero);
    // the player follows
    expect(inPlayer(find.text('Troisième message')), findsWidgets);

    await end(tester, app);
    expect(played(app), [2, 3, 4]);
    // the last: it stops there
    await end(tester, app);
    expect(played(app), [2, 3, 4]);
    expect(app.player.snapshot.completed, isTrue);
  });

  testWidgets('« Lecture en continu » turned off, the player stops at the '
      'end; the choice is kept', (tester) async {
    final app = await openTeachings(tester);
    await tester.tap(find.text('Premier message'));
    await tester.pumpAndSettle();

    await show(tester, find.text('Lecture en continu'));
    await tester.tap(find.text('Lecture en continu'));
    await tester.pumpAndSettle();
    expect(app.preferences.getBool(Listening.continuousKey), isFalse);

    await end(tester, app);
    expect(played(app), [1]);
  });

  testWidgets('the choice made before is still made', (tester) async {
    final app = await openTeachings(
      tester,
      preferences: {Listening.continuousKey: false},
    );
    await tester.tap(find.text('Premier message'));
    await tester.pumpAndSettle();
    await end(tester, app);
    expect(played(app), [1]);
  });

  testWidgets('next and previous: the messages around, or the start of this '
      'one once begun', (tester) async {
    final app = await openTeachings(tester);
    await tester.tap(find.text('Troisième message'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Message suivant'));
    await tester.pumpAndSettle();
    expect(played(app), [3, 4]);
    // nothing after the last
    await tester.tap(find.byTooltip('Message suivant'));
    await tester.pumpAndSettle();
    expect(played(app), [3, 4]);

    await tester.tap(find.byTooltip('Message précédent'));
    await tester.pumpAndSettle();
    expect(played(app), [3, 4, 3]);

    // a minute in: back to its start, not to the message before
    app.player.emit(
      app.player.snapshot.copyWith(position: const Duration(minutes: 1)),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Message précédent'));
    await tester.pumpAndSettle();
    expect(played(app), [3, 4, 3]);
    expect(app.player.snapshot.position, Duration.zero);
  });

  testWidgets('« À suivre » lists what comes; a tap goes there', (
    tester,
  ) async {
    final app = await openTeachings(tester);
    await tester.tap(find.text('Premier message'));
    await tester.pumpAndSettle();

    await show(tester, find.text('À SUIVRE'));
    expect(inPlayer(find.text('Deuxième message')), findsOneWidget);
    expect(inPlayer(find.text('Quatrième message')), findsOneWidget);

    await show(tester, inPlayer(find.text('Troisième message')));
    await tester.tap(inPlayer(find.text('Troisième message')));
    await tester.pumpAndSettle();
    expect(played(app), [1, 3]);
    await show(tester, find.text('À SUIVRE'));
    expect(inPlayer(find.text('Deuxième message')), findsNothing);
    expect(inPlayer(find.text('Quatrième message')), findsOneWidget);
  });

  testWidgets('the sleep timer pauses after the time chosen', (tester) async {
    final app = await openTeachings(tester);
    await tester.tap(find.text('Premier message'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Minuterie de sommeil'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dans 15 min'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Arrêt à '), findsOneWidget);

    await tester.pump(const Duration(minutes: 14));
    expect(app.player.snapshot.playing, isTrue);
    await tester.pump(const Duration(minutes: 1, seconds: 1));
    await tester.pumpAndSettle();
    expect(app.player.snapshot.playing, isFalse);
    expect(find.textContaining('Arrêt à '), findsNothing);
  });

  testWidgets('the sleep timer « à la fin de ce message » stops the '
      'sequence there, once; turned off, nothing stops', (tester) async {
    final app = await openTeachings(tester);
    await tester.tap(find.text('Premier message'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Minuterie de sommeil'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('À la fin de ce message'));
    await tester.pumpAndSettle();
    expect(find.text('Arrêt à la fin du message'), findsOneWidget);

    await end(tester, app);
    expect(played(app), [1]);
    expect(find.text('Arrêt à la fin du message'), findsNothing);

    // a timer set then turned off
    await tester.tap(find.byTooltip('Message suivant'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Minuterie de sommeil'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dans 30 min'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Minuterie de sommeil'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Désactiver la minuterie'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Arrêt à '), findsNothing);
    await tester.pump(const Duration(minutes: 31));
    expect(app.player.snapshot.playing, isTrue);
  });

  testWidgets('at the end of the page shown, the list is read further', (
    tester,
  ) async {
    final many = [
      for (var id = 1; id <= 21; id++) _message(id, 'Message numéro $id'),
    ];
    final app = await openTeachings(tester, teachings: many);

    await scrollTo(tester, find.text('Message numéro 20'));
    await tester.tap(find.text('Message numéro 20'));
    await tester.pumpAndSettle();
    expect(played(app), [20]);
    // the system has its « next » button: the list goes on
    expect(app.player.skipNext, isNotNull);

    await end(tester, app);
    expect(played(app), [20, 21]);
    expect(app.player.skipNext, isNull);
  });

  testWidgets('without network, what follows is what is kept on the phone', (
    tester,
  ) async {
    final files = FakeTeachingFiles()..kept.add(4);
    final app = await openTeachings(tester, files: files);
    await tester.tap(find.text('Premier message'));
    await tester.pumpAndSettle();

    app.player.offline = true;
    await end(tester, app);
    expect(played(app), [1, 4]);
    expect(app.player.opened.last.source.scheme, 'file');
    expect(app.player.snapshot.teaching?.id, 4);
  });

  testWidgets('without network and nothing kept, the player closes', (
    tester,
  ) async {
    final app = await openTeachings(tester);
    await tester.tap(find.text('Premier message'));
    await tester.pumpAndSettle();

    app.player.offline = true;
    await end(tester, app);
    expect(played(app), [1]);
    expect(app.player.snapshot.teaching, isNull);
  });

  testWidgets('the buttons of the lock screen and of the headphones go to '
      'the next and the previous message', (tester) async {
    final app = await openTeachings(tester);
    await tester.tap(find.text('Troisième message'));
    await tester.pumpAndSettle();

    await app.player.skipNext!();
    await tester.pumpAndSettle();
    expect(played(app), [3, 4]);
    expect(app.player.skipNext, isNull, reason: 'the last of the list');

    await app.player.skipPrevious!();
    await tester.pumpAndSettle();
    expect(played(app), [3, 4, 3]);

    // the player closed: no button left
    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Fermer le lecteur'));
    await tester.pumpAndSettle();
    expect(app.player.skipNext, isNull);
    expect(app.player.skipPrevious, isNull);
  });
}
