// Generates the screenshots of the store pages: the real screens of the app,
// filled with demo data, set in frames that follow one another (one sky, from
// the night to the dawn, crossed by a golden path), and the feature graphic
// of Google Play.
//
//   flutter test tool/store_screenshots_test.dart
//
// Writes store/screenshots/ios/fr (1290 × 2796, iPhone 6.9"),
// store/screenshots/android/fr (1080 × 2160) and
// store/screenshots/feature_graphic.png (1024 × 500).
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:cmfi_connect/src/core/i18n/strings.g.dart';
import 'package:cmfi_connect/src/core/theme/app_colors.dart';
import 'package:cmfi_connect/src/core/theme/app_icons.dart';
import 'package:cmfi_connect/src/core/utils/date_extensions.dart';
import 'package:cmfi_connect/src/core/widgets/cmfi_logo.dart';
import 'package:cmfi_connect/src/core/widgets/dove_mascot.dart';
import 'package:cmfi_connect/src/core/widgets/goal_ring.dart';
import 'package:cmfi_connect/src/features/authorities/domain/authority.dart';
import 'package:cmfi_connect/src/features/hymns/domain/hymn.dart';
import 'package:cmfi_connect/src/features/ministry/domain/nation.dart';
import 'package:cmfi_connect/src/features/profile/domain/profile.dart';
import 'package:cmfi_connect/src/features/reports/domain/activity_type.dart';
import 'package:cmfi_connect/src/features/reports/domain/daily_report.dart';
import 'package:cmfi_connect/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../test/helpers/fakes.dart';
import '../test/helpers/pump_app.dart';

// ----- the demo account -------------------------------------------------------

const _activities = [
  ActivityType(
    id: 1,
    code: 'LB',
    label: 'Lecture biblique',
    tracksQuantity: true,
    quantityUnit: 'chapitres',
    isStandard: true,
  ),
  ActivityType(
    id: 2,
    code: 'PS',
    label: 'Prière seule',
    tracksDuration: true,
    isStandard: true,
  ),
  ActivityType(
    id: 3,
    code: 'EV',
    label: 'Évangélisation',
    tracksQuantity: true,
    quantityUnit: 'personnes',
    isStandard: true,
  ),
  ActivityType(
    id: 4,
    code: 'MV',
    label: 'Mémorisation',
    tracksQuantity: true,
    quantityUnit: 'versets',
    isStandard: true,
  ),
  ActivityType(
    id: 5,
    code: 'JE',
    label: 'Jeûne',
    tracksDuration: true,
    isStandard: true,
  ),
];

const _goals = {
  '1': {'quantity': 3},
  '2': {'minutes': 60},
  '3': {'quantity': 2},
  '4': {'quantity': 2},
};

ReportEntry _entry(int id, {int? quantity, int? minutes}) {
  final activity = _activities.firstWhere((a) => a.id == id);
  return ReportEntry(
    activityTypeId: id,
    code: activity.code,
    label: activity.label,
    tracksQuantity: activity.tracksQuantity,
    quantityUnit: activity.quantityUnit,
    tracksDuration: activity.tracksDuration,
    quantity: quantity,
    durationMinutes: minutes,
  );
}

/// Three months of reports, growing: the last 23 days without a gap, today
/// every goal reached.
Map<DateTime, DailyReport> _reportDays() {
  final random = math.Random(3);
  final now = today();
  final days = <DateTime, DailyReport>{};
  for (var i = 0; i < 90; i++) {
    if (i >= 23 && i % 7 == 3) {
      continue;
    }
    final day = DateTime(now.year, now.month, now.day - i);
    final growth = (90 - i) / 90;
    final entries = i == 0
        ? [
            _entry(1, quantity: 4),
            _entry(2, minutes: 75),
            _entry(3, quantity: 2),
            _entry(4, quantity: 2),
          ]
        : [
            _entry(1, quantity: 1 + (growth * 3).round() + random.nextInt(2)),
            _entry(
              2,
              minutes: 20 + (growth * 45).round() + random.nextInt(4) * 5,
            ),
            if (random.nextDouble() < 0.3 + growth * 0.5)
              _entry(3, quantity: 1 + random.nextInt(3)),
            if (random.nextDouble() < 0.4 + growth * 0.5)
              _entry(4, quantity: 1 + random.nextInt(2)),
            if (day.weekday == DateTime.friday) _entry(5, minutes: 720),
          ];
    days[day] = DailyReport(date: day, submitted: true, entries: entries);
  }
  return days;
}

