import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/premium_store.dart';
import '../domain/activity_type.dart';
import 'reports_providers.dart';

part 'item_limit.g.dart';

/// How many personal items a member without Premium can create (23/11/2026).
/// The standard items (LB, PS…) don't count, nor the archived ones (the
/// server no longer lists them). A member who already has more keeps them
/// all; only creating another one asks for Premium.
const freePersonalItems = 5;

/// The member's personal items against the free limit.
class ItemQuota {
  const ItemQuota({required this.used, required this.premium});

  /// From the active items: only the personal ones count.
  factory ItemQuota.of(Iterable<ActivityType> items, {required bool premium}) =>
      ItemQuota(
        used: items.where((item) => !item.isStandard).length,
        premium: premium,
      );

  /// The active personal items.
  final int used;

  /// Premium (bought or offered to the team): no limit.
  final bool premium;

  int get limit => freePersonalItems;

  /// Creating one more needs Premium.
  bool get locked => !premium && used >= limit;

  /// « 3 sur 5 » next to the button: without Premium only.
  bool get counted => !premium;
}

/// The quota of the signed-in member; null while the items are unknown.
/// Premium still unknown (loading, store unreachable) opens creation: no lock
/// is shown to a member who paid.
@riverpod
ItemQuota? itemQuota(Ref ref) {
  final items = ref.watch(activitiesProvider).value;
  if (items == null) {
    return null;
  }
  final premium = ref.watch(premiumProvider).value ?? true;
  return ItemQuota.of(items, premium: premium);
}
