import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/api_call.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/storage/preferences.dart';
import '../domain/nation.dart';

part 'ministry_api.g.dart';

/// Our ministry (/v1/ministry): the nations where it is present.
class MinistryApi {
  const MinistryApi(this._dio);

  final Dio _dio;

  /// In the order the ministry reached them.
  Future<List<Nation>> nations() => apiCall(() async {
    final response = await _dio.get<Map<String, dynamic>>('/ministry/nations');
    return [
      for (final json in response.contentList)
        Nation.fromJson(json as Map<String, dynamic>),
    ];
  });
}

@Riverpod(keepAlive: true)
MinistryApi ministryApi(Ref ref) => MinistryApi(ref.watch(dioProvider));

/// The nations seen last, kept for offline; the first time, the copy shipped
/// with the app (assets/ministry/nations.json, the list of 154).
class MinistryLocalStore {
  const MinistryLocalStore(this._preferences);

  final SharedPreferences _preferences;

  static const _key = 'ministry_nations';
  static const shippedAsset = 'assets/ministry/nations.json';

  List<Nation>? saved() {
    final raw = _preferences.getString(_key);
    return raw == null ? null : _decode(raw);
  }

  Future<void> save(List<Nation> nations) =>
      _preferences.setString(_key, jsonEncode(nations));

  Future<List<Nation>> shipped(AssetBundle bundle) async =>
      _decode(await bundle.loadString(shippedAsset, cache: false));

  static List<Nation> _decode(String raw) => [
    for (final json in jsonDecode(raw) as List<dynamic>)
      Nation.fromJson(json as Map<String, dynamic>),
  ];
}

@Riverpod(keepAlive: true)
MinistryLocalStore ministryLocalStore(Ref ref) =>
    MinistryLocalStore(ref.watch(sharedPreferencesProvider));
