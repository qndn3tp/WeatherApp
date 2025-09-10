//
//  ContentView.swift
//  Weather
//
//  Created by Your Name on 2025/08/21.
//
import SwiftUI

// MARK: - 메인 뷰
struct ContentView: View {
    // MARK: - Properties
    @ObservedObject var locationManager: LocationManager
    @Environment(\.scenePhase) private var scenePhase
    
    enum Tab {
        case weekly
        case today
        case notifications
    }
    
    @State private var selectedTab: Tab = .today
    
    // MARK: - Body
    var body: some View {
        TabView(selection: $selectedTab) {
            // 주간 날씨 뷰
            WeeklyView(locationManager: locationManager)
                .tabItem {
                    Image("icon_tab_weekly")
                        .renderingMode(.template)
                    Text("Weekly")
                }
                .tag(Tab.weekly)
            
            // 오늘 날씨 뷰
            TodayView(locationManager: locationManager)
                .tabItem {
                    Image("icon_tab_today")
                        .renderingMode(.template)
                    Text("Today")
                }
                .tag(Tab.today)
            
            // 알림 설정 뷰
            NotificationsView()
                .tabItem {
                    Image("icon_tab_notification")
                        .renderingMode(.template)
                    Text("Notifications")
                }
                .tag(Tab.notifications)
        }
        // 탭바 색상 커스텀
        .onAppear {
            let appearance = UITabBarAppearance()
            
            // 모든 선택된 탭에 적용
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.buttonPrimary)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor(Color.buttonPrimary),
                .font: UIFont.systemFont(ofSize: 11, weight: .bold)
            ]
            
            // 모든 일반 탭에 적용
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.textTertiary)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor(Color.textTertiary),
                .font: UIFont.systemFont(ofSize: 11, weight: .bold)
            ]
            
            UITabBar.appearance().standardAppearance = appearance
        }
        // 앱 생명주기 관리
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                locationManager.resumeServices()
            } else if newPhase == .background {
                locationManager.pauseServices()
            }
        }
    }
}

#Preview {
    ContentView(locationManager: LocationManager())
}
