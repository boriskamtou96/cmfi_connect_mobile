import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/i18n/strings.g.dart';
import '../../../core/utils/date_extensions.dart';
import '../../../core/utils/date_format.dart';
import '../domain/daily_report.dart';
import '../domain/measure_format.dart';
import '../domain/report_export.dart';
import 'report_item_texts.dart';

/// Who the report is about, written at the top of the files.
typedef ReportOwner = ({String name, String? church});

/// The ways a report period can leave the app.
enum ReportFormat { pdf, csv, text }

/// "Du 1 au 9 octobre 2026", "Du 29 septembre au 5 octobre 2026".
String exportPeriodLabel(
  Translations t,
  String locale,
  DateTime from,
  DateTime to,
) {
  final pattern = from.year != to.year
      ? 'd MMMM y'
      : from.month != to.month
      ? 'd MMMM'
      : 'd';
  return t.reports.summary.range(
    from: DateFormat(pattern, locale).format(from),
    to: DateFormat('d MMMM y', locale).format(to),
  );
}

/// The name of an item in the files: translated for a standard one.
String _label(Translations t, ExportItem item) =>
    t.itemLabel(item.code, item.label);

ItemUnit? _unit(Translations t, ExportItem item) =>
    t.itemUnit(item.code, item.unit);

/// "2 chapitres", "1 h 30" per day filled, like the summary view.
String _average(Translations t, ExportItem item, String locale) {
  // rounded as written, so that "1 chapter" is singular
  final average = double.parse(
    (item.totalQuantity / item.daysCount).toStringAsFixed(1),
  );
  final quantity = NumberFormat.decimalPatternDigits(
    locale: locale,
    decimalDigits: 1,
  ).format(average).replaceFirst(RegExp(r'[.,]0$'), '');
  final unit = _unit(t, item);
  return [
    if (item.tracksQuantity)
      unit == null ? quantity : unit.count(average, number: quantity),
    if (item.tracksDuration)
      (item.totalMinutes / item.daysCount).round().toDurationLabel(),
  ].join(' · ');
}

String _total(Translations t, ExportItem item) => MeasureFormat.value(
  quantity: item.tracksQuantity ? item.totalQuantity : null,
  minutes: item.tracksDuration ? item.totalMinutes : null,
  unit: _unit(t, item),
);

/// "LB 3 chapitres · PS 1 h": what a day holds, in one line.
String _dayValues(Translations t, DailyReport report) => [
  for (final entry in report.entries.where((entry) => entry.isFilled))
    '${entry.code} ${MeasureFormat.value(quantity: entry.quantity, minutes: entry.durationMinutes, unit: t.itemUnit(entry.code, entry.quantityUnit))}',
].join(' · ');

/// A short summary to paste in a chat (WhatsApp understands *bold*).
String reportAsText(
  ReportExport export, {
  required Translations t,
  required String locale,
  required ReportOwner owner,
}) {
  final doc = t.export.doc;
  final buffer = StringBuffer()
    ..writeln(
      '*${[doc.title, if (owner.name.isNotEmpty) owner.name].join(' · ')}*',
    )
    ..writeln(exportPeriodLabel(t, locale, export.from, export.to))
    ..writeln()
    ..writeln(
      '${doc.regularity} : ${doc.daysFilled(filled: export.daysReported, total: export.daysInRange)}',
    );
  for (final item in export.filledItems) {
    final goal = item.goal == null
        ? ''
        : ' · ${t.reports.summary.goalDays(n: item.goalDays, total: export.daysInRange).toLowerCase()}';
    // an item named like its code is written once
    final label = _label(t, item);
    final name = label == item.code ? item.code : '${item.code} $label';
    buffer.writeln(
      '• $name : ${_total(t, item)} (${t.reports.summary.days(n: item.daysCount)})$goal',
    );
  }
  buffer
    ..writeln()
    ..write(doc.sentFrom);
  return buffer.toString();
}

