//
//  WeeklyWeatherCommentView.swift
//  Weather
//
//  Created by 김건혜 on 9/3/25.
//

import SwiftUI

// MARK: - 주간 날씨 코멘트 뷰
struct WeeklyWeatherCommentView: View {
    
    // MARK: - Initialization
    /// 주간 날씨 코멘트 초기화
    let weeklyWeatherComment = WeeklyWeatherComment (
        comments: [
            "이번주는 평년(22.4~23.4)보다 기온이 높을 예정이고 평년 강수량(10.9~50.1mm)과 비슷하거나 높을 확률이 있어.",
            "덥고 습한 한 주가 되겠지만, 좋은 일만 가득하길 바라!"
        ]
    )
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .bottom, spacing: 33) {
            // 왼쪽: 아바타
            Image("icon_avatar_profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 83, height: 104)
            
            // 오른쪽: weekly 날씨 정보
            VStack(alignment: .leading, spacing: 0) {
                ForEach(weeklyWeatherComment.comments, id: \.self) { comment in
                    Text(comment)
                        .font(.bodySmall)
                        .foregroundStyle(.textSecondary)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
            }
            .frame(width: 200)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(.backgroundPrimary)
            .clipShape(
                .rect(
                    topLeadingRadius: 10,
                    bottomLeadingRadius: 2,
                    bottomTrailingRadius: 10,
                    topTrailingRadius: 10
                )
            )
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 20)
    }
}

// MARK: - 주간 날씨 코멘트 Data Model
struct WeeklyWeatherComment {
    let comments: [String]
}
