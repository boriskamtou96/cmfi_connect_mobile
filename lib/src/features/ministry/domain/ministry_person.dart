import 'package:freezed_annotation/freezed_annotation.dart';

import '../../events/domain/event.dart';

part 'ministry_person.freezed.dart';
part 'ministry_person.g.dart';

/// Nos missionnaires, Nos héros: written by the admins on the back office.
enum MinistryPersonKind { missionary, hero }

/// A portrait of Notre ministère (GET /v1/ministry/people?kind=…): only the
/// published ones come, in the order the admins chose.
@freezed
abstract class MinistryPerson with _$MinistryPerson {
  const factory MinistryPerson({
    required int id,
    @JsonKey(unknownEnumValue: MinistryPersonKind.missionary)
    required MinistryPersonKind kind,
    required String name,
    EventImage? photo,

    /// A missionary's nation ("TD"), '' when none.
    @Default('') String countryCode,

    /// What they do ("Implantation d'églises"), or did, for a hero.
    @Default('') String role,

    /// The year a missionary was sent.
    int? sinceYear,

    /// A hero's life ("1920–1998").
    @Default('') String years,

    /// Plain text, paragraphs separated by a blank line.
    @Default('') String story,
    @Default(0) int position,
  }) = _MinistryPerson;

  const MinistryPerson._();

  factory MinistryPerson.fromJson(Map<String, dynamic> json) =>
      _$MinistryPersonFromJson(json);

  /// The story, paragraph by paragraph.
  List<String> get paragraphs => [
    for (final paragraph in story.split(RegExp(r'\n\s*\n')))
      if (paragraph.trim().isNotEmpty) paragraph.trim(),
  ];
}
