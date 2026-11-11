import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart' show kTouchSlop;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_extensions.dart';
import '../../../../core/widgets/adaptive_pickers.dart';
import '../../../../core/widgets/code_chip.dart';
import '../../../../core/widgets/rolling_text.dart';
import '../../application/reading_books.dart';
import '../../application/report_item_texts.dart';
import '../../domain/daily_report.dart';
import '../../domain/reading_book.dart';
import '../../domain/standard_item.dart';
import '../reading/book_cover.dart';
import '../reading/book_sheets.dart';

/// What the sheet answers: the new values, or null values to clear the item.
/// [book]: the book read (Lecture de la littérature chrétienne only).
typedef EntryValues = ({int? quantity, int? durationMinutes, EntryBook? book});

/// Opens the input sheet of one item. null when closed without validating.
/// Also sets a daily goal: [caption] under the title, [clearLabel] for the
/// button that empties it. An item counted in time can also take its
/// duration from a start and an end; with [onStartTimer] (today's report),
/// « Démarrer le chrono » closes the sheet and starts it ([timerRunning]:
/// it runs already for this item). [withBook]: a report's Lecture de la
/// littérature chrétienne names the book read (not a goal).
Future<EntryValues?> showEntrySheet(
  BuildContext context, {
  required ReportEntry entry,
  required bool personal,
  String? caption,
  String? clearLabel,
  VoidCallback? onStartTimer,
  bool timerRunning = false,
  bool withBook = false,
}) => showModalBottomSheet<EntryValues>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (context) => EntrySheet(
    entry: entry,
    personal: personal,
    caption: caption,
    clearLabel: clearLabel,
    onStartTimer: onStartTimer,
    timerRunning: timerRunning,
    withBook: withBook,
  ),
);

class EntrySheet extends HookConsumerWidget {
  const EntrySheet({
    required this.entry,
    required this.personal,
    this.caption,
    this.clearLabel,
    this.onStartTimer,
    this.timerRunning = false,
    this.withBook = false,
    super.key,
  });

  final ReportEntry entry;
  final bool personal;
  final String? caption;
  final String? clearLabel;
  final VoidCallback? onStartTimer;
  final bool timerRunning;
  final bool withBook;

  // limits of the API
  static const maxQuantity = 100000;
  static const maxMinutes = 1440;
  static const durationPresets = [15, 30, 45, 60, 90, 120];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final quantityController = useTextEditingController(
      text: entry.quantity?.toString() ?? '',
    );
    useListenable(quantityController);
    final minutes = useState(entry.durationMinutes);
    // « De 06:00 à 06:45 » once a start and an end were picked
    final span = useState<String?>(null);
    // the number slides in from below (+) or above (−) when a button changes it
    final nudge = useAnimationController(
      duration: AppMotion.medium,
      initialValue: 1,
    );
    final nudgeDirection = useRef(1.0);
    final nudgeOpacity = useMemoized(
      () => nudge.drive(
        Tween<double>(
          begin: 0.3,
          end: 1,
        ).chain(CurveTween(curve: AppMotion.standard)),
      ),
      [nudge],
    );

    int? quantity() => int.tryParse(quantityController.text);

    // Lecture de la littérature chrétienne names the book read: the one of
    // the day, else (a day not filled in yet) the book being read
    final booksItem =
        withBook &&
        !personal &&
        entry.code == StandardItem.christianLiterature.code;
    final chosenBook = useState<EntryBook?>(entry.book);
    final bookChosen = useState(entry.book != null || entry.isFilled);
    final shelf = booksItem
        ? ref.watch(readingBooksProvider).value ?? const <ReadingBook>[]
        : const <ReadingBook>[];
    final current = booksItem ? ref.watch(currentBookProvider) : null;
    final book = bookChosen.value ? chosenBook.value : current?.asEntry;
    ReadingBook? shelfBook;
    for (final other in shelf) {
      if (other.id == book?.id) {
        shelfBook = other;
      }
    }
    // the pages read before today: the shelf counts this day as saved
    final readBefore = math.max(
      0,
      (shelfBook?.pagesRead ?? 0) -
          (entry.book?.id == book?.id ? entry.quantity ?? 0 : 0),
    );

