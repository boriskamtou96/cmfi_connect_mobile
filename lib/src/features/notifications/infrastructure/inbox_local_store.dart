import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/storage/preferences.dart';
import '../domain/announcement.dart';

part 'inbox_local_store.g.dart';

/// The first page of the notifications as the server last gave it, to open
/// them at once and without network. Forgotten at sign-out.
class InboxLocalStore {
  const InboxLocalStore(this._preferences);

  final SharedPreferences _preferences;

  static const _key = 'inbox_first_page';

  AnnouncementPage? read() {
    final raw = _preferences.getString(_key);
    if (raw == null) {
      return null;
    }
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return (
        items: [
          for (final item in json['items'] as List<dynamic>)
            Announcement.fromJson(item as Map<String, dynamic>),
        ],
        unread: json['unread'] as int,
        total: json['total'] as int,
      );
    } on Object {
      return null;
    }
  }

  Future<void> save(AnnouncementPage page) => _preferences.setString(
    _key,
    jsonEncode({
      'items': page.items,
      'unread': page.unread,
      'total': page.total,
    }),
  );

  Future<void> clear() => _preferences.remove(_key);
}

@Riverpod(keepAlive: true)
InboxLocalStore inboxLocalStore(Ref ref) =>
    InboxLocalStore(ref.watch(sharedPreferencesProvider));
