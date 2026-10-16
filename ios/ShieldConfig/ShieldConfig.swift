import ManagedSettings
import ManagedSettingsUI
import UIKit

/// Cherche d'abord Dieu: the screen of a closed app, night blue and gold,
/// in the app language (the texts the app left in the App Group).
class ShieldConfig: ShieldConfigurationDataSource {
  private let night = UIColor(red: 6 / 255, green: 31 / 255, blue: 64 / 255, alpha: 1)
  private let gold = UIColor(red: 226 / 255, green: 169 / 255, blue: 59 / 255, alpha: 1)
  private let goldLight = UIColor(red: 246 / 255, green: 210 / 255, blue: 122 / 255, alpha: 1)

  override func configuration(shielding application: Application) -> ShieldConfiguration {
    shield(named: application.localizedDisplayName)
  }

  override func configuration(
    shielding application: Application, in category: ActivityCategory
  ) -> ShieldConfiguration {
    shield(named: application.localizedDisplayName)
  }

  override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
    shield(named: webDomain.domain)
  }

  override func configuration(
    shielding webDomain: WebDomain, in category: ActivityCategory
  ) -> ShieldConfiguration {
    shield(named: webDomain.domain)
  }

  private func shield(named name: String?) -> ShieldConfiguration {
    let texts = SeekFirst.texts
    let app = name ?? texts["thisApp"] ?? "This app"
    let subtitle = (texts["subtitle"] ?? "{app} stays closed until today's report.")
      .replacingOccurrences(of: "{app}", with: app)
    let left = SeekFirst.pausesLeft()
    let pause = (texts["pause"] ?? "5-min break ({n}/3)")
      .replacingOccurrences(of: "{n}", with: "\(left)")
    return ShieldConfiguration(
      backgroundBlurStyle: .systemUltraThinMaterialDark,
      backgroundColor: night.withAlphaComponent(0.92),
      icon: UIImage(named: "ShieldIcon"),
      title: ShieldConfiguration.Label(text: texts["title"] ?? "Seek God first", color: .white),
      subtitle: ShieldConfiguration.Label(
        text: subtitle, color: UIColor.white.withAlphaComponent(0.82)),
      primaryButtonLabel: ShieldConfiguration.Label(
        text: texts["fill"] ?? "Fill in my report", color: night),
      primaryButtonBackgroundColor: gold,
      secondaryButtonLabel: left > 0 ? ShieldConfiguration.Label(text: pause, color: goldLight) : nil
    )
  }
}