/// One line per day, one column per measure: opens in Excel or Google Sheets.
/// French uses ";" (the separator French Excel expects), English ",".
Uint8List reportAsCsv(
  ReportExport export, {
  required Translations t,
  required String locale,
}) {
  final separator = locale.startsWith('fr') ? ';' : ',';
  String cell(Object? value) {
    final text = value?.toString() ?? '';
    return text.contains(separator) || text.contains('"') || text.contains('\n')
        ? '"${text.replaceAll('"', '""')}"'
        : text;
  }

  final doc = t.export.doc;
  final items = export.filledItems;
  final columns = <(String, int? Function(ReportEntry))>[
    for (final item in items) ...[
      if (item.tracksQuantity)
        (
          '${item.code} – ${_label(t, item)}${switch (_unit(t, item)?.symbol) {
            final unit? => ' ($unit)',
            null => '',
          }}',
          (ReportEntry e) =>
              e.activityTypeId == item.activityTypeId ? e.quantity : null,
        ),
      if (item.tracksDuration)
        (
          '${item.code} – ${_label(t, item)} (min)',
          (ReportEntry e) => e.activityTypeId == item.activityTypeId
              ? e.durationMinutes
              : null,
        ),
    ],
  ];

  final lines = [
    [
      doc.date,
      doc.filledColumn,
      for (final (name, _) in columns) name,
      doc.note,
    ],
    for (final day in export.days)
      if (export.reports[day] case final report)
        [
          day.toApiDate(),
          report == null ? doc.no : doc.yes,
          for (final (_, valueOf) in columns)
            report?.entries.map(valueOf).nonNulls.firstOrNull,
          report?.note,
        ],
  ];
  final csv = lines.map((line) => line.map(cell).join(separator)).join('\r\n');
  // the BOM tells Excel the file is UTF-8 (accents)
  return Uint8List.fromList(utf8.encode('﻿$csv\r\n'));
}

// Brand colors, as in the app
const _blue = PdfColor.fromInt(0xFF0A5EA8);
const _blueSoft = PdfColor.fromInt(0xFFE2EEFA);
const _onBlue = PdfColor.fromInt(0xFFDCE9F7);
const _gold = PdfColor.fromInt(0xFFE2A93B);
const _ink = PdfColor.fromInt(0xFF0F1A2A);
const _muted = PdfColor.fromInt(0xFF556375);
const _line = PdfColor.fromInt(0xFFDFE6EF);
const _personal = PdfColor.fromInt(0xFF8A5A0F);
const _personalSoft = PdfColor.fromInt(0xFFFBF1DC);

/// The mark of CMFI Connect (same drawing as CmfiLogoPainter.paintMark, on
/// its 100×100 grid): the open ring in CMFI blue, the cross in gold.
const _logo = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <defs>
    <linearGradient id="g" x1="40" y1="35" x2="60" y2="65" gradientUnits="userSpaceOnUse">
      <stop offset="0" stop-color="#E8B348"/>
      <stop offset="1" stop-color="#C08A1E"/>
    </linearGradient>
  </defs>
  <path d="M70.65 33.87 A26.2 26.2 0 1 1 53.65 24.05" fill="none" stroke="#0A5EA8" stroke-width="8.2" stroke-linecap="round"/>
  <rect x="46.5" y="35.35" width="7" height="29.3" rx="3.5" fill="url(#g)"/>
  <rect x="40.45" y="43.55" width="19.1" height="7" rx="3.5" fill="url(#g)"/>
