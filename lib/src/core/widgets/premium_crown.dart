import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../i18n/strings.g.dart';
import '../services/premium_store.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';

/// The member's own photo ([child], [size] wide) with a golden crown tilted
/// on its top edge while they have Premium (bought, or given to the team).
/// Read « Membre Premium » by screen readers. Nothing changes without it.
class PremiumCrown extends ConsumerWidget {
  const PremiumCrown({required this.size, required this.child, super.key});

  final double size;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final premium = ref.watch(premiumProvider).value ?? false;
    if (!premium) {
      return child;
    }
    final crown = size * 0.46;
    // leaning outwards, on the side where the line starts
    final rtl = Directionality.of(context) == TextDirection.rtl;
    // a white outline around the gold, so it reads on a photo and on blue
    const outline = [
      Shadow(color: Colors.white, offset: Offset(1.2, 0)),
      Shadow(color: Colors.white, offset: Offset(-1.2, 0)),
      Shadow(color: Colors.white, offset: Offset(0, 1.2)),
      Shadow(color: Colors.white, offset: Offset(0, -1.2)),
      Shadow(color: Color(0x40000000), offset: Offset(0, 2), blurRadius: 3),
    ];
    return Semantics(
      label: context.t.premium.crown,
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            PositionedDirectional(
              top: -crown * 0.42,
              start: -crown * 0.18,
              child: Transform.rotate(
                angle: rtl ? 0.42 : -0.42,
                child: Stack(
                  children: [
                    // the outline, under the gold
                    Icon(
                      AppIcons.premiumCrown,
                      size: crown,
                      color: Colors.white,
                      shadows: outline,
                    ),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.goldLight, AppColors.gold],
                      ).createShader(bounds),
                      child: Icon(AppIcons.premiumCrown, size: crown),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
