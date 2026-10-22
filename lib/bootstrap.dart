import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'src/core/config/firebase_options.dart';
import 'src/core/config/flavor.dart';
import 'src/core/i18n/languages.dart';
import 'src/core/i18n/strings.g.dart';
import 'src/core/services/app_log.dart';
import 'src/core/services/crash_reporting.dart';
import 'src/core/storage/preferences.dart';
import 'src/features/update/presentation/app_update_gate.dart';

/// Everything that must happen before the first frame lives here.
Future<void> bootstrap(Flavor flavor) async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  // the native splash stays until SplashScreen knows where to go
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  setUpLanguages();
  final preferences = await SharedPreferences.getInstance();
  final language = preferences.getString(SavedLanguage.key);
  if (language != null) {
    await LocaleSettings.setLocaleRaw(language);
  } else {
    await LocaleSettings.useDeviceLocale();
  }
  // day and month names (DateFormat) in every supported language
  await initializeDateFormatting();
  // the notifications of the admins and the crash reports; the app works
  // without them
  if (firebaseOptionsFor(flavor) case final options?) {
    try {
      await Firebase.initializeApp(options: options);
      await startCrashReporting();
      // the errors the app lives with go to Crashlytics too
      AppLog.reporter = const FirebaseCrashReporting();
    } on Object catch (error) {
      AppLog.info('Firebase did not start: $error');
    }
  }

  runApp(
    ProviderScope(
      overrides: [
        flavorProvider.overrideWithValue(flavor),
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
      child: TranslationProvider(
        // a version no longer allowed shows only the update screen
        child: DismissKeyboardApp(child: const AppUpdateGate(child: App())),
      ),
    ),
  );
}

class DismissKeyboardApp extends HookConsumerWidget {
  const DismissKeyboardApp({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
