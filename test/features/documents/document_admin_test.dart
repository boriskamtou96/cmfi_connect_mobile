import 'dart:typed_data';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  final admin = sampleAccount.copyWith(role: 'admin');

  Future<TestApp> openManage(WidgetTester tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      account: admin,
      membersApi: FakeMembersApi(account: admin),
    );
    await openMenu(tester);
    await tester.pumpAndSettle();
    await scrollTo(tester, inMenu('Gérer les documents'));
    await tester.tap(inMenu('Gérer les documents'));
    await tester.pumpAndSettle();
    return app;
  }

  Future<void> tapSave(WidgetTester tester) async {
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();
  }

  testWidgets('a member sees neither the menu row nor the shortcut', (
    tester,
  ) async {
    await pumpApp(tester, token: 't');
    await openMenu(tester);
    await tester.pumpAndSettle();
    expect(inMenu('Gérer les documents'), findsNothing);

    await scrollTo(tester, inMenu('Nos documents'));
    await tester.tap(inMenu('Nos documents'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Gérer les documents'), findsNothing);
  });

  testWidgets('an admin publishes a PDF: the file first, its name as the '
      'title, a category', (tester) async {
    final app = await openManage(tester);
    expect(find.text('Règlement intérieur'), findsOneWidget);
    expect(find.text("Fiche d'inscription"), findsOneWidget);

    app.documentPicker.next.add((
      bytes: Uint8List.fromList(List.filled(2048, 1)),
      name: 'Guide_du_disciple.pdf',
    ));
    await tester.tap(find.text('Nouveau document'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Choisir un PDF ou un Word'));
    await tester.pumpAndSettle();
    expect(app.documentsApi.uploaded, ['Guide_du_disciple.pdf']);
    expect(find.text('Guide_du_disciple.pdf'), findsOneWidget);
    // the file's name as a first title
    expect(find.text('Guide du disciple'), findsOneWidget);

    await tester.ensureVisible(find.widgetWithText(ChoiceChip, 'Formulaires'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'Formulaires'));
    await tester.pumpAndSettle();
    await tapSave(tester);

    final saved = app.documentsApi.saved.single;
    expect(saved.id, isNull);
    expect(saved.draft.title, 'Guide du disciple');
    expect(saved.draft.categoryId, 1);
    expect(saved.draft.fileId, 901);
    expect(saved.draft.fileName, 'Guide_du_disciple.pdf');
    expect(saved.draft.published, isTrue);
    expect(saved.draft.notify, isTrue);
    expect(app.toasts.messages, contains('Document enregistré'));
    // back on the list, the new one first
    expect(find.text('Guide du disciple'), findsOneWidget);
  });

  testWidgets('without a file, the form says so; a new category is typed', (
    tester,
  ) async {
    final app = await openManage(tester);
    await tester.tap(find.text('Nouveau document'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Cantiques');
    await tester.ensureVisible(find.text('Nouvelle catégorie'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Nouvelle catégorie'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).last, 'Chants');
    await tapSave(tester);
    expect(app.documentsApi.saved, isEmpty);
    expect(app.toasts.messages, contains('Choisis le fichier du document.'));

    app.documentPicker.next.add((
      bytes: Uint8List.fromList([1, 2, 3]),
      name: 'chants.docx',
    ));
    // back to the top of the form, where the file goes
    await tester.drag(find.byType(ListView).last, const Offset(0, 2000));
    await tester.pumpAndSettle();
    expect(find.text('Choisis le fichier du document.'), findsOneWidget);
    await tester.tap(find.text('Choisir un PDF ou un Word'));
    await tester.pumpAndSettle();
    await tapSave(tester);

    final draft = app.documentsApi.saved.single.draft;
    // the title typed is kept, not the file's name
    expect(draft.title, 'Cantiques');
    expect(draft.categoryId, isNull);
    expect(draft.newCategory, 'Chants');
    expect(draft.toJson()['category'], 'Chants');
  });

  testWidgets('a file over 10 MB is refused before being sent', (tester) async {
    final app = await openManage(tester);
    app.documentPicker.next.add((
      bytes: Uint8List(10 * 1024 * 1024 + 1),
      name: 'lourd.pdf',
    ));
    await tester.tap(find.text('Nouveau document'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Choisir un PDF ou un Word'));
    await tester.pumpAndSettle();

    expect(app.documentsApi.uploaded, isEmpty);
    expect(
      app.toasts.messages,
      contains('Ce fichier est trop lourd (10 Mo au plus).'),
    );
  });

  testWidgets('an admin keeps a document as a draft, then deletes it', (
    tester,
  ) async {
    final app = await openManage(tester);
    await tester.tap(find.text('Règlement intérieur'));
    await tester.pumpAndSettle();
    expect(find.text('Modifier le document'), findsOneWidget);
    // the file kept
    expect(find.text('Règlement intérieur.pdf'), findsOneWidget);

    await tester.ensureVisible(find.text('Publier maintenant'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Publier maintenant'));
    await tester.pumpAndSettle();
    await tapSave(tester);
    final saved = app.documentsApi.saved.single;
    expect(saved.id, 1);
    expect(saved.draft.published, isFalse);
    expect(saved.draft.fileId, 11);
    expect(find.text('Brouillon'), findsOneWidget);

    await tester.tap(find.text('Règlement intérieur'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Supprimer'));
    await tester.pumpAndSettle();
    expect(find.text('Supprimer ce document ?'), findsOneWidget);
    await tester.tap(find.text('Supprimer').last);
    await tester.pumpAndSettle();
    expect(app.documentsApi.deleted, [1]);
    expect(app.toasts.messages, contains('Document supprimé'));
    expect(find.text('Règlement intérieur'), findsNothing);
  });

  testWidgets('Nos documents has a shortcut for the admins', (tester) async {
    await pumpApp(
      tester,
      token: 't',
      account: admin,
      membersApi: FakeMembersApi(account: admin),
    );
    await openMenu(tester);
    await tester.pumpAndSettle();
    await scrollTo(tester, inMenu('Nos documents'));
    await tester.tap(inMenu('Nos documents'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Gérer les documents'));
    await tester.pumpAndSettle();
    expect(find.text('Nouveau document'), findsOneWidget);
  });
}
