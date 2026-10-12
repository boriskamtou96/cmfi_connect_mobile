import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/local_notifications.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../../core/widgets/motion.dart';
import '../../../../core/widgets/rolling_text.dart';
import '../../application/events_providers.dart';
import '../../domain/event.dart';
import 'event_format.dart';

/// Whether the event page shows the registration bar: not for a cancelled
/// event, nor once it is over.
bool showsRegistrationBar(CommunityEvent event) =>
    event.status == EventStatus.published &&
    event.registration.state != RegistrationState.ended;

/// Pinned under the event page: "Je participe", or the user's registration
/// with "Modifier", or why they can't register.
class RegistrationBar extends StatelessWidget {
  const RegistrationBar({required this.event, super.key});

  final CommunityEvent event;

  @override
  Widget build(BuildContext context) {
    final t = context.t.events;
    final scheme = Theme.of(context).colorScheme;
    final mine = event.myRegistration;
    final state = event.registration.state;
    final canChange =
        state == RegistrationState.open || state == RegistrationState.full;
    final placesLeft = event.placesLeft;

    final Widget content;
    if (mine != null) {
      final personal = AppTones.of(context);
      content = Row(
        children: [
          Icon(AppIcons.checkCircleFilled, color: personal.personal, size: 28),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.register.youAre,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  [
                    t.people(n: mine.people, count: context.count(mine.people)),
                    if (mine.needsLodging) t.register.lodgingShort,
                    if (mine.departureCity.isNotEmpty) mine.departureCity,
                  ].join(' · '),
                  style: TextStyle(
                    fontSize: 14,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (canChange)
            OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(0, 44)),
              onPressed: () => showRegistrationSheet(context, event),
              child: Text(t.register.edit),
            ),
        ],
      );
    } else {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (state == RegistrationState.open && placesLeft != null) ...[
            Text(
              t.placesLeft(n: placesLeft, count: context.count(placesLeft)),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 6),
          ],
          FilledButton.icon(
            onPressed: state == RegistrationState.open
                ? () => showRegistrationSheet(context, event)
                : null,
            icon: Icon(
              state == RegistrationState.open
                  ? AppIcons.calendarCheck
                  : AppIcons.info,
            ),
            label: Text(switch (state) {
              RegistrationState.open => t.register.cta,
              RegistrationState.full => t.stateFull,
              _ => t.stateClosed,
            }),
          ),
        ],
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 220),
            alignment: Alignment.topCenter,
            child: content,
          ),
        ),
      ),
    );
  }
}

/// The short form: how many, lodging and departure city when the event asks.
Future<void> showRegistrationSheet(
  BuildContext context,
  CommunityEvent event,
) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
    child: SingleChildScrollView(child: _RegistrationSheet(event: event)),
  ),
);

class _RegistrationSheet extends HookConsumerWidget {
  const _RegistrationSheet({required this.event});

  final CommunityEvent event;

  static const _maxPeople = 50;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.events.tone(context);
    final mine = event.myRegistration;
    final people = useState(mine?.people ?? 1);
    final lodging = useState(mine?.needsLodging ?? false);
    final city = useTextEditingController(text: mine?.departureCity ?? '');
    final sending = useState(false);
    final controller = ref.read(eventDetailProvider(event.id).notifier);

    Future<void> submit() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final navigator = Navigator.of(context);
      final notifications = ref.read(localNotificationsProvider);
      sending.value = true;
      try {
        await controller.register(
          people: people.value,
          needsLodging: lodging.value,
          departureCity: city.text,
        );
        navigator.pop();
        toast.success(mine == null ? t.register.done : t.register.updated);
        if (mine == null) {
          // the reminders of the day before need it
          unawaited(notifications.requestPermission());
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
        if (context.mounted) {
          sending.value = false;
        }
      }
    }

    Future<void> cancel() async {
      final confirmed = await showAppDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(t.register.cancelTitle),
          content: Text(t.register.cancelText),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(t.register.keep),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: scheme.error,
                foregroundColor: scheme.onError,
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(t.register.cancel),
            ),
          ],
        ),
      );
      if (confirmed != true || !context.mounted) {
        return;
      }
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final navigator = Navigator.of(context);
      sending.value = true;
      try {
        await controller.unregister();
        navigator.pop();
        toast.success(t.register.cancelled);
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
        if (context.mounted) {
          sending.value = false;
        }
      }
    }

    return Padding(
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
          Text(t.register.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 2),
          Text(
            '${event.title} · ${context.eventDates(event.startsAt, event.endsAt, event.timeZone)}',
            style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.xl),
          // how many
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.register.people,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      t.register.peopleHint,
                      style: TextStyle(
                        fontSize: 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton.filledTonal(
                tooltip: t.register.less,
                onPressed: people.value > 1 ? () => people.value-- : null,
                icon: const Icon(AppIcons.remove),
              ),
              SizedBox(
                width: 44,
                child: Center(
                  child: RollingText(
                    '${people.value}',
                    value: people.value,
                    alignment: Alignment.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              IconButton.filledTonal(
                tooltip: t.register.more,
                onPressed: people.value < _maxPeople
                    ? () => people.value++
                    : null,
                icon: const Icon(AppIcons.add),
              ),
            ],
          ),
          if (event.asksLodging) ...[
            const SizedBox(height: AppSpacing.md),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: lodging.value,
              onChanged: (value) => lodging.value = value,
              secondary: Icon(AppIcons.lodging, color: tone.onSoft),
              title: Text(
                t.register.lodging,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(t.register.lodgingHint),
            ),
          ],
          if (event.asksDepartureCity) ...[
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: city,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: t.register.departure,
                hintText: t.register.departureHint,
                prefixIcon: const Icon(AppIcons.departure),
              ),
            ),
          ],
          if (event.feeNote.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: tone.soft,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(AppIcons.fees, size: 20, color: tone.onSoft),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      event.feeNote,
                      style: TextStyle(fontSize: 14, color: tone.onSoft),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: mine == null ? t.register.confirm : t.register.update,
            isLoading: sending.value,
            onPressed: submit,
          ),
          if (mine != null) ...[
            const SizedBox(height: AppSpacing.sm),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: scheme.error),
              onPressed: sending.value ? null : cancel,
              child: Text(t.register.cancel),
            ),
          ],
        ],
      ),
    );
  }
}
