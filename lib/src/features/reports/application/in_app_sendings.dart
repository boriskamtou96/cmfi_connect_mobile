import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/in_app_sending.dart';
import '../infrastructure/report_sendings_api.dart';

part 'in_app_sendings.g.dart';

/// The reports sent in the app to the authorities who are members, the
/// newest first, with their answers (Envoi à mes autorités); none without
/// network. Kept alive: read again when an answer comes (push
/// `report_reply`).
@Riverpod(keepAlive: true)
class SentInApp extends _$SentInApp {
  @override
  Future<List<InAppSending>> build() async {
    try {
      return await ref.watch(reportSendingsApiProvider).sent();
    } on Object {
      return const [];
    }
  }

  /// Sends [from]–[to] to [authorityId]: false when they can't receive it
  /// in the app (no longer a member who sees the reports).
  Future<bool> send({
    required DateTime from,
    required DateTime to,
    required int authorityId,
  }) async {
    final done = await ref
        .read(reportSendingsApiProvider)
        .send(from: from, to: to, authorityIds: [authorityId]);
    if (done.isNotEmpty) {
      ref.invalidateSelf();
    }
    return done.isNotEmpty;
  }
}
