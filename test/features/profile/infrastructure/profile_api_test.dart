import 'package:cmfi_connect/src/features/profile/domain/profile.dart';
import 'package:cmfi_connect/src/features/profile/infrastructure/profile_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late DioAdapter server;
  late ProfileApi api;

  setUp(() {
    final dio = Dio(BaseOptions(baseUrl: 'http://api.test/v1'));
    server = DioAdapter(dio: dio);
    api = ProfileApi(dio);
  });

  final profileJson = {
    'id': 4,
    'user_id': 22,
    'first_name': 'Boris',
    'last_name': 'Kamtou',
    'phone_number': '+237690000001',
    'email': '',
    'birth_date': null,
    'city': 'Yaoundé',
    'country': null,
    'church': 'CMFI',
    'assembly': null,
    'created_at': '2026-10-08T10:00:00Z',
    'updated_at': '2026-10-08T10:00:00Z',
  };

  test('parses the profile', () async {
    server.onGet(
      '/profiles/',
      (s) => s.reply(200, {'status': 200, 'content': profileJson}),
    );

    final profile = await api.get();

    expect(profile.fullName, 'Boris Kamtou');
    expect(profile.initials, 'BK');
    expect(profile.city, 'Yaoundé');
    expect(profile.country, isNull);
  });

  test(
    'update sends back the name and phone, which the API would otherwise erase',
    () async {
      server.onPut(
        '/profiles/',
        (s) => s.reply(200, {'status': 200, 'content': profileJson}),
        data: {
          'first_name': 'Boris',
          'last_name': 'Kamtou',
          'phone_number': '+237690000001',
          'email': '',
          'country': 'Cameroun',
          'city': 'Yaoundé',
          'church': 'CMFI',
          'assembly': '',
        },
      );

      await api.update(
        const Profile(
          firstName: 'Boris',
          lastName: 'Kamtou',
          phoneNumber: '+237690000001',
          country: 'Cameroun',
          city: 'Yaoundé',
          church: 'CMFI',
        ),
      );
    },
  );
}
