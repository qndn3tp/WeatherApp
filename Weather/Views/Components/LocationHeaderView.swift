//
//  LocationHeaderView.swift
//  Weather
//
//  Created by 김건혜 on 9/3/25.
//

import SwiftUI

// MARK: - 현재 위치, 시간 정보 헤더 뷰
struct LocationHeaderView: View {
    @ObservedObject var viewModel: LocationViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            // 조건부 렌더링: 위치 권한 상태에 따라 다른 UI 표시
            if viewModel.shouldShowLocationInfo {
                VStack {
                    HStack(spacing: 5) {
                        // 위치
                        Image("icon_location_pin")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        
                        Text(viewModel.cityName ?? "")
                            .font(.headlineLarge)
                            .foregroundStyle(.textPrimary)
                    }
                    // 시간
                    TimelineView(.periodic(from: .now, by: 1.0)) { context in
                        // ViewModel이 제공하는 timeZone이 있을 때만 시간 표시
                        if let timeZone = viewModel.timeZone {
                            Text(context.date.formattedString(format: "h:mm a", for: timeZone))
                        } else {
                            // TimeZone 정보가 아직 없을 경우
                            Text("--:--")
                        }
                    }
                    .font(.bodyLarge)
                    .foregroundStyle(.textTertiary)
                }
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Text(viewModel.statusMessage)
                    .font(.headlineLarge)
                    .foregroundStyle(.textPrimary)
            }
            
            Spacer()
        }
        .padding()
    }
}
