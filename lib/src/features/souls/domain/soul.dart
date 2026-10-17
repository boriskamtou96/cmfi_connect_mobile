import 'package:flutter/foundation.dart';

/// Where a person met through evangelism stands, in order.
enum SoulStage { met, interested, received, followUp, church, baptized }

/// A note of the follow-up: a visit, a call, a prayer answered.
@immutable
class SoulNote {
  const SoulNote({required this.at, required this.text});

  factory SoulNote.fromJson(Map<String, dynamic> json) => SoulNote(
    at: DateTime.parse(json['at'] as String),
    text: json['text'] as String,
  );

  final DateTime at;
  final String text;

  Map<String, dynamic> toJson() => {'at': at.toIso8601String(), 'text': text};
}

/// A person the member evangelised and follows: kept on the phone only (in
/// the Keychain / Keystore), never sent: it is about someone else.
@immutable
class Soul {
  const Soul({
    required this.id,
    required this.name,
    required this.metOn,
    this.phone = '',
    this.place = '',
    this.stage = SoulStage.met,
    this.nextContact,
    this.notes = const [],
  });

  factory Soul.fromJson(Map<String, dynamic> json) => Soul(
    id: json['id'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String? ?? '',
    place: json['place'] as String? ?? '',
    metOn: DateTime.parse(json['met_on'] as String),
    stage: SoulStage.values.asNameMap()[json['stage']] ?? SoulStage.met,
    nextContact: json['next_contact'] == null
        ? null
        : DateTime.parse(json['next_contact'] as String),
    notes: [
      for (final note in json['notes'] as List<dynamic>? ?? const [])
        SoulNote.fromJson(note as Map<String, dynamic>),
    ],
  );

  final String id;
  final String name;

  /// As typed ("+237 6 99 00 00 00"); '' when not given.
  final String phone;

  /// Where they met: "Marché central", "Université de Yaoundé I".
  final String place;
  final DateTime metOn;
  final SoulStage stage;

  /// The day planned to see or call them again; null when none.
  final DateTime? nextContact;

  /// The newest first.
  final List<SoulNote> notes;

  /// "AN" for "Amina Ngono".
  String get initials {
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    return words.take(2).map((word) => word[0].toUpperCase()).join();
  }

  /// The digits to call or write to ("+237699000000").
  String get dialable => phone.replaceAll(RegExp(r'[^\d+]'), '');

  /// To contact on [day] or before (late).
  bool dueBy(DateTime day) => nextContact != null && !nextContact!.isAfter(day);

  Soul copyWith({
    String? name,
    String? phone,
    String? place,
    DateTime? metOn,
    SoulStage? stage,
    DateTime? Function()? nextContact,
    List<SoulNote>? notes,
  }) => Soul(
    id: id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    place: place ?? this.place,
    metOn: metOn ?? this.metOn,
    stage: stage ?? this.stage,
    nextContact: nextContact == null ? this.nextContact : nextContact(),
    notes: notes ?? this.notes,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    if (phone.isNotEmpty) 'phone': phone,
    if (place.isNotEmpty) 'place': place,
    'met_on': _day(metOn),
    'stage': stage.name,
    if (nextContact != null) 'next_contact': _day(nextContact!),
    if (notes.isNotEmpty) 'notes': [for (final note in notes) note.toJson()],
  };

  static String _day(DateTime day) => DateTime.utc(
    day.year,
    day.month,
    day.day,
  ).toIso8601String().substring(0, 10);
}

/// The list as a spreadsheet (`;` between the columns, like the report
/// export in French): to keep a copy elsewhere. [stageName] and [day] write
/// in the app's language.
String soulsAsCsv(
  List<Soul> souls, {
  required List<String> header,
  required String Function(SoulStage stage) stageName,
  required String Function(DateTime day) day,
}) {
  String cell(String value) => value.contains(RegExp('[;"\n]'))
      ? '"${value.replaceAll('"', '""')}"'
      : value;
  final rows = [
    header.map(cell).join(';'),
    for (final soul in souls)
      [
        soul.name,
        soul.phone,
        soul.place,
        day(soul.metOn),
        stageName(soul.stage),
        if (soul.nextContact case final next?) day(next) else '',
        soul.notes.map((note) => '${day(note.at)} : ${note.text}').join('\n'),
      ].map(cell).join(';'),
  ];
  // the BOM: Excel reads the accents
  return '﻿${rows.join('\r\n')}';
}
