import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/network/app_exception.dart';
import '../../../../core/network/app_exception_message.dart';
import '../../../../core/services/local_notifications.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/adaptive_dialogs.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_toast.dart';
import '../../../members/application/my_account.dart';
import '../../../payments/domain/payment.dart';
import '../../../payments/infrastructure/payments_api.dart';
import '../../../payments/presentation/operator_logo.dart';
import '../../../payments/presentation/payment_waiting.dart';
import '../../application/events_providers.dart';
import '../../domain/event.dart';
import '../../infrastructure/events_api.dart';
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
                    if (mine.people > 1)
                      t.people(
                        n: mine.people,
                        count: context.count(mine.people),
                      ),
                    if (mine.needsLodging) t.register.lodgingShort,
                    if (mine.departureCity.isNotEmpty) mine.departureCity,
                    if (mine.paid) t.pay.paidShort,
                    if (!mine.needsLodging &&
                        mine.departureCity.isEmpty &&
                        !mine.paid &&
                        mine.people <= 1)
                      t.register.youAreHint,
                  ].join(' · '),
                  style: TextStyle(
                    fontSize: 14,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                // registered, to pay later
                if (event.price case final price? when !mine.paid)
                  Text(
                    t.pay.toPay(
                      amount: formatMoney(
                        price.amount * mine.people,
                        price.currency,
                        Localizations.localeOf(context).toString(),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: scheme.error,
                    ),
                  ),
              ],
            ),
          ),
          if (canChange)
            OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(0, 44)),
              onPressed: () => showRegistrationSheet(context, event),
              child: Text(
                event.price != null && !mine.paid
                    ? t.pay.payNow
                    : t.register.edit,
              ),
            ),
        ],
      );
    } else {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (event.price case final price?
              when state == RegistrationState.open) ...[
            Text(
              t.pay.perPerson(
                price: formatMoney(
                  price.amount,
                  price.currency,
                  Localizations.localeOf(context).toString(),
                ),
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
          ],
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events;
    final scheme = Theme.of(context).colorScheme;
    final tone = AppModule.events.tone(context);
    final mine = event.myRegistration;
    // the member registers themselves (an older registration keeps its
    // people)
    final people = mine?.people ?? 1;
    final lodging = useState(mine?.needsLodging ?? false);
    final city = useTextEditingController(text: mine?.departureCity ?? '');
    final sending = useState(false);
    final controller = ref.read(eventDetailProvider(event.id).notifier);

    // a paid event: paid by mobile money, then registered by the server
    final price = event.price;
    final paidAlready = mine?.paid ?? false;
    final paying = price != null && !paidAlready;
    final locale = Localizations.localeOf(context).toString();
    final phone = useTextEditingController(
      text: ref.read(myAccountProvider).value?.phoneNumber ?? '',
    );
    final phoneText = useValueListenable(phone).text;
    final chosenOperator = useState<String?>(null);
    final guessedOperator = useState<String?>(null);
    final payment = useState<Payment?>(null);
    final operatorsState = paying
        ? ref.watch(mobileMoneyOperatorsProvider(price.currency))
        : null;
    final operators = operatorsState?.value;
    // mobile money switched off on the server: register now, pay later
    final paymentsOff = switch (operatorsState?.error) {
      ApiException(code: 'PAYMENTS_DISABLED') => true,
      _ => false,
    };
    final canPay = paying && !paymentsOff;

    // the operator of the number, guessed as it is typed
    useEffect(() {
      if (!canPay || phoneText.replaceAll(RegExp(r'\D'), '').length < 9) {
        return null;
      }
      final timer = Timer(const Duration(milliseconds: 500), () async {
        try {
          final guess = await ref
              .read(paymentsApiProvider)
              .guessOperator(phoneText.trim());
          if (context.mounted) {
            guessedOperator.value = guess.provider;
          }
        } on Object {
          // an unknown number: the server says it when paying
        }
      });
      return timer.cancel;
    }, [phoneText, canPay]);
    final operator = chosenOperator.value ?? guessedOperator.value;

    Future<void> pay() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      sending.value = true;
      try {
        final started = await ref
            .read(paymentsApiProvider)
            .payForEvent(
              event.id,
              people: people,
              needsLodging: lodging.value,
              departureCity: city.text.trim(),
              phoneNumber: phone.text.trim(),
              provider: operator ?? '',
            );
        if (started.status == PaymentStatus.failed) {
          toast.error(paymentFailureMessage(started.failureCode, messages));
        } else {
          payment.value = started;
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, messages));
      } finally {
        if (context.mounted) {
          sending.value = false;
        }
      }
    }

    // paid: the event comes back with the registration
    Future<void> paid(Payment _) async {
      final toast = ref.read(toasterProvider).of(context);
      final navigator = Navigator.of(context);
      final notifications = ref.read(localNotificationsProvider);
      try {
        await controller.replace(
          await ref.read(eventsApiProvider).get(event.id),
        );
      } on Object {
        // shown at the next opening of the event
      }
      navigator.pop();
      toast.success(t.pay.done);
      unawaited(notifications.requestPermission());
    }

    if (payment.value case final started?) {
      return PaymentWaiting(
        payment: started,
        onCompleted: paid,
        onRetry: () => payment.value = null,
      );
    }

    Future<void> submit() async {
      final toast = ref.read(toasterProvider).of(context);
      final messages = context.t;
      final navigator = Navigator.of(context);
      final notifications = ref.read(localNotificationsProvider);
      sending.value = true;
      try {
        await controller.register(
          people: people,
          needsLodging: lodging.value,
          departureCity: city.text,
        );
        navigator.pop();
        toast.success(switch (price) {
          // registered without paying yet
          final price? when mine == null => t.pay.laterDone(
            amount: formatMoney(price.amount * people, price.currency, locale),
          ),
          _ when mine == null => t.register.done,
          _ => t.register.updated,
        });
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
      final confirmed = await showConfirmDialog(
        context,
        title: t.register.cancelTitle,
        text: t.register.cancelText,
        cancelLabel: t.register.keep,
        confirmLabel: t.register.cancel,
        destructive: true,
      );
      if (!confirmed || !context.mounted) {
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
          if (event.asksLodging) ...[
            const SizedBox(height: AppSpacing.md),
            SwitchListTile.adaptive(
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
          if (paying && paymentsOff) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              t.pay.unavailable,
              style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
            ),
          ],
          if (canPay) ...[
            const SizedBox(height: AppSpacing.xl),
            Text(
              t.pay.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              autofillHints: const [AutofillHints.telephoneNumber],
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: t.pay.phone,
                hintText: t.pay.phoneHint,
                helperText: t.pay.phoneHelp,
                helperMaxLines: 2,
                prefixIcon: const Icon(AppIcons.phone),
              ),
            ),
            if (operators != null && operators.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                t.pay.operator,
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.xs),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final country in operators)
                    for (final candidate in country.operators)
                      if (candidate.isOpen)
                        OperatorChoice(
                          provider: candidate.provider,
                          label: operators.length > 1
                              ? '${candidate.name} · ${country.nameIn(locale.split('_').first)}'
                              : candidate.name,
                          selected: operator == candidate.provider,
                          onTap: () =>
                              chosenOperator.value = candidate.provider,
                        ),
                ],
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: Text(
                    t.pay.total,
                    style: TextStyle(
                      fontSize: 15,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Text(
                  formatMoney(price.amount * people, price.currency, locale),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
          if (paidAlready) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              t.pay.paidNote,
              style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: canPay
                ? t.pay.pay(
                    amount: formatMoney(
                      price.amount * people,
                      price.currency,
                      locale,
                    ),
                  )
                : mine == null
                ? t.register.confirm
                : t.register.update,
            isLoading: sending.value,
            onPressed: canPay ? pay : submit,
          ),
          // or registered now, paid later
          if (canPay) ...[
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: sending.value ? null : submit,
              child: Text(mine == null ? t.pay.later : t.register.update),
            ),
          ],
          if (mine != null && !paidAlready) ...[
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
