import 'package:flutter/material.dart';

import '../i18n/strings.g.dart';
import '../theme/app_spacing.dart';
import '../utils/phone.dart';
import 'labeled_field.dart';

/// Phone number with the Cameroon dial code in front (+237).
class PhoneField extends StatelessWidget {
  const PhoneField({
    required this.controller,
    this.textInputAction = TextInputAction.next,
    super.key,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;

    return LabeledField(
      label: t.auth.phone,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            label: t.auth.dialCode(code: defaultDialCode),
            excludeSemantics: true,
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLow,
                border: Border.all(color: scheme.outline, width: 1.5),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              alignment: Alignment.center,
              child: const Text(
                defaultDialCode,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.phone,
              textInputAction: textInputAction,
              autofillHints: const [AutofillHints.telephoneNumberNational],
              decoration: InputDecoration(hintText: t.auth.phoneHint),
              validator: (value) {
                final digits = (value ?? '').replaceAll(RegExp(r'[^0-9+]'), '');
                if (digits.isEmpty) {
                  return t.validation.required;
                }
                return digits.replaceAll('+', '').length < 8
                    ? t.validation.invalidPhone
                    : null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
