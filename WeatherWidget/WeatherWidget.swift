//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by 김건혜 on 8/4/25.
//

import WidgetKit // 위젯을 만들기 위한 핵심 프레임워크
import SwiftUI // 위젯 UI를 만들기 위한 프레임워크
import AppIntents // 사용자 설정을 처리하기 위한 프레임워크

// 위젯에 데이터를 제공하는 공급자입니다.
// AppIntentTimelineProvider는 사용자의 설정을 받을 수 있는 위젯을 만들 때 사용합니다.
struct Provider: AppIntentTimelineProvider {
    // 위젯 갤러리에서 표시될 기본(Placeholder) 데이터를 제공합니다.
    // 위젯을 추가할 때 사용자에게 미리 보여주는 용도로 사용됩니다.
    func placeholder(in context: Context) -> SimpleEntry {
        // 현재 날짜와 기본 설정으로 SimpleEntry를 만듭니다.
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }
    
    // 위젯의 현재 상태를 빠르게 보여주기 위한 스냅샷 데이터를 제공합니다.
    // 위젯이 처음 추가되거나, 위젯 갤러리에서 미리보기할 때 사용됩니다.
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        // 현재 날짜와 사용자의 설정(configuration)을 담은 SimpleEntry를 반환합니다.
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    // 위젯의 업데이트 일정을 정의하는 타임라인을 제공합니다.
    // 위젯이 언제, 어떤 데이터로 업데이트될지 시스템에 알려줍니다.
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // 현재 시점부터 한 시간 간격으로 5개의 엔트리를 생성합니다.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            // entryDate는 currentDate에 hourOffset 시간만큼 더한 값입니다.
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            // 각 시간에 표시될 데이터를 담은 엔트리(SimpleEntry)를 만듭니다.
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        
        // 타임라인을 반환합니다.
        // policy: .atEnd 는 마지막 엔트리 시간이 지나면 새로운 타임라인을 요청하라는 의미입니다.
        return Timeline(entries: entries, policy: .atEnd)
    }
}

// 위젯에 표시될 데이터를 담는 구조체입니다.
// TimelineEntry 프로토콜을 준수해야 합니다.
struct SimpleEntry: TimelineEntry {
    // 엔트리가 표시될 시점
    let date: Date
    // 사용자의 설정 데이터 (예: favoriteEmoji)
    let configuration: ConfigurationAppIntent
}

// ------------------- UI 로직 -------------------

// 위젯의 실제 UI를 담당하는 뷰입니다.
// Provider가 제공하는 Entry 데이터를 받아 화면에 표시합니다.
struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 상단 헤더
            HStack(alignment: .top) {
                Text("San Francisco")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "cloud.rain.fill") // 비 아이콘
                        .foregroundColor(.blue)
                    Text("Light Rain")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.bottom, 10)
            
            // 중간 컨텐츠
            HStack(alignment: .center) {
                // 왼쪽의 캐릭터 이미지
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                
                Spacer()
                
                // 오른쪽의 날씨 정보 및 말풍선
                VStack(alignment: .trailing, spacing: 8) {
                    HStack(alignment: .bottom) {
                        // 습도
                        VStack {
                            Text("습도")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.secondary)
                            Text("57%")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                        .padding(.bottom, 10)
                        // 강수확률
                        VStack {
                            Text("강수확률")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.secondary)
                            Text("45%")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.secondary)
                        }.padding(.bottom, 10)
                        
                        // 온도
                        Text("72°")
                            .font(.system(size: 50, weight: .bold))
                    }
                    
                    
                    // 말풍선 모양의 텍스트 박스
                    VStack() {
                        Text("Perfect weather for a cozy day!")
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(UIColor.systemGray6))
                            )
                    }
                    // 음수 패딩으로 확장
                    .frame(maxWidth: 300)
                    .padding(.leading, -50)
                    .padding(.trailing, -20)
                    
                }
                .padding(.trailing, 8)
            }
        }
        .containerBackground(
            LinearGradient(
                colors: [
                    Color(red: 237 / 255.0, green: 244 / 255.0, blue: 254 / 255.0),
                    Color(red: 227 / 255.0, green: 237 / 255.0, blue: 253 / 255.0)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            for: .widget
        )
    }
}

// ------------------- 위젯 설정 -------------------

// 위젯을 정의하는 메인 구조체입니다.
// Widget 프로토콜을 준수해야 합니다.
struct WeatherWidget: Widget {
    // 위젯의 고유한 식별자입니다.
    let kind: String = "WeatherWidget"
    
    var body: some WidgetConfiguration {
        // 사용자의 설정을 받는 위젯을 위한 설정입니다.
        // kind: 위젯 식별자
        // intent: 사용자 설정에 사용될 Intent
        // provider: 위젯 데이터 공급자
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            // 위에서 정의한 UI 뷰를 연결합니다.
            WeatherWidgetEntryView(entry: entry)
        }
    }
}

// ------------------- 미리보기 설정 -------------------

// AppIntent를 위한 미리보기 데이터를 정의하는 확장(extension)입니다.
extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀" // 스마일 이모지로 설정
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩" // 별눈 이모지로 설정
        return intent
    }
}

// Xcode 캔버스에서 위젯을 미리보기 위한 코드입니다.
#Preview(as: .systemMedium) {
    // .systemSmall 크기의 위젯을 미리보기합니다.
    WeatherWidget()
} timeline: {
    // 미리보기 타임라인에 사용할 데이터를 정의합니다.
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
