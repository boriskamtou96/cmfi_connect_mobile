import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_tones.dart';
import '../../domain/game.dart';

/// The look of the games: thick things with a darker edge under them, which
/// sink when touched.

/// The darker edge of a face of color [face].
Color gameEdge(Color face) => Color.lerp(face, Colors.black, 0.26)!;

/// The big button of the games (« VÉRIFIER », « CONTINUER »): in capitals,
/// on a darker edge it sinks into when pressed. Grey without [onPressed].
class GameButton extends HookWidget {
  const GameButton({
    required this.label,
    required this.onPressed,
    this.color,
    this.foreground,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;

  /// The face (the brand blue by default) and what is written on it.
  final Color? color;
  final Color? foreground;

  static const _depth = 4.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pressed = useState(false);
    final enabled = onPressed != null;
    final face = enabled
        ? color ?? scheme.primary
        : scheme.surfaceContainerHighest;
    final ink = enabled
        ? foreground ?? scheme.onPrimary
        : AppTones.of(context).disabled;
    final down = pressed.value && enabled;

    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => pressed.value = true,
        onTapCancel: () => pressed.value = false,
        onTapUp: (_) => pressed.value = false,
        onTap: enabled
            ? () {
                HapticFeedback.selectionClick();
                onPressed!();
              }
            : null,
        child: Padding(
          padding: EdgeInsets.only(
            top: down ? _depth : 0,
            bottom: down ? 0 : _depth,
          ),
          child: Container(
            constraints: const BoxConstraints(minHeight: 52),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: face,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                if (!down)
                  BoxShadow(
                    color: enabled ? gameEdge(face) : scheme.outlineVariant,
                    offset: const Offset(0, _depth),
                  ),
              ],
            ),
            child: Text(
              label.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontSize: 15.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
                color: ink,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A lesson on the path: a round button in relief. Gold once done (with its
/// stars under it), the brand blue and a ring around it when it is the one
/// to play, grey and closed otherwise.
class PathNode extends StatelessWidget {
  const PathNode({
    required this.state,
    required this.stars,
    required this.label,
    required this.onTap,
    super.key,
  });

  final LessonState state;
  final int stars;

  /// Read by screen readers: the lesson and where it stands.
  final String label;
  final VoidCallback onTap;

  static const size = 70.0;
  static const _depth = 6.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (face, ink, icon) = switch (state) {
      LessonState.done => (AppColors.gold, Colors.white, AppIcons.lessonDone),
      LessonState.open => (
        scheme.primary,
        scheme.onPrimary,
        AppIcons.lessonOpen,
      ),
      LessonState.locked => (
        scheme.surfaceContainerHighest,
        AppTones.of(context).disabled,
        AppIcons.lessonLocked,
      ),
    };
    final open = state == LessonState.open;

    Widget node = Container(
      width: size,
      height: size - _depth,
      margin: const EdgeInsets.only(bottom: _depth),
      decoration: BoxDecoration(
        color: face,
        borderRadius: const BorderRadius.all(Radius.elliptical(size, size - 6)),
        boxShadow: [
          BoxShadow(
            color: state == LessonState.locked
                ? scheme.outlineVariant
                : gameEdge(face),
            offset: const Offset(0, _depth),
          ),
        ],
      ),
      child: Icon(icon, size: 30, color: ink),
    );
    if (open) {
      // the one to play: a ring around it
      node = Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: scheme.primary.withValues(alpha: 0.28),
            width: 5,
          ),
        ),
        child: node,
      );
    }

    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            node,
            if (state == LessonState.done)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: GameStars(stars: stars, size: 14),
              ),
          ],
        ),
      ),
    );
  }
}

/// Three stars, [stars] of them gold.
class GameStars extends StatelessWidget {
  const GameStars({required this.stars, this.size = 18, this.empty, super.key});

  final int stars;
  final double size;

  /// The color of the stars not won (a faded gold by default).
  final Color? empty;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (var i = 1; i <= 3; i++)
        Icon(
          i <= stars ? AppIcons.starFilled : AppIcons.star,
          size: size,
          color: i <= stars
              ? AppColors.gold
              : empty ?? AppColors.gold.withValues(alpha: 0.45),
        ),
    ],
  );
}

/// How a choice shows.
enum ChoiceLook { idle, selected, right, wrong, faded }

/// A choice of a question: a wide card in relief, its text, and what the
/// check said (a tick on the right one, an arrow on the one to see again:
/// never the color alone).
class ChoiceCard extends StatelessWidget {
  const ChoiceCard({
    required this.text,
    required this.look,
    required this.onTap,
    super.key,
  });

  final String text;
  final ChoiceLook look;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final missing = AppTones.of(context).missing;
    final (edge, fill, ink) = switch (look) {
      ChoiceLook.idle || ChoiceLook.faded => (
        scheme.outlineVariant,
        scheme.surface,
        scheme.onSurface,
      ),
      ChoiceLook.selected => (
        scheme.primary,
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
      ),
      // opaque tints: the edge under the card must not show through
      ChoiceLook.right => (
        AppColors.success,
        Color.alphaBlend(
          AppColors.success.withValues(alpha: 0.14),
          scheme.surface,
        ),
        scheme.onSurface,
      ),
      ChoiceLook.wrong => (
        missing,
        Color.alphaBlend(missing.withValues(alpha: 0.12), scheme.surface),
        scheme.onSurface,
      ),
    };
    final mark = switch (look) {
      ChoiceLook.right => Icon(AppIcons.right, color: AppColors.success),
      ChoiceLook.wrong => Icon(AppIcons.wrong, color: missing),
      _ => null,
    };

    return Semantics(
      button: true,
      selected: look == ChoiceLook.selected,
      enabled: onTap != null,
      child: Opacity(
        opacity: look == ChoiceLook.faded ? 0.55 : 1,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap == null
              ? null
              : () {
                  HapticFeedback.selectionClick();
                  onTap!();
                },
          child: Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsetsDirectional.fromSTEB(18, 15, 14, 15),
            constraints: const BoxConstraints(minHeight: 56),
            decoration: BoxDecoration(
              color: fill,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: edge, width: 2),
              boxShadow: [BoxShadow(color: edge, offset: const Offset(0, 4))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      color: ink,
                    ),
                  ),
                ),
                if (mark != null) ...[const SizedBox(width: 10), mark],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A number at the top of the tab, after its icon: the streak, the points,
/// the goal of the day.
class GameStat extends StatelessWidget {
  const GameStat({
    required this.icon,
    required this.color,
    required this.text,
    required this.label,
    super.key,
  });

  final IconData icon;
  final Color color;
  final String text;

  /// Read by screen readers (« Série de jeu : 6 »).
  final String label;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    excludeSemantics: true,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    ),
  );
}
