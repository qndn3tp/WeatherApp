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
    let currentWeatherDetailsData: [CurrentWeatherDetail] = [
        CurrentWeatherDetail(icon: "face.smiling", value: "좋음", label: "미세먼지", iconColor: .green),
        CurrentWeatherDetail(icon: "thermometer.variable", value: "33°", label: "체감온도", iconColor: .red),
        CurrentWeatherDetail(icon: "umbrella", value: "50%", label: "강수확률", iconColor: .gray),
        CurrentWeatherDetail(icon: "humidity", value: "40%", label: "습도", iconColor: .blue)
    ]

    // MARK: - Body
    var body: some View {
        HStack(spacing: 16) {
            ForEach(currentWeatherDetailsData, id: \.label) { detail in
                CurrentWeatherDetailCard(weatherDetail: detail)
            }
        }
    }
}

// MARK: - 현재 날씨 부가정보 카드 뷰
struct CurrentWeatherDetailCard: View {
    // MARK: - Properties
    let weatherDetail: CurrentWeatherDetail
    
    // MARK: - Body
    var body: some View {
        VStack {
            /// 상단: 카테고리를 나타내는 아이콘
            Image(systemName: weatherDetail.icon)
                .font(.system(size: 20))
                .foregroundColor(weatherDetail.iconColor)
            
            /// 중간: 실제 값 (메인 정보)
            Text(weatherDetail.value)
                .font(.system(size: 14, weight: .medium))
            
            /// 하단: 라벨 (부가 설명)
            Text(weatherDetail.label)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.black.opacity(0.03))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - 현재 날씨 부가정보 struct
struct CurrentWeatherDetail: Identifiable {
    let id = UUID()
    let icon: String
    let value: String
    let label: String
    let iconColor: Color
}
