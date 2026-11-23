import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/services/link_launcher.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/utils/phone.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/phone_field.dart';
import '../../../core/widgets/sub_page.dart';
import '../../../core/widgets/tour/space_tour.dart';
import '../../members/application/my_account.dart';
import '../domain/payment.dart';
import '../infrastructure/payments_api.dart';
import 'operator_logo.dart';
import 'payment_waiting.dart';

/// « Faire un don » (13/11/2026): the member chooses an amount (one of the
/// four offered, or their own), then pays like a registration: mobile money
/// (the number of the account by default, its operator guessed) or a card on
/// the provider's secure page. The payment is followed here; once received, a thank you.
/// Nothing is given in return. The currency and the way shown first follow
/// the member's country (18/11/2026, [PaymentOptions]): the card in their
/// currency, mobile money in the operator's (XAF).
@RoutePage()
class DonationScreen extends HookConsumerWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toString();
    final typed = useTextEditingController();
    final typedText = useValueListenable(typed).text;
    // the amount touched, in the currency it was shown in
    final chosen = useState<(String, int)?>(null);
    // the number of the account, its country in front (the dial code is
    // chosen, never typed)
    final (accountCountry, accountNational) = splitPhone(
      ref.read(myAccountProvider).value?.phoneNumber ?? '',
      ref.read(phoneCountryProvider),
    );
    final phoneCountry = useState(accountCountry);
    final phone = useTextEditingController(text: accountNational);
    final phoneText = useValueListenable(phone).text;
    final chosenOperator = useState<String?>(null);
    final guessedOperator = useState<String?>(null);
    // null: the way the server shows first
    final chosenMethod = useState<PaymentMethod?>(null);
    final sending = useState(false);
    final payment = useState<Payment?>(null);
    final thanked = useState<Payment?>(null);

    final optionsState = ref.watch(paymentOptionsProvider('XAF'));
    final options = optionsState.value;
    final operators = options?.countries;
    final cards = options?.cards ?? false;
    final cardFirst = cards && options?.preferred == PaymentMethod.card.code;
    final method =
        chosenMethod.value ??
        (cardFirst ? PaymentMethod.card : PaymentMethod.mobileMoney);
    final byCard = cards && method == PaymentMethod.card;
    // mobile money in the operator's currency, the card in the country's
    final currency = byCard ? options?.cardCurrency ?? 'XAF' : 'XAF';
    final rule = options?.ruleFor(currency) ?? DonationRule.fallback;
    final minDonation = byCard ? rule.cardMin : rule.min;
    final maxDonation = rule.max;
    final paymentsOff = switch (optionsState.error) {
      ApiException(code: 'PAYMENTS_DISABLED') => true,
      _ => false,
    };

    // the amount touched in this currency, else the second one offered
    final touched = switch (chosen.value) {
      (final shownIn, final value) when shownIn == currency => value,
      _ => rule.amounts[rule.amounts.length > 1 ? 1 : 0],
    };
    // the amount typed wins over the one touched
    final amount = typedText.trim().isEmpty
        ? touched
        : int.tryParse(typedText.replaceAll(RegExp(r'\D'), ''));
    final amountOk =
        amount != null && amount >= minDonation && amount <= maxDonation;
    String money(int value) => formatMoney(value, currency, locale);

    // the operator of the number, guessed as it is typed
    useEffect(() {
      if (byCard ||
          !(parsePhone(phoneText, phoneCountry.value)?.isValidLength() ??
              false)) {
        return null;
      }
      final timer = Timer(const Duration(milliseconds: 500), () async {
        try {
          final guess = await ref
              .read(paymentsApiProvider)
              .guessOperator(
                toInternationalPhone(phoneText, country: phoneCountry.value),
              );
          if (context.mounted) {
            guessedOperator.value = guess.provider;
          }
        } on Object {
          // an unknown number: the server says it when paying
        }
      });
      return timer.cancel;
    }, [phoneText, phoneCountry.value, byCard]);
    final operator = chosenOperator.value ?? guessedOperator.value;

    Future<void> give() async {
      final toast = ref.read(toasterProvider).of(context);
      if (!amountOk) {
        toast.error(
          t.donation.bounds(min: money(minDonation), max: money(maxDonation)),
        );
        return;
      }
      sending.value = true;
      try {
        final started = await ref
            .read(paymentsApiProvider)
            .donate(
              amount,
              method: byCard ? PaymentMethod.card : PaymentMethod.mobileMoney,
              phoneNumber: toInternationalPhone(
                phone.text,
                country: phoneCountry.value,
              ),
              provider: operator ?? '',
              // a server that knows the currencies checks the one shown
              currency: (options?.donations.isEmpty ?? true) ? null : currency,
            );
        if (started.status == PaymentStatus.failed) {
          toast.error(paymentFailureMessage(started.failureCode, t));
        } else {
          payment.value = started;
          // a card: the provider's secure page, the app waits behind it
          if (started.gatewayUrl.isNotEmpty) {
            unawaited(
              ref
                  .read(linkLauncherProvider)
                  .openInApp(Uri.parse(started.gatewayUrl)),
            );
          }
        }
      } on Object catch (error) {
        toast.error(userMessageFor(error, t));
      } finally {
        if (context.mounted) {
          sending.value = false;
        }
      }
    }

    if (thanked.value case final received?) {
      return SubPage(
        title: t.donation.title,
        child: _Thanks(
          amount: money(received.amount),
          onDone: () => Navigator.of(context).pop(),
        ),
      );
    }
    if (payment.value case final started?) {
      return SubPage(
        title: t.donation.title,
        child: Center(
          child: PaymentWaiting(
            payment: started,
            slowText: t.donation.waitingSlow,
            cardText: t.donation.waitingCard,
            onCompleted: (done) async {
              unawaited(HapticFeedback.mediumImpact());
              payment.value = null;
              thanked.value = done;
            },
            onRetry: () => payment.value = null,
          ),
        ),
      );
    }

    return SpaceTour(
      space: TourSpace.donate,
      child: SubPage(
        title: t.donation.title,
        bottom: paymentsOff
            ? null
            : SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.md,
                  ),
                  child: TourTarget(
                    step: TourStep.donateGive,
                    child: AppButton(
                      label: amountOk
                          ? (byCard ? t.donation.giveCard : t.donation.give)(
                              amount: money(amount),
                            )
                          : t.donation.title,
                      isLoading: sending.value,
                      onPressed: give,
                    ),
                  ),
                ),
              ),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              t.donation.intro,
              style: TextStyle(
                fontSize: 14.5,
                height: 1.4,
                color: scheme.onSurfaceVariant,
              ),
            ),
            if (paymentsOff) ...[
              const SizedBox(height: AppSpacing.lg),
              Text(t.donation.unavailable),
            ] else ...[
              const SizedBox(height: AppSpacing.lg),
              Text(
                t.donation.amount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TourTarget(
                step: TourStep.donateAmounts,
                child: Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final value in rule.amounts)
                      ChoiceChip(
                        label: Text(money(value)),
                        selected: typedText.trim().isEmpty && touched == value,
                        onSelected: (_) {
                          typed.clear();
                          chosen.value = (currency, value);
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: typed,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                decoration: InputDecoration(
                  labelText: t.donation.other,
                  suffixText: formatMoney(0, currency, locale).split(' ').last,
                  helperText: t.donation.bounds(
                    min: money(minDonation),
                    max: money(maxDonation),
                  ),
                  errorText: typedText.trim().isNotEmpty && !amountOk
                      ? t.donation.bounds(
                          min: money(minDonation),
                          max: money(maxDonation),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                cards ? t.events.pay.how : t.events.pay.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              if (cards) ...[
                TourTarget(
                  step: TourStep.donateMethod,
                  radius: 999,
                  child: SegmentedButton<PaymentMethod>(
                    // its own icons say enough: no tick in place of them
                    showSelectedIcon: false,
                    segments: [
                      for (final way
                          in cardFirst
                              ? [PaymentMethod.card, PaymentMethod.mobileMoney]
                              : [PaymentMethod.mobileMoney, PaymentMethod.card])
                        way == PaymentMethod.card
                            ? ButtonSegment(
                                value: way,
                                icon: const Icon(AppIcons.card),
                                label: Text(t.events.pay.methodCard),
                              )
                            : ButtonSegment(
                                value: way,
                                icon: const Icon(AppIcons.mobileMoney),
                                label: Text(t.events.pay.methodMobile),
                              ),
                    ],
                    selected: {method},
                    onSelectionChanged: (choice) {
                      // another currency: the amount typed meant another
                      typed.clear();
                      chosenMethod.value = choice.first;
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              if (byCard)
                Text(
                  t.events.pay.cardNote,
                  style: TextStyle(
                    fontSize: 14,
                    color: scheme.onSurfaceVariant,
                  ),
                )
              else ...[
                PhoneField(
                  controller: phone,
                  country: phoneCountry.value,
                  onCountryChanged: (picked) => phoneCountry.value = picked,
                  textInputAction: TextInputAction.done,
                  label: t.events.pay.phone,
                  helperText: t.events.pay.phoneHelp,
                ),
                if (operators != null && operators.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    t.events.pay.operator,
                    style: TextStyle(
                      fontSize: 13,
                      color: scheme.onSurfaceVariant,
                    ),
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
              ],
            ],
          ],
        ),
      ),
    );
  }
}

/// The donation arrived: Zoé, a thank you with the amount, and the way back.
class _Thanks extends StatelessWidget {
  const _Thanks({required this.amount, required this.onDone});

  final String amount;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          const ExcludeSemantics(
            child: Center(
              child: DoveMascot(pose: DovePose.celebrate, size: 120),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Semantics(
            header: true,
            liveRegion: true,
            child: Text(
              t.donation.thanksTitle,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.donation.thanksText(amount: amount),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.5,
              height: 1.4,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            t.donation.verse,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Lora',
              fontSize: 15,
              fontStyle: FontStyle.italic,
              height: 1.4,
              color: AppColors.gold,
            ),
          ),
          const Spacer(flex: 2),
          AppButton(label: t.donation.done, onPressed: onDone),
        ],
      ),
    );
  }
}
