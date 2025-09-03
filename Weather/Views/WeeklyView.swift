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
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self._locationViewModel = StateObject(wrappedValue: LocationViewModel(locationManager: locationManager))
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            // 현재 위치 및 시간 정보
            LocationHeaderView(locationViewModel: locationViewModel)
            
            // 상단
            HStack(alignment: .bottom, spacing: 33) {
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 190)
                
                // 오른쪽: 이번달 weekly날씨 정보
                Text("이번달 weekly날씨 정보")
                    .frame(width: 187, height: 146)
                    .background(.white)
            }
            .padding(.horizontal, 40)
            VStack(alignment: .leading, spacing: 0) {
                Text("주간 날씨")
                    .font(.titleSmall)
                Text("주간 날씨 정보")
                    .frame(width: 359, height: 300)
                    .background(.white)
                Text("유용한 정보")
                    .font(.titleSmall)
                Text("날씨에 따른 생활정보, 코디 팁 등 큐레이션")
                    .font(.system(size: 14))
                    .frame(width: 359, height: 100)
                    .background(.white)
            }
            
        }
        .padding(.horizontal, 20)
        .background(Color(red: 0xF8 / 255, green: 0xFC / 255, blue: 0xFF / 255))
    }
}

// MARK: - Preview
#Preview {
    WeeklyView(locationManager: LocationManager())
}
