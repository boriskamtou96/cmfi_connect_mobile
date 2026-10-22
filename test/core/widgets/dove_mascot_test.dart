import 'package:cmfi_connect/src/core/widgets/dove_mascot.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// [dove] alone on the screen, as in the app (which always has a direction).
Widget _alone(DoveMascot dove) => Directionality(
  textDirection: TextDirection.ltr,
  child: Center(child: dove),
);

/// Whether a canvas call draws a cheek, one of the details that vanish when
/// small.
bool _drawsCheek(Symbol method, List<dynamic> arguments) =>
    method == #drawOval &&
    (arguments[1] as Paint).color.toARGB32() == 0xFFF5B5A5;

void main() {
  for (final pose in DovePose.values) {
    for (final size in [24.0, 48.0, 160.0]) {
      testWidgets('the ${pose.name} pose draws at ${size.toInt()} px', (
        tester,
      ) async {
        await tester.pumpWidget(_alone(DoveMascot(pose: pose, size: size)));

        expect(tester.takeException(), isNull);
        expect(tester.getSize(find.byType(DoveMascot)), Size.square(size));
        expect(find.byType(DoveMascot), paints..path());
      });
    }
  }

  testWidgets('a small dove drops its cheeks, a larger one keeps them', (
    tester,
  ) async {
    await tester.pumpWidget(_alone(const DoveMascot(size: 24)));
    expect(find.byType(DoveMascot), isNot(paints..something(_drawsCheek)));

    await tester.pumpWidget(_alone(const DoveMascot(size: 48)));
    expect(find.byType(DoveMascot), paints..something(_drawsCheek));
  });

  testWidgets('the dove is decorative unless given a label', (tester) async {
    await tester.pumpWidget(_alone(const DoveMascot()));
    expect(find.bySemanticsLabel(RegExp('.')), findsNothing);

    await tester.pumpWidget(
      _alone(
        const DoveMascot(pose: DovePose.celebrate, semanticLabel: 'Bravo !'),
      ),
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel('Bravo !')),
      matchesSemantics(label: 'Bravo !', isImage: true),
    );
  });

  group('alive', () {
    tearDown(() => DoveMascot.lively = true);

    test('she blinks in joy, waves in cheer, the z rise in rest', () {
      expect(DoveMotion.at(DovePose.joy, 0.74).blink, greaterThan(0.9));
      expect(DoveMotion.at(DovePose.joy, 0.3).blink, 0);
      expect(DoveMotion.at(DovePose.cheer, 1 / 12).wing, closeTo(10, 0.01));
      expect(DoveMotion.at(DovePose.rest, 0.5).drift, 0.5);
    });

    testWidgets('she moves by herself, still with less motion', (tester) async {
      DoveMascot.lively = true;
      DovePainter painter() =>
          tester
                  .widget<CustomPaint>(
                    find.descendant(
                      of: find.byType(DoveMascot),
                      matching: find.byType(CustomPaint),
                    ),
                  )
                  .painter!
              as DovePainter;

      await tester.pumpWidget(_alone(const DoveMascot(pose: DovePose.cheer)));
      await tester.pump(const Duration(milliseconds: 300));
      final first = painter().motion;
      await tester.pump(const Duration(milliseconds: 400));
      expect(painter().motion, isNot(first));

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: _alone(const DoveMascot(pose: DovePose.cheer)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 400));
      expect(painter().motion, const DoveMotion());
    });
  });
}
