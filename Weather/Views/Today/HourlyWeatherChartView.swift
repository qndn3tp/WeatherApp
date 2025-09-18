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
    
    // MARK: - Properties
    @StateObject private var viewModel = HourlyWeatherChartViewModel()
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if viewModel.isLoading {
                // 1. 데이터가 로딩중, 스켈레톤 UI
                HStack(spacing: 0) {
                    TodayLeftLabelView()
                    
                    Rectangle()
                        .fill(.borderTertiary)
                        .frame(width: 1)
                    
                    // 스켈레톤 UI
                    ForEach(0..<5) { _ in
                        VStack(spacing: 10) {
                            Text("시").frame(height: 18)
                            Image(systemName: "circle").frame(height: 30).padding(.bottom, 10)
                            Text("00°").frame(height: 30)
                            Text("-").frame(height: 6)
                            Text("0")
                            Text("0")
                            Text("0")
                        }
                        .frame(width: UIScreen.main.bounds.width / 7)
                    }
                    .redacted(reason: .placeholder)
                }
            } else {
                // 2. 데이터 로딩 완료
                ZStack(alignment: .topLeading) {
                    HStack(spacing: 0) {
                        // 왼쪽 라벨 영역
                        TodayLeftLabelView()
                        
                        // 세로 구분선
                        Rectangle()
                            .fill(.borderTertiary)
                            .frame(width: 1)
                        
                        // 시간별 차트
                        ForEach(viewModel.hourlyWeather) { item in
                            VStack(spacing: 10) {
                                // 시간
                                Text("\(item.temp)시")
                                    .font(.buttonMedium)
                                    .foregroundStyle(.textSecondary)
                                    .frame(height: 18)
                                
                                Image(systemName: item.icon)
                                    .font(.system(size: 20))
                                    .frame(height: 30)
                                    .padding(.bottom, 10)
                                
                                Text("\(item.temp)°")
                                    .font(.bodySmall)
                                    .foregroundStyle(.textSecondary)
                                    .frame(height: 30)
                                
                                Text(item.rainPop == 0 ? "-" : "\(item.rainPop)%")
                                    .font(.captionSmall)
                                    .foregroundStyle(.borderPrimary)
                                    .frame(height: 6)
                                
                                Text("\(item.rainAmount)")
                                    .font(.bodySmall)
                                    .foregroundStyle(.textTertiary)
                                
                                Text("\(item.humidity)")
                                    .font(.bodySmall)
                                    .foregroundStyle(.borderPrimary)
                                
                                Text("\(item.windSpeed)")
                                    .font(.bodySmall)
                                    .foregroundStyle(.borderPrimary)
                            }
                            .frame(width: UIScreen.main.bounds.width / 7)
                        }
                    }
                    // 기온 면적 차트
                    Chart(viewModel.hourlyWeather) { item in
                        AreaMark(
                            x: .value("Hour", item.hour),
                            y: .value("Temperature", item.temp)
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
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 15)
        .task {
            await viewModel.fetchHourlyWeather()
        }
    }
}

// MARK: - 왼쪽 라벨 뷰
struct TodayLeftLabelView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 시간
            Text("오늘")
                .font(.buttonMedium)
                .foregroundStyle(.textInverse)
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
                    .foregroundStyle(.textSecondary)
                Text("mm")
                    .font(.captionSmall)
                    .foregroundStyle(.textTertiary)
            }
            
            // 습도
            HStack(spacing: 2) {
                Text("습도")
                    .font(.buttonMedium)
                    .foregroundStyle(.textSecondary)
                Text("%")
                    .font(.captionSmall)
                    .foregroundStyle(.textTertiary)
            }
            
            // 바람
            HStack(spacing: 2) {
                Text("바람")
                    .font(.buttonMedium)
                    .foregroundStyle(.textSecondary)
                Text("m/s")
                    .font(.captionSmall)
                    .foregroundStyle(.textTertiary)
            }
        }
        .frame(width: 60)
    }
}
