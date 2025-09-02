//
//  WeeklyView.swift
//  Weather

//  Created by 김건혜 on 8/13/25.

import SwiftUI

struct WeeklyView: View {
    // MARK: - Body
    var body: some View {
        ScrollView {
            // 상단
            HStack(spacing: 42) {
                // 왼쪽: 아바타 프로필
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70, height: 190)
                
                // 오른쪽: 이번달 weekly날씨 정보
                Text("이번달 weekly날씨 정보")
                    .frame(width: 187, height: 146)
                    .background(.white)
            }
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
    }
}

// MARK: - Preview
#Preview {
    WeeklyView()
}
