import 'package:flutter/material.dart';

import '../i18n/strings.g.dart';
import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';

/// Content being loaded: grey shapes laid out like what is coming (a
/// skeleton), with a light sweeping across them. It only lives while the
/// content loads, like a progress indicator; still when motion is reduced.
/// Screen readers hear "Chargement…" once, not the shapes.
class Shimmer extends StatefulWidget {
  const Shimmer({required this.child, super.key});

  /// Shapes made of [SkeletonBox] (any opaque widget takes the shimmer).
  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (AppMotion.reduced(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final base = scheme.surfaceContainerHighest;
    // a little lighter than the shapes, in both modes
    final light = Color.lerp(base, Colors.white, dark ? 0.08 : 0.6)!;

    return Semantics(
      label: context.t.common.loading,
      liveRegion: true,
      child: ExcludeSemantics(
        child: AnimatedBuilder(
          animation: _controller,
          child: widget.child,
          builder: (context, child) => ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) => LinearGradient(
              colors: [base, light, base],
              stops: const [0.35, 0.5, 0.65],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              transform: _Sweep(_controller.value),
            ).createShader(bounds),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Moves the light from beyond the start to beyond the end.
class _Sweep extends GradientTransform {
  const _Sweep(this.progress);

  final double progress;

  @override
  Matrix4 transform(Rect bounds, {TextDirection? textDirection}) {
    final sweep = bounds.width * (progress * 2 - 1);
    return Matrix4.translationValues(
      textDirection == TextDirection.rtl ? -sweep : sweep,
      0,
      0,
    );
  }
}

/// A shape of the skeleton (inside a [Shimmer]).
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    this.width,
    this.height = 12,
    this.radius = AppRadius.sm,
    this.circle = false,
    super.key,
  });

  final double? width;
  final double height;
  final double radius;
  final bool circle;

  @override
  Widget build(BuildContext context) => Container(
    width: circle ? height : width,
    height: height,
    decoration: BoxDecoration(
      // any opaque color: the shimmer paints over it
      color: Colors.white,
      shape: circle ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: circle ? null : BorderRadius.circular(radius),
    ),
  );
}

/// A line of text being loaded, [widthFactor] of the width.
class SkeletonLine extends StatelessWidget {
  const SkeletonLine({this.widthFactor = 1, this.height = 12, super.key});

  final double widthFactor;
  final double height;

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
    alignment: AlignmentDirectional.centerStart,
    widthFactor: widthFactor,
    child: SkeletonBox(height: height),
  );
}

/// A row of a list being loaded: a picture (round, or a rounded tile), a
/// title and a second line.
class SkeletonRow extends StatelessWidget {
  const SkeletonRow({
    this.leading = 40,
    this.round = true,
    this.lines = 2,
    this.widthFactor = 0.6,
    super.key,
  });

  /// The size of the picture; 0 without one.
  final double leading;
  final bool round;
  final int lines;

  /// How wide the title is (the second line is a little shorter).
  final double widthFactor;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: 12,
    ),
    child: Row(
      children: [
        if (leading > 0) ...[
          SkeletonBox(
            height: leading,
            width: leading,
            circle: round,
            radius: AppRadius.md,
          ),
          const SizedBox(width: 14),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < lines; i++) ...[
                if (i > 0) const SizedBox(height: 8),
                SkeletonLine(
                  widthFactor: i == 0 ? widthFactor : widthFactor * 0.7,
                  height: i == 0 ? 14 : 11,
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

/// [count] rows of a list (inside a [Shimmer]), in a bordered card like the
/// lists of the app. Alone in a section of a page that already scrolls;
/// [LoadingList] for a whole page.
class SkeletonList extends StatelessWidget {
  const SkeletonList({
    this.count = 6,
    this.leading = 40,
    this.round = true,
    this.lines = 2,
    this.card = true,
    super.key,
  });

  final int count;
  final double leading;
  final bool round;
  final int lines;

  /// The rows in a bordered card (false: on the page).
  final bool card;

  @override
  Widget build(BuildContext context) {
    final rows = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < count; i++)
          SkeletonRow(
            leading: leading,
            round: round,
            lines: lines,
            // a little irregular, like real names
            widthFactor: const [0.62, 0.48, 0.7, 0.55, 0.66, 0.5][i % 6],
          ),
      ],
    );

    return card
        ? DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: rows,
          )
        : rows;
  }
}

/// [count] cards one under the other ([height] each, inside a [Shimmer]).
/// Alone in a section of a page that already scrolls; [LoadingCards] for a
/// whole page.
class SkeletonCards extends StatelessWidget {
  const SkeletonCards({this.count = 3, this.height = 140, super.key});

  final int count;
  final double height;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (var i = 0; i < count; i++) ...[
        if (i > 0) const SizedBox(height: AppSpacing.md),
        SkeletonBox(height: height, radius: AppRadius.xl),
      ],
    ],
  );
}

/// A list being loaded: [count] rows in a card, like the lists of the app.
class LoadingList extends StatelessWidget {
  const LoadingList({
    this.count = 6,
    this.leading = 40,
    this.round = true,
    this.lines = 2,
    this.padding = const EdgeInsetsDirectional.fromSTEB(
      AppSpacing.lg,
      AppSpacing.sm,
      AppSpacing.lg,
      AppSpacing.xl,
    ),
    this.card = true,
    super.key,
  });

  final int count;
  final double leading;
  final bool round;
  final int lines;
  final EdgeInsetsGeometry padding;

  /// The rows in a bordered card (false: on the page).
  final bool card;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    padding: padding,
    child: Shimmer(
      child: SkeletonList(
        count: count,
        leading: leading,
        round: round,
        lines: lines,
        card: card,
      ),
    ),
  );
}

/// Cards being loaded, one under the other ([height] each).
class LoadingCards extends StatelessWidget {
  const LoadingCards({
    this.count = 3,
    this.height = 140,
    this.padding = const EdgeInsetsDirectional.fromSTEB(
      AppSpacing.lg,
      AppSpacing.sm,
      AppSpacing.lg,
      AppSpacing.xl,
    ),
    super.key,
  });

  final int count;
  final double height;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    padding: padding,
    child: Shimmer(
      child: SkeletonCards(count: count, height: height),
    ),
  );
}

/// A page of text being loaded: a title, then paragraphs.
class LoadingDetail extends StatelessWidget {
  const LoadingDetail({
    this.picture = 0,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    super.key,
  });

  /// The height of a picture on top (a poster); 0 without one.
  final double picture;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    physics: const NeverScrollableScrollPhysics(),
    padding: padding,
    child: Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (picture > 0) ...[
            SkeletonBox(height: picture, radius: AppRadius.xl),
            const SizedBox(height: AppSpacing.lg),
          ],
          const SkeletonLine(widthFactor: 0.7, height: 22),
          const SizedBox(height: AppSpacing.md),
          const SkeletonLine(widthFactor: 0.45),
          const SizedBox(height: AppSpacing.xl),
          for (final width in const [1.0, 0.95, 0.9, 0.97, 0.6]) ...[
            SkeletonLine(widthFactor: width),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: AppSpacing.lg),
          for (final width in const [0.92, 1.0, 0.75]) ...[
            SkeletonLine(widthFactor: width),
            const SizedBox(height: 10),
          ],
        ],
      ),
    ),
  );
}
