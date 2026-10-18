import AppIntents
import UIKit

// Siri and the Shortcuts app (iOS 16+): « Dis Siri, remplis mon compte rendu
// dans CMFI Connect », « … commence la retraite dans CMFI Connect ». Each
// action opens the app on its screen through the app's own link
// (cmficonnect://open?to=…, read by app_links like any other link: see
// core/services/deep_links.dart). The phrases are in AppShortcuts.strings,
// the titles in Localizable.strings, one per language of the app.

/// Gives [path] to the app as if its link had been opened.
@MainActor
private func openInApp(_ path: String) {
  guard let url = URL(string: "cmficonnect://open?to=\(path)") else { return }
  let application = UIApplication.shared
  _ = application.delegate?.application?(application, open: url, options: [:])
}

@available(iOS 16.0, *)
struct FillReportIntent: AppIntent {
  static var title: LocalizedStringResource = "Fill in my report"
  static var description = IntentDescription("Opens today's report.")
  static var openAppWhenRun = true

  @MainActor
  func perform() async throws -> some IntentResult {
    openInApp("reports/today")
    return .result()
  }
}

@available(iOS 16.0, *)
struct StartRetreatIntent: AppIntent {
  static var title: LocalizedStringResource = "Start the retreat"
  static var description = IntentDescription("Opens the prayer retreat of the moment.")
  static var openAppWhenRun = true

  @MainActor
  func perform() async throws -> some IntentResult {
    openInApp("prayer/retreat")
    return .result()
  }
}

@available(iOS 16.0, *)
struct CmfiShortcuts: AppShortcutsProvider {
  static var appShortcuts: [AppShortcut] {
    AppShortcut(
      intent: FillReportIntent(),
      phrases: [
        "Fill in my report in \(.applicationName)",
        "Open my report in \(.applicationName)",
      ],
      shortTitle: "Fill in my report",
      systemImageName: "checkmark.circle"
    )
    AppShortcut(
      intent: StartRetreatIntent(),
      phrases: [
        "Start the retreat in \(.applicationName)",
        "Pray with \(.applicationName)",
      ],
      shortTitle: "Start the retreat",
      systemImageName: "hands.sparkles"
    )
  }
}