    Future<void> changeBook() async {
      final picked = await showBookPicker(context, selectedId: book?.id);
      if (picked != null) {
        chosenBook.value = picked.asEntry;
        bookChosen.value = true;
      }
    }

    void setQuantity(int value) {
      final clamped = value.clamp(0, maxQuantity);
      nudgeDirection.value = clamped < (quantity() ?? 0) ? -1 : 1;
      quantityController.value = TextEditingValue(
        text: '$clamped',
        selection: TextSelection.collapsed(offset: '$clamped'.length),
      );
      if (!AppMotion.reduced(context)) {
        nudge.forward(from: 0);
      }
    }

    void addMinutes(int delta) {
      span.value = null;
      minutes.value = ((minutes.value ?? 0) + delta).clamp(0, maxMinutes);
    }

    // the start, then the end: the time between (past midnight too)
    Future<void> pickSpan() async {
      final now = TimeOfDay.now();
      final from = await showAppTimePicker(
        context,
        initialTime: TimeOfDay(hour: (now.hour + 23) % 24, minute: now.minute),
        helpText: t.reports.timer.from,
        use24h: true,
      );
      if (from == null || !context.mounted) {
        return;
      }
      final to = await showAppTimePicker(
        context,
        initialTime: now,
        helpText: t.reports.timer.to,
        use24h: true,
      );
      if (to == null || !context.mounted) {
        return;
      }
      final start = from.hour * 60 + from.minute;
      final end = to.hour * 60 + to.minute;
      final length = (end - start + 1440) % 1440;
      if (length == 0) {
        return;
      }
      minutes.value = length;
      span.value = t.reports.timer.span(
        from: from.format(context),
        to: to.format(context),
      );
    }

    void validate() => Navigator.of(context).pop<EntryValues>((
      quantity: entry.tracksQuantity ? quantity() : null,
      durationMinutes: entry.tracksDuration && (minutes.value ?? 0) > 0
          ? minutes.value
          : null,
      book: booksItem ? book : null,
    ));

