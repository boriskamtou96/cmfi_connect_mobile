import 'dart:convert';

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/biometrics.dart';
import 'package:cmfi_connect/src/core/services/local_notifications.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/features/souls/domain/soul.dart';
import 'package:cmfi_connect/src/features/souls/presentation/soul_screen.dart';
import 'package:cmfi_connect/src/features/souls/presentation/souls_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  Soul amina({DateTime? nextContact, SoulStage stage = SoulStage.met}) => Soul(
    id: 'a1',
    name: 'Amina Ngono',
    phone: '+237 6 99 00 00 00',
    place: 'Marché central',
    metOn: DateTime(2026, 10, 1),
    stage: stage,
    nextContact: nextContact,
    notes: [SoulNote(at: DateTime(2026, 10, 1), text: 'Veut lire la Bible')],
  );

  /// The souls of [sampleAccount] already kept.
  FakeSoulsStorage keeping(List<Soul> souls) => FakeSoulsStorage()
    ..saved[sampleAccount.id] = jsonEncode([
      for (final soul in souls) soul.toJson(),
    ]);

  Future<TestApp> openSouls(
    WidgetTester tester, {
    FakeSoulsStorage? storage,
    FakeBiometrics? biometrics,
    Map<String, Object> preferences = const {},
  }) async {
    final app = await pumpApp(
      tester,
      token: 't',
      account: sampleAccount,
      soulsStorage: storage,
      biometrics: biometrics,
      initialPreferences: preferences,
    );
    await openMore(tester);
    await scrollTo(tester, find.text('Suivi des âmes'));
    await tester.tap(find.text('Suivi des âmes'));
    await tester.pumpAndSettle();
    return app;
  }

  test('a soul kept as JSON, and the list as a spreadsheet', () {
    final soul = amina(nextContact: DateTime(2026, 10, 20));
    final back = Soul.fromJson(
      jsonDecode(jsonEncode(soul.toJson())) as Map<String, dynamic>,
    );
    expect(back.name, 'Amina Ngono');
    expect(back.nextContact, DateTime(2026, 10, 20));
    expect(back.notes.single.text, 'Veut lire la Bible');
    expect(back.initials, 'AN');
    expect(back.dialable, '+237699000000');

    final csv = soulsAsCsv(
      [soul],
      header: ['Nom', 'Téléphone'],
      stageName: (stage) => stage.name,
      day: (day) => '${day.day}/${day.month}',
    );
    expect(csv, startsWith('﻿Nom;Téléphone\r\n'));
    expect(
      csv,
      contains('Amina Ngono;+237 6 99 00 00 00;Marché central;1/10;met;20/10;'),
    );
  });

  testWidgets('a person added, kept in the Keychain of the account', (
    tester,
  ) async {
    final storage = FakeSoulsStorage();
    await openSouls(tester, storage: storage);

    expect(find.byType(SoulsScreen), findsOneWidget);
    expect(
      find.textContaining('Note ici les personnes que tu évangélises'),
      findsOneWidget,
    );
    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Nom'),
      'Paul Mbarga',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Téléphone'),
      '+237 677 11 22 33',
    );
    await tester.tap(find.text('A reçu Jésus'));
    await tester.enterText(
      find.widgetWithText(TextField, 'Une note (facultatif)'),
      'A prié au marché',
    );
    await scrollTo(tester, find.text('Enregistrer'));
    await tester.tap(find.text('Enregistrer'));
    await tester.pumpAndSettle();

    expect(find.text('Paul Mbarga'), findsOneWidget);
    final saved = jsonDecode(storage.saved[sampleAccount.id]!) as List;
    expect(saved.single['stage'], 'received');
    expect(saved.single['notes'].single['text'], 'A prié au marché');
  });

  testWidgets('followed: the stage, a note, the next contact', (tester) async {
    final app = await openSouls(tester, storage: keeping([amina()]));

    await tester.tap(find.text('Amina Ngono'));
    await tester.pumpAndSettle();
    expect(find.byType(SoulScreen), findsOneWidget);
    expect(find.text('Veut lire la Bible'), findsOneWidget);

    await tester.tap(find.byTooltip('WhatsApp'));
    expect(app.links.opened.last.toString(), 'https://wa.me/237699000000');

    await scrollTo(tester, find.text('Vient à l\'église'));
    await tester.tap(find.text('Vient à l\'église'));
    await tester.pumpAndSettle();

    await scrollTo(tester, find.byType(TextField));
    await tester.enterText(find.byType(TextField), 'Visite à la maison');
    await tester.pump();
    await tester.tap(find.byTooltip('Ajouter la note'));
    await tester.pumpAndSettle();
    expect(find.text('Visite à la maison'), findsOneWidget);

    final saved = jsonDecode(app.soulsStorage.saved[sampleAccount.id]!) as List;
    expect(saved.single['stage'], 'church');
    expect(saved.single['notes'], hasLength(2));
  });

  testWidgets('to contact again: first in the list, a reminder without a '
      'name', (tester) async {
    final day = today();
    final app = await openSouls(
      tester,
      storage: keeping([amina(nextContact: day.add(const Duration(days: 2)))]),
    );

    // the reminder of that day, at 9: nobody named on a locked screen
    final planned = app.notifications.groups[NotificationGroup.souls]!;
    expect(planned.single.at, day.add(const Duration(days: 2, hours: 9)));
    expect(planned.single.body, '1 personne à recontacter aujourd\'hui.');
    expect(planned.single.body, isNot(contains('Amina')));
    expect(find.textContaining('Prochain contact le'), findsOneWidget);
  });

  testWidgets('exported as a spreadsheet', (tester) async {
    final app = await openSouls(tester, storage: keeping([amina()]));

    await tester.tap(find.byTooltip("Plus d'options"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Exporter (tableur)'));
    await tester.pumpAndSettle();

    final file = app.share.files.single;
    expect(file.name, 'Suivi des âmes.csv');
    expect(utf8.decode(file.bytes), contains('Amina Ngono'));
  });

  testWidgets('locked: Face ID each time it is opened', (tester) async {
    final faceId = FakeBiometrics(available: BiometricKind.face, accept: false);
    await openSouls(
      tester,
      storage: keeping([amina()]),
      biometrics: faceId,
      preferences: {'souls_lock': true},
    );

    expect(faceId.prompts, ['Ouvre ton suivi des âmes']);
    expect(find.text('Amina Ngono'), findsNothing);
    expect(find.text('Ton suivi des âmes est verrouillé'), findsOneWidget);

    faceId.accept = true;
    await tester.tap(find.text('Déverrouiller'));
    await tester.pumpAndSettle();
    expect(find.text('Amina Ngono'), findsOneWidget);
  });
}
