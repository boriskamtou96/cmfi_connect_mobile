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

/// "2 chapitres", "1 h 30" per day filled, like the summary view.
String _average(ExportItem item, String locale) {
  final quantity =
      NumberFormat.decimalPatternDigits(locale: locale, decimalDigits: 1)
          .format(item.totalQuantity / item.daysCount)
          .replaceFirst(RegExp(r'[.,]0$'), '');
  final unit = MeasureFormat.unitSymbol(item.unit);
  return [
    if (item.tracksQuantity) unit == null ? quantity : '$quantity $unit',
    if (item.tracksDuration)
      (item.totalMinutes / item.daysCount).round().toDurationLabel(),
  ].join(' · ');
}

String _total(ExportItem item) => MeasureFormat.value(
  quantity: item.tracksQuantity ? item.totalQuantity : null,
  minutes: item.tracksDuration ? item.totalMinutes : null,
  unit: item.unit,
);

/// "LB 3 chapitres · PS 1 h": what a day holds, in one line.
String _dayValues(DailyReport report) => [
  for (final entry in report.entries.where((entry) => entry.isFilled))
    '${entry.code} ${MeasureFormat.value(quantity: entry.quantity, minutes: entry.durationMinutes, unit: entry.quantityUnit)}',
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
    final name = item.label == item.code
        ? item.code
        : '${item.code} ${item.label}';
    buffer.writeln(
      '• $name : ${_total(item)} (${t.reports.summary.days(n: item.daysCount)})$goal',
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
          '${item.code} – ${item.label}${switch (MeasureFormat.unitSymbol(item.unit)) {
            final unit? => ' ($unit)',
            null => '',
          }}',
          (ReportEntry e) =>
              e.activityTypeId == item.activityTypeId ? e.quantity : null,
        ),
      if (item.tracksDuration)
        (
          '${item.code} – ${item.label} (min)',
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

/// The CMFI emblem (same drawing as CmfiLogoPainter, on its 100×100 grid).
const _logo = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <defs>
    <linearGradient id="c" x1="10" y1="12" x2="86" y2="88" gradientUnits="userSpaceOnUse">
      <stop offset="0" stop-color="#0A4C92"/><stop offset="0.55" stop-color="#0B6CB8"/><stop offset="1" stop-color="#19A6E4"/>
    </linearGradient>
    <radialGradient id="g" cx="45.16" cy="34.2" r="47.25" gradientUnits="userSpaceOnUse">
      <stop offset="0" stop-color="#F4FBFF"/><stop offset="0.6" stop-color="#BFE6F8"/><stop offset="1" stop-color="#7CCAEE"/>
    </radialGradient>
  </defs>
  <path d="M60.45 7.01 A46.0 46.0 0 1 0 89.34 68.97 A40.53 40.53 0 1 1 60.45 7.01 Z" fill="url(#c)"/>
  <circle cx="55.16" cy="47.2" r="35.0" fill="url(#g)"/>
  <g fill="none" stroke="#fff" stroke-width="0.9" stroke-opacity="0.7">
    <ellipse cx="55.16" cy="47.2" rx="14.70" ry="35.0"/>
    <ellipse cx="55.16" cy="47.2" rx="28.00" ry="35.0"/>
    <path d="M20.16 47.2 Q55.16 52.2 90.16 47.2 M24.85 29.70 Q55.16 33.7 85.47 29.70 M24.85 64.70 Q55.16 69.2 85.47 64.70"/>
  </g>
  <g fill="#1A4FA0">
    <rect x="51.66" y="10.5" width="7" height="51.5" rx="1"/>
    <rect x="41.16" y="22.5" width="28" height="7" rx="1"/>
  </g>
  <g>
    <path d="M55.16 64.5 C48.16 61 40.16 60.5 34.16 61.5 V75 C41.16 74 49.16 75 55.16 78.5 C61.16 75 69.16 74 76.16 75 V61.5 C70.16 60.5 62.16 61 55.16 64.5 Z" fill="#D88E74"/>
    <path d="M55.16 62.5 C48.16 59 41.16 58.5 35.66 59.5 V72.5 C42.16 71.5 49.16 72.5 55.16 76 Z" fill="#fff"/>
    <path d="M55.16 62.5 C62.16 59 69.16 58.5 74.66 59.5 V72.5 C68.16 71.5 61.16 72.5 55.16 76 Z" fill="#F3F8FC"/>
    <path d="M55.16 62.5 V76" stroke="#C9A08C" stroke-width="0.8"/>
    <g stroke="#9DBCDD" stroke-width="0.7" fill="none" stroke-linecap="round">
      <path d="M38.66 63.2 C43.16 62.6 48.16 63.2 52.16 65.2"/>
      <path d="M38.66 66.4 C43.16 65.8 48.16 66.4 52.16 68.4"/>
      <path d="M38.66 69.6 C43.16 69 48.16 69.6 52.16 71.6"/>
      <path d="M71.66 63.2 C67.16 62.6 62.16 63.2 58.16 65.2"/>
      <path d="M71.66 66.4 C67.16 65.8 62.16 66.4 58.16 68.4"/>
      <path d="M71.66 69.6 C67.16 69 62.16 69.6 58.16 71.6"/>
    </g>
  </g>
  <g transform="translate(80.5 4.5)">
    <path d="M7.4 9.2 C6.2 5.6 6.8 2.4 9.4 0 C10.4 3.2 10.4 6.4 9.2 9.4 Z" fill="#8FD0F2"/>
    <path d="M1.4 10.6 C3.2 8.4 6.4 7.6 9.4 8.4 C11.6 9 13.6 10.4 15 12.4 C13.2 12 11.6 12.2 10.4 13 C8 14.8 4.4 14.4 1.4 10.6 Z" fill="#2E9BDA"/>
    <path d="M1.4 10.6 L0 10.9 L1.6 11.6 Z" fill="#2E9BDA"/>
    <path d="M7 10.2 C7.6 6.4 10 3.2 13.8 1.4 C13.4 5.2 11.6 8.6 8.6 10.8 Z" fill="#45AEE6"/>
  </g>
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
                              item.label,
                              style: pw.TextStyle(font: semiBold, fontSize: 9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    cell(
                      _total(item),
                      align: pw.TextAlign.right,
                      font: semiBold,
                    ),
                    cell('${item.daysCount}', align: pw.TextAlign.right),
                    cell(_average(item, locale), align: pw.TextAlign.right),
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
                          : cell(_dayValues(report)),
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
