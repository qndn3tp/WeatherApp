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
        VStack(alignment: .leading) {
            HStack(spacing: 6) {
                Text("과거 날씨")
                    .font(.system(size: 14, weight: .medium))
                Text("작년 오늘의 날씨는?")
                    .font(.system(size: 8, weight: .thin))
            }
            HStack(spacing: 15) {
                HStack(spacing: 15) {
                    // 각 카드가 서로 다른 날짜를 보여주도록
                    ForEach(0..<5, id: \.self) { index in
                        LastYearWeatherCard(dayIndex: index)
                    }
                }
            }
        }
    }
}

// MARK: - 작년 일주일 날씨 정보 카드 뷰
struct LastYearWeatherCard: View {
    
    // 어떤 날짜를 보여줄지 결정하는 인덱스
    let dayIndex: Int
    
    // MARK: - Properties 작년 날씨 데이터
    let lastYearWeatherData = LastYearWeather(
        date: ["8/22", "8/23", "8/24", "8/25", "8/26"],
        highTemp: [29, 28, 27, 28, 29],
        lowTemp: [26, 25, 24, 25, 26],
        rainAmount: [30, 0, 0, 20, 0],
        weatherIcon: ["cloud.rain", "sun.max", "sun.max", "cloud.rain", "sun.max"]
    )
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            // 날짜
            Text(lastYearWeatherData.date[dayIndex])
                .font(.system(size: 8))
                .foregroundColor(.white)
                .padding(.horizontal, 5)
                .padding(.vertical, 2)
                .background(.black.opacity(0.6))
                .clipShape(Capsule())
            
            HStack(spacing: 5) {
                // 날씨 아이콘
                Image(systemName: lastYearWeatherData.weatherIcon[dayIndex])
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                
                // 기온 정보
                VStack(spacing: 4) {
                    /// 최고기온
                    Text("\(lastYearWeatherData.highTemp[dayIndex])°")
                        .font(.system(size: 8))
                        .foregroundColor(.red)
                    
                    /// 최저기온
                    Text("\(lastYearWeatherData.lowTemp[dayIndex])°")
                        .font(.system(size: 8))
                        .foregroundColor(.blue)
                    
                    /// 강수량
                    Text("\(lastYearWeatherData.rainAmount[dayIndex])mm")
                        .font(.system(size: 6))
                        .foregroundColor(.green)
                }
            }
        }
    }
}

// MARK: - 작년 날씨 정보 struct
struct LastYearWeather {
    let date: [String]
    let highTemp: [Int]
    let lowTemp: [Int]
    let rainAmount: [Int]
    let weatherIcon: [String]
}