const _profile = Profile(
  firstName: 'Grâce',
  lastName: 'Nkodo',
  phoneNumber: '+237690000001',
  city: 'Yaoundé',
  country: 'CM',
  church: 'CMCI Yaoundé',
  assembly: 'Assemblée de Mvolyé',
);

const _authorities = [
  Authority(
    id: 7,
    firstName: 'Paul',
    lastName: 'Ndi',
    phoneNumber: '+237 6 77 00 00 07',
    email: 'paul.ndi@example.com',
    isDiscipleMaker: true,
  ),
  Authority(
    id: 8,
    firstName: 'Marie',
    lastName: 'Ekane',
    phoneNumber: '+237 6 99 00 00 08',
  ),
];

List<HymnBook> _books() => [
  for (final code in ['chants-edification-1', 'christ-est-vainqueur'])
    HymnBook.fromJson(
      jsonDecode(File('assets/hymns/$code.json').readAsStringSync())
          as Map<String, dynamic>,
    ),
];

List<Nation> _nations() => [
  for (final json
      in jsonDecode(File('assets/ministry/nations.json').readAsStringSync())
          as List)
    Nation.fromJson(json as Map<String, dynamic>),
];

// ----- posters of the demo events -----------------------------------------------

typedef _PosterLook = ({List<Color> colors, String title, String theme});

const _posterLooks = <String, _PosterLook>{
  '/v1/media/poster.jpg': (
    colors: [Color(0xFF0B3B70), Color(0xFF041C3A)],
    title: 'Conférence\nannuelle 2026',
    theme: "Marcher dans l'Esprit",
  ),
  '/v1/media/youth.jpg': (
    colors: [Color(0xFF6A2C91), Color(0xFF2A0F45)],
    title: 'Retraite\ndes jeunes',
    theme: 'Brûlants pour Lui',
  ),
  '/v1/media/mission.jpg': (
    colors: [Color(0xFFB4532A), Color(0xFF4A1A0C)],
    title: "Campagne\nd'évangélisation",
    theme: 'Allez par tout le monde',
  ),
};

