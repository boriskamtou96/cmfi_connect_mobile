import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/date_extensions.dart';
import '../domain/disciple.dart';
import '../infrastructure/disciples_api.dart';

part 'disciples.g.dart';

/// The members who chose the user as disciple maker ("Mes disciples").
@riverpod
Future<List<Disciple>> disciples(Ref ref) =>
    ref.watch(disciplesApiProvider).list(today: today());
