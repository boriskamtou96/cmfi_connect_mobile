package com.example.cmfi_connect

import androidx.core.content.pm.PackageInfoCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// a FragmentActivity: the Customer Center of RevenueCat (purchases_ui_flutter) needs one
class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // the version of the app: the store rating is asked once per version
        // (core/services/store_review.dart)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "cmficonnect/app")
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "version" -> result.success(
                        packageManager.getPackageInfo(packageName, 0).versionName ?: "",
                    )
                    // shown at the bottom of Plus: "Version 1.0.0 (1)"
                    "build" -> result.success(
                        PackageInfoCompat.getLongVersionCode(
                            packageManager.getPackageInfo(packageName, 0),
                        ).toString(),
                    )
                    else -> result.notImplemented()
                }
            }
    }
}
