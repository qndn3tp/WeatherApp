//
//  WeeklyTipView.swift
//  Weather
//
//  Created by 김건혜 on 9/18/25.
//

import SwiftUI

// MARK: 주간 날씨 유용한 정보 뷰
struct WeeklyTipView: View {
    
    // MARK: Body
    var body: some View {
        VStack( spacing: 10) {
            HStack {
                Text("유용한 정보")
                    .font(.titleSmall)
                    .foregroundStyle(.textSecondary)
                    .padding(.top, 20)
                Spacer()
            }
            .padding(.leading, 50)
            
            Text("날씨에 따른 생활정보, 코디 팁 등 큐레이션")
                .font(.titleSmall)
                .foregroundStyle(.textSecondary)
        }
    }
}
