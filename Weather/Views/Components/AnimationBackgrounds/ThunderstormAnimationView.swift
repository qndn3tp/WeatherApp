//
//  ThunderstormAnimationView.swift
//  Weather
//
//  Created by 김건혜 on 9/8/25.
//

import SwiftUI

// MARK: - 천둥 애니메이션
struct ThunderstormAnimationView: View {
    @State private var isFlashing: Bool = false
    @State private var flashOpacity: Double = 0
    @State private var lightningPaths: [Path] = []
    @State private var showLightning: Bool = false
    @State private var lightningTimer: Timer?

    var body: some View {
        ZStack {
            // 배경 번개 번쩍임 효과
            Rectangle()
                .fill(Color.white)
                .opacity(flashOpacity)
                .ignoresSafeArea()

            // 번개 번쩍임과 함께 비 애니메이션
            RainyAnimationView()

            // 번개 모양
            if showLightning {
                Canvas { context, _ in
                    for lightningPath in lightningPaths {
                        context.stroke(
                            lightningPath,
                            with: .color(.white),
                            style: StrokeStyle(lineWidth: 3, lineCap: .round)
                        )

                        // 번개 주변 글로우 효과
                        context.stroke(
                            lightningPath,
                            with: .color(.yellow.opacity(0.5)),
                            style: StrokeStyle(lineWidth: 3, lineCap: .round)
                        )
                    }
                }
            }
        }
        .onAppear {
            startThunderstormAnimation()
        }
        .onDisappear {
            lightningTimer?.invalidate()
            lightningTimer = nil
        }
    }

    /// 천둥 애니메이션 시작
    private func startThunderstormAnimation() {
        // 3-7초마다 번개 치기
        lightningTimer = Timer.scheduledTimer(withTimeInterval: Double.random(in: 3...7), repeats: true) { _ in
            triggerLightning()
        }
    }

    /// 번개 치는 효과
    private func triggerLightning() {
        // 번개 경로 생성
        generateLightningPaths()

        // 번개 모양 보여주기
        showLightning = true

        // 화면 번쩍임 효과
        withAnimation(.easeOut(duration: 0.1)) {
            flashOpacity = 1
        }

        // 0.1초 후 번개 사라지기
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            showLightning = false

            withAnimation(.easeOut(duration: 0.3)) {
                flashOpacity = 0
            }
        }
    }

    /// 번개 경로 생성 (지그재그 모양)
    private func generateLightningPaths() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        lightningPaths = []

        // 1-3개의 번개 생성
        for _ in 0..<Int.random(in: 1...2) {
            let startX = CGFloat.random(in: screenWidth * 0.2...screenWidth * 0.8)
            let path = createLightningPath(startX: startX, screenHeight: screenHeight)
            lightningPaths.append(path)
        }
    }

    /// 지그재그 번개 모양 생성
    private func createLightningPath(startX: CGFloat, screenHeight: CGFloat) -> Path {
        Path { path in
            var currentX = startX
            var currentY: CGFloat = 0

            path.move(to: CGPoint(x: currentX, y: currentY))

            // 여러 구간으로 나누어 지그재그 생성
            let segments = 8
            let segmentHeight = screenHeight / CGFloat(segments)

            for i in 1...segments {
                currentY = CGFloat(i) * segmentHeight

                // 랜덤한 가로 변화 (지그재그 효과)
                let horizontalOffset = CGFloat.random(in: -30...30)
                currentX += horizontalOffset

                // 화면 밖으로 나가지 않도록 제한
                currentX = max(50, min(UIScreen.main.bounds.width - 50, currentX))

                path.addLine(to: CGPoint(x: currentX, y: currentY))
            }
        }
    }
}
