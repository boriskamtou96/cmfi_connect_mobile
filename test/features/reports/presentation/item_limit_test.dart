import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/theme/app_icons.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:cmfi_connect/src/features/reports/presentation/items_screen.dart';
import 'package:cmfi_connect/src/features/reports/presentation/new_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/pump_app.dart';
import '../application/item_limit_test.dart' show personalItems;

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  final standards = [
    for (final item in sampleActivities)
      if (item.isStandard) item,
  ];

  /// The report with [personal] items of the member's own, then « Mes
  /// éléments » open.
  Future<TestApp> openItems(
    WidgetTester tester, {
    required int personal,
    bool premium = false,
    bool admin = false,
  }) async {
    final account = admin ? sampleAccount.copyWith(role: 'admin') : null;
    final app = await pumpApp(
      tester,
      token: 'saved-token',
      premium: FakePremiumStore(active: premium),
      account: account,
      membersApi: account == null ? null : FakeMembersApi(account: account),
      activities: <ActivityType>[...standards, ...personalItems(personal)],
    );
    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Mes éléments'));
    await tester.pumpAndSettle();
    return app;
  }

  // FilledButton.icon is a private subclass: matched by its type
  Finder createButton() => find.ancestor(
    of: find.text('Créer un élément'),
    matching: find.byWidgetPredicate((widget) => widget is FilledButton),
  );

  /// Down to the button (and its counter) under the items.
  Future<void> showCreate(WidgetTester tester) async {
    final list = find.descendant(
      of: find.byType(ItemsScreen),
      matching: find.byType(Scrollable),
    );
    await tester.scrollUntilVisible(
      createButton(),
      200,
      scrollable: list.first,
    );
    await tester.ensureVisible(createButton());
    await tester.pumpAndSettle();
  }

  testWidgets('under the limit: « 3 sur 5 », and the form opens', (
    tester,
  ) async {
    await openItems(tester, personal: 3);
    await showCreate(tester);

    expect(find.text('3 sur 5'), findsOneWidget);
    expect(find.byIcon(AppIcons.premiumLock), findsNothing);

    await tester.tap(createButton());
    await tester.pumpAndSettle();

    expect(find.byType(NewItemScreen), findsOneWidget);
  });

  testWidgets('at 5 without Premium: a lock, a kind word, then Premium', (
    tester,
  ) async {
    final app = await openItems(tester, personal: 5);
    await showCreate(tester);

    expect(find.text('5 sur 5'), findsOneWidget);
    expect(
      find.descendant(
        of: createButton(),
        matching: find.byIcon(AppIcons.premiumLock),
      ),
      findsOneWidget,
    );

    await tester.tap(createButton());
    await tester.pumpAndSettle();

    expect(find.byType(NewItemScreen), findsNothing);
    expect(find.text("Plus d'éléments avec Premium"), findsOneWidget);
    expect(
      find.textContaining("jusqu'à 5 éléments personnels"),
      findsOneWidget,
    );

    await tester.tap(find.text('Découvrir Premium'));
    await tester.pumpAndSettle();

    // the Premium page, with the new benefit
    expect(find.text('Éléments illimités'), findsOneWidget);
    expect(app.activitiesApi.activities.length, standards.length + 5);
  });

  testWidgets('« Plus tard » closes the window and stays on the items', (
    tester,
  ) async {
    await openItems(tester, personal: 5);
    await showCreate(tester);

    await tester.tap(createButton());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Plus tard'));
    await tester.pumpAndSettle();

    expect(find.text("Plus d'éléments avec Premium"), findsNothing);
    expect(find.text('Éléments illimités'), findsNothing);
    expect(find.text('5 sur 5'), findsOneWidget);
  });

  testWidgets('more than 5 from before: all kept and editable, none more', (
    tester,
  ) async {
    await openItems(tester, personal: 7);

    for (var i = 0; i < 7; i++) {
      expect(
        find.byTooltip('Modifier P$i', skipOffstage: false),
        findsOneWidget,
      );
    }
    await showCreate(tester);
    expect(find.text('7 sur 5'), findsOneWidget);
    await tester.tap(createButton());
    await tester.pumpAndSettle();
    expect(find.text("Plus d'éléments avec Premium"), findsOneWidget);
    await tester.tap(find.text('Plus tard'));
    await tester.pumpAndSettle();

    // still usable: renamed like any item
    await tester.scrollUntilVisible(find.byTooltip('Modifier P6'), -200);
    await tester.tap(find.byTooltip('Modifier P6'));
    await tester.pumpAndSettle();
    expect(find.text("Modifier l'élément"), findsOneWidget);
  });

  testWidgets('archiving an item frees a place', (tester) async {
    await openItems(tester, personal: 5);

    await tester.tap(find.text('Archiver').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Archiver').last);
    await tester.pumpAndSettle();

    await showCreate(tester);
    expect(find.text('4 sur 5'), findsOneWidget);
    await tester.tap(createButton());
    await tester.pumpAndSettle();
    expect(find.byType(NewItemScreen), findsOneWidget);
  });

  testWidgets('with Premium: no counter, no lock, the form opens', (
    tester,
  ) async {
    await openItems(tester, personal: 9, premium: true);

    expect(find.textContaining('sur 5', skipOffstage: false), findsNothing);
    await showCreate(tester);
    expect(
      find.descendant(
        of: createButton(),
        matching: find.byIcon(AppIcons.premiumLock),
      ),
      findsNothing,
    );

    await tester.tap(createButton());
    await tester.pumpAndSettle();
    expect(find.byType(NewItemScreen), findsOneWidget);
  });

  testWidgets('the team (Premium offered) creates without limit', (
    tester,
  ) async {
    await openItems(tester, personal: 6, admin: true);

    expect(find.textContaining('sur 5', skipOffstage: false), findsNothing);
    await showCreate(tester);
    await tester.tap(createButton());
    await tester.pumpAndSettle();
    expect(find.byType(NewItemScreen), findsOneWidget);
  });

  testWidgets('the row of the day is locked the same way', (tester) async {
    await pumpApp(
      tester,
      token: 'saved-token',
      activities: <ActivityType>[...standards, ...personalItems(5)],
    );
    await tester.tap(find.text('Compte rendu').last);
    await tester.pumpAndSettle();

    final row = find.text('Créer un élément');
    await tester.scrollUntilVisible(row, 200);
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();
    await tester.tap(row);
    await tester.pumpAndSettle();

    expect(find.byType(NewItemScreen), findsNothing);
    expect(find.text("Plus d'éléments avec Premium"), findsOneWidget);
  });
}
