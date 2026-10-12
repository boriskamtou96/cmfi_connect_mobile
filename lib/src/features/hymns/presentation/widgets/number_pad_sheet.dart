import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_tones.dart';
import '../../domain/hymn.dart';

/// Big keypad to open a hymn by its number, as announced during worship.
/// Returns the number to open, or null.
Future<int?> showNumberPad(BuildContext context, {required HymnBook book}) =>
    showModalBottomSheet<int>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => _NumberPad(book: book),
    );

class _NumberPad extends HookWidget {
  const _NumberPad({required this.book});

  final HymnBook book;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final digits = useState('');
    final number = int.tryParse(digits.value);
    final hymn = number == null ? null : book.hymn(number);

    void type(String digit) {
      if (digits.value.length < 4 && !(digits.value.isEmpty && digit == '0')) {
        HapticFeedback.selectionClick();
        digits.value += digit;
      }
    }

    void erase() {
      if (digits.value.isNotEmpty) {
        digits.value = digits.value.substring(0, digits.value.length - 1);
      }
    }

    Widget key(
      Widget child, {
      VoidCallback? onTap,
      String? semanticLabel,
      bool filled = false,
    }) => Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Semantics(
          button: true,
          label: semanticLabel,
          child: Material(
            color: filled ? scheme.primary : scheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              onTap: onTap,
              child: SizedBox(height: 60, child: Center(child: child)),
            ),
          ),
        ),
      ),
    );

    Widget digit(String value) => key(
      Text(
        value,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
      onTap: () => type(value),
    );

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.hymns.pad.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Semantics(
            liveRegion: true,
            child: Text(
              digits.value.isEmpty ? '—' : digits.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w800,
                color: AppModule.hymns.tone(context).onSoft,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
          SizedBox(
            height: 44,
            child: Center(
              child: Text(
                switch ((number, hymn)) {
                  (null, _) => t.hymns.pad.placeholder,
                  (_, final found?) => found.title,
                  (final missing?, null) => t.hymns.pad.notFound(
                    number: missing,
                  ),
                },
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: hymn != null ? FontWeight.w600 : FontWeight.w400,
                  color: hymn != null
                      ? scheme.onSurface
                      : scheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final row in const [
            ['1', '2', '3'],
            ['4', '5', '6'],
            ['7', '8', '9'],
          ])
            Row(children: [for (final value in row) digit(value)]),
          Row(
            children: [
              key(
                Icon(AppIcons.erase, color: scheme.onSurfaceVariant),
                onTap: erase,
                semanticLabel: t.hymns.pad.erase,
              ),
              digit('0'),
              key(
                Text(
                  t.hymns.pad.open,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: hymn != null
                        ? scheme.onPrimary
                        : scheme.onSurfaceVariant,
                  ),
                ),
                filled: hymn != null,
                onTap: hymn == null
                    ? null
                    : () => Navigator.of(context).pop(hymn.number),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
