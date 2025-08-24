//
//  LocationView.swift
//  Weather
//
//  Created by 김건혜 on 8/13/25.
//
//
//import SwiftUI
//
//struct LocationView: View {
//    var body: some View {
//        Text("위치화면")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//}

// Copyright © 2022 Swift Charts Examples.
// Open Source - MIT License
// Modified for Weather App

import SwiftUI
import Charts

struct LocationView: View {
    
    // MARK: - Properties 일별 날씨 데이터
    let weatherData = [
        WeatherDay(day: "Yester", date: "7.17", icon: "umbrella", highTemp: 27, lowTemp: 25),
        WeatherDay(day: "Today", date: "7.18", icon: "umbrella", highTemp: 30, lowTemp: 25),
        WeatherDay(day: "Fri", date: "7.19", icon: "umbrella", highTemp: 30, lowTemp: 25),
        WeatherDay(day: "Sat", date: "7.20", icon: "umbrella", highTemp: 30, lowTemp: 25),
        WeatherDay(day: "Sun", date: "7.21", icon: "umbrella", highTemp: 30, lowTemp: 25),
        WeatherDay(day: "Mon", date: "7.22", icon: "cloud.bolt", highTemp: 31, lowTemp: 26)
    ]
    
    // MARK: - Chart Properties
    @State private var chartColor: Color = .blue.opacity(0.7)
    @State private var showGradient = true
    @State private var gradientRange = 0.3
    
    // MARK: - Computed Properties
    private var gradient: Gradient {
        var colors = [chartColor]
        if showGradient {
            colors.append(chartColor.opacity(gradientRange))
        }
        return Gradient(colors: colors)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 10) {
            Text("hello")
            // 상단 날씨 정보들
            HStack(spacing: 0) {
                ForEach(Array(weatherData.enumerated()), id: \.offset) { index, weather in
                    VStack(spacing: 8) {
                        Text(weather.day)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.gray)
                        
                        Text(weather.date)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.gray)
                        
                        Image(systemName: weather.icon)
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                            .frame(height: 30)
                        
                        Text("\(weather.highTemp)°")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                        
                        Text("\(weather.lowTemp)°")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            
            // Area Chart
            Chart(weatherData, id: \.date) { weather in
                AreaMark(
                    x: .value("Date", weather.date),
                    y: .value("Temperature", weather.highTemp)
                )
                .foregroundStyle(gradient)
                .interpolationMethod(.catmullRom) // 부드러운 곡선
                
            
                LineMark(
                    x: .value("Date", weather.date),
                    y: .value("Temperature", weather.highTemp)
                )
                .lineStyle(StrokeStyle(lineWidth: 2))
                .interpolationMethod(.catmullRom)
                .foregroundStyle(.black)
            }
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            .frame(height: 70)
        }
    }
}

// MARK: - Struct
struct WeatherDay {
    let day: String
    let date: String
    let icon: String
    let highTemp: Int
    let lowTemp: Int
}

// MARK: - Preview
#Preview {
    LocationView()
}