    final sectionTitle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: scheme.onSurfaceVariant,
    );

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        20,
        0,
        20,
        MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CodeChip(code: entry.code, personal: personal, minWidth: 0),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    t.itemLabel(entry.code, entry.label),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton.filledTonal(
                  tooltip: t.common.close,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(AppIcons.close),
                ),
              ],
            ),
            if (caption != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Icon(AppIcons.goal, size: 18, color: scheme.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      caption!,
                      style: TextStyle(
                        fontSize: 14,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            if (booksItem) ...[
              const SizedBox(height: 18),
              _BookChoice(
                book: book,
                coverUrl: shelfBook?.coverUrl ?? book?.coverUrl ?? '',
                readBefore: readBefore,
                onChange: changeBook,
              ),
            ],
            if (entry.tracksQuantity) ...[
              const SizedBox(height: 22),
              Text(
                t.itemUnit(entry.code, entry.quantityUnit)?.name ??
                    t.reports.sheet.quantity,
                style: sectionTitle,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    _StepButton(
                      icon: AppIcons.remove,
                      tooltip: t.reports.sheet.decrease,
                      onPressed: (quantity() ?? 0) > 0
                          ? () => setQuantity((quantity() ?? 0) - 1)
                          : null,
                    ),
                    Expanded(
                      child: AnimatedBuilder(
                        animation: nudge,
                        builder: (context, child) => Transform.translate(
                          offset: Offset(
                            0,
                            nudgeDirection.value *
                                12 *
                                (1 - AppMotion.standard.transform(nudge.value)),
                          ),
                          child: child,
                        ),
                        child: FadeTransition(
                          opacity: nudgeOpacity,
                          child: TextField(
                            controller: quantityController,
                            autofocus:
                                entry.quantity == null && !entry.tracksDuration,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                            decoration: InputDecoration(
                              hintText: '0',
                              filled: false,
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _StepButton(
                      icon: AppIcons.add,
                      tooltip: t.reports.sheet.increase,
                      onPressed: () => setQuantity((quantity() ?? 0) + 1),
                    ),
                  ],
                ),
              ),
              if (book != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  t.reading.willReach(
                    page: math.min(
                      readBefore + (quantity() ?? 0),
                      book.totalPages,
                    ),
                    total: book.totalPages,
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: scheme.primary,
                  ),
                ),
              ],
            ],
            if (entry.tracksDuration) ...[
              const SizedBox(height: 22),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    child: Text(t.reports.sheet.duration, style: sectionTitle),
                  ),
                  RollingText(
                    (minutes.value ?? 0) == 0
                        ? '—'
                        : minutes.value!.toDurationLabel(),
                    value: minutes.value ?? 0,
                    alignment: AlignmentDirectional.centerEnd,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final preset in durationPresets)
                    _PresetChip(
                      label: preset.toDurationLabel(),
                      selected: minutes.value == preset,
                      onTap: () {
                        span.value = null;
                        minutes.value = preset;
                      },
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: _RepeatButton(
                      label: t.reports.sheet.minus1,
                      semanticLabel: t.reports.sheet.removeMinute,
                      onStep: (minutes.value ?? 0) > 0
                          ? () => addMinutes(-1)
                          : null,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: _RepeatButton(
                      label: t.reports.sheet.plus1,
                      semanticLabel: t.reports.sheet.addMinute,
                      onStep: () => addMinutes(1),
                    ),
                  ),
                ],
              ),
              if (onStartTimer != null) ...[
                const SizedBox(height: AppSpacing.md),
                FilledButton.tonalIcon(
                  onPressed: timerRunning
                      ? null
                      : () {
                          Navigator.of(context).pop();
                          onStartTimer!();
                        },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  icon: Icon(
                    timerRunning
                        ? AppIcons.stopwatchActive
                        : AppIcons.stopwatch,
                    size: 20,
                  ),
                  label: Text(
                    timerRunning
                        ? t.reports.timer.running
                        : t.reports.timer.start,
                  ),
                ),
              ],
              // a book takes the room: no start and end for the LLC item
              if (!booksItem) ...[
                const SizedBox(height: AppSpacing.xs),
                Center(
                  child: TextButton.icon(
                    onPressed: pickSpan,
                    icon: const Icon(AppIcons.time, size: 18),
                    label: Text(t.reports.timer.startEnd),
                  ),
                ),
              ],
              if (span.value case final text? when !booksItem) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
              ],
            ],
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: scheme.error,
                    minimumSize: const Size(0, 54),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    textStyle: const TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: entry.isFilled
                      ? () => Navigator.of(context).pop<EntryValues>((
                          quantity: null,
                          durationMinutes: null,
                          book: null,
                        ))
                      : null,
                  child: Text(clearLabel ?? t.reports.sheet.clear),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(54),
                    ),
                    onPressed: validate,
                    child: Text(t.reports.sheet.validate),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return IconButton.outlined(
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        fixedSize: const Size.square(52),
        backgroundColor: scheme.surface,
        foregroundColor: scheme.primary,
        side: BorderSide(color: scheme.outlineVariant),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
      icon: Icon(icon),
    );
  }
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const _border = 1.5;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final duration = AppMotion.of(context, AppMotion.fast);

    return Semantics(
      selected: selected,
      button: true,
      child: AnimatedContainer(
        duration: duration,
        curve: AppMotion.standard,
        decoration: BoxDecoration(
          color: selected ? scheme.primary : scheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.md),
          border: Border.all(
            color: selected ? scheme.primary : scheme.outline,
            width: _border,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSpacing.md),
            onTap: onTap,
            // the border of the decoration takes 1.5 px on each side
            child: Container(
              height: 44 - 2 * _border,
              padding: const EdgeInsets.symmetric(horizontal: 14 - _border),
              // widthFactor 1: as wide as the label, not the whole row
              child: Center(
                widthFactor: 1,
                child: AnimatedDefaultTextStyle(
                  duration: duration,
                  curve: AppMotion.standard,
                  style: DefaultTextStyle.of(context).style.merge(
                    TextStyle(
                      fontSize: 14,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                      color: selected ? scheme.onPrimary : scheme.onSurface,
                    ),
                  ),
                  child: Text(label),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "− 1 min" / "+ 1 min": one step per tap. Held down, it repeats after a
/// short delay, faster and faster, until released (or turned off at 0).
class _RepeatButton extends HookWidget {
  const _RepeatButton({
    required this.label,
    required this.semanticLabel,
    required this.onStep,
  });

  final String label;
  final String semanticLabel;

  /// null: disabled.
  final VoidCallback? onStep;

  static const _holdDelay = Duration(milliseconds: 400);

  /// Time to the next step, shorter the longer the button has been held.
  static Duration _interval(Duration held) => switch (held.inMilliseconds) {
    < 1000 => const Duration(milliseconds: 120),
    < 2500 => const Duration(milliseconds: 60),
    _ => const Duration(milliseconds: 30),
  };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // the latest callback: "−" turns off at 0 while it is held
    final step = useRef(onStep);
    step.value = onStep;
    final timer = useRef<Timer?>(null);
    final held = useRef(Duration.zero);
    final downAt = useRef(Offset.zero);
    // steps already made by the repeat: the release is not one more
    final repeated = useRef(false);

    void stop() {
      timer.value?.cancel();
      timer.value = null;
    }

    useEffect(() => stop, const []);

    void repeat() {
      final onStep = step.value;
      if (onStep == null) {
        stop();
        return;
      }
      onStep();
      repeated.value = true;
      final next = _interval(held.value);
      held.value += next;
      timer.value = Timer(next, repeat);
    }

    void start(PointerDownEvent event) {
      stop();
      repeated.value = false;
      downAt.value = event.position;
      if (step.value == null) {
        return;
      }
      held.value = _holdDelay;
      timer.value = Timer(_holdDelay, repeat);
    }

    return Listener(
      onPointerDown: start,
      // the finger scrolls or drags the sheet: not a press any more
      onPointerMove: (event) {
        if ((event.position - downAt.value).distance > kTouchSlop) {
          stop();
        }
      },
      onPointerUp: (_) => stop(),
      onPointerCancel: (_) => stop(),
      child: OutlinedButton(
        onPressed: onStep == null
            ? null
            : () {
                if (repeated.value) {
                  repeated.value = false;
                  return;
                }
                onStep!();
              },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          backgroundColor: scheme.surfaceContainerLow,
          side: BorderSide(color: scheme.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.md),
          ),
          textStyle: const TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: Semantics(
          label: semanticLabel,
          hint: context.t.reports.sheet.holdToRepeat,
          excludeSemantics: true,
          child: Text(label),
        ),
      ),
    );
  }
}

/// The book of a Lecture de la littérature chrétienne entry, and « Changer »;
/// « Choisir le livre lu » without one.
class _BookChoice extends StatelessWidget {
  const _BookChoice({
    required this.book,
    required this.coverUrl,
    required this.readBefore,
    required this.onChange,
  });

  final EntryBook? book;
  final String coverUrl;

  /// The pages read in it before this day.
  final int readBefore;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    final t = context.t.reading;
    final scheme = Theme.of(context).colorScheme;
    final book = this.book;

    if (book == null) {
      return OutlinedButton.icon(
        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
        onPressed: onChange,
        icon: const Icon(AppIcons.book),
        label: Text(t.choose),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          BookCover(title: book.title, coverUrl: coverUrl, width: 42),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.current,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  [
                    if (book.author.isNotEmpty) book.author,
                    t.readUpTo(page: math.min(readBefore, book.totalPages)),
                  ].join(' · '),
                  style: TextStyle(
                    fontSize: 13,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          TextButton(onPressed: onChange, child: Text(t.change)),
        ],
      ),
    );
  }
}
