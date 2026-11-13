import '../../../core/utils/date_extensions.dart';
import 'activity_type.dart';
import 'daily_report.dart';

/// Past days filled from a sheet (13/11/2026): one row per day, a column
/// « Date », then a column per measure of an item, named like those of the
/// export (« LB – Lecture biblique (chapitres) », « PS – Prière seule
/// (min) »). A column is known by the code before the dash; « (min) » at its
/// end means the duration, in minutes.

/// What a column of the sheet fills.
typedef ImportColumn = ({ActivityType item, bool duration});

/// The header of the column of [item]'s quantity or duration, as the model
/// writes it and as [importColumnOf] reads it back.
String importHeader(
  ActivityType item, {
  required bool duration,
  required String label,
  String? unit,
}) => duration
    ? '${item.code} – $label (min)'
    : '${item.code} – $label${unit == null ? '' : ' ($unit)'}';

/// The column a header names among [items], null when it names none.
ImportColumn? importColumnOf(String header, List<ActivityType> items) {
  final text = header.trim();
  // « LB – … », « LB - … » or the code alone
  final code = text.split(RegExp(r'\s+[–—-]\s+')).first.trim().toUpperCase();
  final item = items
      .where((item) => item.code.toUpperCase() == code)
      .firstOrNull;
  if (item == null) {
    return null;
  }
  final minutes = RegExp(r'\(\s*min\s*\)\s*$', caseSensitive: false);
  final duration =
      item.tracksDuration && (minutes.hasMatch(text) || !item.tracksQuantity);
  if (!duration && !item.tracksQuantity) {
    return null;
  }
  return (item: item, duration: duration);
}

/// The day a cell of the column « Date » names: a date typed in Excel
/// ([fromSerial] turns its number into a day), « 2026-11-03 », or
/// « 03/11/2026 » (day first). Null when it is not a date.
DateTime? importDate(
  Object? cell, {
  required DateTime Function(num) fromSerial,
}) {
  if (cell is num) {
    return cell > 20000 && cell < 80000 ? fromSerial(cell) : null;
  }
  final text = '$cell'.trim();
  final iso = RegExp(r'^(\d{4})-(\d{1,2})-(\d{1,2})').firstMatch(text);
  final local = RegExp(r'^(\d{1,2})[/.](\d{1,2})[/.](\d{4})').firstMatch(text);
  final (year, month, day) = switch ((iso, local)) {
    (final match?, _) => (match[1]!, match[2]!, match[3]!),
    (_, final match?) => (match[3]!, match[2]!, match[1]!),
    _ => ('', '', ''),
  };
  if (year.isEmpty) {
    return null;
  }
  final date = DateTime(int.parse(year), int.parse(month), int.parse(day));
  // 31/02 would slide to March: refused
  return date.month == int.parse(month) && date.day == int.parse(day)
      ? date
      : null;
}

/// What a sheet would fill.
class ReportImport {
  const ReportImport({
    required this.days,
    required this.badRows,
    required this.unknownColumns,
    required this.future,
  });

  /// Reads [rows] (the first one names the columns) for the [items] of the
  /// member. A day comes once (its last row wins); [now] and later days are
  /// counted in [future] and left out when after [now].
  factory ReportImport.read(
    List<List<Object?>> rows, {
    required List<ActivityType> items,
    required DateTime now,
    required DateTime Function(num) fromSerial,
  }) {
    final header = rows.isEmpty ? const <Object?>[] : rows.first;
    final columns = <int, ImportColumn>{};
    final unknown = <String>[];
    int? dateColumn;
    for (final (index, cell) in header.indexed) {
      if (cell == null) {
        continue;
      }
      final name = '$cell'.trim();
      if (dateColumn == null &&
          RegExp(
            r'^(date|datum|fecha|jour|day)\b',
            caseSensitive: false,
          ).hasMatch(name)) {
        dateColumn = index;
      } else if (importColumnOf(name, items) case final column?) {
        columns[index] = column;
      } else {
        unknown.add(name);
      }
    }

    final days = <DateTime, List<ReportEntry>>{};
    final bad = <int>[];
    var future = 0;
    for (var r = 1; r < rows.length; r++) {
      final row = rows[r];
      if (row.every((cell) => cell == null)) {
        continue;
      }
      final date = dateColumn == null
          ? null
          : importDate(row.elementAtOrNull(dateColumn), fromSerial: fromSerial);
      if (date == null) {
        bad.add(r + 1);
        continue;
      }
      if (date.isAfter(now)) {
        future++;
        continue;
      }
      final entries = <int, ReportEntry>{};
      var wrong = false;
      for (final MapEntry(key: index, value: column) in columns.entries) {
        final cell = row.elementAtOrNull(index);
        if (cell == null) {
          continue;
        }
        final value = cell is num ? cell : num.tryParse('$cell'.trim());
        if (value == null || value < 0 || value > 100000) {
          wrong = true;
          continue;
        }
        if (value == 0) {
          continue;
        }
        final item = column.item;
        final entry =
            entries[item.id] ??
            ReportEntry(
              activityTypeId: item.id,
              code: item.code,
              label: item.label,
              tracksQuantity: item.tracksQuantity,
              quantityUnit: item.quantityUnit,
              tracksDuration: item.tracksDuration,
            );
        entries[item.id] = column.duration
            ? entry.copyWith(durationMinutes: value.round())
            : entry.copyWith(quantity: value.round());
      }
      if (wrong) {
        bad.add(r + 1);
      }
      if (entries.isNotEmpty) {
        days[date.dateOnly] = entries.values.toList();
      }
    }
    return ReportImport(
      days: days,
      badRows: bad,
      unknownColumns: unknown,
      future: future,
    );
  }

  /// The entries of each day read, the oldest day first when listed.
  final Map<DateTime, List<ReportEntry>> days;

  /// The rows (as numbered in Excel) with no date, or a value that is not
  /// a number.
  final List<int> badRows;

  /// The headers that name no item of the member.
  final List<String> unknownColumns;

  /// The rows dated after today, left out.
  final int future;
}
