import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/authorities/domain/authority.dart';
import 'package:cmfi_connect/src/features/members/domain/member.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<void> openAuthorities(WidgetTester tester) async {
    await openMore(tester);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mes autorités spirituelles'));
    await tester.pumpAndSettle();
  }

  Future<void> fillForm(
    WidgetTester tester, {
    required String firstName,
    required String phone,
  }) async {
    // someone without the app: typed by hand
    await tester.tap(find.textContaining('Saisir ses coordonnées'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), firstName);
    await tester.enterText(fields.at(1), 'Tientcheu');
    await tester.enterText(fields.at(2), phone);
    await tester.pump();
  }

  testWidgets('add the disciple maker from the empty list', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await openAuthorities(tester);

    expect(find.text("Tu n'as encore ajouté personne."), findsOneWidget);

    await tester.tap(find.text('Ajouter une autorité'));
    await tester.pumpAndSettle();
    await fillForm(tester, firstName: 'Marc', phone: '697881122');
    await tester.tap(find.text("C'est mon faiseur de disciples"));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Ajouter'));
    await tester.pumpAndSettle();

    final saved = app.authoritiesApi.authorities.single;
    expect(saved.phoneNumber, '+237697881122');
    expect(saved.isDiscipleMaker, isTrue);
    expect(find.text('Marc Tientcheu'), findsOneWidget);
    expect(find.text('FAISEUR DE DISCIPLES'), findsOneWidget);

    // the "Plus" tab names the disciple maker
    await tester.tap(find.byTooltip('Retour'));
    await tester.pumpAndSettle();
    expect(find.text('Faiseur de disciples : Marc Tientcheu'), findsOneWidget);
  });

  testWidgets('only one disciple maker: the switch explains why it is off', (
    tester,
  ) async {
    final app = await pumpApp(
      tester,
      token: 't',
      authoritiesApi: FakeAuthoritiesApi(const [
        Authority(
          id: 3,
          firstName: 'Marc',
          lastName: 'Tientcheu',
          phoneNumber: '+237697881122',
          isDiscipleMaker: true,
        ),
      ]),
    );
    await openAuthorities(tester);

    await tester.tap(find.text('Ajouter une autorité'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Marc Tientcheu est déjà ton faiseur de disciples'),
      findsOneWidget,
    );

    await fillForm(tester, firstName: 'Clarisse', phone: '677554433');
    await tester.tap(find.widgetWithText(FilledButton, 'Ajouter'));
    await tester.pumpAndSettle();

    expect(app.authoritiesApi.authorities.last.isDiscipleMaker, isFalse);
    expect(find.text('AUTRES AUTORITÉS'), findsOneWidget);
  });

  testWidgets('remove someone after confirming', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      authoritiesApi: FakeAuthoritiesApi(const [
        Authority(
          id: 4,
          firstName: 'Clarisse',
          lastName: 'Nguele',
          phoneNumber: '+237677554433',
        ),
      ]),
    );
    await openAuthorities(tester);

    await tester.tap(find.byTooltip('Retirer'));
    await tester.pumpAndSettle();
    expect(find.text('Retirer Clarisse Nguele ?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Retirer'));
    await tester.pumpAndSettle();

    expect(app.authoritiesApi.authorities, isEmpty);
    expect(find.text("Tu n'as encore ajouté personne."), findsOneWidget);
  });

  testWidgets('another authority becomes the disciple maker', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      authoritiesApi: FakeAuthoritiesApi(const [
        Authority(
          id: 4,
          firstName: 'Marc',
          lastName: 'Ndi',
          phoneNumber: '+237677554433',
          isDiscipleMaker: true,
        ),
        Authority(
          id: 5,
          firstName: 'Paul',
          lastName: 'Eto',
          phoneNumber: '+237677554434',
        ),
      ]),
    );
    await openAuthorities(tester);

    await tester.tap(find.byTooltip('Faire mon faiseur de disciples'));
    await tester.pumpAndSettle();
    expect(
      find.text('Faire de Paul Eto ton faiseur de disciples ?'),
      findsOneWidget,
    );
    expect(
      find.text('Paul Eto sera prévenu. Marc Ndi reste parmi tes autorités.'),
      findsOneWidget,
    );
    await tester.tap(
      find.widgetWithText(FilledButton, 'Faire mon faiseur de disciples'),
    );
    await tester.pumpAndSettle();

    expect(app.toasts.messages, [
      'Paul Eto est maintenant ton faiseur de disciples.',
    ]);
    final authorities = app.authoritiesApi.authorities;
    expect(authorities.firstWhere((a) => a.id == 5).isDiscipleMaker, isTrue);
    expect(authorities.firstWhere((a) => a.id == 4).isDiscipleMaker, isFalse);
    // Marc is now among the others: he can become it again
    expect(find.byTooltip('Faire mon faiseur de disciples'), findsOneWidget);
  });

  Future<void> searchPseudo(WidgetTester tester, String username) async {
    await tester.tap(find.text('Ajouter une autorité'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, username);
    await tester.tap(find.byTooltip('Rechercher'));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'a member found by pseudo gets a request, pending until they answer',
    (tester) async {
      final app = await pumpApp(tester, token: 't');
      await openAuthorities(tester);

      await searchPseudo(tester, '@Marc.Tientcheu');
      expect(find.text('Marc Tientcheu'), findsOneWidget);
      expect(find.text('@marc.tientcheu · PSU-Yaoundé'), findsOneWidget);

      await tester.tap(find.text("C'est mon faiseur de disciples"));
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Envoyer la demande'));
      await tester.pumpAndSettle();

      expect(app.toasts.messages, ['Demande envoyée à Marc Tientcheu.']);
      final asked = app.authoritiesApi.authorities.single;
      expect(asked.username, 'marc.tientcheu');
      expect(asked.isDiscipleMaker, isTrue);
      expect(find.text('En attente'), findsOneWidget);
      expect(find.text('@marc.tientcheu'), findsOneWidget);
    },
  );

  testWidgets('nobody with this pseudo: invite them to join', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await openAuthorities(tester);

    await searchPseudo(tester, 'paul.inconnu');
    expect(find.text("Personne n'a le pseudo @paul.inconnu."), findsOneWidget);
    // nothing to send a request to
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'Envoyer la demande'),
          )
          .onPressed,
      isNull,
    );

    await tester.tap(find.text("L'inviter à rejoindre CMFI Connect"));
    await tester.pumpAndSettle();
    expect(app.share.texts.single, contains('Mon pseudo : @boris.kamtou'));
  });

  testWidgets('one cannot be their own authority', (tester) async {
    await pumpApp(tester, token: 't');
    await openAuthorities(tester);

    await searchPseudo(tester, 'boris.kamtou');

    expect(find.text("C'est ton propre pseudo."), findsOneWidget);
  });

  testWidgets('a request received is accepted from the list', (tester) async {
    final app = await pumpApp(
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
    await openMore(tester);
    await tester.pumpAndSettle();
    expect(find.text('1 demande à voir'), findsOneWidget);

    await tester.tap(find.text('Mes autorités spirituelles'));
    await tester.pumpAndSettle();
    expect(find.text('DEMANDES REÇUES'), findsOneWidget);
    expect(
      find.text("Te demande d'être son faiseur de disciples"),
      findsOneWidget,
    );

    await tester.tap(find.text('Accepter'));
    await tester.pumpAndSettle();

    expect(app.authoritiesApi.answers, {9: true});
    expect(app.toasts.messages, ['Tu accompagnes maintenant Clarisse Nguele.']);
    expect(find.text('DEMANDES REÇUES'), findsNothing);
  });

  testWidgets('the push of a request opens the authorities', (tester) async {
    final app = await pumpApp(tester, token: 't');
    app.push.tapsController.add({'type': 'authority_request', 'id': '7'});
    await tester.pumpAndSettle();
    expect(find.text('Mes autorités spirituelles'), findsWidgets);
  });
}

