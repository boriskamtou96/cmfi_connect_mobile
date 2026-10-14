import SwiftUI
import WidgetKit

// The "Verset du jour" widget: the verse of the day of the app, in its
// language. The app saves the verses of the next two weeks in the App Group
// (lib/src/core/services/home_widgets.dart, VerseWidgetData); the widget turns
// to the next one at midnight by itself. Free, signed in or not.

private let appGroup =
  Bundle.main.object(forInfoDictionaryKey: "AppGroupId") as? String
  ?? "group.com.cmficonnect.app"

private func dynamic(light: UInt32, dark: UInt32) -> Color {
  func color(_ hex: UInt32) -> UIColor {
    UIColor(
      red: CGFloat((hex >> 16) & 0xFF) / 255,
      green: CGFloat((hex >> 8) & 0xFF) / 255,
      blue: CGFloat(hex & 0xFF) / 255,
      alpha: 1)
  }
  return Color(UIColor { $0.userInterfaceStyle == .dark ? color(dark) : color(light) })
}

// the verse card of the app: a warm paper, the brand blue, the gold book
private let paper = dynamic(light: 0xFFFBF4, dark: 0x131A24)
private let ink = dynamic(light: 0x0F1A2A, dark: 0xE3E9F1)
private let muted = dynamic(light: 0x556375, dark: 0xA2AFBF)
private let blue = dynamic(light: 0x0A5EA8, dark: 0x8CC6F4)
private let gold = Color(red: 226 / 255, green: 169 / 255, blue: 59 / 255)

/// The texts before the app has given its verses (just installed), and the
/// name of the widget in the gallery, in the phone's language.
private enum VerseFallback {
  static let texts: [String: [String: String]] = [
    "fr": [
      "name": "Verset du jour",
      "description": "Un verset de la Bible chaque jour.",
      "empty": "Ouvre l'app pour recevoir le verset du jour.",
      "sample": "Car Dieu a tant aimé le monde qu'il a donné son Fils unique.",
      "sample_ref": "Jean 3.16",
    ],
    "en": [
      "name": "Verse of the day",
      "description": "A Bible verse every day.",
      "empty": "Open the app to get the verse of the day.",
      "sample": "For God so loved the world, that he gave his one and only Son.",
      "sample_ref": "John 3:16",
    ],
    "de": [
      "name": "Vers des Tages",
      "description": "Jeden Tag ein Bibelvers.",
      "empty": "Öffne die App, um den Vers des Tages zu erhalten.",
      "sample": "Denn also hat Gott die Welt geliebt, dass er seinen eingeborenen Sohn gab.",
      "sample_ref": "Johannes 3,16",
    ],
    "es": [
      "name": "Versículo del día",
      "description": "Un versículo de la Biblia cada día.",
      "empty": "Abre la app para recibir el versículo del día.",
      "sample": "Porque de tal manera amó Dios al mundo, que ha dado a su Hijo unigénito.",
      "sample_ref": "Juan 3:16",
    ],
    "ar": [
      "name": "آية اليوم",
      "description": "آية من الكتاب المقدس كل يوم.",
      "empty": "افتح التطبيق لتصلك آية اليوم.",
      "sample": "لأنه هكذا أحب الله العالم حتى بذل ابنه الوحيد.",
      "sample_ref": "يوحنا 3: 16",
    ],
    "zh": [
      "name": "每日经文",
      "description": "每天一节圣经经文。",
      "empty": "打开应用以获取每日经文。",
      "sample": "神爱世人，甚至将他的独生子赐给他们。",
      "sample_ref": "约翰福音 3:16",
    ],
    "hi": [
      "name": "आज का वचन",
      "description": "हर दिन बाइबल का एक वचन।",
      "empty": "आज का वचन पाने के लिए ऐप खोलो।",
      "sample": "क्योंकि परमेश्वर ने जगत से ऐसा प्रेम रखा कि उसने अपना एकलौता पुत्र दे दिया।",
      "sample_ref": "यूहन्ना 3:16",
    ],
  ]

  static var language: String {
    Locale.preferredLanguages.first.map { String($0.prefix(2)) } ?? "en"
  }

  static func text(_ key: String) -> String {
    texts[language]?[key] ?? texts["en"]?[key] ?? ""
  }
}

struct VerseEntry: TimelineEntry {
  let date: Date
  /// nil before the app has given its verses.
  let text: String?
  let reference: String
  let source: String
  let title: String
  let rightToLeft: Bool

