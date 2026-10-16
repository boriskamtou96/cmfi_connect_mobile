import FamilyControls
import Flutter
import SwiftUI
import UIKit

/// Cherche d'abord Dieu, for the Flutter app (core/services/app_shield.dart):
/// Screen Time access, the system's list of apps, the settings and the day
/// saved. The work itself is in SeekFirst/SeekFirstShared.swift, shared with
/// the extensions. Needs iOS 16 ("available" says so).
enum AppShield {
  static func register(with messenger: FlutterBinaryMessenger) {
    FlutterMethodChannel(name: "cmficonnect/shield", binaryMessenger: messenger)
      .setMethodCallHandler { call, result in
        guard #available(iOS 16.0, *) else {
          result(call.method == "available" ? false : nil)
          return
        }
        handle(call, result)
      }
  }

  @available(iOS 16.0, *)
  private static func handle(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    let arguments = call.arguments as? [String: Any] ?? [:]
    switch call.method {
    case "available":
      result(true)
    case "authorized":
      result(AuthorizationCenter.shared.authorizationStatus == .approved)
    case "authorize":
      Task { @MainActor in
        do {
          try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
        } catch {
          // refused, or no Screen Time on this phone
        }
        result(AuthorizationCenter.shared.authorizationStatus == .approved)
      }
    case "selection":
      result(SeekFirst.counts(SeekFirst.selection))
    case "choose":
      choose(texts: arguments["texts"] as? [String: String] ?? [:], result)
    case "configure":
      SeekFirst.enabled = arguments["enabled"] as? Bool ?? false
      SeekFirst.startMinutes = arguments["startMinutes"] as? Int ?? 5 * 60
      SeekFirst.pausesPerDay = arguments["pausesPerDay"] as? Int ?? 3
      SeekFirst.texts = arguments["texts"] as? [String: String] ?? [:]
      SeekFirst.schedule()
      SeekFirst.apply()
      result(nil)
    case "unlock":
      SeekFirst.doneDay = arguments["day"] as? String
      SeekFirst.apply()
      result(nil)
    case "pausesLeft":
      result(SeekFirst.pausesLeft())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  /// The system's list of apps, over the app; the counts once done, nil if
  /// cancelled.
  @available(iOS 16.0, *)
  private static func choose(texts: [String: String], _ result: @escaping FlutterResult) {
    guard
      let root = UIApplication.shared.connectedScenes
        .compactMap({ ($0 as? UIWindowScene)?.keyWindow?.rootViewController }).first
    else {
      result(nil)
      return
    }
    var top = root
    while let presented = top.presentedViewController { top = presented }

    var host: UIViewController?
    let picker = AppPicker(
      selection: SeekFirst.selection,
      title: texts["title"] ?? "",
      done: texts["done"] ?? "OK",
      cancel: texts["cancel"] ?? "Cancel",
      onDone: { chosen in
        SeekFirst.selection = chosen
        SeekFirst.apply()
        host?.dismiss(animated: true)
        result(SeekFirst.counts(chosen))
      },
      onCancel: {
        host?.dismiss(animated: true)
        result(nil)
      }
    )
    let controller = UIHostingController(rootView: picker)
    controller.isModalInPresentation = true
    host = controller
    top.present(controller, animated: true)
  }
}

/// FamilyActivityPicker with "Annuler" and "OK".
@available(iOS 16.0, *)
private struct AppPicker: View {
  @State var selection: FamilyActivitySelection
  let title: String
  let done: String
  let cancel: String
  let onDone: (FamilyActivitySelection) -> Void
  let onCancel: () -> Void

  var body: some View {
    NavigationView {
      FamilyActivityPicker(selection: $selection)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            Button(cancel, action: onCancel)
          }
          ToolbarItem(placement: .confirmationAction) {
            Button(done) { onDone(selection) }.bold()
          }
        }
    }
  }
}
