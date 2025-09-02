//
//  NotificationsView.swift
//  Weather
//
//  Created by 김건혜 on 8/13/25.
//

import SwiftUI

// MARK: - 알림 설정 View
struct NotificationsView: View {
    // MARK: Properties
    
    // 알림 더미 데이터
    @State private var notifications = [
        NotificationData(period: "오전", time: "7:00", label: "출근 전, 주중", isOn: true),
        NotificationData(period: "오후", time: "9:00", label: "퇴근 후, 내일 준비", isOn: false)
    ]
    
    // 알림 삭제(스와이프)
    func deleteNotification(at offsets: IndexSet) {
        withAnimation {
            notifications.remove(atOffsets: offsets)
        }
    }
    
    // 알림 추가 sheet
    @State private var showingAddNotification = false
    
    // 알림 추가
    func addNotification() {
        showingAddNotification = true
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Text("원하는 시간에 신속하게 날씨 정보를 받아보세요")
                    .font(.captionSmall)
                List {
                    // 알림 헤더
                    Section {
                        // 알림 리스트
                        ForEach(Array(notifications.enumerated()), id: \.offset) { index, notification in
                            HStack {
                                VStack(alignment: .leading, spacing: 3) {
                                    // 시간 표시
                                    HStack(alignment: .firstTextBaseline, spacing: 11) {
                                        Text(notification.period)
                                            .font(.system(size: 14, weight: .thin))
                                        Text(notification.time)
                                            .font(.system(size: 32, weight: .thin))
                                    }
                                    // 알림 이름
                                    Text(notification.label)
                                        .font(.captionMedium)
                                }
                                Spacer()
                                // 토글 스위치
                                Toggle("", isOn: $notifications[index].isOn)
                            }
                        }
                        .onDelete(perform: deleteNotification) // 스와이프 삭제
                    }
                    .listRowBackground(Color(red: 0xF8 / 255, green: 0xFC / 255, blue: 0xFF / 255))
                    
                }
                .navigationTitle("알림")
                .sheet(isPresented: $showingAddNotification) {
                    AddNotificationView { newNotification in
                        notifications.append(newNotification)
                    }
                }
                // 편집, 추가
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: addNotification, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
                .scrollContentBackground(.hidden) // List 기본 배경 숨기기
            }
            .background(Color(red: 0xF8 / 255, green: 0xFC / 255, blue: 0xFF / 255))
            
        }
    }
}


// MARK: - 알림데이터 구조
struct NotificationData: Identifiable {
    let id = UUID()
    let period: String
    let time: String
    let label: String
    var isOn: Bool
}


// MARK: - Preview
#Preview {
    NotificationsView()
}