Future<Uint8List> _poster(_PosterLook look) async {
  const size = Size(1080, 1350);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final rect = Offset.zero & size;
  canvas.drawRect(
    rect,
    Paint()
      ..shader = ui.Gradient.linear(
        rect.topCenter,
        rect.bottomCenter,
        look.colors,
      ),
  );
  // rays of light from the top
  final rays = Paint()..color = Colors.white.withValues(alpha: 0.06);
  for (var i = 0; i < 9; i++) {
    final angle = -math.pi / 2 + (i - 4) * 0.18;
    final path = Path()
      ..moveTo(size.width / 2, -80)
      ..lineTo(
        size.width / 2 + math.cos(angle - 0.04) * 2200,
        -80 - math.sin(angle - 0.04) * -2200,
      )
      ..lineTo(
        size.width / 2 + math.cos(angle + 0.04) * 2200,
        -80 - math.sin(angle + 0.04) * -2200,
      )
      ..close();
    canvas.drawPath(path, rays);
  }
  canvas
    ..save()
    ..translate(size.width / 2 - 90, 140);
  const CmfiLogoPainter(disc: true).paint(canvas, const Size.square(180));
  canvas.restore();

  void text(String value, TextStyle style, double top) {
    final painter = TextPainter(
      text: TextSpan(text: value, style: style),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 140);
    painter.paint(canvas, Offset((size.width - painter.width) / 2, top));
  }

  text(
    look.title.toUpperCase(),
    const TextStyle(
      fontFamily: 'Onest',
      fontSize: 104,
      height: 1.02,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
    470,
  );
  text(
    look.theme,
    const TextStyle(
      fontFamily: 'Lora',
      fontStyle: FontStyle.italic,
      fontSize: 62,
      color: AppColors.goldLight,
    ),
    760,
  );
  text(
    'YAOUNDÉ · CAMEROUN',
    TextStyle(
      fontFamily: 'Onest',
      fontSize: 38,
      letterSpacing: 8,
      fontWeight: FontWeight.w700,
      color: Colors.white.withValues(alpha: 0.8),
    ),
    1180,
  );
  final image = await recorder.endRecording().toImage(
    size.width.toInt(),
    size.height.toInt(),
  );
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return bytes!.buffer.asUint8List();
}

// ----- taking the app ------------------------------------------------------------

/// The app signed in with the demo account, on an iPhone (status bar and
/// home indicator areas included).
Future<(TestApp, GlobalKey)> _pumpDemo(
  WidgetTester tester,
  Map<String, Uint8List> posters,
) async {
  final key = GlobalKey();
  final next = sampleEvents(daysAhead: 12).next;
  final books = _books();
  final app = await pumpApp(
    tester,
    token: 't',
    account: sampleAccount.copyWith(
      firstName: 'Grâce',
      lastName: 'Nkodo',
      username: 'grace.nkodo',
    ),
    profile: _profile,
    activities: _activities,
    reportDays: _reportDays(),
    authoritiesApi: FakeAuthoritiesApi(_authorities),
    hymnsApi: FakeHymnsApi(books: books),
    hymnStorage: FakeHymnBookStorage(bundled: books),
    premium: FakePremiumStore(active: true),
    ministryApi: FakeMinistryApi(list: _nations()),
    mediaImages: FakeMediaImages(posters),
    eventsApi: FakeEventsApi(
      upcoming: [
        next.copyWith(poster: samplePoster.copyWith(color: '#082B55')),
        next.copyWith(
          id: 3,
          title: 'Retraite des jeunes',
          theme: 'Brûlants pour Lui',
          startsAt: next.startsAt.add(const Duration(days: 21)),
          endsAt: next.endsAt.add(const Duration(days: 21)),
          city: 'Douala',
          poster: samplePoster.copyWith(
            id: 3,
            url: '/v1/media/youth.jpg',
            color: '#4A1F6B',
          ),
        ),
        next.copyWith(
          id: 4,
          title: "Campagne d'évangélisation",
          theme: 'Allez par tout le monde',
          startsAt: next.startsAt.add(const Duration(days: 40)),
          endsAt: next.endsAt.add(const Duration(days: 40)),
          city: 'Bafoussam',
          poster: samplePoster.copyWith(
            id: 4,
            url: '/v1/media/mission.jpg',
            color: '#7A2E14',
          ),
        ),
      ],
    ),
    initialPreferences: {
      'report_goals': jsonEncode(_goals),
      'report_sending': jsonEncode({
        'enabled': true,
        'rhythm': 'weekly',
        'weekday': DateTime.sunday,
        'minutes': 20 * 60,
        'authorities': [7, 8],
      }),
    },
    screenKey: key,
  );
  // an iPhone: the status bar and the home indicator
  tester.view.padding = const FakeViewPadding(top: 59 * 3, bottom: 34 * 3);
  tester.view.viewPadding = const FakeViewPadding(top: 59 * 3, bottom: 34 * 3);
  await _settle(tester, posters);
  return (app, key);
}

/// Lets the images (posters) decode, then the screen settle.
Future<void> _settle(
  WidgetTester tester, [
  Map<String, Uint8List> posters = const {},
]) async {
  await tester.pumpAndSettle();
  await tester.runAsync(() async {
    final context = tester.element(find.byType(MaterialApp).first);
    for (final bytes in posters.values) {
      await precacheImage(MemoryImage(bytes), context);
    }
    await Future<void>.delayed(const Duration(milliseconds: 200));
  });
  await tester.pumpAndSettle();
}

Future<ui.Image> _shoot(WidgetTester tester, GlobalKey key) async {
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  return (await tester.runAsync(() => boundary.toImage(pixelRatio: 3)))!;
}

Future<void> _openTab(WidgetTester tester, String label) async {
  await tester.tap(find.text(label).last);
  await tester.pumpAndSettle();
}

AppRouter _router(TestApp app) => app.container.read(appRouterProvider);

// ----- the frames -------------------------------------------------------------------

/// A headline: plain words, and the words in gold italic.
typedef _Words = List<(String, bool)>;

class _Shot {
  const _Shot({
    required this.name,
    required this.eyebrow,
    required this.headline,
    this.lightStatusBar = false,
    this.tilt = 0,
    this.headlineScale = 1,
    this.extra,
  });

  final String name;
  final String eyebrow;
  final _Words headline;

  /// White status bar text (a dark screen).
  final bool lightStatusBar;

  /// The phone turned a little (radians).
  final double tilt;

  /// A long headline, a little smaller.
  final double headlineScale;

  /// What comes out of the phone: a ring, a bubble, Zoé…
  final Widget Function(double u)? extra;
}

/// The sky of all the frames side by side: night blue, CMFI blue, the
/// colours of the modules, back to the night; stars, and the golden path.
class _PanoramaPainter extends CustomPainter {
  _PanoramaPainter({required this.index, required this.count});

  final int index;
  final int count;

  static const _stops = [
    Color(0xFF061A33),
    Color(0xFF0A4F92),
    Color(0xFF13306E),
    Color(0xFF0B5E66),
    Color(0xFF3B2470),
    Color(0xFF7A3418),
    Color(0xFF071F3D),
    Color(0xFF0A4E96),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final total = size.width * count;
    final shift = -index * size.width;
    canvas.save();
    canvas.translate(shift, 0);
    final all = Rect.fromLTWH(0, 0, total, size.height);
    canvas.drawRect(
      all,
      Paint()
        ..shader = ui.Gradient.linear(
          all.centerLeft,
          all.centerRight,
          [for (var i = 0; i < count; i++) _stops[i % _stops.length]],
          [for (var i = 0; i < count; i++) (i + 0.5) / count],
        ),
    );
    // darker towards the bottom, a light at the top
    canvas.drawRect(
      all,
      Paint()
        ..shader = ui.Gradient.linear(
          all.topCenter,
          all.bottomCenter,
          [
            Colors.white.withValues(alpha: 0.06),
            Colors.black.withValues(alpha: 0),
            Colors.black.withValues(alpha: 0.35),
          ],
          [0, 0.45, 1],
        ),
    );

    final u = size.width / 1290;
    final random = math.Random(11);
    final star = Paint();
    for (var i = 0; i < 90 * count; i++) {
      final x = random.nextDouble() * total;
      final y = math.pow(random.nextDouble(), 1.6) * size.height * 0.9;
      final bright = random.nextDouble();
      star.color = (bright > 0.93 ? AppColors.goldLight : Colors.white)
          .withValues(alpha: 0.15 + 0.55 * bright);
      canvas.drawCircle(
        Offset(x, y.toDouble()),
        (1.2 + 2.6 * bright) * u,
        star,
      );
    }

    // the golden path, one curve through every frame
    double pathY(double x) =>
        size.height * (0.58 + 0.12 * math.sin(x / size.width * 1.7 + 0.8));
    final glow = Paint()
      ..color = AppColors.gold.withValues(alpha: 0.22)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10 * u);
    final dot = Paint()..color = AppColors.goldLight.withValues(alpha: 0.9);
    for (var x = 0.0; x < total; x += 34 * u) {
      final at = Offset(x, pathY(x));
      canvas
        ..drawCircle(at, 9 * u, glow)
        ..drawCircle(at, 5 * u, dot);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_PanoramaPainter old) => false;
}

/// An iPhone around a screen of the app: bezel, Dynamic Island, status bar.
class _Phone extends StatelessWidget {
  const _Phone({
    required this.screen,
    required this.width,
    required this.lightStatusBar,
  });

  final ui.Image screen;
  final double width;
  final bool lightStatusBar;

  @override
  Widget build(BuildContext context) {
    final bezel = width * 0.032;
    final screenWidth = width - bezel * 2;
    final screenHeight = screenWidth * screen.height / screen.width;
    // the app's points, on this screen
    final pt = screenWidth / 390;
    final ink = lightStatusBar ? Colors.white : AppColors.ink;

    return Container(
      width: width,
      padding: EdgeInsets.all(bezel),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1118),
        borderRadius: BorderRadius.circular(width * 0.155),
        border: Border.all(color: const Color(0xFF4A5468), width: pt * 1.4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: width * 0.08,
            offset: Offset(0, width * 0.04),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.125),
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: RawImage(image: screen, fit: BoxFit.cover),
              ),
              // status bar
              Positioned(
                left: 38 * pt,
                top: 18 * pt,
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
              Positioned(
                right: 30 * pt,
                top: 19 * pt,
                child: Row(
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
                      size: 24 * pt,
                      color: ink,
                    ),
                  ],
                ),
              ),
              // Dynamic Island
              Positioned(
                top: 11 * pt,
                left: (screenWidth - 124 * pt) / 2,
                child: Container(
                  width: 124 * pt,
                  height: 36 * pt,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20 * pt),
                  ),
                ),
              ),
              // home indicator
              Positioned(
                bottom: 8 * pt,
                left: (screenWidth - 140 * pt) / 2,
                child: Container(
                  width: 140 * pt,
                  height: 5 * pt,
                  decoration: BoxDecoration(
                    color: AppColors.ink.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(3 * pt),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A white card that comes out of the phone.
Widget _bubble(
  double u, {
  required Widget child,
  Color color = Colors.white,
  double radius = 44,
}) => Container(
  padding: EdgeInsets.symmetric(horizontal: 36 * u, vertical: 28 * u),
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius * u),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.30),
        blurRadius: 50 * u,
        offset: Offset(0, 22 * u),
      ),
    ],
  ),
  child: child,
);

