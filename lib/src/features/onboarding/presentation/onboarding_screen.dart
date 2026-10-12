import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../routing/app_router.dart';
import 'widgets/onboarding_illustrations.dart';

/// Three presentation pages, shown on the first launch only.
@RoutePage()
class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  static const _pageCount = 3;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final controller = usePageController();
    final page = useState(0);
    final isLast = page.value == _pageCount - 1;
    final reduced = AppMotion.reduced(context);

    final pages = [
      (
        illustration: const ReportsIllustration(),
        title: t.onboarding.reports.title,
        text: t.onboarding.reports.text,
      ),
      (
        illustration: const WorshipIllustration(),
        title: t.onboarding.worship.title,
        text: t.onboarding.worship.text,
      ),
      (
        illustration: const CommunityIllustration(),
        title: t.onboarding.community.title,
        text: t.onboarding.community.text,
      ),
    ];

    Future<void> finish() async {
      await ref.read(onboardingSeenProvider.notifier).markSeen();
      if (context.mounted) {
        await context.router.replaceAll([const WelcomeRoute()]);
      }
    }

    void next() {
      if (isLast) {
        finish();
      } else {
        controller.nextPage(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  0,
                  AppSpacing.xs,
                  AppSpacing.sm,
                  0,
                ),
                child: TextButton(
                  onPressed: finish,
                  style: TextButton.styleFrom(
                    foregroundColor: scheme.onSurfaceVariant,
                  ),
                  child: Text(t.onboarding.skip),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (index) => page.value = index,
                children: [
                  for (final (index, item) in pages.indexed)
                    _PageOffset(
                      controller: controller,
                      index: index,
                      fallbackPage: page.value,
                      enabled: !reduced,
                      builder: (context, offset) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              // the board lags behind the page and shrinks a
                              // little as it leaves (parallax)
                              child: FractionalTranslation(
                                translation: Offset(offset * 0.1, 0),
                                child: Transform.scale(
                                  scale: 1 - 0.08 * offset.abs(),
                                  child: item.illustration,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                              28,
                              AppSpacing.xxl,
                              28,
                              AppSpacing.lg,
                            ),
                            // the text of one page fades out as the next fades in
                            child: Opacity(
                              opacity: (1 - offset.abs() * 1.6).clamp(0, 1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: textTheme.headlineMedium,
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  Text(
                                    item.text,
                                    style: textTheme.bodyLarge?.copyWith(
                                      color: scheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl,
                AppSpacing.sm,
                AppSpacing.xl,
                AppSpacing.lg,
              ),
              child: Column(
                children: [
                  Semantics(
                    label: t.onboarding.step(
                      current: page.value + 1,
                      total: _pageCount,
                    ),
                    child: ExcludeSemantics(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 0; i < _pageCount; i++)
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              margin: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.xs,
                              ),
                              width: i == page.value ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: i == page.value
                                    ? scheme.primary
                                    : scheme.outline,
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: next,
                      child: Text(
                        isLast ? t.onboarding.start : t.onboarding.next,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Rebuilds a page of the PageView with its distance to the current scroll
/// position: 0 when centered, 1 when a full page to the left (-1: right).
class _PageOffset extends StatelessWidget {
  const _PageOffset({
    required this.controller,
    required this.index,
    required this.fallbackPage,
    required this.enabled,
    required this.builder,
  });

  final PageController controller;
  final int index;

  /// The page shown while the controller has no position yet.
  final int fallbackPage;

  /// False with reduced motion: always 0.
  final bool enabled;
  final Widget Function(BuildContext context, double offset) builder;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return builder(context, 0);
    }
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final position = controller.hasClients ? controller.position : null;
        final current = position != null && position.hasContentDimensions
            ? controller.page ?? fallbackPage.toDouble()
            : fallbackPage.toDouble();
        return builder(context, (current - index).clamp(-1, 1));
      },
    );
  }
}
