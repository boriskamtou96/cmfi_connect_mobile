import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/widgets/adaptive_pickers.dart';
import '../../../core/widgets/app_toast.dart';
import '../application/retreat_reminders.dart';
import '../domain/prayer.dart';
import 'widgets/prayer_look.dart';

/// The reminders of the four retreats: on or off, and at what time.
Future<void> showRetreatRemindersSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) =>
          const SingleChildScrollView(child: _RetreatRemindersSheet()),
    );

class _RetreatRemindersSheet extends ConsumerWidget {
  const _RetreatRemindersSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final times = ref.watch(retreatRemindersProvider);
    final reminders = ref.read(retreatRemindersProvider.notifier);

    Future<void> turnOn(RetreatMoment moment, TimeOfDay time) async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      if (!await reminders.set(moment, time)) {
        toast.error(messages.reminder.denied);
      }
    }

    Future<void> pickTime(RetreatMoment moment) async {
      final picked = await showAppTimePicker(
        context,
        initialTime: times[moment] ?? defaultRetreatTimes[moment]!,
      );
      if (picked != null && context.mounted) {
        await turnOn(moment, picked);
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.prayer.reminders.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          Text(
            t.prayer.reminders.intro,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          for (final moment in RetreatMoment.values)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(moment.icon, color: moment.colors.first),
              title: Text(
                moment.retreat(t),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                times[moment]?.format(context) ?? t.prayer.reminders.off,
              ),
              onTap: () => pickTime(moment),
              trailing: Switch.adaptive(
                value: times[moment] != null,
                onChanged: (on) => on
                    ? turnOn(moment, defaultRetreatTimes[moment]!)
                    : reminders.turnOff(moment),
              ),
            ),
        ],
      ),
    );
  }
}
