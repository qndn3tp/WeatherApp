//
//  WeeklyWeatherView.swift
//  Weather
//
//  Created by 김건혜 on 9/4/25.
//

import SwiftUI

// MARK: - 주간 날씨 차트 뷰
struct WeeklyWeatherView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = WeeklyWeatherViewModel()

    // MARK: - Body
    var body: some View {
        VStack(spacing: 10) {
            // title
            HStack {
                Text("주간 날씨")
                    .font(.titleSmall)
                    .foregroundStyle(.textSecondary)
                    .padding(.top, 10)
                Spacer()
            }
            .padding(.leading, 50)
            
            // 주간 날씨 데이터 표
            VStack(spacing: 5) {
                // 헤더 행 (라벨)
                WeeklyLabelView()
                
                // 데이터 표
                if viewModel.isLoading {
                    // 로딩 중일 때 스켈레톤 UI 표시
                    ForEach(0..<7) { _ in
                        WeeklyWeatherRowView(weather: nil)
                            .redacted(reason: .placeholder)
                    }
                } else {
                    // 1. viewModel의 weeklyWeather 배열을 직접 순회
                    ForEach(viewModel.weeklyWeather) { item in
                        WeeklyWeatherRowView(weather: item)
                        
                        // 2. 현재 아이템이 마지막 아이템이 아니라면 Divider를 추가
                        if item.id != viewModel.weeklyWeather.last?.id {
                            Divider()
                                .background(.borderPrimary)
                                .padding(.horizontal, 50)
                        }
                    }
                }
            }
        }
        .task {
            await viewModel.fetchWeeklyWeather()
        }
    }
}

// MARK: - 상단 라벨 뷰
struct WeeklyLabelView: View {
    var body: some View {
        HStack(spacing: 30) {
            /// 왼쪽: 빈 공간 (날짜 영역)
            Text("")
                .frame(width: 50)
            
            /// 중간: 오전/오후 라벨
            HStack(spacing: 15) {
                /// 오전
                HStack(spacing: 10) {
                    Text("")
                        .frame(width: 30)
                    Text("오전")
                        .font(.captionMedium)
                        .frame(width: 20)
                }
                /// 오후
                HStack(spacing: 10) {
                    Text("오후")
                        .font(.captionMedium)
                        .frame(width: 20)
                    Text("")
                        .frame(width: 30)
                }
            }
            .frame(width: 140)
            
            /// 오른쪽: 최저/최고 라벨
            HStack(spacing: 4) {
                Text("최저")
                    .font(.captionMedium)
                Text("/")
                    .font(.captionMedium)
                Text("최고")
                    .font(.captionMedium)
            }
            .frame(width: 70)
        }
        .foregroundStyle(.textTertiary)
    }
}

// MARK: - 주간 날씨 차트 각 행
struct WeeklyWeatherRowView: View {
    let weather: WeeklyWeatherData?
    
    var body: some View {
        HStack(spacing: 30) {
            /// 왼쪽: 날짜 정보
            VStack(alignment: .center, spacing: 3) {
                Text(weather?.dayOfWeek ?? "오늘")
                    .font(.buttonMedium)
                    .foregroundStyle(.textSecondary)
                Text(weather?.date ?? "00.00")
                    .font(.captionMedium)
                    .foregroundStyle(.textTertiary)
            }
            .frame(width: 50)
            
            /// 중간: 날씨 정보
            HStack(spacing: 15) {
                /// 오전
                HStack(spacing: 10) {
                    Text("\(weather?.morningRainPop ?? 0)%")
                        .font(.buttonMedium)
                        .foregroundStyle(.buttonPrimary)
                        .frame(width: 30)
                    Image(systemName: "\(weather?.morningWeatherIcon ?? "sun.max")")
                        .font(.system(size: 20))
                        .foregroundStyle(.gray)
                        .frame(width: 20)
                }
                /// 오후
                HStack(spacing: 10) {
                    Image(systemName: "\(weather?.afternoonWeatherIcon ?? "sun.max")")
                        .font(.system(size: 20))
                        .foregroundStyle(.gray)
                        .frame(width: 20)
                    Text("\(weather?.afternoonRainPop ?? 0)%")
                        .font(.buttonMedium)
                        .foregroundStyle(.buttonPrimary)
                        .frame(width: 30)
                }
            }
            .frame(width: 140)
            
            /// 오른쪽: 기온 정보
            HStack(spacing: 4) {
                Text("\(weather?.lowTemp ?? 0)°")
                    .font(.buttonLarge)
                    .foregroundStyle(.buttonPrimary)
                Text("/")
                    .font(.captionSmall)
                Text("\(weather?.highTemp ?? 0)°")
                    .font(.buttonLarge)
                    .foregroundStyle(.textDanger)
            }
            .frame(width: 70)
        }
        .frame(height: 36)
        .padding(.bottom, 5)
    }
}
