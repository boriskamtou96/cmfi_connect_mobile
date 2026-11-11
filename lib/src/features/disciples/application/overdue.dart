import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/date_extensions.dart';
import '../domain/overdue.dart';
import '../infrastructure/disciples_api.dart';

part 'overdue.g.dart';

/// The thresholds offered on « À relancer », in days.
const overdueThresholds = [3, 7, 14];

/// The disciples with no report for [days] days or more.
@riverpod
Future<Overdue> overdueDisciples(Ref ref, {int days = 3}) =>
    ref.watch(disciplesApiProvider).overdue(today: today(), days: days);
