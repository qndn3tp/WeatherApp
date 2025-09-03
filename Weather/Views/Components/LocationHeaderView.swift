//
//  LocationHeaderView.swift
//  Weather
//
//  Created by 김건혜 on 9/3/25.
//

import SwiftUI

// MARK: - 현재 위치, 시간 정보 헤더 뷰
struct LocationHeaderView: View {
    @ObservedObject var locationViewModel: LocationViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            // 조건부 렌더링: 위치 권한 상태에 따라 다른 UI 표시
            if locationViewModel.shouldShowLocationInfo {
                VStack {
                    HStack(spacing: 5) {
                        Image("icon_location_pin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        
                        Text(locationViewModel.cityName ?? "")
                            .font(.headlineLarge)
                    }
                    
                    Text(locationViewModel.currentTime ?? "")
                        .font(.bodyLarge)
                }
            } else {
                Text(locationViewModel.statusMessage)
                    .font(.headlineLarge)
            }
            
            Spacer()
        }
        .padding()
    }
}
