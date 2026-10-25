import SwiftUI
import WidgetKit

// The "Aujourd'hui" widget: today's report done or to fill in, and how far
// the goals go. The app saves the values and the texts in its language
// (lib/src/core/services/home_widgets.dart) in the App Group; the next day,
// the widget shows "to fill in" by itself. It comes with Premium.

private let appGroup =
  Bundle.main.object(forInfoDictionaryKey: "AppGroupId") as? String
  ?? "group.com.cmficonnect.mobile"

private let brandBlue = Color(red: 10 / 255, green: 94 / 255, blue: 168 / 255)
private let mutedOnBlue = Color(red: 184 / 255, green: 214 / 255, blue: 242 / 255)
private let gold = Color(red: 226 / 255, green: 169 / 255, blue: 59 / 255)

/// The texts before the app has given its own (just installed), and the
/// name of the widget in the gallery, in the phone's language.
private enum Fallback {
  static let texts: [String: [String: String]] = [
    "fr": [
      "name": "Compte rendu du jour",
      "description": "Ton compte rendu du jour et tes objectifs.",
      "title": "Aujourd'hui",
      "done": "Fait",
      "todo": "À remplir",
      "open": "Remplir",
      "locked": "Active le widget avec Premium",
      "signed_out": "Connecte-toi dans l'app",
      "goals": "objectifs",
    ],
    "en": [
      "name": "Today's report",
      "description": "Your report of the day and your goals.",
      "title": "Today",
      "done": "Done",
      "todo": "To fill in",
      "open": "Fill in",
      "locked": "Turn on the widget with Premium",
      "signed_out": "Sign in to the app",
      "goals": "goals",
    ],
    "de": [
      "name": "Tagesbericht",
      "description": "Dein Tagesbericht und deine Ziele.",
      "title": "Heute",
      "done": "Erledigt",
      "todo": "Auszufüllen",
      "open": "Ausfüllen",
      "locked": "Aktiviere das Widget mit Premium",
      "signed_out": "Melde dich in der App an",
      "goals": "Ziele",
    ],
    "es": [
      "name": "Informe del día",
      "description": "Tu informe del día y tus objetivos.",
      "title": "Hoy",
      "done": "Hecho",
      "todo": "Por rellenar",
      "open": "Rellenar",
      "locked": "Activa el widget con Premium",
      "signed_out": "Inicia sesión en la app",
      "goals": "objetivos",
    ],
    "ar": [
      "name": "تقرير اليوم",
      "description": "تقرير يومك وأهدافك.",
      "title": "اليوم",
      "done": "تم",
      "todo": "للتعبئة",
      "open": "عبّئ",
      "locked": "فعّل الأداة مع Premium",
      "signed_out": "سجّل الدخول في التطبيق",
      "goals": "الأهداف",
    ],
    "zh": [
      "name": "今日报告",
      "description": "今天的报告和你的目标。",
      "title": "今天",
      "done": "已完成",
      "todo": "待填写",
      "open": "填写",
      "locked": "用 Premium 开启小组件",
      "signed_out": "请在应用中登录",
      "goals": "目标",
    ],
    "hi": [
      "name": "आज की रिपोर्ट",
      "description": "आज की तुम्हारी रिपोर्ट और लक्ष्य।",
      "title": "आज",
      "done": "हो गया",
      "todo": "भरना बाकी",
      "open": "भरो",
      "locked": "Premium से विजेट चालू करो",
      "signed_out": "ऐप में साइन इन करो",
      "goals": "लक्ष्य",
    ],
  ]

  static func text(_ key: String) -> String {
    let language = Locale.preferredLanguages.first.map { String($0.prefix(2)) } ?? "en"
    return texts[language]?[key] ?? texts["en"]?[key] ?? ""
  }
}

struct TodayEntry: TimelineEntry {
  let date: Date
  let signedIn: Bool
  let premium: Bool
  /// The values are today's (else today is still to fill in).
  let fresh: Bool
  let done: Bool
  /// 0 to 100; nil without goals.
  let goal: Int?
  let texts: [String: String]

  func text(_ key: String) -> String { texts[key] ?? Fallback.text(key) }

  var link: URL {
    URL(string: !signedIn ? "cmficonnect://open" : !premium ? "cmficonnect://premium" : "cmficonnect://today")!
  }

  /// The gallery shows the widget filled in.
  static let sample = TodayEntry(
    date: Date(), signedIn: true, premium: true, fresh: true, done: false, goal: 75,
    texts: [:])
}

struct TodayProvider: TimelineProvider {
  func placeholder(in context: Context) -> TodayEntry { .sample }

  func getSnapshot(in context: Context, completion: @escaping (TodayEntry) -> Void) {
    completion(context.isPreview ? .sample : read(at: Date()))
  }

