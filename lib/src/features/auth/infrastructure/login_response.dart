import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/session/account.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

/// Content of POST /v1/users/login.
@freezed
abstract class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    @JsonKey(name: 'user') required Account account,
    // The API sends this key in camelCase, unlike the rest of its JSON (snake_case)
    @JsonKey(name: 'accessToken') required String accessToken,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
