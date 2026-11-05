import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../network/api_call.dart';
import '../network/dio_provider.dart';
import '../session/session.dart';
import '../storage/account_storage.dart';

part 'premium_store.g.dart';

/// The Premium of the signed-in member, as the server keeps it (bought on
/// cmfi-connect.com, offered by the admins): GET /v1/premium/status. Behind
/// a provider: tests use a fake.
abstract class PremiumStore {
  /// [userId] signed in: their Premium is asked.
  Future<void> logIn(String userId);

  /// Signed out: no Premium any more.
  Future<void> logOut();
  Future<bool> isActive();

  /// When the Premium bought or offered ends, as last known; null without
  /// one, or for life.
  DateTime? get until;

  /// Premium starts or ends (bought on the site, offered, over).
  Stream<bool> get changes;

  /// Asks the server again: Premium bought on the website or offered by the
  /// admins shows at once.
  Future<void> refresh();
}

class ServerPremiumStore implements PremiumStore {
  ServerPremiumStore(this._dio);

  final Dio _dio;
  final _changes = StreamController<bool>.broadcast();

  /// The last answer, kept for when the network is gone.
  var _active = false;
  DateTime? _until;

  @override
  DateTime? get until => _until;

  @override
  Future<void> logIn(String userId) => refresh();

  @override
  Future<void> logOut() async {
    _active = false;
    _until = null;
    _changes.add(false);
  }

  @override
  Future<bool> isActive() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/premium/status');
      final status = response.content;
      final until = DateTime.tryParse('${status['until'] ?? ''}');
      final lifetime = status['lifetime'] == true;
      _until = lifetime ? null : until?.toLocal();
      _active = lifetime || (until != null && until.isAfter(DateTime.now()));
    } on DioException {
      // offline: what was known
    }
    return _active;
  }

  @override
  Stream<bool> get changes => _changes.stream;

  @override
  Future<void> refresh() async => _changes.add(await isActive());
}

@Riverpod(keepAlive: true)
PremiumStore premiumStore(Ref ref) =>
    ServerPremiumStore(ref.watch(dioProvider));

/// Premium offered to everyone: the widget, the year of the summary and the
/// progress of the goals open, and nothing leading to the paywall. It was so
/// in the published app of v1; Premium is sold on the website now. Kept to
/// offer it again if ever needed: return true.
@Riverpod(keepAlive: true)
bool premiumForEveryone(Ref ref) => false;

/// Whether the signed-in member has Premium (the home-screen widget, the
/// year and the progress of the goals in the summary). false while unknown.
/// The team (admins and superadmins) has it without paying: the role of the
/// account saved at sign-in, refreshed at each launch (GET /v1/users/me).
/// Always true while [premiumForEveryone].
@Riverpod(keepAlive: true)
class Premium extends _$Premium {
  @override
  Future<bool> build() async {
    if (ref.watch(premiumForEveryoneProvider)) {
      return true;
    }
    final store = ref.watch(premiumStoreProvider);
    final staff = await ref.watch(premiumIsOfferedProvider.future);
    final session = await ref.watch(sessionProvider.future);
    if (session == SessionStatus.unauthenticated) {
      return false;
    }
    final changes = store.changes.listen(
      (active) => state = AsyncData(active || staff),
    );
    ref.onDispose(changes.cancel);
    return staff || await store.isActive();
  }
}

/// Premium comes with the role: admins and superadmins don't pay.
@Riverpod(keepAlive: true)
Future<bool> premiumIsOffered(Ref ref) async {
  final status = await ref.watch(sessionProvider.future);
  if (status == SessionStatus.unauthenticated) {
    return false;
  }
  final account = await ref.watch(accountStorageProvider).read();
  return account?.isAdmin ?? false;
}
