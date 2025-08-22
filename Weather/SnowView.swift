//
//  SnowAnimationView.swift
//  Weather
//
//  Created by 김건혜 on 7/31/25.
//

import SwiftUI

struct Snowflake: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var speed: CGFloat
    var opacity: Double
    var drift: CGFloat // 눈이 좌우로 흔들리는 정도
}

struct SnowAnimationView: View {
    @State private var snowflakes: [Snowflake] = []
    let snowCount = 50 // 눈송이 개수
    
    var body: some View {
        GeometryReader { geo in
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    for snowflake in snowflakes {
                        // 눈송이 모양을 그리기 위해 타원(Ellipse) 사용
                        let rect = CGRect(
                            x: snowflake.x,
                            y: snowflake.y,
                            width: snowflake.size,
                            height: snowflake.size
                        )
                        let path = Path(ellipseIn: rect)
                        
                        context.fill(path, with: .color(.white.opacity(snowflake.opacity)))
                    }
                }
                .onAppear {
                    // 눈송이 초기 생성
                    snowflakes = (0..<snowCount).map { _ in
                        Snowflake(
                            x: CGFloat.random(in: 0...geo.size.width),
                            y: CGFloat.random(in: -geo.size.height...geo.size.height),
                            size: CGFloat.random(in: 3...8), // 눈송이 크기 다양화
                            speed: CGFloat.random(in: 0.5...2.0), // 떨어지는 속도 다양화
                            opacity: Double.random(in: 0.5...1.0), // 투명도 다양화
                            drift: CGFloat.random(in: -1...1) // 좌우 흔들림 방향
                        )
                    }
                }
                .onChange(of: timeline.date) { _ in
                    // 눈송이 아래로 이동 및 좌우 흔들림
                    for i in snowflakes.indices {
                        snowflakes[i].y += snowflakes[i].speed
                        snowflakes[i].x += snowflakes[i].drift
                        
                        if snowflakes[i].y > geo.size.height {
                            // 화면 아래로 내려가면 다시 위에서 생성
                            snowflakes[i].y = -snowflakes[i].size
                            snowflakes[i].x = CGFloat.random(in: 0...geo.size.width)
                            snowflakes[i].speed = CGFloat.random(in: 0.5...2.0)
                            snowflakes[i].size = CGFloat.random(in: 3...8)
                            snowflakes[i].opacity = Double.random(in: 0.5...1.0)
                            snowflakes[i].drift = CGFloat.random(in: -1...1)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    // 미리보기에서 SnowAnimationView를 사용하려면 배경색을 추가해야 합니다.
    ZStack {
        Color.black.ignoresSafeArea()
        SnowAnimationView()
    }
}
