import 'dart:typed_data';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/features/events/application/events_providers.dart';
import 'package:cmfi_connect/src/features/events/domain/event.dart';
import 'package:cmfi_connect/src/features/events/infrastructure/events_local_store.dart';
import 'package:cmfi_connect/src/features/hymns/presentation/hymn_reader_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  /// From the home card to the event page.
  Future<void> openEvent(WidgetTester tester) async {
    await tester.scrollUntilVisible(find.text('PROCHAIN ÉVÈNEMENT'), 200);
    // brought to the top: the bottom of the list runs under the tab bar
    await tester.ensureVisible(find.text('Conférence annuelle 2026'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Conférence annuelle 2026'));
    await tester.pumpAndSettle();
  }

  Future<void> scrollTo(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(
      finder,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the home card shows the next event and its countdown', (
    tester,
  ) async {
    await pumpApp(tester, token: 't');
    await tester.scrollUntilVisible(find.text('PROCHAIN ÉVÈNEMENT'), 200);

    expect(find.text('Conférence annuelle 2026'), findsOneWidget);
    expect(find.text('J-42'), findsOneWidget);
  });

  testWidgets('the event page shows the theme, the facts and the program', (
    tester,
  ) async {
    await pumpApp(tester, token: 't');
    await openEvent(tester);

    expect(find.text("Marcher dans l'Esprit"), findsWidgets);
    expect(find.text('Dans 42 jours'), findsOneWidget);
    await scrollTo(tester, find.text('128 inscrits'));
    // "1 160", with the French thousands separator
    expect(
      find.textContaining(RegExp(r'^340 personnes · 1\s160 places restantes$')),
      findsOneWidget,
    );
    await scrollTo(tester, find.text("Culte d'ouverture"));
    expect(find.text('Accueil et inscriptions'), findsOneWidget);
    expect(find.text('Cantique 1'), findsOneWidget);

    // the next day
    final days = find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          widget.data == '${DateTime.now().add(const Duration(days: 43)).day}',
    );
    await tester.tap(days.first);
    await tester.pumpAndSettle();
    expect(
      find.text('Enseignement : « Conduits par l\'Esprit »'),
      findsOneWidget,
    );
    expect(find.text("Culte d'ouverture"), findsNothing);
  });

  testWidgets('a hymn of the program opens in the hymn book', (tester) async {
    await pumpApp(tester, token: 't');
    await openEvent(tester);
    await scrollTo(tester, find.text('Cantique 1'));

    await tester.tap(find.text('Cantique 1'));
    await tester.pumpAndSettle();

    expect(find.byType(HymnReaderScreen), findsOneWidget);
  });

  testWidgets('registering: how many, lodging, city, then reminded', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    await openEvent(tester);

    await tester.tap(find.text('Je participe'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Une personne de plus'));
    await tester.tap(find.text("J'ai besoin d'un hébergement"));
    await tester.enterText(find.byType(TextField), 'Douala');
    await tester.pump();
    await tester.tap(find.text('Confirmer mon inscription'));
    await tester.pumpAndSettle();

    expect(app.toasts.messages, [
      "C'est noté, tu es inscrit ! On te le rappellera la veille.",
    ]);
    expect(find.text('Tu es inscrit'), findsOneWidget);
    expect(find.text('2 personnes · hébergement · Douala'), findsOneWidget);
    await scrollTo(tester, find.text('129 inscrits'));
    expect(app.eventsApi.events[2]?.myRegistration?.people, 2);
    // the evening before and an hour before
    expect(app.notifications.plannedEvents, hasLength(2));
    expect(app.notifications.permissionAsked, isTrue);
  });

  testWidgets('a full event says so, and nothing changes', (tester) async {
    final api = FakeEventsApi()
      ..registerError = const ApiException(
        status: 409,
        code: 'EVENT_FULL',
        message: '',
      );
    final app = await pumpApp(tester, token: 't', eventsApi: api);
    await openEvent(tester);

    await tester.tap(find.text('Je participe'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirmer mon inscription'));
    await tester.pumpAndSettle();

    expect(app.toasts.errors, ["Il n'y a plus de place pour cet évènement."]);
    expect(find.text('Tu es inscrit'), findsNothing);
  });

  testWidgets('cancelling a registration frees the place', (tester) async {
    final api = FakeEventsApi();
    await api.register(2, people: 3);
    final app = await pumpApp(tester, token: 't', eventsApi: api);
    await openEvent(tester);

    expect(find.text('Tu es inscrit'), findsOneWidget);
    await tester.tap(find.text('Modifier'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Annuler mon inscription'));
    await tester.pumpAndSettle();
    // the confirmation
    await tester.tap(find.text('Annuler mon inscription').last);
    await tester.pumpAndSettle();

    expect(app.toasts.messages, ['Ton inscription est annulée.']);
    expect(find.text('Je participe'), findsOneWidget);
    expect(app.eventsApi.events[2]?.myRegistration, isNull);
  });

  testWidgets('add to the calendar and directions', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await openEvent(tester);

    await scrollTo(tester, find.text('Itinéraire'));
    await tester.tap(find.text('Itinéraire'));
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text('Ajouter au calendrier'));
    await tester.tap(find.text('Ajouter au calendrier'));
    await tester.pumpAndSettle();

    expect(app.calendar.added, ['Conférence annuelle 2026']);
    expect(app.links.opened.single.toString(), 'https://maps.example/mvolye');
  });

  testWidgets('the list: the next event large, then the past editions', (
    tester,
  ) async {
    await pumpApp(tester, token: 't');
    await tester.scrollUntilVisible(find.text('PROCHAIN ÉVÈNEMENT'), 200);
    await tester.scrollUntilVisible(find.text('Tous les évènements'), 200);
    // above the tab bar
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -200));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tous les évènements'));
    await tester.pumpAndSettle();

    expect(find.text('À LA UNE'), findsOneWidget);
    await scrollTo(tester, find.text('Conférence annuelle 2025'));
    expect(find.text('ÉDITIONS PASSÉES'), findsOneWidget);
  });

  testWidgets('several events: a carousel of posters on the home screen', (
    tester,
  ) async {
    final next = sampleEvents().next;
    await pumpApp(
      tester,
      token: 't',
      eventsApi: FakeEventsApi(
        upcoming: [
          next,
          next.copyWith(id: 3, title: 'Retraite des jeunes'),
          next.copyWith(id: 4, title: 'Campagne d\'évangélisation'),
        ],
      ),
    );
    final carousel = find.byType(PageView);
    await tester.scrollUntilVisible(
      carousel,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -250));
    await tester.pumpAndSettle();

    expect(find.text('Conférence annuelle 2026'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Évènement 1 sur 3')), findsOneWidget);
    // one card at a time, the next one peeking
    for (var i = 0; i < 3; i++) {
      await tester.drag(carousel, const Offset(-300, 0));
      await tester.pumpAndSettle();
    }
    expect(find.text('3 évènements à venir'), findsOneWidget);
    await tester.tap(find.text('Tous les évènements'));
    await tester.pumpAndSettle();
    expect(find.text('À LA UNE'), findsOneWidget);
  });

  testWidgets('without network, the events kept on the phone show', (
    tester,
  ) async {
    final api = FakeEventsApi();
    final app = await pumpApp(tester, token: 't', eventsApi: api);
    await openEvent(tester);
    expect(
      app.container.read(eventsLocalStoreProvider).event(2)?.title,
      'Conférence annuelle 2026',
    );

    api.offline = true;
    app.container.invalidate(eventListProvider);
    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    await openEvent(tester);

    await scrollTo(tester, find.text('Accueil et inscriptions'));
  });

  testWidgets('no upcoming event: the home card opens the list', (
    tester,
  ) async {
    await pumpApp(
      tester,
      token: 't',
      eventsApi: FakeEventsApi(upcoming: const []),
    );
    await tester.scrollUntilVisible(
      find.text(
        'Les rencontres de la communauté, leur programme et leurs actualités.',
      ),
      200,
    );
    await tester.ensureVisible(
      find.text(
        'Les rencontres de la communauté, leur programme et leurs actualités.',
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find.text(
        'Les rencontres de la communauté, leur programme et leurs actualités.',
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Aucun évènement à venir'), findsOneWidget);
  });

  group('admins', () {
    final admin = sampleAccount.copyWith(role: 'admin');

    testWidgets('a member sees no admin menu', (tester) async {
      await pumpApp(tester, token: 't');
      await openEvent(tester);

      expect(find.byTooltip('Gérer'), findsNothing);
    });

    testWidgets('an admin creates an event with its poster', (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        account: admin,
        membersApi: FakeMembersApi(account: admin),
      );
      app.picker.next.add((
        bytes: Uint8List.fromList([1, 2, 3]),
        name: 'affiche.jpg',
      ));
      await openMore(tester);
      await tester.pumpAndSettle();
      await scrollToEnd(tester);
      await tester.tap(find.text('Évènements').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Créer un évènement'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Choisir une affiche'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, 'Retraite');
      await tester.pump();
      await tester.scrollUntilVisible(
        find.text('Publié'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      // above the save button
      await tester.ensureVisible(find.text('Publié'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Publié'));
      await tester.pump();
      await tester.tap(find.text('Enregistrer'));
      await tester.pumpAndSettle();

      final draft = app.eventsApi.drafts.single;
      expect(draft.title, 'Retraite');
      expect(draft.posterId, 101);
      expect(draft.status, EventStatus.published);
      expect(draft.endsAt.isAfter(draft.startsAt), isTrue);
      expect(app.eventsApi.uploads, ['affiche.jpg']);
      expect(app.toasts.messages, ['Évènement enregistré.']);
      // the new event opens
      expect(find.text('Retraite'), findsWidgets);
    });

    testWidgets('an admin posts news', (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        account: admin,
        membersApi: FakeMembersApi(account: admin),
      );
      await openEvent(tester);

      await tester.tap(find.byTooltip('Gérer'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Publier une actualité'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField).first,
        'Le car part à 6 h.',
      );
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Publier'));
      await tester.pumpAndSettle();

      expect(app.toasts.messages, ['Actualité publiée.']);
      expect(app.eventsApi.events[2]?.posts.first.body, 'Le car part à 6 h.');
    });

    testWidgets('an admin sees who registered and exports the list', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        token: 't',
        account: admin,
        membersApi: FakeMembersApi(account: admin),
      );
      await openEvent(tester);
      await tester.tap(find.byTooltip('Gérer'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Inscrits'));
      await tester.pumpAndSettle();

      expect(find.text('Marie Ngo'), findsOneWidget);
      expect(find.text('3 personnes · hébergement · Douala'), findsOneWidget);

      await tester.tap(find.byTooltip('Exporter la liste (CSV)'));
      await tester.pumpAndSettle();

      final file = app.share.files.single;
      expect(file.name, 'conference-annuelle-2026-inscrits.csv');
      final text = String.fromCharCodes(file.bytes.skip(3));
      expect(text, contains('Marie Ngo;marie.ngo;+237690000002'));
    });
  });
}
