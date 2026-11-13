import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../i18n/strings.g.dart';
import '../services/premium_store.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';

/// The member's own photo ([child], [size] wide) while they have Premium
/// (bought, or given to the team): a thin gold ring around it and a small
/// gold seal on its lower edge (since 13/11/2026; the crown leaning on the
/// photo was taken away at the user's request). Read « Membre Premium » by
/// screen readers. Nothing changes without Premium.
class PremiumMark extends ConsumerWidget {
  const PremiumMark({required this.size, required this.child, super.key});

  final double size;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premium = ref.watch(premiumProvider).value ?? false;
    if (!premium) {
      return child;
    }
    final ring = (size * 0.045).clamp(2.0, 3.5);
    final seal = (size * 0.36).clamp(16.0, 30.0);
    const gold = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.goldLight, AppColors.gold],
    );
    return Semantics(
      label: context.t.premium.crown,
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            // the ring, drawn over the edge of the photo
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _RingPainter(ring, gold)),
              ),
            ),
            PositionedDirectional(
              end: -seal * 0.18,
              bottom: -seal * 0.18,
              child: Container(
                width: seal,
                height: seal,
                decoration: BoxDecoration(
                  gradient: gold,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  AppIcons.premiumSeal,
                  size: seal * 0.58,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter(this.width, this.gradient);

  final double width;
  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawCircle(
      rect.center,
      size.shortestSide / 2 - width / 2,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = width
        ..shader = gradient.createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.width != width;
}
