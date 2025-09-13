//
//  SmallView.swift
//  Weather
//
//  Created by 김건혜 on 9/13/25.
//

import WidgetKit
import SwiftUI

// MARK: 위젯 small view (2x2)
struct SmallView: View {
    
    // MARK: - Properties
    var entry: SimpleEntry
    
    private enum Constants {
        static let iconSize: CGFloat = 15
        static let avatarSize: CGFloat = 50
        static let contentSpacing: CGFloat = 5
    }
    
    // MARK: - Body
    var body: some View {
        HStack() {
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
            // 아바타
            Image("avatar")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .frame(width: Constants.avatarSize, height: Constants.avatarSize)
                .offset(y: 60)
        }
        .lineLimit(1)
        .minimumScaleFactor(0.8)
        .padding(.leading, 15)
        .padding(.trailing, 8)
    }
}
