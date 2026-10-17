import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_document.freezed.dart';
part 'library_document.g.dart';

/// A PDF, or a Word file (.docx, .doc).
enum DocumentKind { pdf, word }

/// The file of a document, kept by the server ("/v1/media/….pdf").
@freezed
abstract class LibraryFile with _$LibraryFile {
  const factory LibraryFile({
    required int id,
    required String url,

    /// "Règlement intérieur.pdf": the name it keeps on the phone.
    @Default('') String name,
    @JsonKey(unknownEnumValue: DocumentKind.pdf)
    @Default(DocumentKind.pdf)
    DocumentKind kind,
    @Default(0) int sizeBytes,
  }) = _LibraryFile;

  factory LibraryFile.fromJson(Map<String, dynamic> json) =>
      _$LibraryFileFromJson(json);
}

/// A document of Nos documents (GET /v1/documents): the library of the
/// community, written by the admins.
@freezed
abstract class LibraryDocument with _$LibraryDocument {
  const factory LibraryDocument({
    required int id,
    required String title,
    @Default('') String description,

    /// "Enseignements", "Formulaires"…; '' when none.
    @Default('') String category,
    required LibraryFile file,
    DateTime? publishedAt,
  }) = _LibraryDocument;

  factory LibraryDocument.fromJson(Map<String, dynamic> json) =>
      _$LibraryDocumentFromJson(json);
}

/// A category of the published documents, and how many it holds.
@freezed
abstract class DocumentCategory with _$DocumentCategory {
  const factory DocumentCategory({
    required String name,
    @Default(0) int count,
  }) = _DocumentCategory;

  factory DocumentCategory.fromJson(Map<String, dynamic> json) =>
      _$DocumentCategoryFromJson(json);
}
