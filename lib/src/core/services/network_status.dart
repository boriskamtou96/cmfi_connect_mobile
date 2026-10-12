import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_status.g.dart';

/// Tells when the phone gets a network back. Behind a provider so tests
/// replace it.
class NetworkStatus {
  const NetworkStatus();

  /// true each time a network (Wi-Fi, mobile data…) becomes available, false
  /// when the last one goes away. Having a network doesn't promise the
  /// server answers: callers still handle a NetworkException.
  Stream<bool> get changes => Connectivity().onConnectivityChanged
      .map((results) => results.any((r) => r != ConnectivityResult.none))
      .distinct();
}

@Riverpod(keepAlive: true)
NetworkStatus networkStatus(Ref ref) => const NetworkStatus();
