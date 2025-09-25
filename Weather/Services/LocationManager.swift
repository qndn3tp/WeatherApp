//
//  LocationManager.swift
//  Weather
//
//  Created by Your Name on 2025/08/21.
//

import Foundation
import CoreLocation

// MARK: - 위치 관리자: 위치, 시간 관리
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // MARK: - Properties
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()                 // 도시 이름을 가져오기 위한 클래스
    
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var currentLocation: CLLocation?
    @Published var isUpdatingLocation = false
    @Published var locationError: String?
    @Published var timeZone: TimeZone?  // 현재 위치의 시간대
    @Published var cityName: String? {
        didSet {
            // 값이 변경될 때마다 위젯 공유 저장소에 저장(위젯과 위치 공유)
            SharedLocationData.shared.saveCityName(cityName)
            print("도시 업데이트: \(cityName ?? "nil")")
        }
    }
        
    // MARK: - Initializer
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced // 배터리 효율을 위해 정확도를 낮춤
        authorizationStatus = locationManager.authorizationStatus
        locationManager.requestWhenInUseAuthorization()             // 앱 사용 중 위치 권한 요청
    }
    
    // MARK: - 위치 업데이트
    // 위치 업데이트 시작
    public func startUpdatingLocation() {
        print("📍 위치 업데이트 시작")
        guard authorizationStatus == .authorizedWhenInUse ||
                authorizationStatus == .authorizedAlways else {
            print("📍 권한 없음")
            return
        }
        
        isUpdatingLocation = true
        locationManager.startUpdatingLocation()
        
        // 타임아웃 설정 (10초)
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self] in
            if self?.isUpdatingLocation == true {
                print("📍 위치 업데이트 타임아웃")
                self?.stopUpdatingLocation()
                self?.locationError = "위치를 가져올 수 없습니다"
            }
        }
    }
    // 위치 업데이트 종료
    public func stopUpdatingLocation() {
        print("📍 위치 업데이트 중지")
        isUpdatingLocation = false
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - 위치 권한 상태 변경 시 호출
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("📍 권한 변경: \(status.rawValue)")
        self.authorizationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
    
    // MARK: - 위치가 업데이트될 때 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        print("📍 위치 업데이트됨: \(location.coordinate)")
        
        // 즉시 업데이트
        self.currentLocation = location
        
        // 첫 번째 위치를 받으면 업데이트 중지 (배터리 절약)
        stopUpdatingLocation()
        
        // 역지오코딩
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if let error = error {
                    print("📍 역지오코딩 실패: \(error)")
                    self.locationError = "위치 정보 변환 실패"
                    return
                }
                
                guard let placemark = placemarks?.first else {
                    self.locationError = "위치 정보를 찾을 수 없음"
                    return
                }
                
                // 도시 이름 업데이트
                if let city = placemark.locality {
                    self.cityName = city
                    print("📍 도시명 업데이트: \(city)")
                } else {
                    self.cityName = "도시를 찾을 수 없음"
                }
                
                // 시간대 저장하고 시간 업데이트
                if let timezone = placemark.timeZone {
                    self.timeZone = timezone
                    print("📍 시간대 설정: \(timezone.identifier)")
                } else {
                    self.timeZone = nil
                }
                
                // 에러 초기화
                self.locationError = nil
            }
        }
    }
    
    // MARK: - 위치 업데이트 실패 시 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 업데이트 실패: \(error.localizedDescription)")
        DispatchQueue.main.async { [weak self] in
            self?.isUpdatingLocation = false
            self?.locationError = error.localizedDescription
        }
    }
    
    // MARK: - 앱 생명주기 관리
    // 포그라운드
    func resumeServices() {
        print("⏰ 포그라운드 진입 - 위치 재시작")
        startUpdatingLocation()
    }
    // 백그라운드/종료
    func pauseServices() {
        print("⏰ 백그라운드 진입 - 위치 정지")
        stopUpdatingLocation()
    }
    
    // MARK: - Deinitializer
    deinit {
        NotificationCenter.default.removeObserver(self)
        locationManager.stopUpdatingLocation()
    }
}
