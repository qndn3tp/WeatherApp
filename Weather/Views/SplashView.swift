//
//  SplashView.swift
//  Weather
//
//  Created by 김건혜 on 8/15/25.
//
import SwiftUI
import CoreLocation

// MARK: - SplashView (로딩 로직 담당)
struct SplashView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            Color(red: 0xF8 / 255, green: 0xFC / 255, blue: 0xFF / 255)
                .ignoresSafeArea()
            if isLoading {
                // 로딩 중일 때 표시할 UI
                Text("로딩 중...")
                    .onAppear {
                        startLocationProcess()
                    }
            } else {
                // 로딩 완료 후 표시할 메인 화면
                ContentView(locationManager: locationManager)
            }
        }
        .onReceive(locationManager.$authorizationStatus) { status in
            handleLocationStatus(status)
        }
    }
    
    // MARK: - 위치 서비스 관련 함수
    
    /// 위치 서비스 시작 요청
    private func startLocationProcess() {
        locationManager.startUpdatingLocation()
    }
    
    /// 위치 권한 상태 변경시 화면 전환 처리
    private func handleLocationStatus(_ status: CLAuthorizationStatus?) {
        guard let status = status else { return }
        if status != .notDetermined {
            isLoading = false
        }
    }
    
}
