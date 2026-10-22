import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../domain/payment.dart';
import '../infrastructure/payments_api.dart';

/// The member confirms the payment on their phone (their mobile money PIN):
/// the payment is asked every [every] until it ends. [onCompleted] once paid;
/// [onRetry] after a failure. After [patience] it says the outcome will come
/// anyway (the server finishes it).
class PaymentWaiting extends HookConsumerWidget {
  const PaymentWaiting({
    required this.payment,
    required this.onCompleted,
    required this.onRetry,
    this.every = const Duration(seconds: 3),
    this.patience = const Duration(minutes: 3),
    super.key,
  });

  final Payment payment;
  final Future<void> Function(Payment payment) onCompleted;
  final VoidCallback onRetry;
  final Duration every;
  final Duration patience;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t.events.pay;
    final scheme = Theme.of(context).colorScheme;
    final current = useState(payment);
    final slow = useState(false);
    final locale = Localizations.localeOf(context).toString();

    useEffect(() {
      final api = ref.read(paymentsApiProvider);
      var asking = false;
      var done = false;
      final timer = Timer.periodic(every, (timer) async {
        if (asking || done) {
          return;
        }
        asking = true;
        try {
          final next = await api.get(payment.id);
          if (!context.mounted || done) {
            return;
          }
          current.value = next;
          if (next.status == PaymentStatus.completed) {
            done = true;
            timer.cancel();
            await onCompleted(next);
          } else if (next.status != PaymentStatus.pending) {
            done = true;
            timer.cancel();
          }
        } on Object {
          // offline a moment: asked again next time
        } finally {
          asking = false;
        }
      });
      final late = Timer(patience, () {
        if (context.mounted) {
          slow.value = true;
        }
      });
      return () {
        timer.cancel();
        late.cancel();
      };
    }, const []);

    final amount = formatMoney(payment.amount, payment.currency, locale);
    final status = current.value.status;
    final failed =
        status == PaymentStatus.failed ||
        status == PaymentStatus.refunding ||
        status == PaymentStatus.refunded;

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.md),
          Center(
            child: failed
                ? Icon(AppIcons.error, size: 56, color: scheme.error)
                : const SizedBox.square(
                    dimension: 56,
                    child: CircularProgressIndicator(strokeWidth: 4),
                  ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Semantics(
            liveRegion: true,
            child: Text(
              failed ? t.failedTitle : t.waitingTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            failed
                ? paymentFailureMessage(current.value.failureCode, context.t)
                : slow.value
                ? t.waitingSlow
                : t.waitingText(amount: amount),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.4,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          if (failed)
            AppButton(label: t.retry, onPressed: onRetry)
          else if (slow.value)
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(t.close),
            ),
        ],
      ),
    );
  }
}

/// Why a payment failed, in words the member understands.
String paymentFailureMessage(String code, Translations t) {
  final failures = t.events.pay.failures;
  return switch (code) {
    'INSUFFICIENT_BALANCE' => failures.insufficientBalance,
    'PAYER_NOT_FOUND' || 'INVALID_PHONE_NUMBER' => failures.payerNotFound,
    'PAYER_LIMIT_REACHED' || 'WALLET_LIMIT_REACHED' => failures.limitReached,
    'PAYMENT_NOT_APPROVED' || 'PAYER_NOT_APPROVED' => failures.notApproved,
    'PROVIDER_TEMPORARILY_UNAVAILABLE' ||
    'PAYMENTS_UNAVAILABLE' => failures.unavailable,
    _ => failures.generic,
  };
}
