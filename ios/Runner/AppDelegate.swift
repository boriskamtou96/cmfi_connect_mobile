import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // the report reminder also shows while the app is open
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    GeneratedPluginRegistrant.register(with: self)
    // the version of the app: the store rating is asked once per version
    // (core/services/store_review.dart)
    if let registrar = registrar(forPlugin: "AppVersion") {
      FlutterMethodChannel(name: "cmficonnect/app", binaryMessenger: registrar.messenger())
        .setMethodCallHandler { call, result in
          if call.method == "version" {
            result(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
          } else {
            result(FlutterMethodNotImplemented)
          }
        }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
