//
//  CurrentWeather.swift
//  Weather
//
//  Created by 김건혜 on 9/16/25.
//

// MARK: - Today 뷰의 현재 날씨 데이터
struct CurrentWeather: Codable {
    // 메인 화면용 데이터
    let weatherCondition: String   /// 현재 날씨 (예: "맑음")
    let weatherIcon: String
    let mainTemp: Int
    let tempDiffFromYesterday: Int /// 어제와의 기온차이
    let highTemp: Int
    let lowTemp: Int
    let weatherComments: [String]  /// 코멘트 (예: "오늘 외출하기 좋아요!")
    
    // TODO: computed property로 매핑
    //    var weatherIcon: String { /* 매핑 로직 */ }
    //    var weatherComments: [String] { /* 매핑 로직 */ }
}
