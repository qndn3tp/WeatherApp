//
//  ContentView.swift
//  Weather
//
//  Created by Your Name on 2025/08/21.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var locationManager: LocationManager
    
    enum Tab {
        case location
        case home
        case settings
    }
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            LocationView()
                .tabItem {
                    Image(systemName: "location")
                    Text("Location")
                }
                .tag(Tab.location)
                .background(Color(red: 0xF8 / 255, green: 0xFC / 255, blue: 0xFF / 255))
        
            HomeView(locationManager: locationManager)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(Tab.home)
                .background(Color(red: 0xF8 / 255, green: 0xFC / 255, blue: 0xFF / 255))
        
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(Tab.settings)
                .background(Color.green.ignoresSafeArea())
        }
    }
}

#Preview {
    ContentView(locationManager: LocationManager())
}
