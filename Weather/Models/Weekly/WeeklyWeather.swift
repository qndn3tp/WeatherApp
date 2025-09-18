//
//  WeeklyWeather.swift
//  Weather
//
//  Created by 김건혜 on 9/18/25.
//

import Foundation

// MARK: - Weekly뷰의 주간 날씨 차트 데이터
struct WeeklyWeatherData: Identifiable {
    var id: String { date } // date를 고유 식별자로 사용
    let dayOfWeek: String
    let date: String
    let morningRainPop: Int
    let afternoonRainPop: Int
    let morningWeatherIcon: String
    let afternoonWeatherIcon: String
    let lowTemp: Int
    let highTemp: Int
    
    // TODO: computed properties로 아이콘 매핑
}
