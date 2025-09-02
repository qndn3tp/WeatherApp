//
//  NotificationRepeatDaysView.swift
//  Weather
//
//  Created by 김건혜 on 9/2/25.
//

import SwiftUI

// MARK: - 알림 반복 요일 설정 뷰
struct NotificationRepeatDaysView: View {
    
    // MARK: - Properties
    @State private var selectedDays: Set<Int> = []
    let weekdays = ["월", "화", "수", "목", "금", "토", "일"]
    
    private func toggleDay(_ index: Int) {
        if selectedDays.contains(index) {
            selectedDays.remove(index)
        } else {
            selectedDays.insert(index)
        }
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<weekdays.count, id: \.self) { index in
                Button(action: {
                    toggleDay(index)
                }) {
                    Text(weekdays[index])
                        .foregroundColor(selectedDays.contains(index) ? .white : .primary)
                        .frame(width: 40, height: 40)
                        .background(selectedDays.contains(index) ? .black : .clear)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                .opacity(selectedDays.contains(index) ? 0 : 1)
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
