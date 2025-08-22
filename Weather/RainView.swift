//
//  RainView.swift
//  Weather
//
//  Created by 김건혜 on 7/31/25.
//

import SwiftUI

struct RainDrop: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var length: CGFloat
}

struct RainAnimationView: View {
    @State private var drops: [RainDrop] = []
    let dropCount = 10
    
    var body: some View {
        GeometryReader { geo in
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    for drop in drops {
                        var path = Path()
                        path.move(to: CGPoint(x: drop.x, y: drop.y))
                        path.addLine(to: CGPoint(x: drop.x, y: drop.y + drop.length))
                        
                        context.stroke(path, with: .color(.white.opacity(0.8)), lineWidth: 1.5)
                    }
                }
                .onAppear {
                    // 비방울 초기 생성
                    drops = (0..<dropCount).map { _ in
                        RainDrop(
                            x: CGFloat.random(in: 0...geo.size.width),
                            y: CGFloat.random(in: -geo.size.height...geo.size.height),
                            length: CGFloat.random(in: 10...25)
                        )
                    }
                }
                .onChange(of: timeline.date) { _ in
                    // 비방울 아래로 이동
                    for i in drops.indices {
                        drops[i].y += 5
                        if drops[i].y > geo.size.height {
                            // 화면 아래로 내려가면 다시 위에서 생성
                            drops[i].y = -drops[i].length
                            drops[i].x = CGFloat.random(in: 0...geo.size.width)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        RainAnimationView()
    }
}

