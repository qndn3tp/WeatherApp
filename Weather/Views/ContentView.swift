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
                    Image(systemName: "location")
                    Text("Weekly")
                }
                .tag(Tab.weekly)
            
            // 오늘 날씨 뷰
            TodayView(locationManager: locationManager)
                .tabItem {
                    Image(systemName: "house")
                    Text("Today")
                }
                .tag(Tab.today)
            
            // 알림 설정 뷰
            NotificationsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Notifications")
                }
                .tag(Tab.notifications)
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
