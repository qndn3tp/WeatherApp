//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by 김건혜 on 8/31/25.
//

import SwiftUI

// MARK: - 현재 날씨 정보(메인)
struct CurrentWeatherView: View {
    
    // MARK: - Properties 오늘 날씨 데이터
    let currentWeatherData = CurrentWeather(
        /// 메인 화면용 데이터
        weatherCondition: "가벼운 비",
        weatherIcon: "cloud.rain",
        mainTemp: 26,
        tempDiffFromYesterday: -2,
        highTemp: 34,
        lowTemp: 20,
        weatherComments: ["심한 일교차", "겉옷은 필수!"]
    )
    
    var tempDifferenceComment: String {
        if currentWeatherData.tempDiffFromYesterday > 0 {
            return "어제보다 \(currentWeatherData.tempDiffFromYesterday)° ↑"
        } else if currentWeatherData.tempDiffFromYesterday < 0 {
            return "어제보다 \(abs(currentWeatherData.tempDiffFromYesterday))° ↓"
        } else {
            return "어제와 비슷해요"
        }
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 48) {
            // 왼쪽: 아바타
            Image("avatar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 190)
            
            // 오른쪽: 현재 날씨 정보
            VStack(alignment: .trailing, spacing: 5) {
                // 상단: 날씨 아이콘과 상태
                HStack(spacing: 10) {
                    Image(systemName: currentWeatherData.weatherIcon)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    Text(currentWeatherData.weatherCondition)
                        .font(.bodySmall)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 15)
                
                // 중간: 현재 온도
                Text("\(currentWeatherData.mainTemp)°")
                    .font(.weatherLarge)
                
                // 하단: 부가 정보 (어제 비교, 최고/최저 온도, 오늘 날씨 한줄 코멘트)
                Text(tempDifferenceComment)
                    .font(.bodySmall)
                HStack(alignment: .bottom, spacing: 2) {
                    Text("최고").font(.bodySmall)
                    Text("\(currentWeatherData.highTemp)°").font(.bodyMedium)
                    Text("최저").font(.bodySmall)
                    Text("\(currentWeatherData.lowTemp)°").font(.bodyMedium)
                }
                .padding(.bottom, 14)
                HStack(spacing: 3) {
                    Text(currentWeatherData.weatherComments.joined(separator: ", "))
                        .font(.captionMedium)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                    Image("icon_logo_bee")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
    }
}

// MARK: - TodayWeather struct
struct CurrentWeather {
    // 메인 화면용 데이터
    let weatherCondition: String   /// 현재 날씨 (예: "맑음")
    let weatherIcon: String
    let mainTemp: Int
    let tempDiffFromYesterday: Int /// 어제와의 기온차이
    let highTemp: Int
    let lowTemp: Int
    let weatherComments: [String]  /// 코멘트 (예: "오늘 외출하기 좋아요!")
}
