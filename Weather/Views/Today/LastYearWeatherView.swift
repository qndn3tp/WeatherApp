//
//  LastYearWeatherView.swift
//  Weather
//
//  Created by 김건혜 on 8/31/25.
//

import SwiftUI

// MARK: - 작년 일주일 날씨 정보 뷰
struct LastYearWeatherView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .lastTextBaseline, spacing: 6) {
                Text("과거 날씨")
                    .font(.titleSmall)
                    .foregroundStyle(.textSecondary)
                Text("작년 오늘의 날씨는?")
                    .font(.captionSmall)
                    .foregroundStyle(.textTertiary)
            }
            
            Text("2024년 9월 1주차")
                .font(.bodySmall)
                .foregroundStyle(.textTertiary)
                .padding(.top, 10)
            
            HStack(spacing: 20) {
                // 각 카드가 서로 다른 날짜를 보여주도록
                ForEach(0..<7, id: \.self) { index in
                    LastYearWeatherCard(dayIndex: index)
                }
            }
        }
        .padding(.horizontal, 26)
        .padding(.vertical, 15)
    }
}

// MARK: - 작년 일주일 날씨 정보 카드 뷰
struct LastYearWeatherCard: View {
    
    // 어떤 날짜를 보여줄지 결정하는 인덱스
    let dayIndex: Int
    
    // MARK: - Properties 작년 날씨 데이터
    let lastYearWeatherData = LastYearWeather(
        dates: ["8/22", "8/23", "8/24", "8/25", "8/26", "8.27", "8.28"],
        highTemps: [29, 28, 27, 28, 29, 30, 31],
        lowTemps: [26, 25, 24, 25, 26, 27, 28],
        rainAmounts: [30, 0, 0, 20, 0, 0, 0],
        icons: ["cloud.rain", "sun.max", "sun.max", "cloud.rain", "sun.max", "sun.max", "cloud.rain"]
    )
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 4) {
            // 날짜
            Text(lastYearWeatherData.dates[dayIndex])
                .font(.system(size: 8))
                .foregroundColor(.white)
                .padding(.horizontal, 5)
                .padding(.vertical, 2)
                .background(.black.opacity(0.6))
                .clipShape(Capsule())
            
            // 날씨 아이콘
            Image(systemName: lastYearWeatherData.icons[dayIndex])
                .font(.system(size: 20))
            
            // 기온 정보
            VStack(spacing: 3) {
                /// 최고기온
                Text("\(lastYearWeatherData.highTemps[dayIndex])°")
                    .font(.captionMedium)
                    .foregroundColor(.textDanger)
                
                /// 최저기온
                Text("\(lastYearWeatherData.lowTemps[dayIndex])°")
                    .font(.captionMedium)
                    .foregroundColor(.buttonPrimary)
                
                /// 강수량
                Text("\(lastYearWeatherData.rainAmounts[dayIndex])mm")
                    .font(.captionSmall)
                    .foregroundColor(.borderPrimary)
            }
        }
    }
}

// MARK: - 작년 날씨 정보 struct
struct LastYearWeather {
    let dates: [String]
    let highTemps: [Int]
    let lowTemps: [Int]
    let rainAmounts: [Int]
    let icons: [String]
//    let conditions : [String]
    
    // TODO: 컨디션-날씨 아이콘 매핑 로직
    // TODO: date time으로 받아오면 포맷팅 다시
}
