import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.freezed.dart';
part 'announcement.g.dart';

/// An image or a PDF of an announcement (GET /v1/media/KEY).
@freezed
abstract class AnnouncementFile with _$AnnouncementFile {
  const factory AnnouncementFile({
    required int id,

    /// "image" or "pdf".
    required String kind,

    /// "/v1/media/3f91….jpg", relative to the API origin.
    required String url,

    /// The file name of a PDF ("Programme.pdf"), often '' for an image.
    @Default('') String name,
    @Default(0) int width,
    @Default(0) int height,

    /// "#1F4D3A", or ''.
    @Default('') String color,
    @Default(0) int sizeBytes,
  }) = _AnnouncementFile;

  const AnnouncementFile._();

  factory AnnouncementFile.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFileFromJson(json);

  bool get isImage => kind == 'image';

  /// Width / height, square when unknown.
  double get aspectRatio => width > 0 && height > 0 ? width / height : 1;

  /// The average color as 0xFFRRGGBB, null when unknown.
  int? get argb {
    if (color.length != 7 || !color.startsWith('#')) {
      return null;
    }
    final rgb = int.tryParse(color.substring(1), radix: 16);
    return rgb == null ? null : 0xFF000000 | rgb;
  }
}

/// A notification written by an admin (GET /v1/notifications): its push
/// showed the start; the app shows it all, with its files.
@freezed
abstract class Announcement with _$Announcement {
  const factory Announcement({
    required int id,
    required String title,
    required String body,
    @Default(<AnnouncementFile>[]) List<AnnouncementFile> attachments,
    required DateTime createdAt,

    /// null while not opened.
    DateTime? readAt,
  }) = _Announcement;

  const Announcement._();

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  bool get isRead => readAt != null;

  List<AnnouncementFile> get images =>
      attachments.where((file) => file.isImage).toList();

  List<AnnouncementFile> get documents =>
      attachments.where((file) => !file.isImage).toList();
}

/// A page of the member's notifications, and how many are not read yet.
typedef AnnouncementPage = ({List<Announcement> items, int unread, int total});
