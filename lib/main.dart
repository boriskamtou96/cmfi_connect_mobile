import 'bootstrap.dart';
import 'src/core/config/flavor.dart';

/// Launch with a flavor:
///   flutter run --flavor dev
///   flutter run --flavor prod --release
Future<void> main() => bootstrap(currentFlavor());
