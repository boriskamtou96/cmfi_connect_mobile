import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'src/core/config/flavor.dart';
import 'src/core/i18n/languages.dart';
import 'src/core/i18n/strings.g.dart';
import 'src/core/storage/preferences.dart';

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

  runApp(
    ProviderScope(
      overrides: [
        flavorProvider.overrideWithValue(flavor),
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
      child: TranslationProvider(child: DismissKeyboardApp(child: const App())),
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
