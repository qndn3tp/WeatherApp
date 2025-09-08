//
//  RainyAnimationView.swift
//  Weather
//
//  Created by 김건혜 on 9/8/25.
//

import SwiftUI

// MARK: - 비 애니메이션
struct RainyAnimationView: View {
   @State private var raindrops: [WeatherParticle] = []

   var body: some View {
       TimelineView(.animation(minimumInterval: 1/60)) { timeline in
           Canvas { context, _ in
               // 화면에 빗방울들을 그리기
               for raindrop in raindrops {
                   // 빗방울 모양 정의 (세로로 긴 직사각형)
                   let rect = CGRect(
                       x: raindrop.x,
                       y: raindrop.y,
                       width: raindrop.size * 0.05,  // 가로는 좁게
                       height: raindrop.size        // 세로는 길게
                   )

                   // 빗방울의 투명도 설정
                   context.opacity = raindrop.opacity

                   // 둥근 모서리를 가진 빗방울 그리기
                   context.fill(
                       Path(roundedRect: rect, cornerRadius: raindrop.size * 0.15),
                       with: .color(.gray.opacity(0.3))
                   )
               }
           }
           .onAppear {
               // 뷰가 나타날 때 빗방울들 초기화
               initializeRaindrops()
           }
           .onChange(of: timeline.date) {
               // 시간이 변할 때마다 빗방울 위치 업데이트 (60fps)
               updateRaindrops()
           }
       }
       .background(.gray.opacity(0.1))
   }

   /// 빗방울들을 화면에 랜덤하게 생성하는 함수
   private func initializeRaindrops() {
       raindrops = (0..<50).map { _ in
           WeatherParticle(
               x: CGFloat.random(in: -50...UIScreen.main.bounds.width + 50),  // 화면 너비보다 약간 넓게
               y: CGFloat.random(in: -100...UIScreen.main.bounds.height),     // 화면 위에서부터 랜덤 시작
               speed: CGFloat.random(in: 5...10),      // 떨어지는 속도
               size: CGFloat.random(in: 15...25),      // 빗방울 크기
               opacity: Double.random(in: 0.5...1),  // 투명도 (자연스러운 효과)
               angle: 0
           )
       }
   }

   /// 매 프레임마다 빗방울들의 위치를 업데이트하는 함수
   private func updateRaindrops() {
       let screenHeight = UIScreen.main.bounds.height
       let screenWidth = UIScreen.main.bounds.width

       // 모든 빗방울들의 위치 업데이트
       for i in raindrops.indices {
           // 세로 방향으로 떨어지기
           raindrops[i].y += raindrops[i].speed

           // 바람 효과 (약간의 가로 움직임)
           raindrops[i].x += raindrops[i].angle * raindrops[i].speed

           // 화면 밖으로 나가면 다시 위에서 시작 (무한 루프 효과)
           if raindrops[i].y > screenHeight + 50 {
               raindrops[i].y = -50
               raindrops[i].x = CGFloat.random(in: -50...screenWidth + 50)
           }
       }
   }
}
