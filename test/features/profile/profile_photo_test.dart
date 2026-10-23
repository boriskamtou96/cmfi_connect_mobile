import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/network/app_exception.dart';
import 'package:cmfi_connect/src/features/events/domain/event.dart';
import 'package:cmfi_connect/src/features/members/presentation/widgets/member_avatar.dart';
import 'package:cmfi_connect/src/features/prayer/domain/prayer.dart';
import 'package:cmfi_connect/src/features/profile/domain/photo_crop.dart';
import 'package:cmfi_connect/src/features/profile/presentation/photo_crop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

const avatar = EventImage(
  id: 9,
  url: '/v1/media/me.jpg',
  width: 512,
  height: 512,
  color: '#7A5A3C',
);

/// A real PNG of [width] × [height] pixels, as the gallery gives one.
Future<Uint8List> picture(
  WidgetTester tester, {
  int width = 40,
  int height = 20,
}) async => (await tester.runAsync(() async {
  final recorder = ui.PictureRecorder();
  Canvas(recorder).drawRect(
    Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
    Paint()..color = const Color(0xFF0A5EA8),
  );
  final image = await recorder.endRecording().toImage(width, height);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);
  return data!.buffer.asUint8List();
}))!;

/// The app, with a picture ready in the gallery (decoded beforehand).
Future<TestApp> pumpWithPicture(WidgetTester tester) async {
  final bytes = await picture(tester);
  final decoded = (await tester.runAsync(() => decodeImageFromList(bytes)))!;
  addTearDown(decoded.dispose);
  final app = await pumpApp(
    tester,
    token: 't',
    photoDecoder: (_) async => decoded.clone(),
  );
  app.picker.next.add((bytes: bytes, name: 'me.png'));
  return app;
}

