//
//  CurrentWeatherView.swift
//  Weather
//
//  Created by 김건혜 on 9/14/25.
//

import SwiftUI

// MARK: 공통으로 사용되는 현재 날씨 뷰
struct CurrentWeatherView: View {
    
    private enum Constants {
        static let iconSize: CGFloat = 15
        static let contentSpacing: CGFloat = 5
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.contentSpacing) {
            // 상단: 날씨 아이콘, 위치
            HStack(spacing: Constants.contentSpacing) {
                Image(systemName: "umbrella")
                    .font(.system(size: Constants.iconSize))
                    .padding(.trailing, 2)
                
                Text("정릉3동")
                    .font(.captionLarge)
                    .foregroundColor(.textTertiary)
                
                Text("비")
                    .font(.buttonMedium)
                    .foregroundColor(.textTertiary)
            }
            .padding(.bottom, Constants.contentSpacing)
            
            // 중간: 메인 온도
            Text("26°")
                .font(.weatherLarge)
                .foregroundColor(.textPrimary)
            
            // 하단 정보들: 날씨 비교, 최고최저온도
            Text("어제보다 1.8° ↓")
                .font(.captionLarge)
                .foregroundColor(.textTertiary)
            
            Text("34° / 21°")
                .font(.bodyMedium)
                .foregroundColor(.textSecondary)
        }
    }
}
