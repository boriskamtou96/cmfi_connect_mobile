import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/adaptive_pickers.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../application/report_reminder.dart';

/// After the first saved day: offers the evening reminder, once (closing the
/// sheet counts as an answer).
Future<void> showReminderOffer(BuildContext context, WidgetRef ref) async {
  await ref.read(reportReminderProvider.notifier).markOffered();
  if (!context.mounted) {
    return;
  }
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => const SingleChildScrollView(child: _ReminderOffer()),
  );
}

/// Plus › Rappel du soir: on / off and the time.
Future<void> showReminderSettings(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) =>
          const SingleChildScrollView(child: _ReminderSettingsSheet()),
    );

/// Turns the reminder on and says how it went.
Future<void> _enable(
  BuildContext context,
  WidgetRef ref, {
  TimeOfDay? time,
}) async {
  final t = context.t;
  final toast = ref.read(toasterProvider).of(context);
  final enabled = await ref
      .read(reportReminderProvider.notifier)
      .enable(time: time);
  if (!context.mounted) {
    return;
  }
  final chosen = ref.read(reportReminderProvider).time;
  if (enabled) {
    toast.success(t.reminder.enabled(time: chosen.format(context)));
  } else {
    toast.error(t.reminder.denied);
  }
}

Future<TimeOfDay?> _pickTime(BuildContext context, TimeOfDay initial) =>
    showAppTimePicker(
      context,
      initialTime: initial,
      helpText: context.t.reminder.time,
    );

class _ReminderOffer extends HookConsumerWidget {
  const _ReminderOffer();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final time = useState(ref.read(reportReminderProvider).time);

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
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(AppIcons.reminder, color: scheme.primary),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              t.reminder.offerTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.reminder.offerText,
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _TimeRow(
              time: time.value,
              onTap: () async {
                final picked = await _pickTime(context, time.value);
                if (picked != null) {
                  time.value = picked;
                }
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: () async {
                final navigator = Navigator.of(context);
                await _enable(context, ref, time: time.value);
                navigator.pop();
              },
              child: Text(t.reminder.offerAccept),
            ),
            const SizedBox(height: AppSpacing.xs),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.reminder.offerLater),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderSettingsSheet extends ConsumerWidget {
  const _ReminderSettingsSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final settings = ref.watch(reportReminderProvider);
    final reminder = ref.read(reportReminderProvider.notifier);

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
              t.reminder.settings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: settings.enabled,
              onChanged: (on) =>
                  on ? _enable(context, ref) : reminder.disable(),
              title: Text(
                t.reminder.switchLabel,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(t.reminder.switchHint),
            ),
            const SizedBox(height: AppSpacing.sm),
            AnimatedOpacity(
              opacity: settings.enabled ? 1 : 0.45,
              duration: const Duration(milliseconds: 180),
              child: _TimeRow(
                time: settings.time,
                onTap: settings.enabled
                    ? () async {
                        final picked = await _pickTime(context, settings.time);
                        if (picked != null) {
                          await reminder.setTime(picked);
                        }
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Heure du rappel        20:00 ›"
class _TimeRow extends StatelessWidget {
  const _TimeRow({required this.time, required this.onTap});

  final TimeOfDay time;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: 14,
          ),
          child: Row(
            children: [
              Icon(AppIcons.time, color: scheme.onSurfaceVariant),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  context.t.reminder.time,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                time.format(context),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: scheme.primary,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Icon(AppIcons.chevronRight, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
