import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/features/reports/domain/reading_book.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('a book is corrected: its title, author and pages', (
    tester,
  ) async {
    final reading = FakeReadingApi(
      books: [
        ReadingBook(
          id: 7,
          title: 'Le chemin de l’obeissance',
          author: 'Fomum',
          totalPages: 204,
          coverUrl: 'https://covers.openlibrary.org/b/id/7-M.jpg',
          startedOn: DateTime(2026, 11, 2),
          pagesRead: 40,
        ),
      ],
    );
    final app = await pumpApp(tester, token: 'test-token', readingApi: reading);
    app.container.read(appRouterProvider).push(const ReadingRoute()).ignore();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Le chemin de l’obeissance'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Modifier'));
    await tester.pumpAndSettle();
    expect(find.text('Modifier le livre'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(1), 'Z. T. Fomum');
    await tester.enterText(fields.at(2), '240');
    await tester.tap(find.widgetWithText(FilledButton, 'Enregistrer'));
    await tester.pumpAndSettle();

    final edited = reading.edits.single;
    expect(edited.author, 'Z. T. Fomum');
    expect(edited.totalPages, 240);
    // another author: the server looks for the cover again
    expect(edited.coverUrl, '');
    expect(app.toasts.messages, ['Livre modifié.']);
    expect(find.text('Modifier le livre'), findsNothing);
  });
}
