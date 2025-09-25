//
//  DateExtemsopms.swift
//  Weather
//
//  Created by 김건혜 on 9/24/25.
//

// MARK: - 시간 데이터 포맷팅
import Foundation

extension Date {
    /// 특정 시간대를 기준으로 '시간(hour)'을 숫자로 반환. (계산용)
    func hour(for timeZone: TimeZone) -> Int {
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        return calendar.component(.hour, from: self)
    }
    
    /// 특정 시간대와 포맷에 맞춰 보기 좋은 시간 문자열을 반환. (표시용)
    func formattedString(format: String, for timeZone: TimeZone) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }
}
