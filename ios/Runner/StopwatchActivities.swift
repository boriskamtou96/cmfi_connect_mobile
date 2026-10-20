import ActivityKit
import Flutter
import Foundation

/// The stopwatch of the app on the lock screen and in the Dynamic Island
/// (core/services/lock_screen_timer.dart): "show" starts it or brings it up
/// to date, "hide" ends it. Nothing when the member turned the Activités en
/// direct off.
@available(iOS 16.1, *)
enum StopwatchActivities {
  static func register(with messenger: FlutterBinaryMessenger) {
    FlutterMethodChannel(name: "cmficonnect/stopwatch", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        switch call.method {
        case "show":
          guard let arguments = call.arguments as? [String: Any],
            let label = arguments["label"] as? String,
            let since = arguments["since"] as? Double
          else {
            result(FlutterError(code: "arguments", message: nil, details: nil))
            return
          }
          show(
            StopwatchAttributes.ContentState(
              label: label,
              since: Date(timeIntervalSince1970: since / 1000),
              pausedSeconds: arguments["pausedSeconds"] as? Int,
              pausedText: arguments["pausedText"] as? String ?? ""
            ))
          result(nil)
        case "hide":
          hide()
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
  }

  /// One at a time: the one shown is brought up to date.
  static func show(_ state: StopwatchAttributes.ContentState) {
    if let shown = Activity<StopwatchAttributes>.activities.first {
      Task {
        if #available(iOS 16.2, *) {
          await shown.update(ActivityContent(state: state, staleDate: nil))
        } else {
          await shown.update(using: state)
        }
      }
      return
    }
    guard ActivityAuthorizationInfo().areActivitiesEnabled else {
      return
    }
    if #available(iOS 16.2, *) {
      _ = try? Activity.request(
        attributes: StopwatchAttributes(),
        content: ActivityContent(state: state, staleDate: nil),
        pushType: nil)
    } else {
      _ = try? Activity.request(
        attributes: StopwatchAttributes(), contentState: state, pushType: nil)
    }
  }

  static func hide() {
    for shown in Activity<StopwatchAttributes>.activities {
      Task {
        if #available(iOS 16.2, *) {
          await shown.end(nil, dismissalPolicy: .immediate)
        } else {
          await shown.end(dismissalPolicy: .immediate)
        }
      }
    }
  }
}
