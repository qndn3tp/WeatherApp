//
//  NotificationManager.swift
//  Weather
//
//  Created by 김건혜 on 9/7/25.
//

import Foundation

/**
 * 알림 설정 데이터를 관리하는 서비스 클래스
 * - 역할: 알림 데이터의 생성, 수정, 삭제, 저장
 * - ObservableObject: SwiftUI에서 상태 변화를 자동으로 감지하여 UI 업데이트
 * - @StateObject로 NotificationView에서 인스턴스 생성
 */
// MARK: - 알림 설정 데이터 관리 클래스
class NotificationManager: ObservableObject {
    
    // MARK: - Properties
    
    /// 알림 데이터 배열
    @Published var notifications: [NotificationData] = []
    
    /// UserDefaults: iOS에서 제공하는 간단한 키-값 저장소
    private let userDefaults = UserDefaults.standard
    
     /// UserDefaults에서 데이터를 구분하는 키 값
    private let notificationsKey = "UserNotifications"
    
    // MARK: - Initializer
    
    /**
     * NotificationView에서 @StateObject로 생성될 때 자동 호출
     * 저장된 알림 데이터를 즉시 로드하여 앱 시작과 동시에 이전 설정 복원
     */
    init() {
        loadNotifications()
    }
    
    // MARK: - 알림 데이터 로드
    /**
     * UserDefaults에서 저장된 알림 데이터를 불러오는 메서드
     *
     * 동작 순서:
     * 1. UserDefaults에서 "UserNotifications" 키로 데이터 검색
     * 2. 데이터가 있으면 JSON 디코딩 시도
     * 3. 성공하면 notifications 배열에 할당
     * 4. 실패하거나 데이터가 없으면 기본값 설정
     */
    func loadNotifications() {
        // UserDefaults에서 Data 타입으로 저장된 데이터 가져오기
        if let data = userDefaults.data(forKey: notificationsKey) {
            do {
                // JSON 디코더를 사용해 Data → [NotificationData] 변환
                let decodedNotifications = try JSONDecoder().decode([NotificationData].self, from: data)
                
                // 메인 스레드에서 UI 업데이트를 위해 notifications 배열 할당
                self.notifications = decodedNotifications
                print("알림 데이터 로드 완료: \(notifications.count)개")
                
            } catch {
                // 디코딩 실패시 (데이터 손상, 형식 변경 등)
                print("알림 데이터 로드 실패: \(error)")
                setDefaultNotifications() // 기본값으로 복구
            }
        } else {
            // 첫 실행이거나 저장된 데이터가 없는 경우
            print("저장된 알림 데이터가 없음. 기본값 설정")
            setDefaultNotifications()
        }
    }
    
    // MARK: - 알림 데이터 저장
    /**
     * 현재 notifications 배열을 UserDefaults에 저장하는 메서드
     *
     * 저장 과정:
     * 1. notifications 배열을 JSON 인코딩으로 Data 타입 변환
     * 2. UserDefaults에 키-값 쌍으로 저장
     * 3. 에러 발생시 콘솔에 로그 출력
     *
     * 호출 시점: 데이터 변경이 일어날 때마다 즉시 호출
     */
    func saveNotifications() {
        do {
            // [NotificationData] → Data 변환 (JSON 인코딩)
            let encodedData = try JSONEncoder().encode(notifications)
            
            // UserDefaults에 저장 (즉시 디스크에 기록됨)
            userDefaults.set(encodedData, forKey: notificationsKey)
            print("알림 데이터 저장 완료")
            
        } catch {
            // 인코딩 실패시 (메모리 부족, 데이터 오류 등)
            print("알림 데이터 저장 실패: \(error)")
        }
    }
    
    // MARK: - 기본 알림 설정
    /**
     * 앱 첫 실행이나 데이터 로드 실패시 사용할 기본 알림 설정
     *
     * private: 외부에서 호출할 필요 없는 내부 메서드
     */
    private func setDefaultNotifications() {
        notifications = [
            NotificationData(period: "오전", time: "7:00", label: "출근 전, 주중", isOn: true),
            NotificationData(period: "오후", time: "9:00", label: "퇴근 후, 내일 준비", isOn: true)
        ]
        
        // 기본값 설정 후 즉시 저장하여 다음 실행시 유지
        saveNotifications()
    }
    
    // MARK: - 알림 토글 업데이트
    /**
     * 특정 인덱스의 알림 on/off 상태를 변경하는 메서드
     *
     * @param index: 변경할 알림의 배열 내 위치
     * @param isOn: 새로운 on/off 상태 (true: 켜짐, false: 꺼짐)
     *
     * 사용 시점: 사용자가 토글 스위치를 조작할 때
     * 중요: 변경 즉시 저장하여 데이터 손실 방지
     */
    func updateNotificationStatus(at index: Int, isOn: Bool) {
        // 배열 범위 검사로 크래시 방지
        guard index < notifications.count else {
            print("잘못된 인덱스: \(index)")
            return
        }
        
        // 해당 인덱스의 알림 상태 변경
        notifications[index].isOn = isOn
        
        // 변경 즉시 UserDefaults에 저장
        saveNotifications()
        
        // 디버깅용 로그 (어떤 알림의 상태가 어떻게 바뀌었는지 추적)
        print("알림 \(index) 상태 변경: \(isOn)")
    }
    
    // MARK: - 알림 추가
    /**
     * 새로운 알림을 추가하는 메서드
     *
     * @param notification: 추가할 새 알림 데이터
     *
     * 사용 시점: 사용자가 '+" 버튼을 눌러 새 알림을 생성할 때
     * AddNotificationView에서 완료 후 이 메서드 호출
     */
    func addNotification(_ notification: NotificationData) {
        // 배열 끝에 새 알림 추가
        notifications.append(notification)
        
        // 추가 즉시 저장하여 영구 보존
        saveNotifications()
        
        // 성공 로그 (어떤 알림이 추가되었는지 확인)
        print("새 알림 추가: \(notification.label)")
    }
    
    // MARK: - 알림 삭제
    /**
     * 선택된 알림들을 삭제하는 메서드
     *
     * @param offsets: 삭제할 알림들의 인덱스 집합(SwiftUI의 onDelete에서 제공)
     *
     * 사용 시점: 사용자가 스와이프하여 알림을 삭제할 때
     * IndexSet: 여러 개의 인덱스를 한번에 처리 가능
     */
    func deleteNotification(at offsets: IndexSet) {
        // IndexSet에 포함된 모든 인덱스의 알림 제거
        // IndexSet은 역순으로 정렬되어 있어 안전하게 삭제 가능
        notifications.remove(atOffsets: offsets)
        
        // 삭제 즉시 저장하여 변경사항 영구 반영
        saveNotifications()
        
        // 삭제 완료 로그
        print("알림 삭제됨")
    }
}
