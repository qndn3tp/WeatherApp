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
    
    // 알림매니저 - 알림 데이터 관리
    @StateObject private var notificationManager = NotificationManager()
    
    // 알림 추가 sheet
    @State private var showingAddNotification = false
    
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
                        ForEach(Array(notificationManager.notifications.enumerated()), id: \.offset) { index, notification in
                            HStack {
                                VStack(alignment: .leading, spacing: 3) {
                                    // 시간 표시
                                    HStack(alignment: .firstTextBaseline, spacing: 11) {
                                        Text(notification.period)
                                            .font(.bodyMedium)
                                        Text(notification.time)
                                            .font(.system(size: 32, weight: .thin))
                                    }
                                    // 알림 이름
                                    Text(notification.label)
                                        .font(.captionMedium)
                                }
                                Spacer()
                                // 토글 스위치 (알림 상태 업데이트)
                                Toggle("", isOn: Binding(
                                    get: {
                                        notification.isOn
                                    },
                                    set: { newValue in
                                        notificationManager.updateNotificationStatus(at: index, isOn: newValue)
                                    }
                                ))
                            }
                        }
                        // 알림 삭제
                        .onDelete { offsets in
                            notificationManager.deleteNotification(at: offsets)
                        }
                    }
                    .listRowBackground(Color(red: 0xF8 / 255, green: 0xFC / 255, blue: 0xFF / 255))
                    
                }
                .navigationTitle("알림")
                
                // 알림 추가 sheet
                .sheet(isPresented: $showingAddNotification) {
                    AddNotificationView { newNotification in
                        notificationManager.addNotification(newNotification)
                    }
                }
                // 편집, 추가
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showingAddNotification = true
                        }, label: {
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

// MARK: - 알림 데이터 구조
struct NotificationData: Identifiable, Codable {
    let id: UUID
    let period: String
    let time: String
    let label: String
    var isOn: Bool
        
    // 기본 생성자
    init(period: String, time: String, label: String, isOn: Bool) {
        self.id = UUID()
        self.period = period
        self.time = time
        self.label = label
        self.isOn = isOn
    }
}

// MARK: - Preview
#Preview {
    NotificationsView()
}