</svg>''';

/// An A4 document: who and when, regularity, totals per item, then each day.
Future<Uint8List> reportAsPdf(
  ReportExport export, {
  required Translations t,
  required String locale,
  required ReportOwner owner,
  DateTime? generatedAt,
}) async {
  Future<pw.Font> font(String weight) async =>
      pw.Font.ttf(await rootBundle.load('assets/fonts/Onest-$weight.ttf'));
  final regular = await font('Regular');
  final semiBold = await font('SemiBold');
  final bold = await font('ExtraBold');

  final doc = t.export.doc;
  final items = export.filledItems;
  final hasGoals = items.any((item) => item.goal != null);
  String date(DateTime day, String pattern) =>
      DateFormat(pattern, locale).format(day).capitalized;

  final pdf = pw.Document(
    title: '${doc.title} – ${owner.name}',
    author: owner.name,
    creator: t.app.name,
    theme: pw.ThemeData.withFont(base: regular, bold: semiBold),
  );

  pw.Widget headerCell(String text, {pw.TextAlign align = pw.TextAlign.left}) =>
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: pw.Text(
          text.toUpperCase(),
          textAlign: align,
          style: pw.TextStyle(
            font: semiBold,
            fontSize: 7.5,
            letterSpacing: 0.6,
            color: _muted,
          ),
        ),
      );

  pw.Widget cell(
    String text, {
    pw.TextAlign align = pw.TextAlign.left,
    pw.Font? font,
    PdfColor color = _ink,
  }) => pw.Padding(
    padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 5),
    child: pw.Text(
      text,
      textAlign: align,
      style: pw.TextStyle(font: font, fontSize: 9, color: color),
    ),
  );

  pw.Widget codeChip(ExportItem item) => pw.Container(
    padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: pw.BoxDecoration(
      color: item.personal ? _personalSoft : _blueSoft,
      borderRadius: pw.BorderRadius.circular(4),
    ),
    child: pw.Text(
      item.code,
      style: pw.TextStyle(
        font: bold,
        fontSize: 7.5,
        color: item.personal ? _personal : _blue,
      ),
    ),
  );

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.fromLTRB(40, 40, 40, 36),
      footer: (context) => pw.Container(
        margin: const pw.EdgeInsets.only(top: 12),
        child: pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                doc.generated(
                  date: DateFormat(
                    'd MMMM y',
                    locale,
                  ).format(generatedAt ?? DateTime.now()),
                ),
                style: const pw.TextStyle(fontSize: 8, color: _muted),
              ),
            ),
            pw.Text(
              doc.page(n: context.pageNumber, total: context.pagesCount),
              style: const pw.TextStyle(fontSize: 8, color: _muted),
            ),
          ],
        ),
      ),
      build: (context) => [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.SvgImage(svg: _logo, width: 38, height: 38),
            pw.SizedBox(width: 10),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    doc.title,
                    style: pw.TextStyle(font: bold, fontSize: 20, color: _ink),
                  ),
                  if (owner.name.isNotEmpty || owner.church != null)
                    pw.Text(
                      [
                        if (owner.name.isNotEmpty) owner.name,
                        ?owner.church,
                      ].join(' · '),
                      style: const pw.TextStyle(fontSize: 10, color: _muted),
                    ),
                ],
              ),
            ),
            pw.Text(
              exportPeriodLabel(t, locale, export.from, export.to),
              style: pw.TextStyle(font: semiBold, fontSize: 10, color: _ink),
            ),
          ],
        ),
        pw.SizedBox(height: 18),
        // the blue regularity card of the summary view
        pw.Container(
          padding: const pw.EdgeInsets.all(16),
          decoration: pw.BoxDecoration(
            color: _blue,
            borderRadius: pw.BorderRadius.circular(12),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                doc.regularity.toUpperCase(),
                style: pw.TextStyle(
                  font: semiBold,
                  fontSize: 8,
                  letterSpacing: 0.8,
                  color: _onBlue,
                ),
              ),
              pw.SizedBox(height: 6),
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    '${export.daysReported} / ${export.daysInRange}',
                    style: pw.TextStyle(
                      font: bold,
                      fontSize: 26,
                      color: PdfColors.white,
                    ),
                  ),
                  pw.SizedBox(width: 8),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(bottom: 4),
                    child: pw.Text(
                      t.reports.summary.daysFilled,
                      style: const pw.TextStyle(fontSize: 11, color: _onBlue),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.ClipRRect(
                horizontalRadius: 3,
                verticalRadius: 3,
                child: pw.Row(
                  children: [
                    if (export.daysReported > 0)
                      pw.Expanded(
                        flex: export.daysReported,
                        child: pw.Container(height: 6, color: _gold),
                      ),
                    if (export.daysInRange > export.daysReported)
                      pw.Expanded(
                        flex: export.daysInRange - export.daysReported,
                        child: pw.Container(
                          height: 6,
                          color: const PdfColor(1, 1, 1, 0.22),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 20),
        if (items.isEmpty)
          pw.Text(t.export.empty, style: const pw.TextStyle(color: _muted))
        else ...[
          pw.Text(
            doc.totals,
            style: pw.TextStyle(font: bold, fontSize: 12, color: _ink),
          ),
          pw.SizedBox(height: 8),
          pw.Table(
            border: const pw.TableBorder(
              horizontalInside: pw.BorderSide(color: _line, width: 0.6),
              bottom: pw.BorderSide(color: _line, width: 0.6),
            ),
            columnWidths: {
              0: const pw.FlexColumnWidth(3.2),
              1: const pw.FlexColumnWidth(1.8),
              2: const pw.FlexColumnWidth(0.8),
              3: const pw.FlexColumnWidth(1.8),
              if (hasGoals) 4: const pw.FlexColumnWidth(1.2),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: _blueSoft),
                children: [
                  headerCell(doc.item),
                  headerCell(doc.total, align: pw.TextAlign.right),
                  headerCell(doc.days, align: pw.TextAlign.right),
                  headerCell(doc.average, align: pw.TextAlign.right),
                  if (hasGoals) headerCell(doc.goal, align: pw.TextAlign.right),
                ],
              ),
              for (final item in items)
                pw.TableRow(
                  verticalAlignment: pw.TableCellVerticalAlignment.middle,
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 5,
                      ),
                      child: pw.Row(
                        children: [
                          codeChip(item),
                          pw.SizedBox(width: 6),
                          pw.Expanded(
                            child: pw.Text(
                              _label(t, item),
                              style: pw.TextStyle(font: semiBold, fontSize: 9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    cell(
                      _total(t, item),
                      align: pw.TextAlign.right,
                      font: semiBold,
                    ),
                    cell('${item.daysCount}', align: pw.TextAlign.right),
                    cell(_average(t, item, locale), align: pw.TextAlign.right),
                    if (hasGoals)
                      cell(
                        item.goal == null
                            ? '—'
                            : '${item.goalDays} / ${export.daysInRange}',
                        align: pw.TextAlign.right,
                        color: item.goal == null ? _muted : _ink,
                      ),
                  ],
                ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            doc.detail,
            style: pw.TextStyle(font: bold, fontSize: 12, color: _ink),
          ),
          pw.SizedBox(height: 8),
          pw.Table(
            border: const pw.TableBorder(
              horizontalInside: pw.BorderSide(color: _line, width: 0.6),
              bottom: pw.BorderSide(color: _line, width: 0.6),
            ),
            columnWidths: const {
              0: pw.FlexColumnWidth(1.5),
              1: pw.FlexColumnWidth(3.4),
              2: pw.FlexColumnWidth(2.6),
            },
            children: [
              pw.TableRow(
                repeat: true,
                decoration: const pw.BoxDecoration(color: _blueSoft),
                children: [
                  headerCell(doc.date),
                  headerCell(doc.values),
                  headerCell(doc.note),
                ],
              ),
              for (final day in export.days)
                if (export.reports[day] case final report)
                  pw.TableRow(
                    children: [
                      cell(
                        date(day, 'EEE d MMM'),
                        font: semiBold,
                        color: report == null ? _muted : _ink,
                      ),
                      report == null
                          ? cell(doc.noReport, color: _muted)
                          : cell(_dayValues(t, report)),
                      cell(report?.note ?? '', color: _muted),
                    ],
                  ),
            ],
          ),
        ],
      ],
    ),
  );
  return pdf.save();
}
