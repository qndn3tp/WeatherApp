//
//  WeeklyWeatherComment.swift
//  Weather
//
//  Created by 김건혜 on 9/18/25.
//

import Foundation

// MARK: - Weekly 뷰의 주간 날씨 코멘트 데이터
@MainActor
class WeeklyWeatherCommentViewModel: ObservableObject {
    
    @Published var weeklyWeatherComment: WeeklyWeatherComment?
    
    // TODO: API 통신 코드 작성
    // 특정시간 마다 fetch하도록 캐시 필요
    func fetchWeeklyWeatherComment() async {
        weeklyWeatherComment =  WeeklyWeatherComment(
            comments: [
                "이번주는 평년(22.4~23.4)보다 기온이 높을 예정이고 평년 강수량(10.9~50.1mm)과 비슷하거나 높을 확률이 있어.",
                "덥고 습한 한 주가 되겠지만, 좋은 일만 가득하길 바라!"
            ]
        )
    }
}
