import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/widgets/adaptive_dialogs.dart';
import '../../../../routing/app_router.dart';
import '../../application/item_limit.dart';

/// The free personal items are all used (no Premium): says it kindly, and
/// opens the Premium page if the member wants to see it.
Future<void> showItemLimitDialog(BuildContext context) async {
  final t = context.t.items.limit;
  final discover = await showConfirmDialog(
    context,
    title: t.title,
    text: t.text(n: freePersonalItems),
    confirmLabel: t.discover,
    cancelLabel: t.later,
  );
  if (discover && context.mounted) {
    await context.router.push(const PremiumRoute());
  }
}

/// The small Premium lock next to « Créer un élément » once the free items
/// are used (as on the « Exporter » / « Importer » tiles).
class ItemLimitLock extends StatelessWidget {
  const ItemLimitLock({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) => Icon(
    AppIcons.premiumLock,
    size: 14,
    color: color,
    semanticLabel: context.t.premium.pill,
  );
}

/// « 3 sur 5 »: the personal items against the free limit, read in a whole
/// sentence by screen readers. Nothing with Premium.
class ItemQuotaCount extends StatelessWidget {
  const ItemQuotaCount({required this.quota, super.key});

  final ItemQuota quota;

  @override
  Widget build(BuildContext context) {
    final t = context.t.items.limit;
    return Semantics(
      label: t.countLabel(used: quota.used, limit: quota.limit),
      excludeSemantics: true,
      child: Text(
        t.count(used: quota.used, limit: quota.limit),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
