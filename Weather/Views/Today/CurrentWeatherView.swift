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
    @StateObject private var viewModel = CurrentWeatherViewModel()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // 데이터가 있는 경우
            if let currentWeatherData = viewModel.currentWeatherData {
                // 애니메이션 백그라운드
                WeatherAnimationBackground(weatherCondition: currentWeatherData.weatherCondition)
                
                HStack(spacing: 35) {
                    // 왼쪽: 아바타
                    Image("avatar")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 220)
                    
                    // 오른쪽: 현재 날씨 정보
                    VStack(alignment: .trailing, spacing: 15) {
                        // 상단: 날씨 아이콘과 상태
                        HStack(spacing: 10) {
                            Image(systemName: currentWeatherData.weatherIcon)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.gray)
                            Text(currentWeatherData.weatherCondition)
                                .font(.bodySmall)
                                .foregroundStyle(.textTertiary)
                        }
                        
                        // 중간: 현재온도, 부가 정보 (어제 비교, 최고/최저 온도)
                        VStack(alignment: .trailing, spacing: 5) {
                            /// 현재 온도
                            Text("\(currentWeatherData.mainTemp)°")
                                .font(.weatherLarge)
                                .foregroundStyle(.textPrimary)
                            
                            ///어제 온도와 비교
                            Text(viewModel.tempDifferenceComment)
                                .font(.bodySmall)
                                .foregroundStyle(.textTertiary)
                            
                            /// 최고/최저 온도
                            HStack(alignment: .bottom, spacing: 2) {
                                Text("최고").font(.bodySmall)
                                Text("\(currentWeatherData.highTemp)°").font(.bodyMedium)
                                Text("최저").font(.bodySmall)
                                Text("\(currentWeatherData.lowTemp)°").font(.bodyMedium)
                            }
                            .foregroundStyle(.textSecondary)
                        }
                        
                        // 하단: 오늘 날씨 한줄 코멘트
                        HStack(spacing: 5) {
                            Text(currentWeatherData.weatherComments.joined(separator: ", "))
                                .font(.system(size: 11))
                                .fixedSize(horizontal: true, vertical: false)
                                .foregroundStyle(.textSecondary)
                                .padding(.horizontal, 10)
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
                            Image("icon_logo_bee")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                .padding(.vertical, 20)
            } else {
                // TODO: 실패하는 경우 뷰 처리
                // 데이터가 아직 없는 경우
                ProgressView()
            }
        }
        .task {
            await viewModel.fetchCurrentWeather()
        }
    }
}
