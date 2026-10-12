import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/session/session.dart';
import 'app_router.dart';

/// Safety net on the routes that need a signed-in user. The screens already
/// navigate after login / logout; this only catches a route opened without a session.
class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._ref);

  final Ref _ref;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final status = await _ref.read(sessionProvider.future);

    if (status == SessionStatus.authenticated) {
      resolver.next();
    } else {
      resolver.next(false);
      // after the current navigation is over
      scheduleMicrotask(() => router.root.replaceAll([const WelcomeRoute()]));
    }
  }
}
