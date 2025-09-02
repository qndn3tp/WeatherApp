//
//  AddNotificationView.swift
//  Weather
//
//  Created by 김건혜 on 9/1/25.
//

import SwiftUI

// MARK: - 알림 추가 View (iOS Clock 스타일)
struct AddNotificationView: View {
    // MARK: - Properties
    
    /// 모달을 닫기 위한 환경변수 (iOS 15+에서 사용)
    @Environment(\.dismiss) private var dismiss
    
    /// 사용자가 선택한 시간을 저장하는 State(현재 시간으로 초기값)
    @State private var selectedTime = Date()
    
    /// 알람 설정들을 저장하는 State 변수들
    @State private var label = ""
    
    /// 부모 View에서 전달받는 클로저 (함수)
    /// 새로운 알람을 저장할 때 이 함수를 호출해서 데이터를 전달
    let onSave: (NotificationData) -> Void
    
    // MARK: - body
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 시간 선택 휠
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .frame(height: 200)
                    .padding(.vertical, 20)
                
                // 설정 옵션들
                List {
                    /// 알람 이름 설정
                    Section {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("알람 이름")
                            TextField("알람 이름을 입력해주세요", text: $label)
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    // 반복 요일 설정
                    Section {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("반복 요일")
                            NotificationRepeatDaysView()
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("알림 추가")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("저장") {
                        saveNotification()
                    }
                }
            }
        }
    }
    
    // MARK: - 알람 저장 함수
    private func saveNotification() {
        // 1. 선택된 시간(Date)을 NotificationData 형태로 변환
        let newNotification = createNotificationData(from: selectedTime)
        
        // 2. 부모 View에 새로운 알람 데이터 전달
        onSave(newNotification)
        
        // 3. 모달 화면 닫기
        dismiss()
    }
    
    // MARK: - Date를 NotificationData로 변환하는 함수
    // Calendar를 사용해서 Date에서 시간과 분을 추출
    private func createNotificationData(from date: Date) -> NotificationData {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date) // 24시간제 시간 (0-23)
        let minute = calendar.component(.minute, from: date) // 분 (0-59)
        
        /// 24시간제를 12시간제로 변환
        let period = hour < 12 ? "오전" : "오후"
        let hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour)
        
        /// 시간 문자열 포맷 ("9:05" 형태 문자열)
        let timeString = String(format: "%d:%02d", hour12, minute)
        
        /// 최종적으로 NotificationData 객체를 생성해서 반환
        return NotificationData(
            period: period,
            time: timeString,
            label: label,
            isOn: true
        )
    }
}
