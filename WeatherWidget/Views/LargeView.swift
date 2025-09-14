//
//  LargeView.swift
//  Weather
//
//  Created by 김건혜 on 9/15/25.
//

import SwiftUI

// MARK: 큰 크기 위젯 (4x4)
struct LargeView: View {
    
    var entry: SimpleEntry
    
    // MARK: - Initialization
    // 주간 날씨 더미데이터
    let weeklyWeather: [WeeklyWeather] = [
        WeeklyWeather(
            dayOfWeek: "오늘",
            date: "9.1",
            morningRainPop: 30,
            afternoonRainPop: 30,
            morningWeatherIcon: "umbrella",
            afternoonWeatherIcon: "umbrella",
            lowTemp: 25,
            highTemp: 34
        ),
        WeeklyWeather(
            dayOfWeek: "내일",
            date: "9.2",
            morningRainPop: 10,
            afternoonRainPop: 50,
            morningWeatherIcon: "umbrella",
            afternoonWeatherIcon: "umbrella",
            lowTemp: 23,
            highTemp: 32
        ),
        WeeklyWeather(
            dayOfWeek: "화",
            date: "9.3",
            morningRainPop: 60,
            afternoonRainPop: 80,
            morningWeatherIcon: "umbrella",
            afternoonWeatherIcon: "umbrella",
            lowTemp: 20,
            highTemp: 27
        ),
        WeeklyWeather(
            dayOfWeek: "수",
            date: "9.4",
            morningRainPop: 0,
            afternoonRainPop: 20,
            morningWeatherIcon: "umbrella",
            afternoonWeatherIcon: "umbrella",
            lowTemp: 22,
            highTemp: 35
        )
    ]
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            // 중간 크기 위젯
            MediumView(entry: entry)
            
            // 이번주 날씨
            VStack(spacing: 10) {
                // 가로 구분선
                Rectangle()
                    .fill(.textInverse)
                    .frame(height: 1)
                
                // 이번주 날씨
                ForEach(weeklyWeather.indices, id: \.self) { index in
                    let weather = weeklyWeather[index]
                    HStack(spacing: 30) {
                        /// 왼쪽: 날짜 정보
                        VStack(alignment: .center, spacing: 3) {
                            Text("\(weather.dayOfWeek)")
                                .font(.buttonMedium)
                                .foregroundStyle(.textSecondary)
                            Text("\(weather.date)")
                                .font(.captionMedium)
                                .foregroundStyle(.textTertiary)
                        }
                        .frame(width: 50)
                        
                        /// 중간: 날씨 정보
                        HStack(spacing: 10) {
                            /// 오전
                            HStack(spacing: 5) {
                                Text("\(weather.morningRainPop)%")
                                    .font(.buttonMedium)
                                    .foregroundColor(.buttonPrimary)
                                Image(systemName: "\(weather.morningWeatherIcon)")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                            }
                            /// 오후
                            HStack(spacing: 5) {
                                Image(systemName: "\(weather.afternoonWeatherIcon)")
                                    .font(.system(size: 20))
                                    .foregroundColor(.gray)
                                Text("\(weather.afternoonRainPop)%")
                                    .font(.buttonMedium)
                                    .foregroundColor(.buttonPrimary)
                            }
                        }
                        .frame(width: 140)
                        
                        /// 오른쪽: 기온 정보
                        HStack(spacing: 4) {
                            Text("\(weather.lowTemp)°")
                                .font(.buttonLarge)
                                .foregroundColor(.buttonPrimary)
                            Text("/")
                                .font(.captionSmall)
                            Text("\(weather.highTemp)°")
                                .font(.buttonLarge)
                                .foregroundColor(.textDanger)
                        }
                        .frame(width: 70)
                    }
                }
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 15)
        }
    }
}


// MARK: - 주간 날씨 데이터 struct
struct WeeklyWeather: Identifiable {
    let id = UUID()
    let dayOfWeek: String
    let date: String
    let morningRainPop: Int
    let afternoonRainPop: Int
    let morningWeatherIcon: String
    let afternoonWeatherIcon: String
    let lowTemp: Int
    let highTemp: Int
}
