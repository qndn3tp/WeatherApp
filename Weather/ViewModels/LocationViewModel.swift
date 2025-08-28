//
//  LocationViewModel.swift
//  Weather
//
//  Created by 김건혜 on 8/28/25.
//

import SwiftUI
import Combine
import CoreLocation

// MARK: HomeView와 연결된 ViewModel 레이어
/// LocationManager의 상태를 View에 적합한 형태로 가공하고 비즈니스 로직을 처리
class LocationViewModel: ObservableObject {
    
    // MARK: - Properties
    private var locationManager: LocationManager
    private var cancellables = Set<AnyCancellable>()
    /// LocationManager의 상태 변화를 구독하여  업데이트
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    // MARK: - Initialization
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self.authorizationStatus = locationManager.authorizationStatus
        
        // LocationManager의 상태 변화를 구독, 동기화
        locationManager.$authorizationStatus
            .receive(on: DispatchQueue.main)
            .assign(to: \.authorizationStatus, on: self)
            .store(in: &cancellables)
    }
    
    // MARK: - Computed Properties (Business Logic)
    
    /// 위치 정보를 표시할지 결정하는 비즈니스 로직
    var shouldShowLocationInfo: Bool {
        authorizationStatus == .authorizedWhenInUse
    }
    
    /// 권한 상태에 따른 사용자에게 표시할 메시지
    var statusMessage: String {
        switch authorizationStatus {
        case .notDetermined:
            return "위치 권한을 요청해주세요."
        case .denied:
            return "설정에서 위치 권한을 허용해주세요."
        case .authorizedWhenInUse:
            return ""
        default:
            return "위치 권한 상태를 알 수 없습니다."
        }
    }
    
    // MARK: - Data Access Layer

    // LocationManager의 데이터 읽기 전용 접근
    var cityName: String? {
        locationManager.cityName
    }
    
    var currentTime: String? {
        locationManager.currentTime
    }
}
