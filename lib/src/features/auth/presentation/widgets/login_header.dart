import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/widgets/cmfi_logo.dart';
import '../../../../core/widgets/photo_kit.dart';

/// The top of the sign-in, like the welcome: cream (night blue in dark
/// mode), faces floating around a gold ring and a sticker. The faces are an
/// illustration (stock photos), not members.
class LoginHeader extends StatelessWidget {
  const LoginHeader({required this.canPop, super.key});

  /// Show the back button (the welcome is below).
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final background = dark ? AppColors.night : AppColors.cream;

    return Container(
      height: top + 250,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
      ),
      child: Stack(
        children: [
          // decorations: physical, the same in both reading directions
          Positioned(
            right: -70,
            top: top - 40,
            child: BrandRing(
              size: 280,
              color: AppColors.gold.withValues(alpha: 0.25),
            ),
          ),
          ExcludeSemantics(
            child: Stack(
              children: [
                _face(
                  StockPhotos.womanLaughing,
                  128,
                  5,
                  left: 110,
                  top: top + 40,
                ),
                _face(StockPhotos.elder, 72, 4, left: 26, top: top + 130),
                _face(StockPhotos.manSmiling, 84, 4, right: 34, top: top + 30),
                _face(
                  StockPhotos.womanGlasses,
                  60,
                  3,
                  right: 22,
                  top: top + 150,
                ),
              ],
            ),
          ),
          PositionedDirectional(
            start: 122,
            top: top + 184,
            child: Sticker(
              icon: AppIcons.prayNow,
              text: context.t.auth.login.welcomeBack,
              color: const Color(0xFFFF7A1A),
              angle: 0.06,
              big: true,
            ),
          ),
          if (canPop)
            PositionedDirectional(
              start: 14,
              top: top + 6,
              child: Material(
                color: dark
                    ? Colors.white.withValues(alpha: 0.12)
                    : Colors.white,
                shape: const CircleBorder(),
                child: IconButton(
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  color: dark ? Colors.white : AppColors.primaryDeep,
                  icon: const Icon(AppIcons.back, size: 26),
                  onPressed: () => Navigator.of(context).maybePop(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _face(
    FaceCrop crop,
    double size,
    double ring, {
    required double top,
    double? left,
    double? right,
  }) => Positioned(
    left: left,
    right: right,
    top: top,
    child: RingedFace(
      size: size,
      ring: Colors.white,
      ringWidth: ring,
      child: CroppedFace(crop, size: size - ring * 2),
    ),
  );
}
