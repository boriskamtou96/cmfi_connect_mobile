import 'package:freezed_annotation/freezed_annotation.dart';

part 'nation.freezed.dart';
part 'nation.g.dart';

/// A nation where the ministry is present (GET /v1/ministry/nations),
/// numbered in the order the ministry reached it: 1 = Cameroun.
@freezed
abstract class Nation with _$Nation {
  const factory Nation({
    required int id,
    required int position,

    /// As the list writes it ("Le Cameroun"). A country is shown with its
    /// name in the app language (countryCode); a region keeps this one.
    required String name,

    /// ISO code ("CM"), '' for a region that is not a country (Écosse…).
    @Default('') String countryCode,
    required double latitude,
    required double longitude,

    /// The year the ministry arrived, when known.
    int? arrivalYear,
  }) = _Nation;

  factory Nation.fromJson(Map<String, dynamic> json) => _$NationFromJson(json);
}
