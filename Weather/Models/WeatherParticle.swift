//
//  WeatherParticle.swift
//  Weather
//
//  Created by 김건혜 on 9/8/25.
//

import SwiftUI

// MARK: - 파티클 데이터 모델
struct WeatherParticle {
    var x: CGFloat
    var y: CGFloat
    var speed: CGFloat
    var size: CGFloat
    var opacity: Double
    var angle: CGFloat // 바람 효과용

    mutating func update(in frame: CGRect) {
        // 위치 업데이트 로직은 각 날씨별로 다르게 구현
    }
}
