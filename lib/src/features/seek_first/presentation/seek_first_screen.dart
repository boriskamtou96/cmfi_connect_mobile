import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/widgets/adaptive_pickers.dart';
import '../../../core/widgets/app_back_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/fade_slide_in.dart';
import '../../../core/widgets/section_card.dart';
import '../../../routing/app_router.dart';
import '../../reports/application/reports_providers.dart';
import '../../reports/application/today_widget.dart';
import '../application/seek_first.dart';

/// "5 apps · 2 catégories", or "Aucune app choisie".
String selectionLabel(BuildContext context, SeekFirstState state) {
  final t = context.t.seekFirst;
  final selection = state.selection;
  if (selection.isEmpty) {
    return t.appsNone;
  }
  return [
    if (selection.apps > 0) t.appCount(n: selection.apps),
    if (selection.categories > 0) t.categoryCount(n: selection.categories),
    if (selection.sites > 0) t.siteCount(n: selection.sites),
  ].join(' · ');
}

/// Plus › Cherche d'abord Dieu: the apps chosen stay closed each day, from
/// a set hour, until the day's report is saved (Matthieu 6:33).
@RoutePage()
class SeekFirstScreen extends ConsumerWidget {
  const SeekFirstScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.seekFirst;
    final settings = ref.watch(seekFirstProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            const _Header(),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: switch (settings) {
                AsyncValue(value: final state?) when !state.supported => Text(
                  t.unsupported,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                AsyncValue(value: final state?) => FadeSlideIn(
                  child: _Settings(state: state),
                ),
                AsyncValue(:final error?) => ErrorView(
                  error: error,
                  onRetry: () => ref.invalidate(seekFirstProvider),
                ),
                _ => const Center(child: CircularProgressIndicator.adaptive()),
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// The night-blue header: the title and Matthieu 6:33.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final t = context.t.seekFirst;

    return Container(
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
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconTheme(
                data: IconThemeData(color: Colors.white),
                child: AppBackButton(),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.goldLight, AppColors.gold],
                        ),
                      ),
                      child: const Icon(
                        AppIcons.seekFirst,
                        color: AppColors.primaryDeep,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Semantics(
                      header: true,
                      child: Text(
                        t.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      '« ${t.verse} »',
                      style: const TextStyle(
                        fontFamily: 'Lora',
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        height: 1.45,
                        color: AppColors.goldLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      t.verseRef,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onPrimaryMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Settings extends ConsumerWidget {
  const _Settings({required this.state});

  final SeekFirstState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.seekFirst;
    final scheme = Theme.of(context).colorScheme;
    final notifier = ref.read(seekFirstProvider.notifier);
    final done = ref.watch(todayWidgetProvider)?.done ?? false;
    final now = TimeOfDay.now();
    final started =
        now.hour * 60 + now.minute >=
        state.start.hour * 60 + state.start.minute;

    Future<void> toggle(bool on) async {
      final toast = ref.read(toasterProvider).of(context);
      if (!on) {
        await notifier.disable();
        return;
      }
      switch (await notifier.enable()) {
        case SeekFirstOutcome.enabled:
          break;
        case SeekFirstOutcome.denied:
          toast.error(t.denied);
        case SeekFirstOutcome.noApps:
          toast.info(t.noApps);
      }
    }

    Future<void> pickStart() async {
      final picked = await showAppTimePicker(
        context,
        initialTime: state.start,
        use24h: true,
      );
      if (picked != null) {
        await notifier.setStart(picked);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(t.intro, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: AppSpacing.lg),
        SectionCard(
          children: [
            SwitchListTile.adaptive(
              value: state.enabled,
              onChanged: toggle,
              title: Text(
                t.enable,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            ListTile(
              enabled: state.enabled,
              title: Text(
                t.apps,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(selectionLabel(context, state)),
              trailing: const Icon(AppIcons.chevronRight),
              onTap: notifier.choose,
            ),
            ListTile(
              enabled: state.enabled,
              title: Text(
                t.start,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: Text(
                state.start.format(context),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: scheme.primary,
                ),
              ),
              onTap: pickStart,
            ),
            ListTile(
              enabled: state.enabled,
              title: Text(
                t.pauses,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                state.enabled
                    ? t.pausesLeft(n: state.pausesLeft)
                    : t.pausesText,
              ),
            ),
          ],
        ),
        if (state.enabled) ...[
          const SizedBox(height: AppSpacing.lg),
          _Today(
            text: done
                ? t.todayOpen
                : started
                ? t.todayLocked
                : t.todayBefore(time: state.start.format(context)),
            done: done,
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(AppIcons.private, size: 18, color: scheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                t.privacy,
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Where today stands: open (gold), or closed until the report.
class _Today extends ConsumerWidget {
  const _Today({required this.text, required this.done});

  final String text;
  final bool done;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.seekFirst;

    // today's report, in the Compte rendu tab
    void fill() {
      ref.read(selectedReportsViewProvider.notifier).select(ReportsView.today);
      ref.read(selectedReportDayProvider.notifier).select(today());
      context.router.root.popUntilRouteWithName(AppShellRoute.name);
      context.navigateTo(const ReportsRoute());
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.primaryDeep,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: done ? Border.all(color: AppColors.gold) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                done ? AppIcons.checkCircleFilled : AppIcons.premiumLock,
                color: done ? AppColors.gold : AppColors.goldLight,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
          if (!done) ...[
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: fill,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.ink,
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(t.fillReport),
            ),
          ],
        ],
      ),
    );
  }
}
