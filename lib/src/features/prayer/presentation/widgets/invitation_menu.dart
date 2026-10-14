import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../../../core/widgets/motion.dart';
import '../../application/importunities.dart';
import '../../domain/prayer.dart';

enum _Choice { report, block }

/// The "⋮" of an invitation to pray (Apple guideline 1.2): report it to the
/// leaders, or block whoever sent it.
class InvitationMenu extends ConsumerWidget {
  const InvitationMenu({
    required this.topic,
    this.color,
    this.onBlocked,
    super.key,
  });

  final Importunity topic;
  final Color? color;

  /// The invitation is gone once blocked: the screen showing it leaves.
  final VoidCallback? onBlocked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.blocking;
    final name = inviterName(topic);
    return PopupMenuButton<_Choice>(
      icon: Icon(
        AppIcons.moreOptions,
        color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      onSelected: (choice) => switch (choice) {
        _Choice.report => showReportSheet(context, topic),
        _Choice.block => _block(context, ref),
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: _Choice.report,
          child: _MenuRow(icon: AppIcons.report, label: t.report),
        ),
        PopupMenuItem(
          value: _Choice.block,
          child: _MenuRow(
            icon: AppIcons.block,
            label: t.block(name: name),
          ),
        ),
      ],
    );
  }

  /// Asks first, then blocks: the invitation leaves the list.
  Future<void> _block(BuildContext context, WidgetRef ref) async {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final name = inviterName(topic);
    final confirmed =
        await showAppDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(t.blocking.blockTitle(name: name)),
            content: Text(t.blocking.blockText(name: name)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(t.common.cancel),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: scheme.error,
                  foregroundColor: scheme.onError,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(t.blocking.blockAction),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed || !context.mounted) {
      return;
    }
    // the card showing the invitation goes away with it: nothing of the
    // widget is used after the call
    final toast = ref.read(toasterProvider).of(context);
    final notifier = ref.read(importunitiesProvider.notifier);
    final blocked = onBlocked;
    try {
      await notifier.blockInviter(topic);
      blocked?.call();
      toast.success(t.blocking.blocked(name: name));
    } on Object catch (error) {
      toast.error(userMessageFor(error, t));
    }
  }
}

/// "Paul", or "@paul.m" when the server gives no first name.
String inviterName(Importunity topic) {
  final inviter = topic.inviter;
  return inviter.firstName.isNotEmpty
      ? inviter.firstName
      : '@${inviter.username}';
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: AppSpacing.md),
        Flexible(child: Text(label)),
      ],
    );
  }
}

/// Reports an invitation to the leaders: why (unwanted, shocking or
/// offensive, other) and, if the user wants, a few words.
Future<void> showReportSheet(BuildContext context, Importunity topic) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(child: _ReportSheet(topic: topic)),
      ),
    );

class _ReportSheet extends HookConsumerWidget {
  const _ReportSheet({required this.topic});

  final Importunity topic;

  /// What the server takes at most.
  static const maxComment = 500;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final reason = useState<ReportReason?>(null);
    final comment = useTextEditingController();
    final sending = useState(false);

    Future<void> send(ReportReason chosen) async {
      final toast = ref.read(toasterProvider).of(context);
      final navigator = Navigator.of(context);
      final notifier = ref.read(importunitiesProvider.notifier);
      sending.value = true;
      try {
        await notifier.reportInvitation(
          topic,
          reason: chosen,
          comment: comment.text,
        );
        navigator.pop();
        toast.success(t.blocking.reported);
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
        if (context.mounted) {
          sending.value = false;
        }
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xl,
          0,
          AppSpacing.xl,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.blocking.reportTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.blocking.reportText,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            RadioGroup<ReportReason>(
              groupValue: reason.value,
              onChanged: (value) => reason.value = value,
              child: Column(
                children: [
                  for (final option in ReportReason.values)
                    RadioListTile<ReportReason>(
                      value: option,
                      contentPadding: EdgeInsets.zero,
                      title: Text(switch (option) {
                        ReportReason.spam => t.blocking.reasons.spam,
                        ReportReason.offensive => t.blocking.reasons.offensive,
                        ReportReason.other => t.blocking.reasons.other,
                      }),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            LabeledField(
              label: t.blocking.comment,
              optionalText: t.common.optional,
              child: TextField(
                controller: comment,
                minLines: 2,
                maxLines: 4,
                maxLength: maxComment,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(hintText: t.blocking.commentHint),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: t.blocking.send,
              isLoading: sending.value,
              onPressed: switch (reason.value) {
                final chosen? => () => send(chosen),
                null => null,
              },
            ),
          ],
        ),
      ),
    );
  }
}
