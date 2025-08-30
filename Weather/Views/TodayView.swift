//
//  TodayView.swift
//  Weather

//  Created by 김건혜 on 7/27/25.

import SwiftUI

// MARK: TodayView
struct TodayView: View {
    
    // MARK: - Properties
    /// 위치 관리자 (외부에서 주입받는 의존성)
    @ObservedObject var locationManager: LocationManager
    
    /// 위치 관련 비즈니스 로직을 처리하는 ViewModel
    @StateObject private var locationViewModel: LocationViewModel
    
    // MARK: - Initialization
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self._locationViewModel = StateObject(wrappedValue: LocationViewModel(locationManager: locationManager))
    }
        
    // MARK: - Body
    var body: some View {
        ScrollView {
            // 현재 위치 및 시간 정보
            HStack {
                Spacer()
                // 조건부 렌더링: 위치 권한 상태에 따라 다른 UI 표시
                if locationViewModel.shouldShowLocationInfo {
                    VStack {
                        Text(locationViewModel.cityName ?? "")
                            .font(.system(size: 20))
                        Text(locationViewModel.currentTime ?? "")
                    }
                } else {
                    Text(locationViewModel.statusMessage)
                }
                Spacer()
            }
            .padding()

            // 현재 날씨 정보
            CurrentWeatherView()

            // 데일리 날씨 부가정보
            WeatherInfoCardsView()
            
            // 시간대별 날씨 정보
            HourlyWeatherChartView()
        }
    }
}

// MARK: - Preview
#Preview {
    TodayView(locationManager: LocationManager())
}
