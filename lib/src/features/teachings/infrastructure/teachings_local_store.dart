import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/storage/preferences.dart';
import '../domain/teaching.dart';
import 'teachings_api.dart';

part 'teachings_local_store.g.dart';

/// The first page of the teachings of each category ('' for all) as the
/// server last gave it, to open the list at once and without network. A
/// search is not kept: it asks the server.
class TeachingsLocalStore {
  const TeachingsLocalStore(this._preferences);

  final SharedPreferences _preferences;

  static const _prefix = 'teachings_first_page_';

  TeachingsPage? read(String category) {
    final raw = _preferences.getString('$_prefix$category');
    if (raw == null) {
      return null;
    }
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return (
        items: [
          for (final item in json['items'] as List<dynamic>)
            Teaching.fromJson(item as Map<String, dynamic>),
        ],
        total: json['total'] as int,
      );
    } on Object {
      return null;
    }
  }

  Future<void> save(String category, TeachingsPage page) =>
      _preferences.setString(
        '$_prefix$category',
        jsonEncode({'items': page.items, 'total': page.total}),
      );
}

@Riverpod(keepAlive: true)
TeachingsLocalStore teachingsLocalStore(Ref ref) =>
    TeachingsLocalStore(ref.watch(sharedPreferencesProvider));
