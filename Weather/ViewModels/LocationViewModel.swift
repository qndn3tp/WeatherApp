//
//  LocationViewModel.swift
//  Weather
//
//  Created by 김건혜 on 8/28/25.
//

import SwiftUI
import Combine
import CoreLocation

// MARK: Location사용하느 View와 연결된 ViewModel 레이어
class LocationViewModel: ObservableObject {
    
    // MARK: - Properties
    private var locationManager: LocationManager
    private var cancellables = Set<AnyCancellable>()
    
    // Time 포맷팅
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    // LocationManager의 모든 중요 상태를 구독
    @Published var authorizationStatus: CLAuthorizationStatus? // 위치 권한
    @Published var cityName: String?     // 도시 이름
    @Published var currentTime: String?  // 도시의 현재 시간
    @Published var currentTimeZone: TimeZone? // 도시의 시간대
    @Published var isDay: Bool = true    // 오후,오전 구분
    @Published var isLoading = false     // 위치 정보 로딩
    @Published var errorMessage: String? // 권한 에러메세지
    
    // MARK: - Initialization
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        setupSubscriptions()
    }
    
    // MARK: - 함수
    private func setupSubscriptions() {
        // 권한 상태 구독
        locationManager.$authorizationStatus
            .receive(on: DispatchQueue.main)
            .assign(to: \.authorizationStatus, on: self)
            .store(in: &cancellables)
        
        // 도시명 구독
        locationManager.$cityName
            .receive(on: DispatchQueue.main)
            .assign(to: \.cityName, on: self)
            .store(in: &cancellables)
        
        // 시간 구독
        Publishers.CombineLatest(locationManager.$currentTime, locationManager.$currentTimeZone)
            .compactMap { ($0, $1) } // 두 값이 모두 nil이 아닐 때만 진행
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (date, timeZone) in
                guard let self = self, let date = date else { return }
                
                // 받아온 timeZone을 DateFormatter에 설정
                self.timeFormatter.timeZone = timeZone ?? .current // nil이면 현재 기기 시간대 사용
                
                // 시간대 설정이 완료된 formatter로 시간 문자열 생성
                self.currentTime = self.timeFormatter.string(from: date)
                
                // isDay 계산
                var calendar = Calendar.current
                calendar.timeZone = timeZone ?? .current // 현지 시간 기준 캘린더
                let hour = calendar.component(.hour, from: date)
                self.isDay = hour >= 6 && hour < 18
            }
            .store(in: &cancellables)
        
        // 로딩 상태 구독
        locationManager.$isUpdatingLocation
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoading, on: self)
            .store(in: &cancellables)
        
        // 에러 상태 구독
        locationManager.$locationError
            .receive(on: DispatchQueue.main)
            .assign(to: \.errorMessage, on: self)
            .store(in: &cancellables)
    }
    
    // 위치 정보를 표시할지 결정하는 비즈니스 로직
    var shouldShowLocationInfo: Bool {
        authorizationStatus == .authorizedWhenInUse && cityName != nil
    }
    
    // 권한 상태에 따른 사용자에게 표시할 메시지
    var statusMessage: String {
        if let error = errorMessage {
            return error
        }
        
        switch authorizationStatus {
        case .notDetermined:
            return "위치 권한을 요청해주세요."
        case .denied:
            return "설정에서 위치 권한을 허용해주세요."
        case .authorizedWhenInUse:
            return isLoading ? "위치 정보를 가져오는 중..." : ""
        default:
            return "위치 권한 상태를 알 수 없습니다."
        }
    }
}
