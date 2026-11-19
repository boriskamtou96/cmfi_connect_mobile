import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/widgets/cmfi_logo.dart';
import '../../../../core/widgets/photo_kit.dart';

/// The top of the sign-in, like the welcome: cream (night blue in dark
/// mode), two faces around a gold ring and a sticker. The faces are an
/// illustration (stock photos), not members.
///
/// It leaves room for the form (critique of 19/11/2026): about a quarter of
/// the screen (112 to 200 pt under the status bar, less when the text is
/// enlarged), the drawing scaled to fit, so the password stays in view on an
/// iPhone SE and with a large text; folded to the back button while the
/// keyboard is open.
class LoginHeader extends StatelessWidget {
  const LoginHeader({required this.canPop, this.typing = false, super.key});

  /// Show the back button (the welcome is below).
  final bool canPop;

  /// The keyboard is open. Told by the screen: inside the Scaffold, the
  /// keyboard is already taken out of the MediaQuery.
  final bool typing;

  /// The drawing is made for this box, then scaled to the room it has.
  static const _canvas = Size(390, 200);

  /// Under the status bar while the keyboard is open: the back button.
  static const _folded = 64.0;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final screen = MediaQuery.sizeOf(context);
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final background = dark ? AppColors.night : AppColors.cream;
    final room = typing
        ? _folded
        : (screen.height * 0.24 / math.max(1, textScale)).clamp(
            112.0,
            _canvas.height,
          );
    final duration = AppMotion.of(context, AppMotion.medium);

    return AnimatedContainer(
      duration: duration,
      curve: AppMotion.standard,
      height: top + room,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(36)),
      ),
      child: Stack(
        children: [
          // decorations: physical, the same in both reading directions
          Positioned(
            right: -0.3 * room,
            top: top - 0.2 * room,
            child: BrandRing(
              size: 1.3 * room,
              // a stronger gold on the night: at 25 % it turns olive
              color: AppColors.gold.withValues(alpha: dark ? 0.4 : 0.25),
            ),
          ),
          Positioned.fill(
            top: top,
            child: AnimatedOpacity(
              opacity: typing ? 0 : 1,
              duration: duration,
              child: FittedBox(
                alignment: Alignment.bottomCenter,
                child: SizedBox.fromSize(
                  size: _canvas,
                  child: const _Drawing(),
                ),
              ),
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
}

/// Two faces and the « Bon retour ! » sticker, in a 390 × 200 box. The
/// faces stay clear of the back button on both sides (Arabic puts it on the
/// right).
class _Drawing extends StatelessWidget {
  const _Drawing();

  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
    children: [
      ExcludeSemantics(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _face(StockPhotos.womanLaughing, 116, 5, left: 104, top: 10),
            _face(StockPhotos.manSmiling, 76, 4, left: 250, top: 58),
          ],
        ),
      ),
      PositionedDirectional(
        start: 116,
        top: 138,
        child: Sticker(
          icon: AppIcons.prayNow,
          text: context.t.auth.login.welcomeBack,
          color: const Color(0xFFFF7A1A),
          angle: 0.06,
          big: true,
        ),
      ),
    ],
  );

  Widget _face(
    FaceCrop crop,
    double size,
    double ring, {
    required double left,
    required double top,
  }) => Positioned(
    left: left,
    top: top,
    child: RingedFace(
      size: size,
      ring: Colors.white,
      ringWidth: ring,
      child: CroppedFace(crop, size: math.max(0, size - ring * 2)),
    ),
  );
}
