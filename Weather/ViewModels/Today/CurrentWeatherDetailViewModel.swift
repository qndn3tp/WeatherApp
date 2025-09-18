//
//  CurrentWeatherDetailViewModel.swift
//  Weather
//
//  Created by 김건혜 on 9/17/25.
//

import Foundation

// MARK: - Today 뷰의 현재 날씨 디테일 데이터(체감온도, 습도, 강수확률, 미세먼지)
@MainActor
class CurrentWeatherDetailViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var weatherDetails: [CurrentWeatherDetailItem] = []
    
    // TODO: API 통신 코드 작성
    // 특정시간 마다 fetch하도록 캐시 필요
    // 데이터를 가져오는 함수
    func fetchCurrentWeatherDetails() async {
        weatherDetails = [
            .feelsLike(temperature: 33),
            .humidity(percentage: 40),
            .rainPop(percentage: 50),
            .fineDust(grade: "좋음")
        ]
    }
}
