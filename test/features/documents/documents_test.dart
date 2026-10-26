import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/documents/domain/library_document.dart';
import 'package:cmfi_connect/src/features/documents/presentation/documents_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Future<void> openDocuments(WidgetTester tester) async {
    await openMenu(tester);
    await tester.pumpAndSettle();
    await scrollTo(tester, inMenu('Nos documents'));
    await tester.tap(inMenu('Nos documents'));
    await tester.pumpAndSettle();
  }

  Future<void> search(WidgetTester tester, String words) async {
    await tester.enterText(find.byType(TextField), words);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
  }

  testWidgets('Plus › Communauté › Nos documents: the list, PDF and Word', (
    tester,
  ) async {
    await pumpApp(tester, token: 't');
    await openDocuments(tester);

    expect(find.byType(DocumentsScreen), findsOneWidget);
    expect(find.text('2 documents'), findsOneWidget);
    expect(find.text('Règlement intérieur'), findsOneWidget);
    expect(find.text('Règlements · 180 Ko'), findsOneWidget);
    expect(find.text('Formulaires · 2,4 Mo'), findsOneWidget);
    expect(find.text('PDF'), findsOneWidget);
    expect(find.text('Word'), findsOneWidget);
  });

  testWidgets('the search and the category chips', (tester) async {
    final app = await pumpApp(tester, token: 't');
    await openDocuments(tester);

    // accents left aside
    await search(tester, 'reglement');
    expect(find.text('1 document'), findsOneWidget);
    expect(find.text("Fiche d'inscription"), findsNothing);
    expect(app.documentsApi.queriesAsked.last.search, 'reglement');

    await search(tester, 'rien de tel');
    expect(
      find.text('Aucun document ne correspond à ta recherche.'),
      findsOneWidget,
    );

    await search(tester, '');
    // the chip carries the slug the server filters by
    await tester.tap(find.widgetWithText(ChoiceChip, 'Formulaires'));
    await tester.pumpAndSettle();
    expect(app.documentsApi.queriesAsked.last.category, 'formulaires');
    expect(find.text("Fiche d'inscription"), findsOneWidget);
    expect(find.text('Règlement intérieur'), findsNothing);
    await tester.tap(find.widgetWithText(ChoiceChip, 'Tous'));
    await tester.pumpAndSettle();
    expect(find.text('2 documents'), findsOneWidget);
  });

  testWidgets('the next page comes at the end of the list', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      documentsApi: FakeDocumentsApi(
        documents: [
          for (var i = 1; i <= 25; i++)
            LibraryDocument(
              id: i,
              title: 'Enseignement $i',
              category: 'Enseignements',
              file: LibraryFile(id: 100 + i, url: '/v1/media/$i.pdf'),
            ),
        ],
      ),
    );
    await openDocuments(tester);

    expect(find.text('25 documents'), findsOneWidget);
    expect(app.documentsApi.pagesAsked, [1]);
    await tester.fling(
      find.byType(CustomScrollView),
      const Offset(0, -6000),
      3000,
    );
    await tester.pumpAndSettle();
    expect(app.documentsApi.pagesAsked, [1, 2]);
    expect(find.text('Enseignement 25'), findsOneWidget);
    expect(find.text('Voir plus'), findsNothing);
  });

  testWidgets('nothing published yet', (tester) async {
    await pumpApp(
      tester,
      token: 't',
      documentsApi: FakeDocumentsApi(documents: const []),
    );
    await openDocuments(tester);

    expect(find.textContaining('Aucun document pour l'), findsOneWidget);
  });

  testWidgets('without network: try again', (tester) async {
    final app = await pumpApp(
      tester,
      token: 't',
      documentsApi: FakeDocumentsApi(offline: true),
    );
    await openDocuments(tester);

    expect(find.text('Réessayer'), findsOneWidget);
    app.documentsApi.offline = false;
    await tester.tap(find.text('Réessayer'));
    await tester.pumpAndSettle();
    expect(find.text('Règlement intérieur'), findsOneWidget);
  });

  testWidgets('the arrow keeps the file on the phone, with its name', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    await openDocuments(tester);

    await tester.tap(find.byTooltip('Télécharger').last);
    await tester.pumpAndSettle();
    expect(app.share.files.single.name, 'Inscription.docx');
  });
}
