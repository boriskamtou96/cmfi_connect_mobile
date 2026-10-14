package com.example.cmfi_connect

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
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
                    else -> result.notImplemented()
                }
            }
    }
}
