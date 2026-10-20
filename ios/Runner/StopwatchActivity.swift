import ActivityKit
import Foundation

/// The stopwatch of an item of the report, outside the app: an Activité en
/// direct on the lock screen and in the Dynamic Island. Shared by the app,
/// which starts, updates and ends it (StopwatchActivities.swift), and the
/// widgets, which draw it (TodayWidget/StopwatchLiveActivity.swift).
@available(iOS 16.1, *)
struct StopwatchAttributes: ActivityAttributes {
  struct ContentState: Codable, Hashable {
    /// The item, in the language of the app ("Prière seule").
    var label: String

    /// When it would have started without its pauses: the time shown runs
    /// from there.
    var since: Date

    /// Paused: the seconds counted, which no longer move; nil while it runs.
    var pausedSeconds: Int?

    /// "en pause", in the language of the app.
    var pausedText: String
  }
}