  // now, and again at midnight to turn to the new day
  func getTimeline(in context: Context, completion: @escaping (Timeline<TodayEntry>) -> Void) {
    let now = Date()
    let calendar = Calendar.current
    let midnight = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: now)!)
    completion(Timeline(entries: [read(at: now), read(at: midnight)], policy: .after(midnight)))
  }

  private func read(at date: Date) -> TodayEntry {
    let defaults = UserDefaults(suiteName: appGroup)
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .gregorian)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd"
    let fresh = defaults?.string(forKey: "day") == formatter.string(from: date)
    let savedGoal = (defaults?.object(forKey: "goal_percent") as? NSNumber)?.intValue ?? -1
    var texts: [String: String] = [:]
    for key in ["title", "done", "todo", "open", "locked", "signed_out", "goals", "items"] {
      if let value = defaults?.string(forKey: "text_\(key)") { texts[key] = value }
    }
    return TodayEntry(
      date: date,
      signedIn: defaults?.bool(forKey: "signed_in") ?? false,
      premium: defaults?.bool(forKey: "premium") ?? false,
      fresh: fresh,
      done: fresh && (defaults?.bool(forKey: "done") ?? false),
      goal: savedGoal < 0 ? nil : fresh ? min(max(savedGoal, 0), 100) : 0,
      texts: texts)
  }
}

/// How far the goals go, like GoalRing in the app: gold at 100 %.
struct GoalRingView: View {
  let percent: Int
  let size: CGFloat

  var body: some View {
    let line = size * 0.11
    ZStack {
      Circle().stroke(Color.white.opacity(0.22), lineWidth: line)
      Circle()
        .trim(from: 0, to: CGFloat(percent) / 100)
        .stroke(percent >= 100 ? gold : Color.white, style: StrokeStyle(lineWidth: line, lineCap: .round))
        .rotationEffect(.degrees(-90))
      Text("\(percent) %")
        .font(.system(size: size * 0.24, weight: .heavy))
        .foregroundColor(.white)
        .minimumScaleFactor(0.6)
        .lineLimit(1)
        .padding(line)
    }
    .frame(width: size, height: size)
  }
}

struct TodayWidgetView: View {
  @Environment(\.widgetFamily) private var family
  let entry: TodayEntry

  private var unlocked: Bool { entry.signedIn && entry.premium }

  private var status: String {
    if !entry.signedIn { return entry.text("signed_out") }
    if !entry.premium { return entry.text("locked") }
    return entry.text(entry.done ? "done" : "todo")
  }

  @ViewBuilder
  private func picture(size: CGFloat) -> some View {
    if unlocked, let goal = entry.goal {
      GoalRingView(percent: goal, size: size)
    } else {
      Image(!unlocked ? "DoveJoy" : entry.done ? "DoveCelebrate" : "DoveCheer")
        .resizable()
        .scaledToFit()
        .frame(width: size, height: size)
        .accessibilityHidden(true)
    }
  }

  var body: some View {
    Group {
      if family == .systemMedium {
        HStack(spacing: 16) {
          picture(size: 84)
          VStack(alignment: .leading, spacing: 3) {
            Text(entry.text("title")).font(.caption.bold()).foregroundColor(mutedOnBlue)
            Text(status).font(.title3.bold()).foregroundColor(.white).lineLimit(2)
            if unlocked && entry.fresh, let items = entry.texts["items"] {
              Text(items).font(.footnote).foregroundColor(mutedOnBlue).lineLimit(1)
            }
            if unlocked && !entry.done {
              Text(entry.text("open"))
                .font(.footnote.bold())
                .foregroundColor(brandBlue)
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .background(Capsule().fill(Color.white))
                .padding(.top, 4)
            }
          }
          Spacer(minLength: 0)
        }
      } else {
        VStack(alignment: .leading, spacing: 4) {
          Text(entry.text("title")).font(.caption.bold()).foregroundColor(mutedOnBlue)
          Spacer(minLength: 0)
          HStack {
            Spacer(minLength: 0)
            picture(size: 64)
            Spacer(minLength: 0)
          }
          Spacer(minLength: 0)
          Text(status).font(.subheadline.bold()).foregroundColor(.white).lineLimit(2)
            .minimumScaleFactor(0.8)
        }
      }
    }
    .widgetURL(entry.link)
    .widgetBackground(brandBlue)
  }
}

extension View {
  /// iOS 17 draws the background of a widget itself (and removes it in the
  /// tinted modes); before, it is painted behind with the margins.
  @ViewBuilder
  func widgetBackground(_ color: Color) -> some View {
    if #available(iOS 17.0, *) {
      containerBackground(for: .widget) { color }
    } else {
      padding().background(color)
    }
  }
}

// one of the widgets of CMFIWidgets (VerseWidget.swift)
struct TodayWidget: Widget {
  // the name given to HomeWidget.updateWidget(iOSName:)
  let kind = "TodayWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: TodayProvider()) { entry in
      TodayWidgetView(entry: entry)
    }
    .configurationDisplayName(Fallback.text("name"))
    .description(Fallback.text("description"))
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}