class _Frame extends StatelessWidget {
  const _Frame({
    required this.shot,
    required this.screen,
    required this.index,
    required this.count,
    required this.size,
  });

  final _Shot shot;
  final ui.Image screen;
  final int index;
  final int count;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final u = size.width / 1290;
    // taller frames (iPhone) give the headline more air
    final top = size.height * (size.height / size.width > 2.1 ? 0.06 : 0.045);
    final phoneWidth = size.width * 0.70;

    return SizedBox.fromSize(
      size: size,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _PanoramaPainter(index: index, count: count),
            ),
          ),
          // a soft light behind the phone
          Positioned(
            left: size.width * 0.05,
            right: size.width * 0.05,
            top: size.height * 0.30,
            height: size.height * 0.55,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.16),
                    Colors.white.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 90 * u,
            right: 90 * u,
            top: top,
            child: Column(
              children: [
                Text(
                  shot.eyebrow,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 36 * u,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 7 * u,
                    color: AppColors.goldLight,
                  ),
                ),
                SizedBox(height: 26 * u),
                Text.rich(
                  TextSpan(
                    children: [
                      for (final (words, accent) in shot.headline)
                        TextSpan(
                          text: words,
                          style: accent
                              ? TextStyle(
                                  fontFamily: 'Lora',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 122 * u * shot.headlineScale,
                                  color: AppColors.goldLight,
                                )
                              : null,
                        ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 112 * u * shot.headlineScale,
                    height: 1.08,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.5 * u,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: (size.width - phoneWidth) / 2,
            top: top + 420 * u,
            child: Transform.rotate(
              angle: shot.tilt,
              child: _Phone(
                screen: screen,
                width: phoneWidth,
                lightStatusBar: shot.lightStatusBar,
              ),
            ),
          ),
          if (shot.extra case final extra?) ...[extra(u)],
        ],
      ),
    );
  }
}

