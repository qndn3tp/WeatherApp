//
//  WeeklyView.swift
//  Weather

//  Created by 김건혜 on 8/13/25.

import SwiftUI

// MARK: 주간 날씨 뷰
struct WeeklyView: View {
    
    // MARK: - Properties
    /// 위치 관리자 (외부에서 주입받는 의존성)
    @ObservedObject var locationManager: LocationManager
    
    /// 위치 관련 비즈니스 로직을 처리하는 ViewModel
    @StateObject private var locationViewModel: LocationViewModel
    
    // MARK: - Initialization
    /// 위치 관리자 초기화
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self._locationViewModel = StateObject(wrappedValue: LocationViewModel(locationManager: locationManager))
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            // 현재 위치 및 시간 정보
            LocationHeaderView(locationViewModel: locationViewModel)
            
            // 상단: 주간 날씨 코멘트
            WeeklyWeatherCommentView()
            
            // 중간: 주간 날씨 데이터 차트
            WeeklyWeatherView()
            
            // 하단: 주간 날씨 유용한 정보
            WeeklyTipView()
        }
        .background(.surfacePrimary)
    }
}

// MARK: - Preview
#Preview {
    WeeklyView(locationManager: LocationManager())
}
