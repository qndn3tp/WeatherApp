//
//  animationBackground.swift
//  Weather
//
//  Created by 김건혜 on 9/8/25.
//

import SwiftUI

// MARK: - 날씨 타입 정의
enum WeatherAnimationType {
    case rainy
    case snowy
    case cloudy
    case clear
    case windy
    case thunderStorm

    static func from(weatherCondition: String) -> WeatherAnimationType {
        if weatherCondition.contains("비") || weatherCondition.contains("rain") {
            return .rainy
        } else if weatherCondition.contains("눈") || weatherCondition.contains("snow") {
            return .snowy
        } else if weatherCondition.contains("구름") || weatherCondition.contains("흐림") || weatherCondition.contains("cloud") {
            return .cloudy
        } else if weatherCondition.contains("바람") || weatherCondition.contains("wind") {
            return .windy
        } else if weatherCondition.contains("천둥") || weatherCondition.contains("번개") || weatherCondition.contains("thunder") {
            return .thunderStorm
        } else {
            return .clear
        }
    }
}

// MARK: - 애니메이션 백그라운드
struct WeatherAnimationBackground: View {
    let weatherCondition: String

    var animationType: WeatherAnimationType {
        WeatherAnimationType.from(weatherCondition: weatherCondition)
    }

    var body: some View {
        ZStack {
            // 날씨별 애니메이션
            Group {
                switch animationType {
                case .rainy:
                    RainyAnimationView()
                case .snowy:
                    SnowyAnimationView()
                case .cloudy:
                    CloudyAnimationView()
                case .windy:
                    WindyAnimationView()
                case .thunderStorm:
                    ThunderstormAnimationView()
                case .clear:
                    EmptyView()
                }
            }
        }
    }
}
