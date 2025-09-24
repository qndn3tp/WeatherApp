//
//  WeatherIcons.swift
//  Weather
//
//  Created by 김건혜 on 9/22/25.
//

// MARK: - 날씨 아이콘
enum WeatherType: String, CaseIterable {
    case clear = "맑음"
    case partlyCloudy = "구름조금"
    case partlyRainy = "비조금"
    case windy = "바람"
    //    case thunderstorm = "뇌우"
    case drizzle = "이슬비"
    case rainy = "비"
    case heavyRain = "폭우"
    case cloudy = "흐림"
    case lightSnow = "가벼운눈"
    case snowy = "눈"
    case heavySnow = "폭설"
    
    // MARK: - Helper
    private var commonImageName: String {
        switch self {
        case .rainy: return "cloud.rain"
        case .drizzle: return "cloud.drizzle"
        case .heavyRain: return "cloud.heavyrain"
        case .windy: return "wind"
        case .cloudy: return "cloud"
        case .lightSnow: return "cloud.sleet.fill"
        case .snowy: return "cloud.snow"
        case .heavySnow: return "snowflake"
        default: return "cloud"  // fallback
        }
    }
    
    var dayImageName: String {
        switch self {
        case .clear: return "sun.max"
        case .partlyCloudy: return "cloud.sun"
        case .partlyRainy: return "cloud.sun.rain"
        default: return commonImageName
        }
    }
    
    var nightImageName: String {
        switch self {
        case .clear: return "moon.stars"
        case .partlyCloudy: return "cloud.moon"
        case .partlyRainy: return "cloud.moon.rain"
        default: return commonImageName
        }
    }
}

// 사용법
//let weather = WeatherType.clear
//let isDay = true
//Image(systemName: isDay ? weather.dayImageName : weather.nightImageName)
