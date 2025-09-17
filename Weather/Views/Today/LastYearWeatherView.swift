//
//  LastYearWeatherView.swift
//  Weather
//
//  Created by 김건혜 on 8/31/25.
//

import SwiftUI

// MARK: - 작년 일주일 날씨 정보 뷰
struct LastYearWeatherView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = LastYearWeatherViewModel()
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .lastTextBaseline, spacing: 6) {
                // title
                Text("과거 날씨")
                    .font(.titleSmall)
                    .foregroundStyle(.textSecondary)
                Text("작년 오늘의 날씨는?")
                    .font(.captionSmall)
                    .foregroundStyle(.textTertiary)
                Spacer()
            }
            
            // 작년 날짜
            HStack {
                Text("2024년 9월 1주차")
                    .font(.bodySmall)
                    .foregroundStyle(.textTertiary)
                    .padding(.top, 10)
                
                Spacer()
            }
            
            // 작년 일주일 치 날씨 데이터
            if viewModel.lastYearWeather.isEmpty {
                // 데이터가 없는 경우
                HStack(spacing: 20) {
                    ForEach(0..<7) { _ in
                        LastYearWeatherCard(lastYearWeather: nil)
                            .redacted(reason: .placeholder)
                    }
                }
            } else {
                // 데이터 로딩 완료
                HStack(spacing: 20) {
                    ForEach(viewModel.lastYearWeather) { item in
                        LastYearWeatherCard(lastYearWeather: item)
                    }
                }
            }
        }
        .padding(.horizontal, 26)
        .padding(.vertical, 15)
        .task {
            await viewModel.fetchLastYearWeather()
        }
    }
}

// MARK: - 작년 일주일 날씨 정보 카드 뷰
struct LastYearWeatherCard: View {
    
    let lastYearWeather: LastYearWeatherItem?
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 4) {
            // 날짜
            Text(lastYearWeather?.date ?? "")
                .font(.system(size: 8))
                .foregroundStyle(.white)
                .padding(.horizontal, 5)
                .padding(.vertical, 2)
                .background(.black.opacity(0.6))
                .clipShape(Capsule())
            
            // 날씨 아이콘
            Image(systemName: lastYearWeather?.icon ?? "questionmark.circle")
                .font(.system(size: 20))
            
            // 기온 정보
            VStack(spacing: 3) {
                /// 최고기온
                Text("\(lastYearWeather?.highTemp ?? 0)°")
                    .font(.captionMedium)
                    .foregroundStyle(.textDanger)
                
                /// 최저기온
                Text("\(lastYearWeather?.lowTemp ?? 0)°")
                    .font(.captionMedium)
                    .foregroundStyle(.buttonPrimary)
                
                /// 강수량
                Text("\(lastYearWeather?.rainAmount ?? 0)mm")
                    .font(.captionSmall)
                    .foregroundStyle(.borderPrimary)
            }
        }
    }
}
