//
//  LastYearWeather.swift
//  Weather
//
//  Created by 김건혜 on 9/17/25.
//

// MARK: - 작년 날씨 데이터
struct LastYearWeatherItem: Identifiable {
    var id: String { date }   // 날짜가 고유하므로 date를 id로 사용
    let date: String
    let highTemp: Int
    let lowTemp: Int
    let rainAmount: Int
    let icon: String
}
