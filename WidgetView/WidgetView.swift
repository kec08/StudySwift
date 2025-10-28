//
//  WidgetView.swift
//  WidgetView
//
//  Created by 김은찬 on 10/28/25.
//

import WidgetKit
import SwiftUI
import AppIntents

// MARK: - 색상 선택 열거형
enum WidgetColorType: String, AppEnum {
    case red
    case blue
    case green
    case purple
    case orange
    case pink
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "위젯 색상"
    
    static var caseDisplayRepresentations: [WidgetColorType: DisplayRepresentation] = [
        .red: DisplayRepresentation(title: "빨강", subtitle: "Red", image: .init(systemName: "circle.fill")),
        .blue: DisplayRepresentation(title: "파랑", subtitle: "Blue", image: .init(systemName: "circle.fill")),
        .green: DisplayRepresentation(title: "초록", subtitle: "Green", image: .init(systemName: "circle.fill")),
        .purple: DisplayRepresentation(title: "보라", subtitle: "Purple", image: .init(systemName: "circle.fill")),
        .orange: DisplayRepresentation(title: "주황", subtitle: "Orange", image: .init(systemName: "circle.fill")),
        .pink: DisplayRepresentation(title: "분홍", subtitle: "Pink", image: .init(systemName: "circle.fill"))
    ]
    
    var gradientColors: [Color] {
        switch self {
        case .red: return [.red, .orange]
        case .blue: return [.blue, .cyan]
        case .green: return [.green, .mint]
        case .purple: return [.purple, .pink]
        case .orange: return [.orange, .yellow]
        case .pink: return [.pink, .purple]
        }
    }
}


// MARK: - Timeline Entry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

// MARK: - Timeline Provider
struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        
        for i in 0..<5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: i * 3, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

// MARK: - Widget Entry View
struct WidgetViewEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            // 이모지
            Text(entry.configuration.favoriteEmoji)
                .font(.system(size: family == .systemLarge ? 90 : (family == .systemSmall ? 50 : 70)))
            
            // 시간
            Text(entry.date, style: .time)
                .font(family == .systemLarge ? .largeTitle : (family == .systemSmall ? .headline : .title2))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            // 날짜
            Text(entry.date, style: .date)
                .font(family == .systemLarge ? .title3 : .caption)
                .foregroundColor(.white.opacity(0.9))
            
            // 색상 이름
            if family != .systemSmall {
                Text(colorName(for: entry.configuration.widgetColor))
                    .font(family == .systemLarge ? .title3 : .caption2)
                    .padding(.horizontal, family == .systemLarge ? 20 : 12)
                    .padding(.vertical, family == .systemLarge ? 10 : 6)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(family == .systemLarge ? 16 : 12)
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .containerBackground(for: .widget) {
            LinearGradient(
                colors: entry.configuration.widgetColor.gradientColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    func colorName(for color: WidgetColorType) -> String {
        switch color {
        case .red: return "빨강"
        case .blue: return "파랑"
        case .green: return "초록"
        case .purple: return "보라"
        case .orange: return "주황"
        case .pink: return "분홍"
        }
    }
}

// MARK: - Widget
struct WidgetView: Widget {
    let kind: String = "위젯"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: Provider()
        ) { entry in
            WidgetViewEntryView(entry: entry)
        }
        .configurationDisplayName("컬러 위젯")
        .description("시간과 이모지를 표시하는 위젯입니다. 색상을 변경할 수 있습니다.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// MARK: - Preview
extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        intent.widgetColor = .blue
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        intent.widgetColor = .purple
        return intent
    }
}

#Preview(as: .systemSmall) {
    WidgetView()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
}

#Preview(as: .systemMedium) {
    WidgetView()
} timeline: {
    SimpleEntry(date: .now, configuration: .starEyes)
}

#Preview(as: .systemLarge) {
    WidgetView()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
}
