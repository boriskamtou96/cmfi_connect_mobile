import 'package:flutter/material.dart';

import '../i18n/strings.g.dart';
import '../theme/app_icons.dart';
import '../theme/app_spacing.dart';
import '../utils/countries.dart';
import 'country_sheet.dart';
import 'labeled_field.dart';

/// A country chosen in the list of countries ([showCountrySheet]), shown with
/// its flag and its name in the app language. [value] is an ISO code ("CM");
/// a free text saved before the list (an old profile) is shown as it is.
class CountryField extends StatelessWidget {
  const CountryField({
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String hint;
  final String? value;
  final ValueChanged<Country> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final language = TranslationProvider.of(context).locale.languageCode;
    final country = Country.tryParse(value);
    final text = country?.name(language) ?? value?.trim() ?? '';

    return LabeledField(
      label: label,
      child: Semantics(
        button: true,
        label: label,
        value: text,
        hint: t.countries.change,
        excludeSemantics: true,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: () async {
            final picked = await showCountrySheet(
              context,
              title: t.countries.title,
              selected: country,
            );
            if (picked != null) {
              onChanged(picked);
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: Icon(
                AppIcons.expand,
                size: 18,
                color: scheme.onSurfaceVariant,
              ),
              // the icon doesn't make the field taller than a text field
              suffixIconConstraints: const BoxConstraints(
                minWidth: 44,
                minHeight: 24,
              ),
            ),
            isEmpty: text.isEmpty,
            child: Row(
              children: [
                if (country != null) ...[
                  // the emoji font has tall lines: kept to the text's height
                  Text(
                    country.flag,
                    style: const TextStyle(fontSize: 18, height: 1),
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
