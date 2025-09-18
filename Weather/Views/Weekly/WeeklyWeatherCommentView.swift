//
//  WeeklyWeatherCommentView.swift
//  Weather
//
//  Created by 김건혜 on 9/3/25.
//

import SwiftUI

// MARK: - 주간 날씨 코멘트 뷰
struct WeeklyWeatherCommentView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = WeeklyWeatherCommentViewModel()
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .bottom, spacing: 25) {
            // 왼쪽: 아바타
            Image("icon_avatar_profile")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 83, height: 104)
            
            // 오른쪽: weekly 날씨 정보
            VStack(alignment: .leading, spacing: 0) {
                if let comment = viewModel.weeklyWeatherComment {
                    // 데이터가 있는 경우
                    ForEach(comment.comments, id: \.self) { item in
                        Text(item)
                            .font(.bodySmall)
                            .foregroundStyle(.textSecondary)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    }
                } else {
                    // 데이터가 비어있다면, 스켈레톤 UI
                    Text("이번주 날씨에 대한 코멘트가 로딩 중입니다. \n 잠시만 기다려주세요. 첫 번째 날씨 코멘트 라인입니다. \n 두 번째 날씨 코멘트 라인입니다.")
                        .font(.bodySmall)
                        .redacted(reason: .placeholder)
                }
            }
            .frame(width: 200)
            .frame(minHeight: 80)
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
        .task {
            await viewModel.fetchWeeklyWeatherComment()
        }
    }
}
