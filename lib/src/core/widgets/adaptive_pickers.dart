import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../i18n/strings.g.dart';
import '../theme/app_spacing.dart';
import '../utils/date_format.dart';
import 'adaptive.dart';

// Dates and times: the Material calendar and clock on Android, the iOS
// wheels in a sheet at the bottom on iPhone (Annuler, the title, OK).

/// Picks a day between [firstDate] and [lastDate]: the day at midnight, or
/// null when cancelled.
Future<DateTime?> showAppDatePicker(
  BuildContext context, {
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  String? helpText,
}) async {
  if (!context.isCupertino) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      helpText: helpText,
    );
  }
  final first = DateUtils.dateOnly(firstDate);
  final last = DateUtils.dateOnly(lastDate);
  final initial = _clamp(DateUtils.dateOnly(initialDate), first, last);
  final picked = await showCupertinoModalPopup<DateTime>(
    context: context,
    builder: (context) => _WheelSheet(
      title: helpText,
      initial: initial,
      wheel: (onChanged) => CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: initial,
        minimumDate: first,
        maximumDate: last,
        onDateTimeChanged: onChanged,
      ),
    ),
  );
  return picked == null ? null : DateUtils.dateOnly(picked);
}

/// Picks a time. [use24h] forces the 24-hour clock (an event's program);
/// otherwise the phone's setting and the language decide.
Future<TimeOfDay?> showAppTimePicker(
  BuildContext context, {
  required TimeOfDay initialTime,
  String? helpText,
  bool use24h = false,
}) async {
  if (!context.isCupertino) {
    return showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: helpText,
      builder: use24h
          ? (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            )
          : null,
    );
  }
  // as the Material clock decides: "20:30" in French, "8:30 PM" in English
  final format = MaterialLocalizations.of(context).timeOfDayFormat(
    alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
  );
  final twentyFour = use24h || hourFormat(of: format) != HourFormat.h;
  final initial = DateTime(2000, 1, 1, initialTime.hour, initialTime.minute);
  final picked = await showCupertinoModalPopup<DateTime>(
    context: context,
    builder: (context) => _WheelSheet(
      title: helpText,
      initial: initial,
      wheel: (onChanged) => CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        initialDateTime: initial,
        use24hFormat: twentyFour,
        onDateTimeChanged: onChanged,
      ),
    ),
  );
  return picked == null ? null : TimeOfDay.fromDateTime(picked);
}

/// Picks a period between [firstDate] and [lastDate]. On iPhone, the rows
/// "Du" and "Au" over one wheel: a tap on a row sets the day it shows.
Future<DateTimeRange?> showAppDateRangePicker(
  BuildContext context, {
  required DateTime firstDate,
  required DateTime lastDate,
  DateTimeRange? initialDateRange,
  String? helpText,
}) {
  if (!context.isCupertino) {
    return showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: initialDateRange,
      helpText: helpText,
    );
  }
  final first = DateUtils.dateOnly(firstDate);
  final last = DateUtils.dateOnly(lastDate);
  final fallback = _clamp(DateUtils.dateOnly(DateTime.now()), first, last);
  return showCupertinoModalPopup<DateTimeRange>(
    context: context,
    builder: (context) => _RangeSheet(
      title: helpText,
      first: first,
      last: last,
      start: _clamp(
        DateUtils.dateOnly(initialDateRange?.start ?? fallback),
        first,
        last,
      ),
      end: _clamp(
        DateUtils.dateOnly(initialDateRange?.end ?? fallback),
        first,
        last,
      ),
    ),
  );
}

DateTime _clamp(DateTime date, DateTime first, DateTime last) =>
    date.isBefore(first) ? first : (date.isAfter(last) ? last : date);

/// The height of the iOS wheels.
const _wheelHeight = 216.0;

/// A wheel at the bottom of the screen, under Annuler, the title and OK. OK
/// gives the last value turned to, Annuler or a tap outside null.
class _WheelSheet extends HookWidget {
  const _WheelSheet({required this.initial, required this.wheel, this.title});

  final DateTime initial;
  final Widget Function(ValueChanged<DateTime> onChanged) wheel;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final value = useRef(initial);
    return _SheetFrame(
      title: title,
      onDone: () => Navigator.of(context).pop(value.value),
      children: [
        SizedBox(
          height: _wheelHeight,
          child: wheel((date) => value.value = date),
        ),
      ],
    );
  }
}

/// "Du" and "Au" over one wheel; the end never comes before the start.
class _RangeSheet extends HookWidget {
  const _RangeSheet({
    required this.first,
    required this.last,
    required this.start,
    required this.end,
    this.title,
  });

  final DateTime first;
  final DateTime last;
  final DateTime start;
  final DateTime end;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final t = context.t.common;
    final start = useState(this.start);
    final end = useState(this.end);
    final editingEnd = useState(false);

    void turnedTo(DateTime date) {
      final day = DateUtils.dateOnly(date);
      if (editingEnd.value) {
        end.value = day;
        if (day.isBefore(start.value)) {
          start.value = day;
        }
      } else {
        start.value = day;
        if (day.isAfter(end.value)) {
          end.value = day;
        }
      }
    }

    return _SheetFrame(
      title: title,
      onDone: () => Navigator.of(
        context,
      ).pop(DateTimeRange(start: start.value, end: end.value)),
      children: [
        _RangeRow(
          label: t.rangeStart,
          date: start.value,
          active: !editingEnd.value,
          onTap: () => editingEnd.value = false,
        ),
        _RangeRow(
          label: t.rangeEnd,
          date: end.value,
          active: editingEnd.value,
          onTap: () => editingEnd.value = true,
        ),
        SizedBox(
          height: _wheelHeight,
          child: CupertinoDatePicker(
            // a new wheel for the other row: it starts on that row's day
            key: ValueKey(editingEnd.value),
            mode: CupertinoDatePickerMode.date,
            initialDateTime: editingEnd.value ? end.value : start.value,
            minimumDate: first,
            maximumDate: last,
            onDateTimeChanged: turnedTo,
          ),
        ),
      ],
    );
  }
}

/// "Du      lun. 1 sept. 2025": the day in the color of the app while the
/// wheel sets it.
class _RangeRow extends StatelessWidget {
  const _RangeRow({
    required this.label,
    required this.date,
    required this.active,
    required this.onTap,
  });

  final String label;
  final DateTime date;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: active,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: active
                      ? scheme.primary.withValues(alpha: 0.12)
                      : scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  context.formatDate(date, 'EEE d MMM y'),
                  style: TextStyle(
                    fontSize: 16,
                    color: active ? scheme.primary : scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The frame of the iOS picker sheets: Annuler | title | OK, then
/// [children].
class _SheetFrame extends StatelessWidget {
  const _SheetFrame({required this.onDone, required this.children, this.title});

  final VoidCallback onDone;
  final List<Widget> children;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final t = context.t.common;
    final scheme = Theme.of(context).colorScheme;
    final title = this.title;
    // a Material: the texts take the app's style (no Scaffold in a popup)
    return Material(
      color: scheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.md)),
      ),
      clipBehavior: Clip.antiAlias,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(t.cancel),
                ),
                Expanded(
                  child: title == null
                      ? const SizedBox.shrink()
                      : Text(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: scheme.onSurface,
                          ),
                        ),
                ),
                CupertinoButton(
                  onPressed: onDone,
                  child: Text(
                    t.done,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const Divider(height: 1),
            ...children,
          ],
        ),
      ),
    );
  }
}
