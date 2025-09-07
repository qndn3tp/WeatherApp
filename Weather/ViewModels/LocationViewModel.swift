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
    
    // LocationManager의 모든 중요 상태를 구독
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var cityName: String?
    @Published var currentTime: String?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Initialization
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        setupSubscriptions()
    }
    
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
        locationManager.$currentTime
            .receive(on: DispatchQueue.main)
            .assign(to: \.currentTime, on: self)
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
