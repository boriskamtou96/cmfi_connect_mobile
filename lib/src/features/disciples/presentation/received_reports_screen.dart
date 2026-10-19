import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/utils/date_format.dart';
import '../../../core/widgets/adaptive.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../routing/app_router.dart';
import '../../members/presentation/widgets/member_avatar.dart';
import '../application/received_reports.dart';
import '../domain/received_report.dart';

/// Plus › Accompagnement › Comptes rendus reçus (and the push « Grâce t'a
/// envoyé son compte rendu »): the periods the disciples sent in the app,
/// the newest first, those not opened marked in gold. « Voir » opens their
/// reports (and marks it read), « Encourager » answers with a word (a few
/// ready-made ones a tap away); they get it as a push.
@RoutePage()
class ReceivedReportsScreen extends ConsumerWidget {
  const ReceivedReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.received;
    final reports = ref.watch(receivedReportsProvider);
    final notifier = ref.read(receivedReportsProvider.notifier);

    return SubPage(
      title: t.title,
      child: switch (reports) {
        AsyncValue(value: final state?) when state.items.isEmpty => _Empty(
          text: t.empty,
        ),
        AsyncValue(value: final state?) =>
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              final metrics = notification.metrics;
              if (metrics.pixels > metrics.maxScrollExtent - 300) {
                notifier.loadMore();
              }
              return false;
            },
            child: RefreshIndicator.adaptive(
              onRefresh: () => ref.refresh(receivedReportsProvider.future),
              child: ListView(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.lg,
                  AppSpacing.sm,
                  AppSpacing.lg,
                  AppSpacing.xxl,
                ),
                children: [
                  for (final report in state.items) ...[
                    _ReceivedCard(report: report),
                    const SizedBox(height: AppSpacing.md),
                  ],
                  if (state.loadingMore)
                    const Padding(
                      padding: EdgeInsets.all(AppSpacing.lg),
                      child: Center(child: AppSpinner()),
                    ),
                ],
              ),
            ),
          ),
        AsyncValue(:final error?) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(receivedReportsProvider),
        ),
        _ => const LoadingCards(count: 3, height: 130),
      },
    );
  }
}

/// "Du 12 au 18 oct." (one day: "Le 18 oct.").
String _periodOf(BuildContext context, ReceivedReport report) {
  final t = context.t.received;
  final to = context.formatDate(report.periodTo, 'd MMM');
  if (report.periodFrom == report.periodTo) {
    return t.day(date: to);
  }
  return t.period(from: context.formatDate(report.periodFrom, 'd MMM'), to: to);
}

class _ReceivedCard extends ConsumerWidget {
  const _ReceivedCard({required this.report});

  final ReceivedReport report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.received;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.reports.tone(context);
    final member = report.member;
    final notifier = ref.read(receivedReportsProvider.notifier);
    // the theme's buttons take the whole width
    final compact = ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(0, 44)),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      ),
    );

    void open() {
      notifier.markRead(report);
      context.router.push(
        DiscipleReportsRoute(
          authorityId: report.authorityId,
          name: member.fullName,
        ),
      );
    }

    return SectionCard(
      children: [
        InkWell(
          onTap: open,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                MemberAvatar(
                  initials: member.initials,
                  photo: member.avatar,
                  background: tone.soft,
                  foreground: tone.onSoft,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        _periodOf(context, report),
                        style: TextStyle(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                if (report.unread)
                  Semantics(
                    label: t.unread,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.gold,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (report.reply.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              t.yourReply(text: report.reply),
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            AppSpacing.xs,
            AppSpacing.sm,
            AppSpacing.sm,
          ),
          child: Row(
            children: [
              TextButton.icon(
                onPressed: open,
                style: compact,
                icon: const Icon(AppIcons.reports, size: 18),
                label: Text(t.open),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Spacer(),
              Flexible(
                flex: 6,
                child: FilledButton.tonalIcon(
                  onPressed: () => _encourage(context, ref, report),
                  style: compact,
                  icon: const Icon(AppIcons.message, size: 18),
                  label: Text(
                    report.reply.isEmpty ? t.encourage : t.editReply,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The word of encouragement: typed, or one of a few ready-made.
Future<void> _encourage(
  BuildContext context,
  WidgetRef ref,
  ReceivedReport report,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (sheet) => _EncourageSheet(report: report),
);

class _EncourageSheet extends HookConsumerWidget {
  const _EncourageSheet({required this.report});

  final ReceivedReport report;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.received;
    final controller = useTextEditingController(text: report.reply);
    final text = useValueListenable(controller).text.trim();
    final busy = useState(false);

    Future<void> send() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final navigator = Navigator.of(context);
      busy.value = true;
      try {
        await ref.read(receivedReportsProvider.notifier).reply(report, text);
        toast.success(t.sent(name: report.member.firstName));
        navigator.pop();
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      } finally {
        if (context.mounted) {
          busy.value = false;
        }
      }
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.encourageTitle(name: report.member.firstName),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final suggestion in t.suggestions)
                ActionChip(
                  label: Text(suggestion),
                  onPressed: () => controller.text = suggestion,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: controller,
            minLines: 3,
            maxLines: 6,
            maxLength: 500,
            autofocus: report.reply.isEmpty,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(hintText: t.hint),
          ),
          const SizedBox(height: AppSpacing.sm),
          FilledButton(
            onPressed: text.isEmpty || busy.value ? null : send,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
            ),
            child: busy.value
                ? const AppSpinner(size: 22, color: Colors.white)
                : Text(t.send),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const DoveMascot(pose: DovePose.joy, size: 96),
          const SizedBox(height: AppSpacing.lg),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    ),
  );
}