  /// The gallery shows a verse.
  static let sample = VerseEntry(
    date: Date(),
    text: VerseFallback.text("sample"),
    reference: VerseFallback.text("sample_ref"),
    source: "",
    title: VerseFallback.text("name"),
    rightToLeft: VerseFallback.language == "ar")
}

struct VerseProvider: TimelineProvider {
  func placeholder(in context: Context) -> VerseEntry { .sample }

  func getSnapshot(in context: Context, completion: @escaping (VerseEntry) -> Void) {
    completion(context.isPreview ? .sample : timeline().first ?? .sample)
  }

  // one entry per day saved, each from its midnight; then the app's next
  // verses (or, without them, the message to open the app)
  func getTimeline(in context: Context, completion: @escaping (Timeline<VerseEntry>) -> Void) {
    let entries = timeline()
    let calendar = Calendar.current
    let tomorrow = calendar.startOfDay(
      for: calendar.date(byAdding: .day, value: 1, to: Date())!)
    completion(
      Timeline(entries: entries, policy: entries.count > 1 ? .atEnd : .after(tomorrow)))
  }

  private func timeline() -> [VerseEntry] {
    let defaults = UserDefaults(suiteName: appGroup)
    let title = defaults?.string(forKey: "verse_title") ?? VerseFallback.text("name")
    let source = defaults?.string(forKey: "verse_source") ?? ""
    let rightToLeft = defaults?.bool(forKey: "verse_rtl") ?? false
    let calendar = Calendar.current
    let now = Date()
    let today = calendar.startOfDay(for: now)

    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .gregorian)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "yyyy-MM-dd"

    var days: [(Date, String, String)] = []
    if let raw = defaults?.string(forKey: "verse_days"),
      let data = raw.data(using: .utf8),
      let json = try? JSONSerialization.jsonObject(with: data) as? [String: [String: String]]
    {
      for (key, verse) in json {
        guard let day = formatter.date(from: key), day >= today,
          let text = verse["text"], let reference = verse["ref"]
        else { continue }
        days.append((day, text, reference))
      }
    }
    days.sort { $0.0 < $1.0 }

    guard !days.isEmpty else {
      return [
        VerseEntry(
          date: now, text: nil, reference: "", source: "", title: title,
          rightToLeft: rightToLeft)
      ]
    }
    return days.map { day, text, reference in
      VerseEntry(
        date: day == today ? now : day, text: text, reference: reference, source: source,
        title: title, rightToLeft: rightToLeft)
    }
  }
}

struct VerseWidgetView: View {
  @Environment(\.widgetFamily) private var family
  let entry: VerseEntry

  private var medium: Bool { family == .systemMedium }

  var body: some View {
    VStack(alignment: .leading, spacing: medium ? 8 : 6) {
      HStack(spacing: 5) {
        Image(systemName: "book.fill")
          .font(.caption2)
          .foregroundColor(gold)
          .accessibilityHidden(true)
        Text(entry.title.uppercased())
          .font(.caption2.weight(.heavy))
          .tracking(medium ? 0.6 : 0.2)
          .foregroundColor(blue)
          .lineLimit(1)
          // the whole title on the small widget
          .minimumScaleFactor(0.7)
      }
      if let text = entry.text {
        Text(text)
          .font(.system(size: medium ? 16 : 14, design: .serif).italic())
          .foregroundColor(ink)
          .lineLimit(medium ? 4 : 6)
          .minimumScaleFactor(0.6)
        Spacer(minLength: 0)
        Text(
          medium && !entry.source.isEmpty ? "\(entry.reference) · \(entry.source)" : entry.reference
        )
        .font(.caption.bold())
        .foregroundColor(medium ? muted : ink)
        .lineLimit(1)
        .minimumScaleFactor(0.7)
      } else {
        Spacer(minLength: 0)
        Text(VerseFallback.text("empty"))
          .font(.footnote)
          .foregroundColor(muted)
        Spacer(minLength: 0)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .environment(\.layoutDirection, entry.rightToLeft ? .rightToLeft : .leftToRight)
    .widgetURL(URL(string: "cmficonnect://verse")!)
    .widgetBackground(paper)
  }
}

struct VerseWidget: Widget {
  // the name given to HomeWidget.updateWidget(iOSName:)
  let kind = "VerseWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: VerseProvider()) { entry in
      VerseWidgetView(entry: entry)
    }
    .configurationDisplayName(VerseFallback.text("name"))
    .description(VerseFallback.text("description"))
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}

/// The widgets of the app: today's report, and the verse of the day.
@main
struct CMFIWidgets: WidgetBundle {
  var body: some Widget {
    TodayWidget()
    VerseWidget()
  }
}
