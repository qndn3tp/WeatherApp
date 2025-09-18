//
//  CurrentWeatherViewModel.swift
//  Weather
//
//  Created by 김건혜 on 9/16/25.
//

import Foundation

// MARK: - Today 뷰의 현재 날씨 데이터
@MainActor
class CurrentWeatherViewModel: ObservableObject {
    
    @Published var currentWeatherData: CurrentWeather?
    
    // 어제와 날씨 비교 로직
    var tempDifferenceComment: String {
        guard let data = currentWeatherData else { return "" }
        
        if data.tempDiffFromYesterday > 0 {
            return "어제보다 \(data.tempDiffFromYesterday)° ↑"
        } else if data.tempDiffFromYesterday < 0 {
            return "어제보다 \(abs(data.tempDiffFromYesterday))° ↓"
        } else {
            return "어제와 비슷해요"
        }
    }
    
    // TODO: API 통신 코드 작성
    // 특정시간 마다 fetch하도록 캐시 필요
    // 데이터를 가져오는 함수
    func fetchCurrentWeather() async {
        
        // 메인 화면용 목업 데이터
        currentWeatherData = CurrentWeather(
            weatherCondition: "번개",
            weatherIcon: "cloud.rain",
            mainTemp: 26,
            tempDiffFromYesterday: -2,
            highTemp: 34,
            lowTemp: 20,
            weatherComments: ["심한 일교차", "겉옷은 필수!"]
        )
    }
}
