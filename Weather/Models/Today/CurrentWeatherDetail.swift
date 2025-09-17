//
//  CurrentWeatherDetail.swift
//  Weather
//
//  Created by 김건혜 on 9/17/25.
//

// MARK: - Today 뷰에 사용되는 현재 날씨 부가정보 데이터
struct CurrentWeatherDetailDTO: Codable {
    let feelsLike: Int
    let humidity: Int
    let rainPop: Int
    let fineDust: String
}

// MARK: - 현재 날씨 부가정보 아이템 Enum
enum CurrentWeatherDetailItem {
    case feelsLike(temperature: Int)
    case humidity(percentage: Int)
    case rainPop(percentage: Int)
    case fineDust(grade: String)

    // 1. 카테고리 이름 (label)
    var label: String {
        switch self {
        case .feelsLike: return "체감온도"
        case .humidity: return "습도"
        case .rainPop: return "강수확률"
        case .fineDust: return "미세먼지"
        }
    }

    // 2. 아이콘 이름
    var icon: String {
        switch self {
        case .feelsLike: return "icon_weather_detail_feelslike"
        case .humidity: return "icon_weather_detail_humidity"
        case .rainPop: return "icon_weather_detail_rainpop"
        case .fineDust: return "icon_weather_detail_finedust"
        }
    }

    // 3. 포맷팅된 값 (value)
    var formattedValue: String {
        switch self {
        // 연관 값을 바로 꺼내서 사용
        case .feelsLike(let temperature):
            return "\(temperature)°"
        case .humidity(let percentage), .rainPop(let percentage):
            return "\(percentage)%"
        case .fineDust(let grade):
            return grade
        }
    }
}
