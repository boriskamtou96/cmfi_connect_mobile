import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/utils/date_extensions.dart';
import '../domain/prayer.dart';

part 'prayer_api.g.dart';

/// The prayer module (/v1/prayer): topics of the community, the user's own
/// lists, the retreats made and the importunity topics.
class PrayerApi {
  const PrayerApi(this._dio);

  final Dio _dio;

  // ----- topics of the community -----

  /// The topics of [day] (the phone's date), or the ended ones.
  Future<List<PrayerTopic>> topics({
    required DateTime day,
    bool archive = false,
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/prayer/topics',
      queryParameters: {'day': day.toApiDate(), if (archive) 'archive': true},
    );
    return [
      for (final json in response.contentList)
        PrayerTopic.fromJson(json as Map<String, dynamic>),
    ];
  });

  Future<PrayerTopic> topic(int id, {required DateTime day}) =>
      apiCall(() async {
        final response = await _dio.get<Map<String, dynamic>>(
          '/prayer/topics/$id',
          queryParameters: {'day': day.toApiDate()},
        );
        return PrayerTopic.fromJson(response.content);
      });

  /// The points (1, 2…) prayed for on [day]: all of them, unchecked ones are
  /// removed.
  Future<PrayerTopic> setPrayed(
    int id, {
    required DateTime day,
    required List<int> positions,
  }) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/prayer/topics/$id/prayed',
      data: {'day': day.toApiDate(), 'positions': positions},
    );
    return PrayerTopic.fromJson(response.content);
  });

  // ----- the user's lists -----

  Future<List<PrayerPerson>> people() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/prayer/people');
    return _people(response);
  });

  /// 409 TOO_MANY_PEOPLE beyond 500.
  Future<PrayerPerson> addPerson({
    required PrayerList list,
    required String name,
    String note = '',
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/prayer/people',
      data: {'list': list.name, 'name': name, 'note': note},
    );
    return PrayerPerson.fromJson(response.content);
  });

  Future<PrayerPerson> updatePerson(PrayerPerson person) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/prayer/people/${person.id}',
      data: {
        'list': person.list.name,
        'name': person.name,
        'note': person.note,
        'answered_on': person.answeredOn?.toApiDate(),
      },
    );
    return PrayerPerson.fromJson(response.content);
  });

  Future<void> deletePerson(int id) => apiCall(() async {
    await _dio.delete<void>('/prayer/people/$id');
  });

  /// A retreat prayed for them on [day]: the whole lists come back.
  Future<List<PrayerPerson>> markPrayed(
    List<int> ids, {
    required DateTime day,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/prayer/people/prayed',
      data: {'day': day.toApiDate(), 'ids': ids},
    );
    return _people(response);
  });

  // ----- retreats -----

  Future<List<RetreatRecord>> retreats({
    required DateTime from,
    required DateTime to,
  }) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/prayer/retreats',
      queryParameters: {'from': from.toApiDate(), 'to': to.toApiDate()},
    );
    return [
      for (final json in response.contentList)
        RetreatRecord.fromJson(json as Map<String, dynamic>),
    ];
  });

  Future<void> saveRetreat(RetreatRecord record) => apiCall(() async {
    await _dio.put<Map<String, dynamic>>(
      '/prayer/retreats/${record.day.toApiDate()}/${record.moment.name}',
      data: {'minutes': record.minutes},
    );
  });

  Future<void> deleteRetreat(DateTime day, RetreatMoment moment) =>
      apiCall(() async {
        await _dio.delete<void>(
          '/prayer/retreats/${day.toApiDate()}/${moment.name}',
        );
      });

  // ----- importunity topics -----

  /// The topics the user prays for or is invited to (invitations first).
  Future<List<Importunity>> importunities() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/prayer/importunities',
    );
    return [
      for (final json in response.contentList)
        Importunity.fromJson(json as Map<String, dynamic>),
    ];
  });

  Future<Importunity> importunity(int id) => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/prayer/importunities/$id',
    );
    return Importunity.fromJson(response.content);
  });

  Future<Importunity> createImportunity({
    required String title,
    String description = '',
    int? goal,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/prayer/importunities',
      data: {'title': title, 'description': description, 'goal': goal},
    );
    return Importunity.fromJson(response.content);
  });

  Future<Importunity> updateImportunity(
    int id, {
    required String title,
    required String description,
    required int? goal,
    required ImportunityStatus status,
  }) => apiCall(() async {
    final response = await _dio.put<Map<String, dynamic>>(
      '/prayer/importunities/$id',
      data: {
        'title': title,
        'description': description,
        'goal': goal,
        'status': status.name,
      },
    );
    return Importunity.fromJson(response.content);
  });

  Future<void> deleteImportunity(int id) => apiCall(() async {
    await _dio.delete<void>('/prayer/importunities/$id');
  });

  /// [amount] proclamations of the user (the taps of the counter, grouped).
  /// 403 NOT_PARTICIPANT, 409 IMPORTUNITY_CLOSED.
  Future<Importunity> count(int id, int amount) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/prayer/importunities/$id/count',
      data: {'amount': amount},
    );
    return Importunity.fromJson(response.content);
  });

  /// How many new invitations went out. 404 USERNAME_NOT_FOUND.
  Future<int> invite(
    int id, {
    List<String> usernames = const [],
    bool family = false,
  }) => apiCall(() async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/prayer/importunities/$id/invitations',
      data: {'usernames': usernames, 'family': family},
    );
    return response.content['invited'] as int;
  });

  /// Joins: the topic comes back. Declines: null.
  Future<Importunity?> answer(int id, {required bool join}) =>
      apiCall(() async {
        final response = await _dio.put<Map<String, dynamic>>(
          '/prayer/importunities/$id/answer',
          data: {'join': join},
        );
        return join ? Importunity.fromJson(response.content) : null;
      });

  Future<void> leave(int id) => apiCall(() async {
    await _dio.delete<void>('/prayer/importunities/$id/membership');
  });

  Future<PrayerFamily> family() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/prayer/importunities/family',
    );
    return PrayerFamily.fromJson(response.content);
  });

  static List<PrayerPerson> _people(Response<Map<String, dynamic>> response) =>
      [
        for (final json in response.contentList)
          PrayerPerson.fromJson(json as Map<String, dynamic>),
      ];
}

@Riverpod(keepAlive: true)
PrayerApi prayerApi(Ref ref) => PrayerApi(ref.watch(dioProvider));