// ----- the shots ------------------------------------------------------------------

final _shots = <_Shot>[
  _Shot(
    name: '01_accueil',
    eyebrow: 'CMFI CONNECT',
    headline: const [('Grandis avec Dieu,\n', false), ('chaque jour', true)],
    extra: (u) => Positioned(
      right: 30 * u,
      top: 470 * u,
      child: DoveMascot(pose: DovePose.cheer, size: 330 * u),
    ),
  ),
  _Shot(
    name: '02_compte_rendu',
    eyebrow: 'COMPTE RENDU',
    headline: const [('Ton compte rendu\nen ', false), ('une minute', true)],
    tilt: -0.035,
    extra: (u) => Positioned(
      left: 50 * u,
      top: 2290 * u,
      child: _bubble(
        u,
        child: Row(
          children: [
            GoalRing(value: 1, label: '', size: 120 * u),
            SizedBox(width: 26 * u),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Objectifs du jour',
                  style: TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 36 * u,
                    fontWeight: FontWeight.w600,
                    color: AppColors.muted,
                  ),
                ),
                Text(
                  'Tous atteints !',
                  style: TextStyle(
                    fontFamily: 'Onest',
                    fontSize: 46 * u,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
  _Shot(
    name: '03_bilan',
    eyebrow: 'BILAN',
    headline: const [
      ('Vois ta ', false),
      ('croissance', true),
      (',\nsemaine après semaine', false),
    ],
    headlineScale: 0.84,
    tilt: 0.03,
    extra: (u) => Positioned(
      right: 46 * u,
      top: 1420 * u,
      child: _bubble(
        u,
        color: AppColors.gold,
        child: Row(
          children: [
            Icon(AppIcons.streak, size: 64 * u, color: AppColors.ink),
            SizedBox(width: 18 * u),
            Text(
              '24 jours\nd\'affilée',
              style: TextStyle(
                fontFamily: 'Onest',
                fontSize: 42 * u,
                height: 1.1,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  const _Shot(
    name: '04_cantiques',
    eyebrow: 'CANTIQUES',
    headline: [('Tous les cantiques,\n', false), ('même hors ligne', true)],
  ),
  _Shot(
    name: '05_priere',
    eyebrow: 'PRIÈRE',
    headline: const [('15 minutes\n', false), ('avec le Seigneur', true)],
    tilt: -0.03,
    extra: (u) => Positioned(
      left: 40 * u,
      top: 2290 * u,
      child: _bubble(
        u,
        child: Row(
          children: [
            Icon(
              PhosphorIconsFill.bellRinging,
              size: 64 * u,
              color: const Color(0xFF6A3FA0),
            ),
            SizedBox(width: 20 * u),
            Text(
              'Matin, midi, soir, nuit :\nun rappel pour prier',
              style: TextStyle(
                fontFamily: 'Onest',
                fontSize: 40 * u,
                height: 1.15,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  _Shot(
    name: '06_evenements',
    eyebrow: 'ÉVÈNEMENTS',
    headline: const [
      ('Ne manque ', false),
      ('aucune', true),
      ('\nrencontre', false),
    ],
    lightStatusBar: true,
    tilt: 0.03,
    extra: (u) => Positioned(
      right: 40 * u,
      top: 1500 * u,
      child: _bubble(
        u,
        child: Row(
          children: [
            Icon(
              PhosphorIconsFill.bellRinging,
              size: 60 * u,
              color: const Color(0xFFB4532A),
            ),
            SizedBox(width: 18 * u),
            Text(
              'Rappel la veille\net une heure avant',
              style: TextStyle(
                fontFamily: 'Onest',
                fontSize: 40 * u,
                height: 1.15,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  const _Shot(
    name: '07_ministere',
    eyebrow: 'NOTRE MINISTÈRE',
    headline: [('Présente dans\n', false), ('154 nations', true)],
    lightStatusBar: true,
  ),
  _Shot(
    name: '08_autorites',
    eyebrow: 'AUTORITÉS SPIRITUELLES',
    headline: const [('À tes autorités,\n', false), ('en un geste', true)],
    tilt: -0.03,
    extra: (u) => Stack(
      children: [
        Positioned(
          left: 40 * u,
          top: 2290 * u,
          child: SizedBox(
            width: 760 * u,
            child: _bubble(
              u,
              color: const Color(0xFFDCF8C6),
              radius: 36,
              child: Text(
                'Bonjour Paul, voici mon compte rendu de la semaine : '
                '7 jours sur 7, objectifs atteints. Gloire à Dieu !',
                style: TextStyle(
                  fontFamily: 'Onest',
                  fontSize: 38 * u,
                  height: 1.3,
                  color: AppColors.ink,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 30 * u,
          top: 2230 * u,
          child: DoveMascot(pose: DovePose.celebrate, size: 300 * u),
        ),
      ],
    ),
  ),
];

/// Takes each screen of the app.
final _scenes = <String, Future<void> Function(WidgetTester, TestApp)>{
  '01_accueil': (tester, app) async {},
  '02_compte_rendu': (tester, app) async {
    await _openTab(tester, 'Compte rendu');
  },
  '03_bilan': (tester, app) async {
    await _openTab(tester, 'Compte rendu');
    await tester.tap(find.text('Bilan'));
    await tester.pumpAndSettle();
  },
  '04_cantiques': (tester, app) async {
    unawaited(
      _router(
        app,
      ).push(HymnReaderRoute(bookCode: 'chants-edification-1', number: 1)),
    );
    await tester.pumpAndSettle();
  },
  '05_priere': (tester, app) async {
    await _openTab(tester, 'Prière');
  },
  '06_evenements': (tester, app) async {
    unawaited(_router(app).push(EventRoute(eventId: 2)));
    await tester.pumpAndSettle();
  },
  '07_ministere': (tester, app) async {
    unawaited(_router(app).push(const NationsRoute()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Voyage'));
    await tester.pump(const Duration(milliseconds: 1500));
  },
  '08_autorites': (tester, app) async {
    unawaited(_router(app).push(ReportSendRoute(day: today().toApiDate())));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('WhatsApp').first);
  },
};

// ----- writing -----------------------------------------------------------------------

Future<void> _loadFont(String family, List<String> files) async {
  final loader = FontLoader(family);
  for (final file in files) {
    loader.addFont(
      Future.value(ByteData.sublistView(File(file).readAsBytesSync())),
    );
  }
  await loader.load();
}

Future<void> _render(
  WidgetTester tester,
  Widget child,
  Size size,
  String path,
) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  tester.view.padding = FakeViewPadding.zero;
  tester.view.viewPadding = FakeViewPadding.zero;
  final key = GlobalKey();
  // the app goes first: TranslationProvider keeps a global key, it would
  // carry the app over into the frame
  await tester.pumpWidget(const SizedBox());
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Onest'),
        home: Material(
          type: MaterialType.transparency,
          child: RepaintBoundary(key: key, child: child),
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
  late Map<String, Uint8List> posters;

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
      ('Fill', 'Phosphor-Fill'),
      ('Duotone', 'Phosphor-Duotone'),
    ]) {
      await _loadFont('packages/phosphor_flutter/Phosphor$family', [
        '$phosphor/$file.ttf',
      ]);
    }
    // the flags (Notre ministère): the Mac's colour font
    await _loadFont('Apple Color Emoji', [
      '/System/Library/Fonts/Apple Color Emoji.ttc',
    ]);
    posters = {
      for (final MapEntry(:key, :value) in _posterLooks.entries)
        key: await _poster(value),
    };
  });
  setUp(() => LocaleSettings.setLocale(AppLocale.fr));

  for (final (index, shot) in _shots.indexed) {
    testWidgets('store screenshot ${shot.name}', (tester) async {
      final (app, key) = await _pumpDemo(tester, posters);
      await _scenes[shot.name]!(tester, app);
      await _settle(tester, posters);
      final screen = await _shoot(tester, key);
      if (shot.name == '07_ministere') {
        // the journey stops before the app goes
        await tester.tap(find.text('Pause'));
        await tester.pump();
      }

      for (final (folder, size) in [
        ('ios', const Size(1290, 2796)),
        ('android', const Size(1080, 2160)),
      ]) {
        await _render(
          tester,
          _Frame(
            shot: shot,
            screen: screen,
            index: index,
            count: _shots.length,
            size: size,
          ),
          size,
          'store/screenshots/$folder/fr/${shot.name}.png',
        );
      }
    });
  }

  testWidgets('feature graphic', (tester) async {
    const size = Size(1024, 500);
    await _render(
      tester,
      SizedBox.fromSize(
        size: size,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _PanoramaPainter(index: 0, count: 1)),
            ),
            Positioned(
              left: 64,
              top: 92,
              child: Row(
                children: [
                  const CmfiLogo.onDark(),
                  const SizedBox(width: 28),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'CMFI Connect',
                        style: TextStyle(
                          fontFamily: 'Onest',
                          fontSize: 64,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Grandis avec Dieu, chaque jour',
                        style: TextStyle(
                          fontFamily: 'Lora',
                          fontStyle: FontStyle.italic,
                          fontSize: 34,
                          color: AppColors.goldLight.withValues(alpha: 0.95),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 66,
              bottom: 70,
              child: Text(
                'Compte rendu · Cantiques · Prière · Évènements',
                style: TextStyle(
                  fontFamily: 'Onest',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onPrimaryMuted,
                ),
              ),
            ),
            const Positioned(
              right: 40,
              bottom: 30,
              child: DoveMascot(pose: DovePose.celebrate, size: 300),
            ),
          ],
        ),
      ),
      size,
      'store/screenshots/feature_graphic.png',
    );
  });
}
