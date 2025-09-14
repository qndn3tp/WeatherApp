//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by 김건혜 on 9/13/25.
//

import WidgetKit
import SwiftUI

// MARK : - Provider
// 위젯의 콘텐츠 업데이트할 날짜와 시간 지정, 위젯을 렌더링하는데 필요한 데이터 포함
struct Provider: TimelineProvider {
    typealias Entry = SimpleEntry
    
    // 위젯이 데이터를 받기 전, 기본적으로 화면에 보여주어야할 값
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😃")  // 고정값
    }
    
    // 위젯을 고를 때, 미리보기에서 보여지는 데이터
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😡")
        completion(entry)
    }
    
    // 위젯 업데이트를 언제 진행할 것인지에 대한 정보
    /// 위젯은 보통 15분~60분 마다 새로고침됨. 실시간으로는 X
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries: [SimpleEntry] = [
            SimpleEntry(date: Date(), emoji: "🥶")
        ]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// 위젯에 표시할 날짜를 지정하고 타임라인 항목을 생성하기 위해 필요(동적으로 뷰를 구성)
struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String  // ConfigurationAppIntent 대신 고정 문자열
}

// 렌더링 되어 실제로 보여줄 뷰를 구성하는 구조체
struct WeatherWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var entry: SimpleEntry

    var body: some View {
        VStack {
            switch family {
            case .systemSmall:
                SmallView(entry: entry)
            case .systemMedium:
                MediumView(entry: entry)
            case .systemLarge:
                LargeView(entry: entry)
            default:
                SmallView(entry: entry)
            }
        }
    }
}

// kind: 위젯 id / intent: 어떤것을 동적으로 작동하는지
struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"      // 위젯의 id
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
                .containerBackground(.blue.opacity(0.1), for: .widget)
        }
        .contentMarginsDisabled()
        // 위젯 설정창
        .configurationDisplayName("채비")
        .description("채비 위젯을 추가해보세요")
    }
}
