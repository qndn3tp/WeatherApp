//
//  CurrentWeatherDetailView.swift
//  Weather
//
//  Created by 김건혜 on 8/31/25.
//

import SwiftUI

// MARK: - 현재 날씨 부가정보 뷰
struct CurrentWeatherDetailView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = CurrentWeatherDetailViewModel()
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 15) {
            // 1. 데이터가 비어있다면, 스켈레톤 UI
            if viewModel.weatherDetails.isEmpty {
                ForEach(0..<4) { _ in
                    CurrentWeatherDetailCard(weatherDetailItem: nil)
                        .redacted(reason: .placeholder)
                }
            } else {
                // 2. 데이터 로딩 완료
                ForEach(viewModel.weatherDetails, id: \.label) { item in
                    CurrentWeatherDetailCard(weatherDetailItem: item)
                }
            }
        }
        .padding(.vertical, 15)
        .task {
            await viewModel.fetchCurrentWeatherDetails()
        }
    }
}

// MARK: - 현재 날씨 부가정보 카드 뷰
struct CurrentWeatherDetailCard: View {
    let weatherDetailItem: CurrentWeatherDetailItem?
    
    var body: some View {
        VStack(spacing: 4) {
            // 옵셔널 체이닝을 사용해 nil일 경우 기본값을 보여줍니다.
            Image(weatherDetailItem?.icon ?? "questionmark.circle")
                .frame(width: 30, height: 30)
            
            Text(weatherDetailItem?.formattedValue ?? "")
                .font(.buttonLarge)
                .foregroundStyle(.textSecondary)
            
            Text(weatherDetailItem?.label ?? "")
                .font(.captionMedium)
                .foregroundStyle(.textTertiary)
        }
        .frame(width: 70, height: 80)
        .background(ColorPalette.blue10)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
