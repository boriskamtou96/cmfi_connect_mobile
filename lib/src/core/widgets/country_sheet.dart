import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../i18n/strings.g.dart';
import '../theme/app_icons.dart';
import '../theme/app_spacing.dart';
import '../utils/countries.dart';

/// Every country with its flag, sorted in the app language, with a search by
/// name, code or dial code. [selected] comes first. Returns the country
/// touched, or null when the sheet is closed.
Future<Country?> showCountrySheet(
  BuildContext context, {
  required String title,
  Country? selected,
  bool showDialCodes = false,
}) => showModalBottomSheet<Country>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (context) => _CountrySheet(
    title: title,
    selected: selected,
    showDialCodes: showDialCodes,
  ),
);

class _CountrySheet extends HookWidget {
  const _CountrySheet({
    required this.title,
    required this.selected,
    required this.showDialCodes,
  });

  final String title;
  final Country? selected;
  final bool showDialCodes;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final language = TranslationProvider.of(context).locale.languageCode;
    final query = useState('');
    final countries = useMemoized(() => Country.sortedFor(language), [
      language,
    ]);
    final selected = this.selected;
    // the selected country first (outside a condition: the lint
    // use_build_context_synchronously crashes on `?x` inside one)
    final all = [
      ?selected,
      ...countries.where((country) => country != selected),
    ];
    final shown = query.value.trim().isEmpty
        ? all
        : [
            for (final country in countries)
              if (country.matches(query.value, language)) country,
          ];

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.85,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.xl,
                0,
                AppSpacing.xl,
                AppSpacing.md,
              ),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: TextField(
                onChanged: (value) => query.value = value,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: t.countries.search,
                  prefixIcon: const Icon(AppIcons.search, size: 20),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: shown.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Text(
                        t.countries.none,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                      itemCount: shown.length,
                      itemBuilder: (context, index) => _CountryTile(
                        country: shown[index],
                        language: language,
                        selected: shown[index] == selected,
                        showDialCode: showDialCodes,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CountryTile extends StatelessWidget {
  const _CountryTile({
    required this.country,
    required this.language,
    required this.selected,
    required this.showDialCode,
  });

  final Country country;
  final String language;
  final bool selected;
  final bool showDialCode;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      selected: selected,
      leading: ExcludeSemantics(
        child: Text(country.flag, style: const TextStyle(fontSize: 24)),
      ),
      title: Text(country.name(language)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDialCode)
            Text(
              country.dialCode,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (selected) ...[
            const SizedBox(width: AppSpacing.sm),
            Icon(AppIcons.check, size: 20, color: scheme.primary),
          ],
        ],
      ),
      onTap: () => Navigator.of(context).pop(country),
    );
  }
}
