import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/motion.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/sub_page.dart';
import '../../../../routing/app_router.dart';
import '../../application/event_admin.dart';
import '../widgets/event_cards.dart';
import '../widgets/program_view.dart';
import 'event_form_screen.dart';

/// Plus › Administration › Évènements: every event, drafts included, and
/// "Créer un évènement".
@RoutePage()
class AdminEventsScreen extends ConsumerWidget {
  const AdminEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events.admin;
    final events = ref.watch(adminEventsProvider);
    final now = DateTime.now();

    return SubPage(
      title: t.title,
      bottom: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: OpenPage(
          page: const EventFormScreen(),
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          builder: (context, open) => FilledButton.icon(
            onPressed: open,
            icon: const Icon(AppIcons.add),
            label: Text(t.create),
          ),
        ),
      ),
      child: switch (events) {
        AsyncValue(value: final list?) => RefreshIndicator(
          onRefresh: () => ref
              .refresh(adminEventsProvider.future)
              .then((_) {}, onError: (_) {}),
          child: ListView(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              if (list.isEmpty)
                TabEmpty(t.empty)
              else
                FadeSlideIn(
                  child: SectionCard(
                    children: [
                      for (final event in list)
                        EventRow(
                          event: event,
                          now: now,
                          heroed: false,
                          onTap: () => context.router.push(
                            EventRoute(eventId: event.id),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        AsyncValue(:final error?) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(adminEventsProvider),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
