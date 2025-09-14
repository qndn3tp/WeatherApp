//
//  SmallView.swift
//  Weather
//
//  Created by 김건혜 on 9/13/25.
//
import SwiftUI

// MARK: 위젯 small view (2x2)
struct SmallView: View {
    
    // MARK: - Properties
    var entry: SimpleEntry
    
    // MARK: - Body
    var body: some View {
        HStack() {
            // 현재 날씨
            CurrentWeatherView()
            // 아바타
            Image("avatar")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .frame(width: 50, height: 50)
                .offset(y: 60)
        }
        .lineLimit(1)
        .minimumScaleFactor(0.8)
        .padding(.leading, 15)
        .padding(.trailing, 8)
    }
}
