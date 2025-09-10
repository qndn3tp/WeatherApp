//
//  CurrentWeatherDetailView.swift
//  Weather
//
//  Created by 김건혜 on 8/31/25.
//

import SwiftUI

// MARK: - 현재 날씨 부가정보 뷰
struct CurrentWeatherDetailView: View {
    // MARK: - Initialization
    let currentWeatherDetailsData: [CurrentWeatherDetail] = [
        CurrentWeatherDetail(category: .feelsLike, intValue: 33),
        CurrentWeatherDetail(category: .humidity, intValue: 40),
        CurrentWeatherDetail(category: .rainPop, intValue: 50),
        CurrentWeatherDetail(category: .fineDust, stringValue: "좋음")
    ]

    // MARK: - Body
    var body: some View {
        HStack(spacing: 15) {
            ForEach(currentWeatherDetailsData, id: \.category) { detail in
                CurrentWeatherDetailCard(weatherDetail: detail)
            }
        }
        .padding(.vertical, 15)
    }
}

// MARK: - 현재 날씨 부가정보 카드 뷰
struct CurrentWeatherDetailCard: View {
    // MARK: - Properties
    let weatherDetail: CurrentWeatherDetail
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 4) {
            /// 상단: 카테고리를 나타내는 아이콘
            Image(systemName: weatherDetail.icon)
                .font(.system(size: 30))
                .frame(width: 30, height: 30) // 정사각형 프레임
                .foregroundColor(weatherDetail.iconColor)
            
            /// 중간: 실제 값 (메인 정보)
            Text(weatherDetail.value)
                .font(.buttonLarge)
                .foregroundStyle(.textSecondary)
            
            /// 하단: 라벨 (부가 설명)
            Text(weatherDetail.label)
                .font(.captionMedium)
                .foregroundStyle(.textTertiary)
        }
        .frame(width: 70, height: 80)
        .background(ColorPalette.blue10)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - 현재 날씨 부가정보 카테고리 열거형
enum CurrentWeatherDetailCategory: String, CaseIterable {
    case feelsLike = "체감온도"
    case humidity = "습도"
    case rainPop = "강수확률"
    case fineDust = "미세먼지"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .feelsLike: return "thermometer.variable"
        case .humidity: return "humidity"
        case .rainPop: return "umbrella"
        case .fineDust: return "face.smiling"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .feelsLike: return .red.opacity(0.5)
        case .humidity: return .blue.opacity(0.5)
        case .rainPop: return .gray.opacity(0.5)
        case .fineDust: return .green.opacity(0.5)
        }
    }
}

// MARK: - 현재 날씨 부가정보 struct
struct CurrentWeatherDetail {
    let category: CurrentWeatherDetailCategory
    private let intValue: Int?
    private let stringValue: String?
    
    // 생성자들
    init(category: CurrentWeatherDetailCategory, intValue: Int) {
        self.category = category
        self.intValue = intValue
        self.stringValue = nil
    }
    
    init(category: CurrentWeatherDetailCategory, stringValue: String) {
        self.category = category
        self.intValue = nil
        self.stringValue = stringValue
    }
    
    // computed properties
    var icon: String { category.icon }
    var iconColor: Color { category.iconColor }
    var label: String { category.rawValue }
    
    var value: String {
        if let intValue = intValue {
            switch category {
            case .feelsLike:
                return "\(intValue)°"
            case .humidity, .rainPop:
                return "\(intValue)%"
            case .fineDust:
                return "\(intValue)"
            }
        } else if let stringValue = stringValue {
            return stringValue
        }
        return ""
    }
}
