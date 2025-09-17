//
//  HourlyWeatherChartViewModel.swift
//  Weather
//
//  Created by 김건혜 on 9/17/25.
//

// ViewModels/HourlyWeatherChartViewModel.swift
import Foundation

@MainActor
class HourlyWeatherChartViewModel: ObservableObject {
    
    @Published var hourlyWeather: [HourlyWeatherItem] = []
    
    // 로딩, 에러 관리
    @Published var isLoading: Bool = false
    
    func fetchHourlyWeather() async {
        isLoading = true
        
        // TODO: 나중에 API를 호출하고, 받아온 데이터를 [HourlyWeatherItem]으로 디코딩
        // 목업 데이터
        hourlyWeather = [
            HourlyWeatherItem(hour: 0, temp: 20, icon: "moon", rainPop: 0, rainAmount: 0, humidity: 80, windSpeed: 1),
            HourlyWeatherItem(hour: 1, temp: 20, icon: "moon", rainPop: 0, rainAmount: 0, humidity: 81, windSpeed: 1),
            HourlyWeatherItem(hour: 2, temp: 21, icon: "cloud", rainPop: 0, rainAmount: 0, humidity: 82, windSpeed: 1),
            HourlyWeatherItem(hour: 3, temp: 22, icon: "cloud", rainPop: 30, rainAmount: 2, humidity: 83, windSpeed: 2),
            HourlyWeatherItem(hour: 4, temp: 23, icon: "cloud", rainPop: 30, rainAmount: 2, humidity: 84, windSpeed: 2),
            HourlyWeatherItem(hour: 5, temp: 24, icon: "sun.min", rainPop: 30, rainAmount: 2, humidity: 85, windSpeed: 2),
            HourlyWeatherItem(hour: 6, temp: 25, icon: "sun.max", rainPop: 0, rainAmount: 0, humidity: 86, windSpeed: 0),
            HourlyWeatherItem(hour: 7, temp: 26, icon: "sun.max", rainPop: 0, rainAmount: 0, humidity: 87, windSpeed: 0),
            HourlyWeatherItem(hour: 8, temp: 27, icon: "sun.max", rainPop: 0, rainAmount: 0, humidity: 88, windSpeed: 0),
            HourlyWeatherItem(hour: 9, temp: 28, icon: "sun.max", rainPop: 0, rainAmount: 0, humidity: 89, windSpeed: 0),
            HourlyWeatherItem(hour: 10, temp: 28, icon: "sun.max", rainPop: 0, rainAmount: 0, humidity: 90, windSpeed: 1),
            HourlyWeatherItem(hour: 11, temp: 27, icon: "sun.max", rainPop: 0, rainAmount: 0, humidity: 91, windSpeed: 1),
            HourlyWeatherItem(hour: 12, temp: 26, icon: "sun.max", rainPop: 0, rainAmount: 0, humidity: 92, windSpeed: 0),
            HourlyWeatherItem(hour: 13, temp: 25, icon: "cloud.sun", rainPop: 0, rainAmount: 0, humidity: 93, windSpeed: 0),
            HourlyWeatherItem(hour: 14, temp: 24, icon: "cloud.sun", rainPop: 0, rainAmount: 0, humidity: 94, windSpeed: 0),
            HourlyWeatherItem(hour: 15, temp: 23, icon: "cloud", rainPop: 0, rainAmount: 0, humidity: 95, windSpeed: 0),
            HourlyWeatherItem(hour: 16, temp: 22, icon: "cloud", rainPop: 0, rainAmount: 0, humidity: 96, windSpeed: 0),
            HourlyWeatherItem(hour: 17, temp: 21, icon: "cloud", rainPop: 0, rainAmount: 0, humidity: 97, windSpeed: 0),
            HourlyWeatherItem(hour: 18, temp: 20, icon: "cloud", rainPop: 0, rainAmount: 0, humidity: 98, windSpeed: 0),
            HourlyWeatherItem(hour: 19, temp: 20, icon: "cloud", rainPop: 0, rainAmount: 0, humidity: 99, windSpeed: 0),
            HourlyWeatherItem(hour: 20, temp: 19, icon: "cloud", rainPop: 0, rainAmount: 0, humidity: 99, windSpeed: 0),
            HourlyWeatherItem(hour: 21, temp: 19, icon: "cloud", rainPop: 0, rainAmount: 0, humidity: 98, windSpeed: 0),
            HourlyWeatherItem(hour: 22, temp: 19, icon: "cloud", rainPop: 0, rainAmount: 0, humidity: 97, windSpeed: 0),
            HourlyWeatherItem(hour: 23, temp: 18, icon: "cloud", rainPop: 0, rainAmount: 0, humidity: 96, windSpeed: 0)
        ]
        
        // 시간 순으로 정렬
        hourlyWeather = hourlyWeather.sorted { $0.hour < $1.hour }
        
        isLoading = false
    }
}
