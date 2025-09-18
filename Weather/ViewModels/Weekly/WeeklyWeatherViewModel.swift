//
//  WeeklyWeatherViewModel.swift
//  Weather
//
//  Created by 김건혜 on 9/18/25.
//

import Foundation

// MARK: - Weekly 뷰의 주간 날씨 차트 데이터

@MainActor
class WeeklyWeatherViewModel: ObservableObject {
    
    @Published var weeklyWeather: [WeeklyWeatherData] = []
    @Published var isLoading: Bool = false
    
    // TODO: 나중에 API를 호출하고 [WeeklyWeatherData]로 디코딩
    func fetchWeeklyWeather() async {
        isLoading = true
        
        weeklyWeather = [
            WeeklyWeatherData(
                dayOfWeek: "오늘",
                date: "9.1",
                morningRainPop: 30,
                afternoonRainPop: 30,
                morningWeatherIcon: "umbrella",
                afternoonWeatherIcon: "umbrella",
                lowTemp: 25,
                highTemp: 34
            ),
            WeeklyWeatherData(
                dayOfWeek: "내일",
                date: "9.2",
                morningRainPop: 10,
                afternoonRainPop: 50,
                morningWeatherIcon: "umbrella",
                afternoonWeatherIcon: "umbrella",
                lowTemp: 23,
                highTemp: 32
            ),
            WeeklyWeatherData(
                dayOfWeek: "화",
                date: "9.3",
                morningRainPop: 60,
                afternoonRainPop: 80,
                morningWeatherIcon: "umbrella",
                afternoonWeatherIcon: "umbrella",
                lowTemp: 20,
                highTemp: 27
            ),
            WeeklyWeatherData(
                dayOfWeek: "수",
                date: "9.4",
                morningRainPop: 0,
                afternoonRainPop: 20,
                morningWeatherIcon: "umbrella",
                afternoonWeatherIcon: "umbrella",
                lowTemp: 22,
                highTemp: 35
            ),
            WeeklyWeatherData(
                dayOfWeek: "목",
                date: "9.5",
                morningRainPop: 40,
                afternoonRainPop: 70,
                morningWeatherIcon: "umbrella",
                afternoonWeatherIcon: "umbrella",
                lowTemp: 19,
                highTemp: 28
            ),
            WeeklyWeatherData(
                dayOfWeek: "금",
                date: "9.6",
                morningRainPop: 10,
                afternoonRainPop: 10,
                morningWeatherIcon: "umbrella",
                afternoonWeatherIcon: "umbrella",
                lowTemp: 24,
                highTemp: 36
            ),
            WeeklyWeatherData(
                dayOfWeek: "토",
                date: "9.7",
                morningRainPop: 20,
                afternoonRainPop: 30,
                morningWeatherIcon: "umbrella",
                afternoonWeatherIcon: "umbrella",
                lowTemp: 26,
                highTemp: 33
            )
        ]
        
        isLoading = false
    }
}

