//
//  TodayView.swift
//  Weather

//  Created by 김건혜 on 7/27/25.

import SwiftUI

// MARK: 현재 날씨 뷰
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
            LocationHeaderView(locationViewModel: locationViewModel)

            // 현재 날씨 정보
            CurrentWeatherView()

            // 현재 날씨 부가정보
            CurrentWeatherDetailView()
            
            // 시간대별 날씨 정보
            HourlyWeatherChartView()
            
            // 과거 날씨(작년)
            LastYearWeatherView()
        }
        .background(Color(red: 0xF8 / 255, green: 0xFC / 255, blue: 0xFF / 255))
    }
}

// MARK: - Preview
#Preview {
    TodayView(locationManager: LocationManager())
}
