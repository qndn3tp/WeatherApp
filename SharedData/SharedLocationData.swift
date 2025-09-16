//
//  SharedLocationData.swift
//  Weather
//
//  Created by 김건혜 on 9/15/25.
//

import Foundation


// MARK: - 메인앱-위젯 위치 데이터 공유
class SharedLocationData {
    // 공유 저장소
    static let shared = SharedLocationData()
    
    private let appGroupID = "group.com.geonhye.Weather"
    
    // UserDefaults가 사용될 때 생성 및 초기화
    private lazy var sharedDefaults: UserDefaults? = UserDefaults(suiteName: appGroupID)
    
    // 앱 전체에 하나의 인스턴스 보장
    private init() {}
    
    // cityName 저장
    func saveCityName(_ cityName: String?) {
        sharedDefaults?.set(cityName, forKey: "shared_city_name")
        sharedDefaults?.synchronize()
    }
    
    // cityName 불러오기
    func getCityName() -> String? {
        let cityName = sharedDefaults?.string(forKey: "shared_city_name")
        return cityName
    }
}
