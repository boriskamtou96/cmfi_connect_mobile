import DeviceActivity
import FamilyControls
import Foundation
import ManagedSettings

/// « Cherche d'abord Dieu », shared by the app (AppShield.swift) and its three
/// extensions: the apps the member chose close each day from a set hour,
/// until the day's report is saved. Everything lives in the App Group, the
/// only place the extensions can read.
///
/// - ShieldMonitor closes them at the hour (the daily schedule), opens them
///   at the end of the day, and closes them again after a pause.
/// - ShieldConfig draws the screen of a closed app.
/// - ShieldActions answers its buttons: a notification that opens the
///   report, or a pause of 5 minutes.
@available(iOS 16.0, *)
enum SeekFirst {
  static let store = ManagedSettingsStore(named: ManagedSettingsStore.Name("seekFirst"))
  static let daily = DeviceActivityName("seekFirst.daily")
  static let pause = DeviceActivityName("seekFirst.pause")
  static let pauseMinutes = 5

  private enum Key {
    static let enabled = "seekFirst.enabled"
    static let start = "seekFirst.start"
    static let selection = "seekFirst.selection"
    static let doneDay = "seekFirst.doneDay"
    static let pausesPerDay = "seekFirst.pausesPerDay"
    static let pausesDay = "seekFirst.pausesDay"
    static let pausesUsed = "seekFirst.pausesUsed"
    static let pauseUntil = "seekFirst.pauseUntil"
    static let texts = "seekFirst.texts"
  }

  /// The App Group of this flavor (Info.plist: AppGroupId).
  private static var defaults: UserDefaults {
    let group = Bundle.main.object(forInfoDictionaryKey: "AppGroupId") as? String ?? ""
    return UserDefaults(suiteName: group) ?? .standard
  }

  /// "2026-10-16", as the app writes it.
  static func dayKey(_ date: Date = Date()) -> String {
    let parts = Calendar.current.dateComponents([.year, .month, .day], from: date)
    return String(format: "%04d-%02d-%02d", parts.year ?? 0, parts.month ?? 0, parts.day ?? 0)
  }

  // ----- the settings -----

  static var enabled: Bool {
    get { defaults.bool(forKey: Key.enabled) }
    set { defaults.set(newValue, forKey: Key.enabled) }
  }

  /// Minutes after midnight; at most 23:44, so the day keeps the 15
  /// minutes a schedule needs.
  static var startMinutes: Int {
    get { defaults.object(forKey: Key.start) as? Int ?? 5 * 60 }
    set { defaults.set(min(max(newValue, 0), 23 * 60 + 44), forKey: Key.start) }
  }

  static var selection: FamilyActivitySelection {
    get {
      guard let data = defaults.data(forKey: Key.selection),
        let selection = try? JSONDecoder().decode(FamilyActivitySelection.self, from: data)
      else { return FamilyActivitySelection() }
      return selection
    }
    set { defaults.set(try? JSONEncoder().encode(newValue), forKey: Key.selection) }
  }

  static func counts(_ selection: FamilyActivitySelection) -> [String: Int] {
    [
      "apps": selection.applicationTokens.count,
      "categories": selection.categoryTokens.count,
      "sites": selection.webDomainTokens.count,
    ]
  }

  /// The day whose report is saved.
  static var doneDay: String? {
    get { defaults.string(forKey: Key.doneDay) }
    set { defaults.set(newValue, forKey: Key.doneDay) }
  }

  static var pausesPerDay: Int {
    get { defaults.object(forKey: Key.pausesPerDay) as? Int ?? 3 }
    set { defaults.set(newValue, forKey: Key.pausesPerDay) }
  }

  /// What the closed apps say, in the app language ("{app}", "{n}" inside).
  static var texts: [String: String] {
    get { defaults.dictionary(forKey: Key.texts) as? [String: String] ?? [:] }
    set { defaults.set(newValue, forKey: Key.texts) }
  }

  // ----- closed or open -----

  /// Whether the chosen apps must be closed at [now].
  static func shouldClose(now: Date = Date()) -> Bool {
    let chosen = selection
    guard enabled,
      !(chosen.applicationTokens.isEmpty && chosen.categoryTokens.isEmpty
        && chosen.webDomainTokens.isEmpty)
    else { return false }
    if doneDay == dayKey(now) { return false }
    if let until = defaults.object(forKey: Key.pauseUntil) as? Date, until > now { return false }
    let parts = Calendar.current.dateComponents([.hour, .minute], from: now)
    return (parts.hour ?? 0) * 60 + (parts.minute ?? 0) >= startMinutes
  }

  /// Closes or opens the apps, as [shouldClose] says.
  static func apply(now: Date = Date()) {
    if shouldClose(now: now) { closeApps() } else { openApps() }
  }

  static func closeApps() {
    let chosen = selection
    store.shield.applications = chosen.applicationTokens.isEmpty ? nil : chosen.applicationTokens
    store.shield.applicationCategories =
      chosen.categoryTokens.isEmpty ? nil : .specific(chosen.categoryTokens)
    store.shield.webDomains = chosen.webDomainTokens.isEmpty ? nil : chosen.webDomainTokens
  }

  static func openApps() {
    store.clearAllSettings()
  }

  /// The daily schedule: closed from the start hour to the end of the day
  /// (ShieldMonitor), nothing when turned off.
  static func schedule() {
    let center = DeviceActivityCenter()
    center.stopMonitoring([daily])
    guard enabled else { return }
    let start = startMinutes
    let interval = DeviceActivitySchedule(
      intervalStart: DateComponents(hour: start / 60, minute: start % 60),
      intervalEnd: DateComponents(hour: 23, minute: 59),
      repeats: true
    )
    try? center.startMonitoring(daily, during: interval)
  }

  // ----- the pauses of 5 minutes -----

  static func pausesLeft(now: Date = Date()) -> Int {
    guard defaults.string(forKey: Key.pausesDay) == dayKey(now) else { return pausesPerDay }
    return max(0, pausesPerDay - defaults.integer(forKey: Key.pausesUsed))
  }

  /// Opens the apps for 5 minutes, if a pause is left today.
  static func usePause(now: Date = Date()) -> Bool {
    let left = pausesLeft(now: now)
    guard left > 0 else { return false }
    defaults.set(dayKey(now), forKey: Key.pausesDay)
    defaults.set(pausesPerDay - left + 1, forKey: Key.pausesUsed)
    let end = now.addingTimeInterval(TimeInterval(pauseMinutes * 60))
    defaults.set(end, forKey: Key.pauseUntil)
    openApps()
    // a schedule lasts 15 minutes at least: it starts in the past, and ends
    // with the pause (ShieldMonitor closes the apps again then)
    let calendar = Calendar.current
    let parts: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
    let interval = DeviceActivitySchedule(
      intervalStart: calendar.dateComponents(parts, from: end.addingTimeInterval(-16 * 60)),
      intervalEnd: calendar.dateComponents(parts, from: end),
      repeats: false
    )
    let center = DeviceActivityCenter()
    center.stopMonitoring([pause])
    try? center.startMonitoring(pause, during: interval)
    return true
  }
}
