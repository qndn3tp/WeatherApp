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
        CurrentWeatherDetail(icon: "face.smiling", value: "좋음", label: "미세먼지", iconColor: .green.opacity(0.5)),
        CurrentWeatherDetail(icon: "thermometer.variable", value: "33°", label: "체감온도", iconColor: .red.opacity(0.5)),
        CurrentWeatherDetail(icon: "umbrella", value: "50%", label: "강수확률", iconColor: .gray.opacity(0.5)),
        CurrentWeatherDetail(icon: "humidity", value: "40%", label: "습도", iconColor: .blue.opacity(0.5))
    ]

    // MARK: - Body
    var body: some View {
        HStack(spacing: 18) {
            ForEach(currentWeatherDetailsData, id: \.label) { detail in
                CurrentWeatherDetailCard(weatherDetail: detail)
            }
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 15)
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
                .font(.system(size: 30))
                .foregroundColor(weatherDetail.iconColor)
                .padding(.bottom, 4)
            
            /// 중간: 실제 값 (메인 정보)
            Text(weatherDetail.value)
                .font(.buttonLarge)
            
            /// 하단: 라벨 (부가 설명)
            Text(weatherDetail.label)
                .font(.captionMedium)
        }
        .frame(width: 70, height: 80)
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
