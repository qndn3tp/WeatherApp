//
//  MediumView.swift
//  Weather
//
//  Created by 김건혜 on 9/13/25.
//

import SwiftUI

struct MediumView: View {
    
    // MARK: - Properties
    var entry: SimpleEntry
    
    private let comments = [
        "심한 일교차, 겉옷은 필수!",
        "작은 우산 하나 챙기는 게 좋아"
    ]
    
    // MARK: - Properties 작년 날씨 데이터
    let hourlyWeather = HourlyWeather(
        hours: [15, 16, 17, 18, 19],
        temps: [29, 28, 27, 28, 29],
        rainAmounts: [30, 0, 0, 20, 0],
        icons: ["cloud.rain", "sun.max", "sun.max", "cloud.rain", "sun.max"]
    )
    
    var body: some View {
        HStack(spacing: 11) {
            // 왼쪽: 현재 날씨
            CurrentWeatherView()
            
            // 세로 구분선
            Rectangle()
                .fill(.textInverse)
                .frame(width: 1)
            
            // 오른쪽: 아바타 코멘트, 시간별 날씨
            VStack(spacing: 10) {
                // 아바타 코멘트
                HStack(alignment: .top, spacing: 11) {
                    // 코멘트
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(comments, id: \.self) { comment in
                            Text(comment)
                                .font(.system(size: 11))
                                .foregroundStyle(.textSecondary)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .frame(minWidth: 140)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.backgroundPrimary)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 5,
                            bottomLeadingRadius: 5,
                            bottomTrailingRadius: 1,
                            topTrailingRadius: 5
                        )
                    )
                    // 아바타
                    Image("icon_avatar_profile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 38, height: 47)
                        .clipShape(Capsule())
                }
                
                // 시간별 날씨
                HStack(spacing: 0) {
                    ForEach(hourlyWeather.hours.indices, id: \.self) { index in
                        VStack(spacing: 4) {
                            // 날짜
                            Text("\(hourlyWeather.hours[index])시")
                                .font(.buttonSmall)
                                .foregroundColor(.textSecondary)
                            
                            // 날씨 아이콘
                            Image(systemName: hourlyWeather.icons[index])
                                .font(.system(size: 20))
                            
                            // 최고기온
                            Text("\(hourlyWeather.temps[index])°")
                                .font(.buttonMedium)
                            
                            // 강수량
                            Text(hourlyWeather.rainAmounts[index] == 0 ? "-"
                                 : "\(hourlyWeather.rainAmounts[index])mm")
                            .font(.captionSmall)
                            .foregroundColor(.borderPrimary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(minWidth: 200)
                .lineLimit(1)
            }
        }
        .minimumScaleFactor(0.8)
        .padding(.vertical, 15)
        .padding(.trailing, 17)
        .padding(.leading, 10)
    }
}

// MARK: - 작년 날씨 정보 struct
struct HourlyWeather {
    let hours: [Int]
    let temps: [Int]
    let rainAmounts: [Int]
    let icons: [String]
}
