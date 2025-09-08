//
//  SnowyAnimationView.swift
//  Weather
//
//  Created by 김건혜 on 9/8/25.
//

import SwiftUI

// MARK: - 눈 애니메이션
struct SnowyAnimationView: View {
    @State private var snowflakes: [WeatherParticle] = []

    var body: some View {
        TimelineView(.animation(minimumInterval: 1/60)) { timeline in
            Canvas { context, _ in
                for snowflake in snowflakes {
                    let origin = CGPoint(
                        x: snowflake.x - snowflake.size / 2,
                        y: snowflake.y - snowflake.size / 2
                    )

                    context.opacity = snowflake.opacity
                    context.fill(
                        Path { path in
                            path.addEllipse(in: CGRect(
                                origin: origin,
                                size: CGSize(width: snowflake.size, height: snowflake.size)
                            ))
                        },
                        with: .color(.white)
                    )
                }
            }
            .onAppear {
                initializeSnowflakes()
            }
            .onChange(of: timeline.date) {
                // 시간이 변할 때마다 눈송이 위치 업데이트 (60fps)
                updateSnowflakes()
            }
        }
    }

    private func initializeSnowflakes() {
        snowflakes = (0..<30).map { _ in
            WeatherParticle(
                x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: -100...UIScreen.main.bounds.height),
                speed: CGFloat.random(in: 1...3),
                size: CGFloat.random(in: 4...8),
                opacity: Double.random(in: 0.5...1.0),
                angle: CGFloat.random(in: -0.5...0.5)
            )
        }
    }

    private func updateSnowflakes() {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width

        for i in snowflakes.indices {
            // 눈은 좌우로 흔들리면서 떨어짐
            snowflakes[i].y += snowflakes[i].speed
            snowflakes[i].x += sin(snowflakes[i].y * 0.01) * 0.5

            if snowflakes[i].y > screenHeight + 20 {
                snowflakes[i].y = -20
                snowflakes[i].x = CGFloat.random(in: 0...screenWidth)
            }
        }
    }
}
