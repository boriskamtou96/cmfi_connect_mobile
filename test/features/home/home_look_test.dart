import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/widgets/photo_kit.dart';
import 'package:cmfi_connect/src/features/ministry/presentation/ministry_screen.dart';
import 'package:cmfi_connect/src/features/teachings/presentation/teaching_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/pump_app.dart';

/// The pictures drawn from [asset].
Finder assetImage(String asset) => find.byWidgetPredicate(
  (widget) =>
      widget is Image &&
      widget.image is AssetImage &&
      (widget.image as AssetImage).assetName == asset,
);

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  testWidgets('the verse of the day is on a photo, with the Bible and share', (
    tester,
  ) async {
    await pumpApp(tester, token: 't');
    await scrollTo(tester, find.byTooltip('Partager le verset'));

    expect(find.text('Verset du jour'), findsOneWidget);
    expect(assetImage(StockPhotos.reading), findsOneWidget);
    expect(find.byTooltip('Lire dans la Bible'), findsOneWidget);
    expect(find.byTooltip('Partager le verset'), findsOneWidget);
  });

  testWidgets('our ministry shows our founder and our leader, and opens', (
    tester,
  ) async {
    await pumpApp(tester, token: 't');
    await scrollTo(tester, find.text('Notre ministère'));

    // real faces of the ministry, never stock photos
    expect(assetImage('assets/ministry/founder.jpg'), findsOneWidget);
    expect(assetImage('assets/ministry/leader.jpg'), findsOneWidget);

    await tester.tap(find.text('Notre ministère'));
    await tester.pumpAndSettle();
    expect(find.byType(MinistryScreen), findsOneWidget);
  });

  testWidgets('« À écouter »: the latest teachings, a touch plays one', (
    tester,
  ) async {
    final app = await pumpApp(tester, token: 't');
    await scrollTo(tester, find.text('Le message de la croix'));
    expect(find.text('À écouter'), findsOneWidget);

    await tester.tap(find.text('Le message de la croix'));
    await tester.pumpAndSettle();
    expect(find.byType(TeachingPlayerScreen), findsOneWidget);
    expect(app.player.snapshot.teaching?.id, 1);
  });
}
