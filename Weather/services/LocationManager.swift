//
//  LocationManager.swift
//  Weather
//
//  Created by Your Name on 2025/08/21.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder() // 도시 이름을 가져오기 위한 클래스

    // MARK: - @Published 프로퍼티로 뷰를 업데이트합니다.
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var cityName: String?
    @Published var currentTime: String? // 현재 위치의 시간을 저장할 프로퍼티

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced // 배터리 효율을 위해 정확도를 낮춥니다.
        locationManager.requestWhenInUseAuthorization() // 앱 사용 중 위치 권한 요청
    }
    
    // MARK: - 위치 업데이트 시작을 위한 공개 메서드 추가
    public func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    // MARK: - 위치 권한 상태 변경 시 호출됩니다.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }

    // MARK: - 위치가 업데이트될 때 호출됩니다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        // MARK: - 위도/경도로 도시 이름을 가져오는 역지오코딩 (Reverse Geocoding)
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self, let placemark = placemarks?.first else { return }
            
            // 도시 이름(locality)을 추출
            if let city = placemark.locality {
                self.cityName = city
            } else {
                self.cityName = "도시를 찾을 수 없음"
            }
            
            // MARK: - 현재 위치의 시간 정보를 가져오는 부분
            if let timezone = placemark.timeZone {
                let formatter = DateFormatter()
                formatter.timeZone = timezone
                formatter.dateFormat = "h:mm a" // 12시간제 (예: 11:56 PM)
                self.currentTime = formatter.string(from: Date())
            } else {
                self.currentTime = "시간 정보를 찾을 수 없음"
            }
        }
    }
    
    // MARK: - 위치 업데이트 실패 시 호출됩니다.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 업데이트 실패: \(error.localizedDescription)")
    }
}
