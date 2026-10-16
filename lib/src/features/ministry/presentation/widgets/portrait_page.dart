import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_back_button.dart';
import '../../../../core/widgets/fade_slide_in.dart';

/// A page of Notre ministère about one person: the night-blue header with
/// the round portrait in a gold ring, [label] in small gold capitals, the
/// name, [line] and [detail], then [facts] as three numbers; [children]
/// (the dates, the story) below on the page background.
class PortraitPage extends StatelessWidget {
  const PortraitPage({
    required this.label,
    required this.name,
    required this.photo,
    required this.photoLabel,
    required this.children,
    this.line,
    this.detail,
    this.facts = const [],
    super.key,
  });

  final String label;
  final String name;

  /// The picture, filling the circle.
  final Widget photo;
  final String photoLabel;
  final String? line;
  final String? detail;

  /// (number, what it counts): "150+", "livres écrits".
  final List<(String, String)> facts;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryDeep,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(AppRadius.xxl),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xs,
                    AppSpacing.xs,
                    AppSpacing.xs,
                    AppSpacing.xl,
                  ),
                  child: Column(
                    children: [
                      const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: IconTheme(
                          data: IconThemeData(color: Colors.white),
                          child: AppBackButton(),
                        ),
                      ),
                      Semantics(
                        container: true,
                        image: true,
                        label: photoLabel,
                        child: ExcludeSemantics(child: _Ring(child: photo)),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: Column(
                          children: [
                            Text(
                              label.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.4,
                                color: AppColors.goldLight,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Semantics(
                              header: true,
                              child: Text(
                                name,
                                textAlign: TextAlign.center,
                                style: text.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            if (line case final line?) ...[
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                line,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Lora',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                  color: AppColors.onPrimaryMuted,
                                ),
                              ),
                            ],
                            if (detail case final detail?) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                detail,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (facts.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.xl),
                        _Facts(facts: facts),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            FadeSlideIn(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xxl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The portrait in a gold ring.
class _Ring extends StatelessWidget {
  const _Ring({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    width: 136,
    height: 136,
    padding: const EdgeInsets.all(3),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.goldLight, AppColors.gold],
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryDeep,
      ),
      child: ClipOval(child: child),
    ),
  );
}

class _Facts extends StatelessWidget {
  const _Facts({required this.facts});

  final List<(String, String)> facts;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    child: IntrinsicHeight(
      child: Row(
        children: [
          for (final (i, (value, label)) in facts.indexed) ...[
            if (i > 0)
              VerticalDivider(
                width: 1,
                color: Colors.white.withValues(alpha: 0.16),
              ),
            Expanded(
              child: MergeSemantics(
                child: Column(
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.25,
                          color: AppColors.onPrimaryMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

/// "LES GRANDES DATES", "SA VIE": the title of a part of the page.
class PortraitSection extends StatelessWidget {
  const PortraitSection(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.md),
    child: Semantics(
      header: true,
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
      ),
    ),
  );
}

/// The dates of a life, year by year on a gold rail.
class PortraitDates extends StatelessWidget {
  const PortraitDates({required this.dates, super.key});

  final List<(int, String)> dates;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: [
          for (final (i, (year, text)) in dates.indexed)
            MergeSemantics(
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: 48,
                      child: Text(
                        '$year',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: scheme.primary,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.gold,
                              border: Border.all(
                                color: scheme.surface,
                                width: 2,
                              ),
                            ),
                          ),
                          if (i < dates.length - 1)
                            Expanded(
                              child: Container(
                                width: 2,
                                color: AppColors.gold.withValues(alpha: 0.35),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                        child: Text(text, style: const TextStyle(height: 1.4)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A story, paragraph by paragraph, easy to read.
class PortraitStory extends StatelessWidget {
  const PortraitStory({required this.paragraphs, super.key});

  final List<String> paragraphs;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(height: 1.6, fontSize: 16.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (i, paragraph) in paragraphs.indexed)
          Padding(
            padding: EdgeInsets.only(
              bottom: i < paragraphs.length - 1 ? AppSpacing.lg : 0,
            ),
            child: Text(paragraph, style: style),
          ),
      ],
    );
  }
}
