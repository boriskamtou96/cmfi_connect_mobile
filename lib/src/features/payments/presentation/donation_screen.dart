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
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/dove_mascot.dart';
import '../../../core/widgets/sub_page.dart';
import '../../members/application/my_account.dart';
import '../domain/payment.dart';
import '../infrastructure/payments_api.dart';
import 'operator_logo.dart';
import 'payment_waiting.dart';

/// The amounts offered at a touch, and the bounds of the server
/// (api/payments.go), in whole units of the currency.
const donationAmounts = [1000, 2000, 5000, 10000];
const minDonation = 100;
const maxDonation = 500000;
const _currency = 'XAF';

/// « Faire un don » (13/11/2026): the member chooses an amount (one of the
/// four offered, or their own), then pays like a registration: mobile money
/// (the number of the account by default, its operator guessed) or a card on
/// Wajub's page. The payment is followed here; once received, a thank you.
/// Nothing is given in return.
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
    final chosen = useState<int?>(donationAmounts[1]);
    final phone = useTextEditingController(
      text: ref.read(myAccountProvider).value?.phoneNumber ?? '',
    );
    final phoneText = useValueListenable(phone).text;
    final chosenOperator = useState<String?>(null);
    final guessedOperator = useState<String?>(null);
    final method = useState(PaymentMethod.mobileMoney);
    final sending = useState(false);
    final payment = useState<Payment?>(null);
    final thanked = useState<Payment?>(null);

    final optionsState = ref.watch(paymentOptionsProvider(_currency));
    final operators = optionsState.value?.countries;
    final cards = optionsState.value?.cards ?? false;
    final byCard = cards && method.value == PaymentMethod.card;
    final paymentsOff = switch (optionsState.error) {
      ApiException(code: 'PAYMENTS_DISABLED') => true,
      _ => false,
    };

    // the amount typed wins over the one touched
    final amount = typedText.trim().isEmpty
        ? chosen.value
        : int.tryParse(typedText.replaceAll(RegExp(r'\D'), ''));
    final amountOk =
        amount != null && amount >= minDonation && amount <= maxDonation;
    String money(int value) => formatMoney(value, _currency, locale);

    // the operator of the number, guessed as it is typed
    useEffect(() {
      if (byCard || phoneText.replaceAll(RegExp(r'\D'), '').length < 9) {
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
    }, [phoneText, byCard]);
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
              phoneNumber: phone.text.trim(),
              provider: operator ?? '',
            );
        if (started.status == PaymentStatus.failed) {
          toast.error(paymentFailureMessage(started.failureCode, t));
        } else {
          payment.value = started;
          // a card: Wajub's secure page, the app waits behind it
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

    return SubPage(
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final value in donationAmounts)
                  ChoiceChip(
                    label: Text(money(value)),
                    selected: typedText.trim().isEmpty && chosen.value == value,
                    onSelected: (_) {
                      typed.clear();
                      chosen.value = value;
                    },
                  ),
              ],
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
                suffixText: 'FCFA',
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.md),
            if (cards) ...[
              SegmentedButton<PaymentMethod>(
                // its own icons say enough: no tick in place of them
                showSelectedIcon: false,
                segments: [
                  ButtonSegment(
                    value: PaymentMethod.mobileMoney,
                    icon: const Icon(AppIcons.mobileMoney),
                    label: Text(t.events.pay.methodMobile),
                  ),
                  ButtonSegment(
                    value: PaymentMethod.card,
                    icon: const Icon(AppIcons.card),
                    label: Text(t.events.pay.methodCard),
                  ),
                ],
                selected: {method.value},
                onSelectionChanged: (choice) => method.value = choice.first,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            if (byCard)
              Text(
                t.events.pay.cardNote,
                style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
              )
            else ...[
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                autofillHints: const [AutofillHints.telephoneNumber],
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: t.events.pay.phone,
                  hintText: t.events.pay.phoneHint,
                  helperText: t.events.pay.phoneHelp,
                  helperMaxLines: 2,
                  prefixIcon: const Icon(AppIcons.phone),
                ),
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
