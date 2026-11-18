import Flutter
import UIKit

// UIScene life cycle (needed by the iOS 27 SDK: without it the app crashes at
// launch). The window belongs to FlutterSceneDelegate (Info.plist,
// UIApplicationSceneManifest), and Flutter creates its engine when the scene
// connects, after didFinishLaunchingWithOptions: the plugins and the app's own
// channels are registered in didInitializeImplicitFlutterEngine. launchOptions
// is nil here; the plugins read the link, notification or shortcut that opened
// the app from the scene (app_links, firebase_messaging, quick_actions,
// home_widget). https://docs.flutter.dev/release/breaking-changes/uiscenedelegate
@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // the report reminder also shows while the app is open. Before launch
    // ends, as Apple asks: the notification touched while the app was closed
    // comes through this delegate (flutter_local_notifications)
    UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    let registry = engineBridge.pluginRegistry
    GeneratedPluginRegistrant.register(with: registry)
    // Cherche d'abord Dieu: the apps closed until the day's report (AppShield.swift)
    if let registrar = registry.registrar(forPlugin: "AppShield") {
      AppShield.register(with: registrar.messenger())
    }
    // the stopwatch on the lock screen (StopwatchActivities.swift)
    if #available(iOS 16.1, *), let registrar = registry.registrar(forPlugin: "Stopwatch") {
      StopwatchActivities.register(with: registrar.messenger())
    }
    // the version of the app: the store rating is asked once per version
    // (core/services/store_review.dart)
    if let registrar = registry.registrar(forPlugin: "AppVersion") {
      FlutterMethodChannel(name: "cmficonnect/app", binaryMessenger: registrar.messenger())
        .setMethodCallHandler { call, result in
          if call.method == "version" {
            result(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
          } else if call.method == "build" {
            // shown at the bottom of Plus: "Version 1.0.0 (1)"
            result(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "")
          } else {
            result(FlutterMethodNotImplemented)
          }
        }
    }
  }
}
