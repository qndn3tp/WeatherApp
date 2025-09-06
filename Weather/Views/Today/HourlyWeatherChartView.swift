//
//  HourlyWeatherChartView.swift
//  Weather
//
//  Created by 김건혜 on 8/31/25.
//

// Copyright © 2022 Swift Charts Examples.
// Open Source - MIT License
// Modified for Weather App

import SwiftUI
import Charts

// MARK: - 시간별 날씨 차트 뷰
struct HourlyWeatherChartView: View {
    
    // MARK: - 일별 날씨 데이터 Properties
    let hourlyWeatherData = HourlyWeather(
        /// 차트용 데이터 (예시: 24시간 데이터)
        hours: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
        temps: [20, 20, 21, 22, 23, 24, 25, 26, 27, 28, 28, 27, 26, 25, 24, 23, 22, 21, 20, 20, 19, 19, 19, 18],
        icons: ["moon", "moon", "cloud", "cloud", "cloud", "sun.min", "sun.max", "sun.max",
                "sun.max", "sun.max", "sun.max", "sun.max", "sun.max", "cloud.sun",
                "cloud.sun", "cloud", "cloud", "cloud", "cloud", "cloud", "cloud",
                "cloud", "cloud", "cloud"],
        rainPops: [0, 0, 0, 30, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        rainAmounts: [0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        humidities: [80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 99, 98, 97, 96]
    )
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ZStack(alignment: .topLeading) {
                HStack(spacing: 0) {
                    // 왼쪽 라벨 영역 (고정)
                    VStack(alignment: .leading, spacing: 10) {
                        // 시간
                        Text("오늘")
                            .font(.buttonMedium)
                            .foregroundColor(.textInverse)
                            .frame(height: 18)
                            .padding(.horizontal, 7)
                            .background(.buttonSecondary)
                            .clipShape(Capsule())
                        
                        // 날씨 아이콘
                        Spacer()
                            .frame(height: 30)
                            .padding(.bottom, 10)
                        
                        // 기온
                        Spacer()
                            .frame(height: 30)
                        
                        // 강수확률
                        Spacer()
                            .frame(height: 6)
                        
                        // 강수량
                        HStack(spacing: 2) {
                            Text("강수량")
                                .font(.buttonMedium)
                                .foregroundColor(.textSecondary)
                            Text("mm")
                                .font(.captionSmall)
                        }
                        
                        // 습도
                        HStack(spacing: 2) {
                            Text("습도")
                                .font(.buttonMedium)
                                .foregroundColor(.textSecondary)
                            Text("%")
                                .font(.captionSmall)
                        }
                    }
                    .frame(width: 60)
                    
                    // 시간별 차트
                    ForEach(Array(hourlyWeatherData.temps.enumerated()), id: \.offset) { index, _ in
                        VStack(spacing: 10) {
                            // 시간
                            Text("\(hourlyWeatherData.hours[index])시")
                                .font(.buttonMedium)
                                .frame(height: 18)
                            
                            // 날씨 아이콘
                            Image(systemName: hourlyWeatherData.icons[index])
                                .font(.system(size: 20))
                                .frame(height: 30)
                                .padding(.bottom, 10)
                            
                            // 기온
                            Text("\(hourlyWeatherData.temps[index])°")
                                .font(.bodySmall)
                                .foregroundColor(.textSecondary)
                                .frame(height: 30)
                            
                            // 강수확률
                            Text("\(hourlyWeatherData.rainPops[index])%")
                                .font(.captionSmall)
                                .foregroundColor(.borderPrimary)
                                .frame(height: 6)
                            
                            // 강수량
                            Text("\(hourlyWeatherData.rainAmounts[index])")
                                .font(.bodySmall)
                                .foregroundColor(.textTertiary)
                            
                            // 습도
                            Text("\(hourlyWeatherData.humidities[index])")
                                .font(.bodySmall)
                                .foregroundColor(.borderPrimary)
                        }
                        .frame(width: UIScreen.main.bounds.width / 7)
                    }
                }
                // 기온 면적 차트
                Chart(Array(hourlyWeatherData.temps.enumerated()), id: \.offset) { index, _ in
                    AreaMark(
                        x: .value("Hour", hourlyWeatherData.hours[index]),
                        y: .value("Temperature", hourlyWeatherData.temps[index])
                    )
                    .foregroundStyle(LinearGradient(
                        colors: [ColorPalette.blue30.opacity(0.5), ColorPalette.blue30.opacity(0)],
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .interpolationMethod(.catmullRom)
                }
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .frame(height: 10 + 30 + 10) /// spacing  + 기온높이 + spacing
                .offset(
                    x: 60,                 /// 라벨 영역 너비만큼 오른쪽으로 이동
                    y: 18 + 10 + 30  + 5   /// 시간 + spacing + 아이콘 높이 + (아이콘-기온 padding) / 2
                )
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 15)
    }
}

// MARK: - 시간별 날씨 데이터 Struct
struct HourlyWeather {
    /// 차트용 데이터
    let hours: [Int]
    let temps: [Int]
    let icons: [String]
    //    let conditions : ["String"]
    let rainPops: [Int]
    let rainAmounts: [Int]
    let humidities: [Int]
    
    // TODO: computed property로 아이콘 매핑
    //    var hourlyWeatherIcon: [String] {
    //        return hourlyWeatherCondition.map { condition in
    //            switch condition {
    //            case "맑음": return "sun.max"
    //            case "흐림": return "cloud.fill"
    //            case "비": return "cloud.rain"
    //            case "눈": return "cloud.snow"
    //            default: return "cloud"
    //            }
    //        }
    //    }
}
