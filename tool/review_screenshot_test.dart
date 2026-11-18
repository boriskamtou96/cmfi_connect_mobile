// Takes the Premium screen (the paywall) for App Store Connect: the screenshot
// "for the review team" attached to each in-app purchase. A member signed in
// without Premium (not on the team, so nothing is offered), the 4 plans of the
// current offering at their real prices, no free trial; on an iPhone 6.9"
// (440 × 956 points at 3x), with the status bar and the home indicator.
//
//   flutter test tool/review_screenshot_test.dart
//
// Writes store/review/premium_paywall_fr.png and premium_paywall_en.png
// (1320 × 2868).
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/services/premium_store.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../test/helpers/fakes.dart';
import '../test/helpers/pump_app.dart';

/// The iPhone 6.9" (16 Pro Max): its points, its safe areas.
const _screen = Size(440, 956);
const _top = 62.0;
const _bottom = 34.0;
const _ratio = 3.0;

/// The store's offering, at its real prices (written as the store writes
/// them in each language), without a trial.
class _ReviewPremiumStore extends FakePremiumStore {
  _ReviewPremiumStore(this._plans) : super(active: false);

  final List<PremiumPlan> _plans;

  @override
  Future<List<PremiumPlan>> plans() async => _plans;
}

List<PremiumPlan> _plans(String Function(String amount) price) => [
  PremiumPlan(
    period: PremiumPeriod.monthly,
    price: price('1.99'),
    amount: 1.99,
  ),
  PremiumPlan(
    period: PremiumPeriod.semiannual,
    price: price('9.99'),
    amount: 9.99,
    pricePerMonth: price('1.66'),
  ),
  PremiumPlan(
    period: PremiumPeriod.annual,
    price: price('14.99'),
    amount: 14.99,
    pricePerMonth: price('1.25'),
  ),
  PremiumPlan(
    period: PremiumPeriod.lifetime,
    price: price('49.99'),
    amount: 49.99,
  ),
];

final _prices = <AppLocale, String Function(String)>{
  AppLocale.fr: (amount) => '${amount.replaceAll('.', ',')} €',
  AppLocale.en: (amount) => '€$amount',
};

Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    loader.addFont(
      Future.value(ByteData.sublistView(File(file).readAsBytesSync())),
    );
  }
  await loader.load();
}

Future<void> _settle(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.runAsync(
    () => Future<void>.delayed(const Duration(milliseconds: 200)),
  );
  await tester.pumpAndSettle();
}

Future<ui.Image> _shoot(WidgetTester tester, GlobalKey key) async {
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  return (await tester.runAsync(() => boundary.toImage(pixelRatio: _ratio)))!;
}

/// The screen of the app under the iPhone's status bar (white: the paywall
/// is dark) and its home indicator.
class _Device extends StatelessWidget {
  const _Device({required this.screen});

  final ui.Image screen;