/// Lets the real work of the crop screen (decoding, encoding) end: real time
/// passes until no spinner turns anymore.
Future<void> settleForReal(WidgetTester tester) async {
  for (var i = 0; i < 40; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pump(const Duration(milliseconds: 100));
    if (find.byType(CircularProgressIndicator).evaluate().isEmpty) {
      break;
    }
  }
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(initializeDateFormatting);
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  group('the part of the picture kept', () {
    const image = Size(1000, 500);

    test('centered at first: the middle square of a wide picture', () {
      // laid out 600 × 300 in a circle of 300, moved by half the overflow
      expect(
        visiblePart(
          image: image,
          viewport: 300,
          zoom: 1,
          offset: const Offset(-150, 0),
        ),
        const Rect.fromLTWH(250, 0, 500, 500),
      );
    });

    test('zoomed in twice and moved: a smaller square', () {
      expect(
        visiblePart(
          image: image,
          viewport: 300,
          zoom: 2,
          offset: const Offset(-450, -150),
        ),
        const Rect.fromLTWH(375, 125, 250, 250),
      );
    });

    test('never outside the picture', () {
      final part = visiblePart(
        image: image,
        viewport: 300,
        zoom: 1,
        offset: const Offset(-5000, 80),
      );
      expect(part, const Rect.fromLTWH(500, 0, 500, 500));
    });
  });

  group('my photo', () {
    testWidgets('picked in the gallery, cropped, sent: it shows on the home '
        'screen', (tester) async {
      final app = await pumpWithPicture(tester);
      expect(
        find.descendant(
          of: find.byType(MemberAvatar),
          matching: find.byType(Image),
        ),
        findsNothing,
      );

      await openProfile(tester);
      await tester.tap(find.bySemanticsLabel('Ajouter une photo de profil'));
      await tester.pumpAndSettle();
      expect(find.text('Photo de profil'), findsOneWidget);
      expect(find.text('Retirer la photo'), findsNothing);
      await tester.tap(find.text('Choisir dans la galerie'));
      await settleForReal(tester);

      expect(app.picker.cameraCalls, [false]);
      expect(find.byType(PhotoCropScreen), findsOneWidget);
      expect(find.text('Recadre ta photo'), findsOneWidget);
      await tester.runAsync(
        () async => tester.tap(find.text('Utiliser cette photo')),
      );
      await settleForReal(tester);

      // a square of 512 pixels was sent
      final sent = app.profileApi.avatars.single;
      final size = await tester.runAsync(() async {
        final image = await decodeImageFromList(sent);
        return Size(image.width.toDouble(), image.height.toDouble());
      });
      expect(size, const Size(512, 512));
      expect(
        app.toasts.messages,
        contains('Ta photo de profil est enregistrée.'),
      );

      // back to the home screen, under Plus
      await tester.tap(find.byTooltip('Retour'));
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byType(MemberAvatar),
          matching: find.byType(Image),
        ),
        findsOneWidget,
      );
    });

    testWidgets('taken with the camera, or given up: nothing is sent', (
      tester,
    ) async {
      final app = await pumpApp(tester, token: 't');
      await openProfile(tester);

      await tester.tap(find.bySemanticsLabel('Ajouter une photo de profil'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Prendre une photo'));
      await tester.pumpAndSettle();

      expect(app.picker.cameraCalls, [true]);
      expect(find.byType(PhotoCropScreen), findsNothing);
      expect(app.profileApi.avatars, isEmpty);
    });

    testWidgets('cancelled while cropping: nothing is sent', (tester) async {
      final app = await pumpWithPicture(tester);
      await openProfile(tester);

      await tester.tap(find.bySemanticsLabel('Ajouter une photo de profil'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Choisir dans la galerie'));
      await settleForReal(tester);
      await tester.tap(find.text('Annuler'));
      await tester.pumpAndSettle();

      expect(find.byType(PhotoCropScreen), findsNothing);
      expect(app.profileApi.avatars, isEmpty);
    });

    testWidgets('removed: the initials come back', (tester) async {
      final app = await pumpApp(
        tester,
        token: 't',
        profile: FakeProfileApi.defaultProfile.copyWith(avatar: avatar),
      );
      await openProfile(tester);

      await tester.tap(find.bySemanticsLabel('Changer la photo de profil'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Retirer la photo'));
      await tester.pumpAndSettle();

      expect(app.profileApi.removedAvatars, 1);
      expect(app.toasts.messages, contains('Ta photo de profil est retirée.'));
      expect(find.text('BK'), findsWidgets);
    });

    testWidgets('refused by the server: said, and the old one stays', (
      tester,
    ) async {
      final app = await pumpWithPicture(tester);
      app.profileApi.avatarError = const ApiException(
        status: 400,
        code: 'AVATAR_INVALID',
        message: '',
      );
      await openProfile(tester);

      await tester.tap(find.bySemanticsLabel('Ajouter une photo de profil'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Choisir dans la galerie'));
      await settleForReal(tester);
      await tester.runAsync(
        () async => tester.tap(find.text('Utiliser cette photo')),
      );
      await settleForReal(tester);

      expect(
        app.toasts.errors,
        contains(
          'Cette photo ne peut pas être utilisée. Choisis-en une autre.',
        ),
      );
    });

    testWidgets('changed from the profile form too', (tester) async {
      await pumpApp(tester, token: 't');
      await openProfile(tester);
      await scrollTo(tester, find.text('Modifier mon profil'));
      await tester.tap(find.text('Modifier mon profil'));
      await tester.pumpAndSettle();

      expect(
        find.bySemanticsLabel('Ajouter une photo de profil'),
        findsOneWidget,
      );
    });
  });

  testWidgets('the other members see it: who invites me to pray', (
    tester,
  ) async {
    final marc = sampleMembers['marc.tientcheu']!.copyWith(avatar: avatar);
    await pumpApp(
      tester,
      token: 't',
      prayerApi: FakePrayerApi(
        importunities: [
          Importunity(
            id: 7,
            title: 'Seigneur, sauve Paul',
            goal: 100,
            total: 40,
            owner: marc,
            invitedBy: marc,
            myStatus: ImportunityMemberStatus.invited,
            participants: 3,
          ),
        ],
      ),
    );
    await tester.tap(find.text('Prière').last);
    await tester.pumpAndSettle();

    final photo = find.descendant(
      of: find.byType(MemberAvatar),
      matching: find.byType(Image),
    );
    await tester.scrollUntilVisible(
      photo,
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(photo, findsOneWidget);
  });
}
