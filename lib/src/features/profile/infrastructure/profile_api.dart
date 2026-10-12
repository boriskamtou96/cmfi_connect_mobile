import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/profile.dart';

part 'profile_api.g.dart';

class ProfileApi {
  const ProfileApi(this._dio);

  final Dio _dio;

  /// The user's profile. A user without profile answers 404 NOT_FOUND.
  Future<Profile> get() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/profiles/');
    return Profile.fromJson(response.content);
  });

  /// The API writes first_name and phone_number as sent (an empty value would erase them),
  /// so the whole profile is sent back. An empty church / city / ... clears the field;
  /// birth_date is left out, which keeps the stored one.
  Future<Profile> update(Profile profile) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/profiles/',
      data: _body(profile),
    );
    return Profile.fromJson(response.content);
  });

  /// For a user who has no profile yet.
  Future<Profile> create(Profile profile) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/profiles/',
      data: _body(profile, withEmail: false),
    );
    return Profile.fromJson(response.content);
  });

  /// [withEmail] false on create: the API currently writes that email into last_name.
  static Map<String, Object?> _body(Profile profile, {bool withEmail = true}) =>
      {
        'first_name': profile.firstName,
        'last_name': profile.lastName,
        'phone_number': profile.phoneNumber,
        if (withEmail) 'email': profile.email,
        'country': profile.country ?? '',
        'city': profile.city ?? '',
        'church': profile.church ?? '',
        'assembly': profile.assembly ?? '',
      };
}

@riverpod
ProfileApi profileApi(Ref ref) => ProfileApi(ref.watch(dioProvider));
