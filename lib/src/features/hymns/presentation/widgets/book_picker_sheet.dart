import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../../../core/widgets/adaptive.dart';
import '../../../../core/widgets/adaptive_menus.dart';
import '../../domain/hymn.dart';

/// Languages of the books, written in the language itself.
const _languageNames = {'fr': 'Français', 'en': 'English'};

/// Lets the user choose a hymn book. Returns its code, or null when dismissed.
/// On iPhone, an action sheet of the titles, the current one checked.
Future<String?> showBookPicker(
  BuildContext context, {
  required List<HymnBook> books,
  required String? selected,
}) => context.isCupertino
    ? showActionSheet<String>(
        context,
        title: context.t.hymns.chooseBook,
        actions: [
          for (final book in books)
            AdaptiveAction(
              value: book.code,
              label: book.title,
              selected: book.code == selected,
            ),
        ],
      )
    : _showBookSheet(context, books: books, selected: selected);

Future<String?> _showBookSheet(
  BuildContext context, {
  required List<HymnBook> books,
  required String? selected,
}) => showModalBottomSheet<String>(
  context: context,
  useSafeArea: true,
  builder: (context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final hymns = AppModule.hymns.tone(context);
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xl,
              0,
              AppSpacing.xl,
              AppSpacing.sm,
            ),
            child: Text(
              t.hymns.chooseBook,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          for (final book in books)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: 2,
              ),
              leading: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hymns.soft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  book.language.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: hymns.onSoft,
                  ),
                ),
              ),
              title: Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                [
                  t.hymns.count(n: book.hymns.length),
                  ?_languageNames[book.language],
                ].join(' · '),
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
              trailing: book.code == selected
                  ? Icon(AppIcons.check, color: scheme.primary)
                  : null,
              selected: book.code == selected,
              onTap: () => Navigator.of(context).pop(book.code),
            ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ),
    );
  },
);
