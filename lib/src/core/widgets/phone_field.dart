import 'package:flutter/material.dart';

import '../i18n/strings.g.dart';
import '../theme/app_icons.dart';
import '../theme/app_spacing.dart';
import '../utils/countries.dart';
import '../utils/phone.dart';
import 'country_sheet.dart';
import 'labeled_field.dart';

/// Phone number with the dial code of [country] in front: touching it opens
/// the list of countries. The number is checked for the chosen country; one
/// typed with its own prefix ("+33 6…") switches the country.
class PhoneField extends StatelessWidget {
  const PhoneField({
    required this.controller,
    required this.country,
    required this.onCountryChanged,
    this.lenient = false,
    this.textInputAction = TextInputAction.next,
    super.key,
  });

  final TextEditingController controller;
  final Country country;
  final ValueChanged<Country> onCountryChanged;

  /// Only checks the length (sign-in: an existing account is never refused).
  final bool lenient;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final language = TranslationProvider.of(context).locale.languageCode;
    final radius = BorderRadius.circular(AppRadius.md);

    Future<void> pickCountry() async {
      final picked = await showCountrySheet(
        context,
        title: t.countries.dialCodeTitle,
        selected: country,
        showDialCodes: true,
      );
      if (picked != null && picked != country) {
        onCountryChanged(picked);
      }
    }

    // "+33 6 12 34 56 78" typed or pasted: the country follows the prefix
    void followPrefix(String value) {
      final typed = value.trimLeft();
      if (!typed.startsWith('+') && !typed.startsWith('00')) {
        return;
      }
      final number = parsePhone(value, country);
      if (number == null || !number.isValidLength()) {
        return;
      }
      onCountryChanged(Country(number.isoCode));
      final national = number.formatNsn();
      controller.value = TextEditingValue(
        text: national,
        selection: TextSelection.collapsed(offset: national.length),
      );
    }

    return LabeledField(
      label: t.auth.phone,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            button: true,
            label: t.auth.dialCode(
              code: '${country.name(language)} ${country.dialCode}',
            ),
            hint: t.countries.change,
            excludeSemantics: true,
            child: Material(
              color: scheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: scheme.outline, width: 1.5),
                borderRadius: radius,
              ),
              child: InkWell(
                onTap: pickCountry,
                borderRadius: radius,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 52),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          country.flag,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          country.dialCode,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          AppIcons.expand,
                          size: 16,
                          color: scheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
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
              onChanged: followPrefix,
              decoration: InputDecoration(hintText: examplePhone(country)),
              validator: (value) {
                final digits = (value ?? '').replaceAll(RegExp('[^0-9]'), '');
                if (digits.isEmpty) {
                  return t.validation.required;
                }
                return isValidPhone(value!, country, lenient: lenient)
                    ? null
                    : t.validation.invalidPhone;
              },
            ),
          ),
        ],
      ),
    );
  }
}
