//
//  LastYearWeatherViewModel.swift
//  Weather
//
//  Created by 김건혜 on 9/17/25.
//

import Foundation

// MARK: - Today 뷰의 작년 날씨 데이터
@MainActor
class LastYearWeatherViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var lastYearWeather: [LastYearWeatherItem] = []
    
    // TODO: API 통신 코드 작성
    // 특정시간 마다 fetch하도록 캐시 필요
    func fetchLastYearWeather() async {
        lastYearWeather = [
            LastYearWeatherItem(date: "8/22", highTemp: 29, lowTemp: 26, rainAmount: 30, icon: "cloud.rain"),
            LastYearWeatherItem(date: "8/23", highTemp: 28, lowTemp: 25, rainAmount: 0, icon: "sun.max"),
            LastYearWeatherItem(date: "8/24", highTemp: 27, lowTemp: 24, rainAmount: 0, icon: "sun.max"),
            LastYearWeatherItem(date: "8/25", highTemp: 28, lowTemp: 25, rainAmount: 20, icon: "cloud.rain"),
            LastYearWeatherItem(date: "8/26", highTemp: 29, lowTemp: 26, rainAmount: 0, icon: "sun.max"),
            LastYearWeatherItem(date: "8/27", highTemp: 30, lowTemp: 27, rainAmount: 0, icon: "sun.max"),
            LastYearWeatherItem(date: "8/28", highTemp: 31, lowTemp: 28, rainAmount: 0, icon: "cloud.rain")
        ]
    }
}
