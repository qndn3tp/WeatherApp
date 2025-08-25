//
//  SplashView.swift
//  Weather
//
//  Created by 김건혜 on 8/15/25.
//
import SwiftUI
import Combine

// MARK: - SplashView (로딩 로직 담당)
struct SplashView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var isLoading = true
    @State private var subscriptions = Set<AnyCancellable>()

    var body: some View {
        ZStack {
            if isLoading {
                // 로딩 중일 때 표시할 UI
                Text("로딩 중...")
                    .onAppear {
                        // 뷰가 나타날 때 위치 업데이트를 시작합니다.
                        locationManager.startUpdatingLocation()
                    }
            } else {
                // 로딩 완료 후 표시할 메인 화면
                ContentView(locationManager: locationManager)
            }
        }
        .onAppear {
            // MARK: - 여기에서 데이터를 불러오는 로직을 실행합니다.
            // .notDetermined 상태를 제외한 모든 상태에서 다음 화면으로 넘어갑니다.
            locationManager.$authorizationStatus
                .sink { status in
                    guard let status = status else { return }
                    if status != .notDetermined {
                        // 권한 상태가 결정되면 isLoading을 false로 변경
                        self.isLoading = false
                        // 구독을 취소하여 메모리 누수를 방지합니다.
                        self.subscriptions.forEach { $0.cancel() }
                        self.subscriptions.removeAll()
                    }
                }
                .store(in: &subscriptions)
        }
    }
}
