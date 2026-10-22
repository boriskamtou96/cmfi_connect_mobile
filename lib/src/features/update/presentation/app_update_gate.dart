import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/services/app_update.dart';
import '../../../core/storage/preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/cmfi_logo.dart';

/// Above the whole app: while this version is no longer allowed (Firebase
/// Remote Config, see RemoteConfigUpdateRules), only [ForceUpdateScreen] is
/// shown, whatever the screen was. The app comes back as soon as the rule
/// is lifted.
class AppUpdateGate extends ConsumerWidget {
  const AppUpdateGate({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(appUpdateProvider).value;
    if (status == null || status.need != UpdateNeed.required) {
      return child;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => context.t.app.name,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ref.watch(savedThemeModeProvider),
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      home: ForceUpdateScreen(status: status),
    );
  }
}

/// "Mise à jour nécessaire": the only way on is the store. Night blue, like
/// the splash.
class ForceUpdateScreen extends HookConsumerWidget {
  const ForceUpdateScreen({required this.status, super.key});

  final AppUpdateStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final starting = useState(false);
    final failed = useState(false);
    final message = status.messageIn(
      TranslationProvider.of(context).locale.languageCode,
    );

    // locked at launch: the native splash is still up
    useEffect(() {
      FlutterNativeSplash.remove();
      return null;
    }, const []);

    Future<void> update() async {
      starting.value = true;
      failed.value = false;
      final started = await ref.read(appUpdateProvider.notifier).start();
      if (context.mounted) {
        starting.value = false;
        failed.value = started == UpdateStart.failed;
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: AppColors.primaryDeep,
          body: Stack(
            children: [
              Positioned(
                right: -250,
                bottom: -190,
                child: BrandRing(
                  size: 560,
                  color: Colors.white.withValues(alpha: 0.07),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      const Center(child: CmfiLogo.onDark(size: 104)),
                      const SizedBox(height: AppSpacing.xxl),
                      Text(
                        t.update.requiredTitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        t.update.requiredText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.onPrimaryMuted,
                          fontSize: 16,
                          height: 1.45,
                        ),
                      ),
                      if (message.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.lg),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(AppRadius.lg),
                          ),
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                      const Spacer(),
                      if (failed.value) ...[
                        Text(
                          t.update.failed,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.goldLight),
                        ),
                        const SizedBox(height: AppSpacing.md),
                      ],
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primaryDeep,
                          minimumSize: const Size.fromHeight(54),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onPressed: starting.value ? null : update,
                        child: starting.value
                            ? const SizedBox.square(
                                dimension: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(t.update.update),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      if ((status.installed, status.target) case (
                        final installed?,
                        final target?,
                      ))
                        Text(
                          t.update.versions(
                            installed: '$installed',
                            target: '$target',
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.onPrimaryMuted,
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
