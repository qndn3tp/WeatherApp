//
//  WeeklyWeatherView.swift
//  Weather
//
//  Created by 김건혜 on 9/4/25.
//

import SwiftUI

// MARK: - 주간 날씨 차트 뷰
struct WeeklyWeatherView: View {
    
    // MARK: - Initialization
    // 주간 날씨 더미데이터
    let weeklyWeatherData: [WeeklyWeatherData] = [
        WeeklyWeatherData(
            dayOfWeek: "오늘",
            date: "9.1",
            morningRainPop: 30,
            afternoonRainPop: 30,
            morningWeatherIcon: "umbrella",
            afternoonWeatherIcon: "umbrella",
            lowTemp: 25,
            highTemp: 34
        ),
        WeeklyWeatherData(
            dayOfWeek: "내일",
            date: "9.2",
            morningRainPop: 10,
            afternoonRainPop: 50,
            morningWeatherIcon: "umbrella",
            afternoonWeatherIcon: "umbrella",
            lowTemp: 23,
            highTemp: 32
        ),
        WeeklyWeatherData(
            dayOfWeek: "화",
            date: "9.3",
            morningRainPop: 60,
            afternoonRainPop: 80,
            morningWeatherIcon: "umbrella",
            afternoonWeatherIcon: "umbrella",
            lowTemp: 20,
            highTemp: 27
        ),
        WeeklyWeatherData(
            dayOfWeek: "수",
            date: "9.4",
            morningRainPop: 0,
            afternoonRainPop: 20,
            morningWeatherIcon: "umbrella",
            afternoonWeatherIcon: "umbrella",
            lowTemp: 22,
            highTemp: 35
        ),
        WeeklyWeatherData(
            dayOfWeek: "목",
            date: "9.5",
            morningRainPop: 40,
            afternoonRainPop: 70,
            morningWeatherIcon: "umbrella",
            afternoonWeatherIcon: "umbrella",
            lowTemp: 19,
            highTemp: 28
        ),
        WeeklyWeatherData(
            dayOfWeek: "금",
            date: "9.6",
            morningRainPop: 10,
            afternoonRainPop: 10,
            morningWeatherIcon: "umbrella",
            afternoonWeatherIcon: "umbrella",
            lowTemp: 24,
            highTemp: 36
        ),
        WeeklyWeatherData(
            dayOfWeek: "토",
            date: "9.7",
            morningRainPop: 20,
            afternoonRainPop: 30,
            morningWeatherIcon: "umbrella",
            afternoonWeatherIcon: "umbrella",
            lowTemp: 26,
            highTemp: 33
        )
    ]
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("주간 날씨")
                .font(.titleSmall)
                .foregroundStyle(.textSecondary)
                .padding(.top, 10)
            // 주간 날씨 데이터 표
            VStack(spacing: 5) {
                // 헤더 행 (라벨)
                HStack(spacing: 30) {
                    /// 왼쪽: 빈 공간 (날짜 영역)
                    Text("")
                        .frame(width: 50)
                    
                    /// 중간: 오전/오후 라벨
                    HStack(spacing: 15) {
                        /// 오전
                        HStack(spacing: 10) {
                            Text("")
                                .frame(width: 30)
                            Text("오전")
                                .font(.captionMedium)
                                .frame(width: 20)
                        }
                        /// 오후
                        HStack(spacing: 10) {
                            Text("오후")
                                .font(.captionMedium)
                                .frame(width: 20)
                            Text("")
                                .frame(width: 30)
                        }
                    }
                    .frame(width: 140)
                    
                    /// 오른쪽: 최저/최고 라벨
                    HStack(spacing: 4) {
                        Text("최저")
                            .font(.captionMedium)
                        Text("/")
                            .font(.captionMedium)
                        Text("최고")
                            .font(.captionMedium)
                    }
                    .frame(width: 70)
                }
                .foregroundStyle(.textTertiary)
                
                // 데이터 표
                ForEach(weeklyWeatherData.indices, id: \.self) { index in
                    let weeklyWeather = weeklyWeatherData[index]
                    
                    HStack(spacing: 30) {
                        /// 왼쪽: 날짜 정보
                        VStack(alignment: .center, spacing: 3) {
                            Text("\(weeklyWeather.dayOfWeek)")
                                .font(.buttonMedium)
                                .foregroundStyle(.textSecondary)
                            Text("\(weeklyWeather.date)")
                                .font(.captionMedium)
                                .foregroundStyle(.textTertiary)
                        }
                        .frame(width: 50)
                        
                        /// 중간: 날씨 정보
                        HStack(spacing: 15) {
                            /// 오전
                            HStack(spacing: 10) {
                                Text("\(weeklyWeather.morningRainPop)%")
                                    .font(.buttonMedium)
                                    .foregroundColor(.buttonPrimary)
                                    .frame(width: 30)
                                Image(systemName: "\(weeklyWeather.morningWeatherIcon)")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                            }
                            /// 오후
                            HStack(spacing: 10) {
                                Image(systemName: "\(weeklyWeather.afternoonWeatherIcon)")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                                    .frame(width: 20)
                                Text("\(weeklyWeather.afternoonRainPop)%")
                                    .font(.buttonMedium)
                                    .foregroundColor(.buttonPrimary)
                                    .frame(width: 30)
                            }
                        }
                        .frame(width: 140)
                        
                        /// 오른쪽: 기온 정보
                        HStack(spacing: 4) {
                            Text("\(weeklyWeather.lowTemp)°")
                                .font(.buttonLarge)
                                .foregroundColor(.buttonPrimary)
                            Text("/")
                                .font(.captionSmall)
                            Text("\(weeklyWeather.highTemp)°")
                                .font(.buttonLarge)
                                .foregroundColor(.textDanger)
                        }
                        .frame(width: 70)
                    }
                    .frame(height: 36)
                    .padding(.bottom, 5)
                    // 구분선
                    .overlay(
                        /// 마지막이 아닐 때만 구분선 적용
                        index < weeklyWeatherData.count - 1 ?
                        AnyView(
                            Rectangle()
                                .fill(Color(red: 96 / 255, green: 142 / 255, blue: 210 / 255).opacity(0.5))
                                .frame(height: 1)
                        ) : AnyView(EmptyView()),
                        alignment: .bottom
                    )
                }
            }
            
        }
    }
}

// MARK: - 주간 날씨 데이터 struct
struct WeeklyWeatherData: Identifiable {
    let id = UUID()
    let dayOfWeek: String
    let date: String
    let morningRainPop: Int
    let afternoonRainPop: Int
    let morningWeatherIcon: String
    let afternoonWeatherIcon: String
    let lowTemp: Int
    let highTemp: Int
    
    // TODO: computed properties로 아이콘 매핑
    //    var morningWeatherIcon: String {
    //        weatherConditionToIcon(morningWeatherCondition)
    //    }
    //
    //    var afternoonWeatherIcon: String {
    //        weatherConditionToIcon(afternoonWeatherCondition)
    //    }
    
    //    private func weatherConditionToIcon(_ condition: String) -> String {
    //        switch condition {
    //        case "맑음": return "sun.max"
    //        case "구름많음": return "cloud.sun"
    //        case "흐림": return "cloud.fill"
    //        case "비": return "cloud.rain"
    //        case "눈": return "cloud.snow"
    //        default: return "cloud"
    //        }
    //    }
}
