import ActivityKit
import SwiftUI
import WidgetKit

private let night = Color(red: 7 / 255, green: 45 / 255, blue: 90 / 255)
private let gold = Color(red: 226 / 255, green: 169 / 255, blue: 59 / 255)
private let goldLight = Color(red: 246 / 255, green: 210 / 255, blue: 122 / 255)

// a touch opens today's report, where the banner of the stopwatch is
private let todayURL = URL(string: "cmficonnect://open?to=reports/today")

/// The time of the stopwatch: running from `since` (drawn by the system,
/// second by second, the app closed), or still while paused.
@available(iOS 16.1, *)
private struct StopwatchTime: View {
  let state: StopwatchAttributes.ContentState

  var body: some View {
    if let seconds = state.pausedSeconds {
      Text(Self.clock(seconds))
    } else {
      Text(timerInterval: state.since...Date.distantFuture, countsDown: false)
    }
  }

  /// "12:34", "1:02:05", as the banner of the app.
  static func clock(_ seconds: Int) -> String {
    let h = seconds / 3600
    let m = (seconds % 3600) / 60
    let s = seconds % 60
    return h > 0
      ? String(format: "%d:%02d:%02d", h, m, s)
      : String(format: "%d:%02d", m, s)
  }
}

/// The lock screen: the item and « en pause » on the left, the time in gold
/// on the right, on the night blue of the app.
@available(iOS 16.1, *)
private struct StopwatchLockScreen: View {
  let state: StopwatchAttributes.ContentState

  var body: some View {
    HStack(spacing: 12) {
      Image(systemName: state.pausedSeconds == nil ? "stopwatch.fill" : "pause.circle.fill")
        .font(.title2)
        .foregroundColor(goldLight)
      VStack(alignment: .leading, spacing: 2) {
        Text(state.label)
          .font(.headline)
          .foregroundColor(.white)
          .lineLimit(1)
        if state.pausedSeconds != nil {
          Text(state.pausedText)
            .font(.subheadline)
            .foregroundColor(goldLight)
        }
      }
      Spacer(minLength: 8)
      StopwatchTime(state: state)
        .font(.system(size: 34, weight: .bold, design: .rounded).monospacedDigit())
        .foregroundColor(gold)
        .multilineTextAlignment(.trailing)
        .frame(maxWidth: 140, alignment: .trailing)
    }
    .padding(.horizontal, 18)
    .padding(.vertical, 14)
  }
}

@available(iOS 16.1, *)
struct StopwatchLiveActivity: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: StopwatchAttributes.self) { context in
      StopwatchLockScreen(state: context.state)
        .activityBackgroundTint(night)
        .activitySystemActionForegroundColor(.white)
        .widgetURL(todayURL)
    } dynamicIsland: { context in
      DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
          Image(systemName: context.state.pausedSeconds == nil ? "stopwatch.fill" : "pause.circle.fill")
            .font(.title2)
            .foregroundColor(goldLight)
            .padding(.leading, 4)
        }
        DynamicIslandExpandedRegion(.trailing) {
          StopwatchTime(state: context.state)
            .font(.title2.bold().monospacedDigit())
            .foregroundColor(gold)
            .multilineTextAlignment(.trailing)
            .frame(maxWidth: 110, alignment: .trailing)
        }
        DynamicIslandExpandedRegion(.bottom) {
          HStack {
            Text(context.state.label).font(.headline).lineLimit(1)
            if context.state.pausedSeconds != nil {
              Text("· \(context.state.pausedText)").foregroundColor(goldLight)
            }
            Spacer()
          }
          .padding(.horizontal, 4)
        }
      } compactLeading: {
        Image(systemName: "stopwatch.fill").foregroundColor(goldLight)
      } compactTrailing: {
        StopwatchTime(state: context.state)
          .monospacedDigit()
          .foregroundColor(gold)
          .frame(maxWidth: 52)
      } minimal: {
        Image(systemName: "stopwatch.fill").foregroundColor(goldLight)
      }
      .widgetURL(todayURL)
      .keylineTint(gold)
    }
  }
}
