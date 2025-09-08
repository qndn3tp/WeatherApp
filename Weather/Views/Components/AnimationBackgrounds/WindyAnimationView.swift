//
//  WindyAnimationView.swift
//  Weather
//
//  Created by 김건혜 on 9/8/25.
//

import SwiftUI

// MARK: - 바람 애니메이션
struct WindyAnimationView: View {
    @State private var windParticles: [WeatherParticle] = []

    var body: some View {
        TimelineView(.animation(minimumInterval: 1/60)) { timeline in
            Canvas { context, size in
                // 바람에 날리는 입자들 그리기
                for particle in windParticles {
                    // 바람 입자 모양 (작은 선이나 점)
                    let path = createWindParticlePath(particle: particle, size: size)

                    context.opacity = particle.opacity
                    context.stroke(
                        path,
                        with: .color(.gray.opacity(0.5)),
                        lineWidth: particle.size * 0.1
                    )
                }
            }
            .onChange(of: timeline.date) {
                updateWindParticles()
            }
        }
        .onAppear {
            initializeWindParticles()
        }
    }

    /// 바람 입자들 초기화 (나뭇잎, 먼지 등)
    private func initializeWindParticles() {
        windParticles = (0..<25).map { _ in
            WeatherParticle(
                x: CGFloat.random(in: -100...UIScreen.main.bounds.width + 100),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height),
                speed: CGFloat.random(in: 3...8),        // 바람 속도
                size: CGFloat.random(in: 8...15),        // 입자 크기
                opacity: Double.random(in: 0.2...0.6),   // 투명도
                angle: CGFloat.random(in: 0.1...0.4)     // 바람 방향
            )
        }
    }

    /// 바람 입자 위치 업데이트
    private func updateWindParticles() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        for i in windParticles.indices {
            // 바람에 의한 가로 움직임 (주요 방향)
            windParticles[i].x += windParticles[i].speed

            // 바람의 파동 효과 (위아래 흔들림)
            windParticles[i].y += sin(Double(i)) * 0.5

            // 화면 밖으로 나가면 왼쪽에서 다시 시작
            if windParticles[i].x > screenWidth + 50 {
                windParticles[i].x = -50
                windParticles[i].y = CGFloat.random(in: 0...screenHeight)
            }
        }
    }

    /// 바람 입자 모양 생성 (작은 선 모양)
    private func createWindParticlePath(particle: WeatherParticle, size: CGSize) -> Path {
        Path { path in
            let startPoint = CGPoint(x: particle.x, y: particle.y)
            let endPoint = CGPoint(
                x: particle.x + particle.size,
                y: particle.y + sin(Double(particle.x) * 0.01) * 2  // 살짝 구불구불
            )
            path.move(to: startPoint)
            path.addLine(to: endPoint)
        }
    }
}
