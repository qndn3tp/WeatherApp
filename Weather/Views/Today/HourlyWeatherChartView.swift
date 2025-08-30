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
        hour: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23],
        hourlyTemp: [20, 20, 21, 22, 23, 24, 25, 26, 27, 28, 28, 27, 26, 25, 24, 23, 22, 21, 20, 20, 19, 19, 19, 18],
        hourlyWeatherIcon: ["moon", "moon", "cloud", "cloud", "cloud", "sun.min", "sun.max", "sun.max", "sun.max", "sun.max", "sun.max", "sun.max", "sun.max", "cloud.sun", "cloud.sun", "cloud", "cloud", "cloud", "cloud", "cloud", "cloud", "cloud", "cloud", "cloud"],
        hourlyRainPop: [0, 0, 0, 30, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        hourlyRainAmounts: [0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        hourlyHumidity: [80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 99, 98, 97, 96]
    )

    // MARK: - 기온 Chart Properties
    @State private var chartColor: Color = Color(red: 0x80 / 255, green: 0xB2 / 255, blue: 0x86 / 255).opacity(0.5)
    @State private var showGradient = true
    @State private var gradientRange = 0.0

    private var gradient: Gradient {
        var colors = [chartColor]
        if showGradient {
            colors.append(chartColor.opacity(gradientRange))
        }
        return Gradient(colors: colors)
    }

    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ZStack(alignment: .topLeading) {
                HStack(spacing: 0) {
                    // 왼쪽 라벨 영역 (고정)
                    VStack(alignment: .leading, spacing: 8) {
                        // 시간
                        Text("오늘")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                            .frame(height: 18)
                            .padding(.vertical, 2)
                            .padding(.horizontal, 5)
                            .background(.black.opacity(0.7))
                            .clipShape(Capsule())

                        Spacer()
                            .frame(height: 30)

                        Spacer()
                            .frame(height: 30)

                        // 강수확률
                        Text("강수확률")
                            .font(.system(size: 16))

                        // 강수량
                        Text("강수량")
                            .font(.system(size: 16))
                        // 습도
                        Text("습도")
                            .font(.system(size: 16))
                    }
                    .frame(width: 60)

                    // 시간별 차트
                    ForEach(Array(hourlyWeatherData.hourlyTemp.enumerated()), id: \.offset) { index, _ in
                        VStack(spacing: 8) {
                            // 시간
                            Text("\(hourlyWeatherData.hour[index])시")
                                .font(.system(size: 13))
                                .frame(height: 18)

                            // 날씨 아이콘
                            Image(systemName: hourlyWeatherData.hourlyWeatherIcon[index])
                                .font(.system(size: 20))
                                .frame(height: 30)

                            // 기온
                            Text("\(hourlyWeatherData.hourlyTemp[index])°")
                                .font(.system(size: 16))
                                .frame(height: 30)

                            // 강수확률
                            Text("\(hourlyWeatherData.hourlyRainPop[index])%")
                                .font(.system(size: 16))

                            // 강수량
                            Text("\(hourlyWeatherData.hourlyRainAmounts[index])")
                                .font(.system(size: 16))

                            // 습도
                            Text("\(hourlyWeatherData.hourlyHumidity[index])")
                                .font(.system(size: 16))
                        }
                        .frame(width: UIScreen.main.bounds.width / 7)
                    }
                }
                // 기온 면적 차트
                Chart(Array(hourlyWeatherData.hourlyTemp.enumerated()), id: \.offset) { index, _ in
                    AreaMark(
                        x: .value("Hour", hourlyWeatherData.hour[index]),
                        y: .value("Temperature", hourlyWeatherData.hourlyTemp[index])
                    )
                    .foregroundStyle(gradient)
                    .interpolationMethod(.catmullRom)
                }
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .frame(height: 8 + 30 + 8) /// spacing + spacer + 기온높이 + spacing = 46
                .offset(
                    x: 60,            /// 라벨 영역 너비만큼 오른쪽으로 이동
                    y: 18 + 8 + 30    /// 시간 + spacing + 아이콘 높이 = 56px
                )
            }
        }
    }
}

// MARK: - 시간별 날씨 데이터 Struct
struct HourlyWeather {
    /// 차트용 데이터
    let hour: [Int]
    let hourlyTemp: [Int]
    let hourlyWeatherIcon: [String]
    let hourlyRainPop: [Int]
    let hourlyRainAmounts: [Int]
    let hourlyHumidity: [Int]
}
