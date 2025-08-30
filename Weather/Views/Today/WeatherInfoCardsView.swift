//
//  WeatherInfoCardsView.swift
//  Weather
//
//  Created by 김건혜 on 8/31/25.
//

import SwiftUI

// MARK: - 데일리 날씨 부가 정보 뷰
struct WeatherInfoCardsView: View {
    var body: some View {
        HStack(spacing: 16) {
            // 미세먼지
            WeatherInfoCard(icon: "face.smiling", value: "좋음", label: "미세먼지", iconColor: .green.opacity(0.5))
            // 체감온도
            WeatherInfoCard(icon: "thermometer.variable", value: "33°", label: "체감온도", iconColor: .red.opacity(0.5))
            // 강수확률
            WeatherInfoCard(icon: "umbrella", value: "50%", label: "강수확률", iconColor: Color.gray.opacity(0.5))
            // 습도
            WeatherInfoCard(icon: "humidity", value: "40%", label: "습도", iconColor: Color.blue.opacity(0.5))
        }
    }
}

// MARK: - 날씨 정보 카드 뷰
struct WeatherInfoCard: View {
    let icon: String
    let value: String
    let label: String
    let iconColor: Color
    
    var body: some View {
        VStack {
            /// 상단: 카테고리를 나타내는 아이콘
            Image(systemName: icon)
                .font(.system(size: 26))
                .foregroundColor(iconColor)
            
            /// 중간: 실제 값 (메인 정보)
            Text(value)
                .font(.system(size: 14, weight: .medium))
            
            /// 하단: 라벨 (부가 설명)
            Text(label)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.black.opacity(0.03))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
