import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:xml/xml.dart';

/// Excel files (.xlsx) read and written by hand: a zip of XML. The packages
/// that do it (excel, spreadsheet_decoder) don't go with the archive 4 of
/// this project. Only what the import of the reports needs: the cells of
/// the first sheet, as texts and numbers.

/// The rows of the first sheet of [bytes]: a text is a [String], a number a
/// [num] (a date typed in Excel is a number: see [excelDate]), an empty cell
/// null. Throws a [FormatException] when it is not an Excel file.
List<List<Object?>> readXlsx(Uint8List bytes) {
  final Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(bytes);
  } on Object {
    throw const FormatException('not a zip');
  }
  String? text(String name) {
    final file = archive.findFile(name);
    return file == null ? null : utf8.decode(file.content as List<int>);
  }

  final shared = <String>[
    if (text('xl/sharedStrings.xml') case final raw?)
      for (final item in XmlDocument.parse(raw).findAllElements('si'))
        // a text in several runs: its pieces put together (not the phonetics)
        item.descendantElements
            .where(
              (element) =>
                  element.name.local == 't' &&
                  element.ancestorElements.every(
                    (parent) => parent.name.local != 'rPh',
                  ),
            )
            .map((element) => element.innerText)
            .join(),
  ];

  final sheetName = archive.files
      .map((file) => file.name)
      .where((name) => RegExp(r'^xl/worksheets/sheet\d+\.xml$').hasMatch(name))
      .fold<String?>(
        null,
        (first, name) =>
            first == null || name.compareTo(first) < 0 ? name : first,
      );
  final sheet = sheetName == null ? null : text(sheetName);
  if (sheet == null) {
    throw const FormatException('no sheet');
  }

  final rows = <List<Object?>>[];
  for (final row in XmlDocument.parse(sheet).findAllElements('row')) {
    final cells = <Object?>[];
    for (final cell in row.findElements('c')) {
      final column = _column(cell.getAttribute('r')) ?? cells.length;
      while (cells.length < column) {
        cells.add(null);
      }
      final raw = cell.getElement('v')?.innerText;
      final value = switch (cell.getAttribute('t')) {
        's' => shared.elementAtOrNull(int.tryParse(raw ?? '') ?? -1),
        'inlineStr' => cell.findAllElements('t').map((t) => t.innerText).join(),
        'str' || 'e' => raw,
        'b' => raw == '1' ? 1 : 0,
        _ => raw == null ? null : num.tryParse(raw) ?? raw,
      };
      cells.add(value is String && value.trim().isEmpty ? null : value);
    }
    // the number of the row: the empty rows before it are kept empty
    final number = int.tryParse(row.getAttribute('r') ?? '');
    while (number != null && rows.length < number - 1) {
      rows.add(const []);
    }
    rows.add(cells);
  }
  return rows;
}

/// "C5" → 2 (the third column), null when unreadable.
int? _column(String? reference) {
  if (reference == null) {
    return null;
  }
  var column = 0;
  var letters = 0;
  for (final unit in reference.toUpperCase().codeUnits) {
    if (unit < 65 || unit > 90) {
      break;
    }
    column = column * 26 + (unit - 64);
    letters++;
  }
  return letters == 0 ? null : column - 1;
}

/// The day of a date as Excel keeps it (days since 30/12/1899).
DateTime excelDate(num serial) =>
    DateTime(1899, 12, 30).add(Duration(days: serial.floor()));

String _letters(int column) {
  var index = column + 1;
  final buffer = StringBuffer();
  while (index > 0) {
    final rest = (index - 1) % 26;
    buffer.write(String.fromCharCode(65 + rest));
    index = (index - 1) ~/ 26;
  }
  return buffer.toString().split('').reversed.join();
}

/// An Excel file with one sheet named [sheet] holding [rows] (texts and
/// numbers; the first row in bold, its columns [width] characters wide).
Uint8List writeXlsx(
  List<List<Object?>> rows, {
  String sheet = 'Sheet1',
  double width = 18,
}) {
  const escape = HtmlEscape(HtmlEscapeMode.attribute);
  final columns = rows.fold(
    0,
    (max, row) => row.length > max ? row.length : max,
  );
  final data = StringBuffer();
  for (final (r, row) in rows.indexed) {
    data.write('<row r="${r + 1}">');
    for (final (c, value) in row.indexed) {
      final at = '${_letters(c)}${r + 1}';
      final style = r == 0 ? ' s="1"' : '';
      if (value is num) {
        data.write('<c r="$at"$style><v>$value</v></c>');
      } else if (value != null) {
        data.write(
          '<c r="$at"$style t="inlineStr"><is><t xml:space="preserve">'
          '${escape.convert('$value')}</t></is></c>',
        );
      }
    }
    data.write('</row>');
  }
  const head = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
  const main = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
  const rels = 'http://schemas.openxmlformats.org/package/2006/relationships';
  const office =
      'http://schemas.openxmlformats.org/officeDocument/2006/relationships';
  const kinds = 'application/vnd.openxmlformats-officedocument.spreadsheetml';
  final files = {
    '[Content_Types].xml':
        '$head<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">'
        '<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>'
        '<Default Extension="xml" ContentType="application/xml"/>'
        '<Override PartName="/xl/workbook.xml" ContentType="$kinds.sheet.main+xml"/>'
        '<Override PartName="/xl/worksheets/sheet1.xml" ContentType="$kinds.worksheet+xml"/>'
        '<Override PartName="/xl/styles.xml" ContentType="$kinds.styles+xml"/>'
        '</Types>',
    '_rels/.rels':
        '$head<Relationships xmlns="$rels">'
        '<Relationship Id="rId1" Type="$office/officeDocument" Target="xl/workbook.xml"/>'
        '</Relationships>',
    'xl/workbook.xml':
        '$head<workbook xmlns="$main" xmlns:r="$office"><sheets>'
        '<sheet name="${escape.convert(sheet)}" sheetId="1" r:id="rId1"/>'
        '</sheets></workbook>',
    'xl/_rels/workbook.xml.rels':
        '$head<Relationships xmlns="$rels">'
        '<Relationship Id="rId1" Type="$office/worksheet" Target="worksheets/sheet1.xml"/>'
        '<Relationship Id="rId2" Type="$office/styles" Target="styles.xml"/>'
        '</Relationships>',
    'xl/styles.xml':
        '$head<styleSheet xmlns="$main">'
        '<fonts count="2"><font><sz val="11"/><name val="Calibri"/></font>'
        '<font><b/><sz val="11"/><name val="Calibri"/></font></fonts>'
        '<fills count="2"><fill><patternFill patternType="none"/></fill>'
        '<fill><patternFill patternType="gray125"/></fill></fills>'
        '<borders count="1"><border><left/><right/><top/><bottom/><diagonal/></border></borders>'
        '<cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>'
        '<cellXfs count="2"><xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>'
        '<xf numFmtId="0" fontId="1" fillId="0" borderId="0" xfId="0" applyFont="1"/></cellXfs>'
        '</styleSheet>',
    'xl/worksheets/sheet1.xml':
        '$head<worksheet xmlns="$main">'
        '${columns == 0 ? '' : '<cols><col min="1" max="$columns" width="$width" customWidth="1"/></cols>'}'
        '<sheetData>$data</sheetData></worksheet>',
  };
  final archive = Archive();
  for (final MapEntry(:key, :value) in files.entries) {
    final content = utf8.encode(value);
    archive.addFile(ArchiveFile.bytes(key, content));
  }
  return ZipEncoder().encodeBytes(archive);
}
