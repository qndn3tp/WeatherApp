//
//  HourlyWeatherChart.swift
//  Weather
//
//  Created by 김건혜 on 9/17/25.
//

// MARK: - Today 뷰의 시간별 날씨 데이터
import Foundation

// '한 시간'에 대한 모든 데이터를 담는 모델
struct HourlyWeatherItem: Identifiable {
    let id = UUID() // 각 아이템을 고유하게 식별
    let hour: Int
    let temp: Int
    let icon: String
    let rainPop: Int
    let rainAmount: Int
    let humidity: Int
    let windSpeed: Int
}
