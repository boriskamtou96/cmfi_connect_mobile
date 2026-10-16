import ManagedSettings
import UserNotifications

/// Cherche d'abord Dieu: the buttons of a closed app. A shield can't open
/// the app: "Remplir mon compte rendu" sends a notification that opens
/// today's report (the payload of the evening reminder, read by
/// flutter_local_notifications); "Pause de 5 min" opens the apps for 5
/// minutes, 3 times a day.
class ShieldActions: ShieldActionDelegate {
  override func handle(
    action: ShieldAction, for application: ApplicationToken,
    completionHandler: @escaping (ShieldActionResponse) -> Void
  ) {
    respond(to: action, completionHandler)
  }

  override func handle(
    action: ShieldAction, for webDomain: WebDomainToken,
    completionHandler: @escaping (ShieldActionResponse) -> Void
  ) {
    respond(to: action, completionHandler)
  }

  override func handle(
    action: ShieldAction, for category: ActivityCategoryToken,
    completionHandler: @escaping (ShieldActionResponse) -> Void
  ) {
    respond(to: action, completionHandler)
  }

  private func respond(
    to action: ShieldAction, _ completionHandler: @escaping (ShieldActionResponse) -> Void
  ) {
    switch action {
    case .primaryButtonPressed:
      notifyToFill { completionHandler(.close) }
    case .secondaryButtonPressed:
      // the app shows again once its shield is gone
      completionHandler(SeekFirst.usePause() ? .defer : .none)
    @unknown default:
      completionHandler(.close)
    }
  }

  private func notifyToFill(then done: @escaping () -> Void) {
    let texts = SeekFirst.texts
    let content = UNMutableNotificationContent()
    content.title = texts["notificationTitle"] ?? "Seek God first"
    content.body = texts["notificationBody"] ?? "Tap here to fill in your report."
    content.sound = .default
    // the keys flutter_local_notifications needs to hand the tap to the app
    content.userInfo = [
      "NotificationId": 990_001,
      "presentAlert": true,
      "presentSound": true,
      "presentBadge": false,
      "presentBanner": true,
      "presentList": true,
      "payload": "report_today",
    ]
    let request = UNNotificationRequest(
      identifier: "seekFirst.fill", content: content, trigger: nil)
    UNUserNotificationCenter.current().add(request) { _ in done() }
  }
}
