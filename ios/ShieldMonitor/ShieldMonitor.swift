import DeviceActivity
import Foundation

/// Cherche d'abord Dieu: closes the chosen apps at the start hour (unless
/// today's report is saved), opens them at the end of the day, and closes
/// them again when a pause ends. See SeekFirst/SeekFirstShared.swift.
class ShieldMonitor: DeviceActivityMonitor {
  override func intervalDidStart(for activity: DeviceActivityName) {
    super.intervalDidStart(for: activity)
    if activity == SeekFirst.daily {
      SeekFirst.apply()
    }
  }

  override func intervalDidEnd(for activity: DeviceActivityName) {
    super.intervalDidEnd(for: activity)
    if activity == SeekFirst.daily {
      // the day is over: open until tomorrow's start hour
      SeekFirst.openApps()
    } else if activity == SeekFirst.pause {
      SeekFirst.apply()
    }
  }
}
