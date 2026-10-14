import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'flavor.dart';

// The apps of the Firebase projects cmfi-connect-dev and cmfi-connect,
// registered with `firebase apps:create`; values from
// `firebase apps:sdkconfig` (they identify the app, they are not secrets).

/// The Firebase app of [flavor] on this platform; null where the app has
/// no Firebase (web, desktop, tests).
FirebaseOptions? firebaseOptionsFor(Flavor flavor) {
  if (kIsWeb) {
    return null;
  }
  return switch ((flavor, defaultTargetPlatform)) {
    (Flavor.dev, TargetPlatform.android) => const FirebaseOptions(
      apiKey: 'AIzaSyCA3fiK1Jizw5jqwXOz9maPKwNzETtUPBQ',
      appId: '1:920730632543:android:173ac3598b0b32d8dff6ea',
      messagingSenderId: '920730632543',
      projectId: 'cmfi-connect-dev',
      storageBucket: 'cmfi-connect-dev.firebasestorage.app',
    ),
    (Flavor.dev, TargetPlatform.iOS) => const FirebaseOptions(
      apiKey: 'AIzaSyBu5Sbi6BKbSk9DBJQ5pRB_hZuNNzm-p9c',
      appId: '1:920730632543:ios:c229a0efa4fd34e0dff6ea',
      messagingSenderId: '920730632543',
      projectId: 'cmfi-connect-dev',
      storageBucket: 'cmfi-connect-dev.firebasestorage.app',
      iosBundleId: 'com.cmficonnect.app.dev',
    ),
    (Flavor.prod, TargetPlatform.android) => const FirebaseOptions(
      apiKey: 'AIzaSyCI3hPb1yybpslWcM2DziYjneM-KUsH7eY',
      appId: '1:894070393803:android:222ff7ffe763dde77c844e',
      messagingSenderId: '894070393803',
      projectId: 'cmfi-connect',
      storageBucket: 'cmfi-connect.firebasestorage.app',
    ),
    (Flavor.prod, TargetPlatform.iOS) => const FirebaseOptions(
      apiKey: 'AIzaSyANwDnxZzAqlnLXCZnlo2vMqPW_3csvqlU',
      appId: '1:894070393803:ios:1828f664b9d079b37c844e',
      messagingSenderId: '894070393803',
      projectId: 'cmfi-connect',
      storageBucket: 'cmfi-connect.firebasestorage.app',
      iosBundleId: 'com.cmficonnect.app',
    ),
    _ => null,
  };
}
