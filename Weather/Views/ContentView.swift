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
    
    enum Tab {
        case location
        case home
        case settings
    }
    
    @State private var selectedTab: Tab = .home
    
    // MARK: - Body
    var body: some View {
        TabView(selection: $selectedTab) {
            // 주간 날씨 뷰
            WeeklyView(locationManager: locationManager)
                .tabItem {
                    Image(systemName: "location")
                    Text("Weekly")
                }
                .tag(Tab.location)
            
            // 오늘 날씨 뷰
            TodayView(locationManager: locationManager)
                .tabItem {
                    Image(systemName: "house")
                    Text("Today")
                }
                .tag(Tab.home)
            
            // 알림 설정 뷰
            NotificationsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Notifications")
                }
                .tag(Tab.settings)
        }
    }
}

#Preview {
    ContentView(locationManager: LocationManager())
}