  @override
  Widget build(BuildContext context) {
    const pt = _ratio;
    const ink = Colors.white;
    return SizedBox(
      width: _screen.width * pt,
      height: _screen.height * pt,
      child: Stack(
        children: [
          Positioned.fill(
            child: RawImage(image: screen, fit: BoxFit.fill),
          ),
          Positioned(
            left: 0,
            width: 150 * pt,
            top: 0,
            height: _top * pt,
            child: const Align(
              alignment: Alignment(0.1, -0.05),
              child: Text(
                '9:41',
                style: TextStyle(
                  fontFamily: 'Onest',
                  fontSize: 17 * pt,
                  fontWeight: FontWeight.w700,
                  color: ink,
                ),
              ),
            ),
          ),
          const Positioned(
            right: 0,
            width: 150 * pt,
            top: 0,
            height: _top * pt,
            child: Align(
              alignment: Alignment(-0.1, -0.05),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PhosphorIconsFill.cellSignalFull,
                    size: 18 * pt,
                    color: ink,
                  ),
                  SizedBox(width: 5 * pt),
                  Icon(PhosphorIconsFill.wifiHigh, size: 18 * pt, color: ink),
                  SizedBox(width: 5 * pt),
                  Icon(
                    PhosphorIconsFill.batteryFull,
                    size: 25 * pt,
                    color: ink,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 8 * pt,
            left: (_screen.width - 140) / 2 * pt,
            child: Container(
              width: 140 * pt,
              height: 5 * pt,
              decoration: BoxDecoration(
                color: ink.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(3 * pt),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _write(WidgetTester tester, ui.Image screen, String path) async {
  tester.view.physicalSize = Size(screen.width + 0.0, screen.height + 0.0);
  tester.view.devicePixelRatio = 1;
  tester.view.padding = FakeViewPadding.zero;
  tester.view.viewPadding = FakeViewPadding.zero;
  final key = GlobalKey();
  // the app goes first: TranslationProvider keeps a global key
  await tester.pumpWidget(const SizedBox());
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        type: MaterialType.transparency,
        child: Align(
          alignment: Alignment.topLeft,
          child: RepaintBoundary(
            key: key,
            child: _Device(screen: screen),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    File(path)
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes!.buffer.asUint8List());
  });
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting();
    await _loadFont('Onest', [
      for (final weight in [
        'Regular',
        'Medium',
        'SemiBold',
        'Bold',
        'ExtraBold',
      ])
        'assets/fonts/Onest-$weight.ttf',
    ]);
    await _loadFont('Lora', [
      'assets/fonts/Lora-Regular.ttf',
      'assets/fonts/Lora-SemiBold.ttf',
      'assets/fonts/Lora-Italic.ttf',
    ]);
    final phosphor =
        '${Platform.environment['HOME']}/.pub-cache/hosted/pub.dev/'
        'phosphor_flutter-2.1.0/lib/fonts';
    for (final (family, file) in [
      ('Regular', 'Phosphor'),
      ('Bold', 'Phosphor-Bold'),
      ('Fill', 'Phosphor-Fill'),
      ('Duotone', 'Phosphor-Duotone'),
    ]) {
      await _loadFont('packages/phosphor_flutter/Phosphor$family', [
        '$phosphor/$file.ttf',
      ]);
    }
  });
  tearDown(() => LocaleSettings.setLocale(AppLocale.fr));

  for (final MapEntry(key: locale, value: price) in _prices.entries) {
    testWidgets(
      'review screenshot premium ${locale.languageCode}',
      variant: TargetPlatformVariant.only(TargetPlatform.iOS),
      (tester) async {
        await LocaleSettings.setLocale(locale);
        final key = GlobalKey();
        final app = await pumpApp(
          tester,
          token: 't',
          // a member, not on the team: Premium isn't offered
          account: sampleAccount.copyWith(
            firstName: 'Grâce',
            lastName: 'Nkodo',
            username: 'grace.nkodo',
            role: 'user',
          ),
          premium: _ReviewPremiumStore(_plans(price)),
          screenKey: key,
        );
        tester.view.physicalSize = _screen * _ratio;
        tester.view.devicePixelRatio = _ratio;
        tester.view.padding = const FakeViewPadding(
          top: _top * _ratio,
          bottom: _bottom * _ratio,
        );
        tester.view.viewPadding = const FakeViewPadding(
          top: _top * _ratio,
          bottom: _bottom * _ratio,
        );
        await _settle(tester);

        unawaited(
          app.container.read(appRouterProvider).push(const PremiumRoute()),
        );
        await _settle(tester);
        // the 4 plans and the store's notes don't fit under the benefits on
        // one screen: scrolled to the end, as the member would
        final list = tester.state<ScrollableState>(
          find
              .descendant(
                of: find.byType(SingleChildScrollView),
                matching: find.byType(Scrollable),
              )
              .first,
        );
        list.position.jumpTo(list.position.maxScrollExtent);
        await _settle(tester);
        // no benefit cut by the top edge: the one there shown whole (the
        // bottom padding of the list leaves the room)
        final viewport = tester.getRect(find.byWidget(list.widget));
        for (final benefit
            in find
                .byWidgetPredicate(
                  (w) => w.runtimeType.toString() == '_Benefit',
                )
                .evaluate()) {
          final rect = tester.getRect(find.byWidget(benefit.widget));
          if (rect.top < viewport.top && rect.bottom > viewport.top) {
            list.position.jumpTo(
              list.position.pixels - (viewport.top - rect.top) - 6,
            );
            await _settle(tester);
          }
        }

        final screen = await _shoot(tester, key);
        await _write(
          tester,
          screen,
          'store/review/premium_paywall_${locale.languageCode}.png',
        );
      },
    );
  }
}
