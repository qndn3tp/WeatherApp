//
//  CloudyAnimationView.swift
//  Weather
//
//  Created by 김건혜 on 9/8/25.
//

import SwiftUI

// MARK: - 구름 애니메이션
struct CloudyAnimationView: View {
    @State private var cloudOffset: CGFloat = -300

    var body: some View {
        ZStack {
            // ☁️ 메인 구름들
            HStack(spacing: 100) {
                ForEach(0..<5, id: \.self) { i in
                    CloudShape(cloudIndex: i)
                        .fill(.white)
                        .frame(
                            width: 50 + CGFloat(i * 15),
                            height: 10 + CGFloat(i * 8)
                        )
                        .shadow(color: .gray.opacity(0.2), radius: 3, x: 2, y: 2)  // 구름 그림자
                        .offset(
                            x: cloudOffset + CGFloat(i * 120),
                            y: -UIScreen.main.bounds.height * (0.05 + CGFloat(i) * 0.015 + sin(Double(i)) * 0.01)
                        )
                }
            }
        }
        .onAppear {
            guard cloudOffset == -300 else { return }
            withAnimation(.linear(duration: 70).repeatForever(autoreverses: false)) {
                cloudOffset = UIScreen.main.bounds.width + 300
            }
        }
    }
}

// MARK: - 실제 구름 모양을 만드는 Custom Shape
struct CloudShape: Shape {
    let cloudIndex: Int  // 구름마다 다른 모양을 만들기 위한 인덱스

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // 구름의 기본 크기 계산
        let width = rect.width
        let height = rect.height
        let centerY = height / 2

        // 구름마다 다른 모양 패턴
        switch cloudIndex {
        case 0:
            // 첫 번째 구름: 작고 둥근 모양
            createSmallCloud(path: &path, width: width, height: height, centerY: centerY)
        case 1:
            // 두 번째 구름: 중간 크기, 복합적인 모양
            createMediumCloud(path: &path, width: width, height: height, centerY: centerY)
        case 2:
            // 세 번째 구름: 크고 복잡한 모양
            createLargeCloud(path: &path, width: width, height: height, centerY: centerY)
        default:
            // 기본 구름 모양
            createSmallCloud(path: &path, width: width, height: height, centerY: centerY)
        }

        return path
    }

    /// 작은 구름 모양 생성
    private func createSmallCloud(path: inout Path, width: CGFloat, height: CGFloat, centerY: CGFloat) {
        // 왼쪽 원
        path.addEllipse(in: CGRect(
            x: 0,
            y: centerY - height * 0.3,
            width: width * 0.4,
            height: height * 0.6
        ))

        // 가운데 원 (가장 큰 원)
        path.addEllipse(in: CGRect(
            x: width * 0.25,
            y: centerY - height * 0.4,
            width: width * 0.5,
            height: height * 0.8
        ))

        // 오른쪽 원
        path.addEllipse(in: CGRect(
            x: width * 0.6,
            y: centerY - height * 0.25,
            width: width * 0.4,
            height: height * 0.5
        ))
    }

    /// 중간 크기 구름 모양 생성
    private func createMediumCloud(path: inout Path, width: CGFloat, height: CGFloat, centerY: CGFloat) {
        // 왼쪽 작은 원
        path.addEllipse(in: CGRect(
            x: 0,
            y: centerY - height * 0.25,
            width: width * 0.3,
            height: height * 0.5
        ))

        // 왼쪽 중간 원
        path.addEllipse(in: CGRect(
            x: width * 0.2,
            y: centerY - height * 0.4,
            width: width * 0.4,
            height: height * 0.8
        ))

        // 오른쪽 중간 원
        path.addEllipse(in: CGRect(
            x: width * 0.45,
            y: centerY - height * 0.35,
            width: width * 0.4,
            height: height * 0.7
        ))

        // 오른쪽 끝 원
        path.addEllipse(in: CGRect(
            x: width * 0.7,
            y: centerY - height * 0.2,
            width: width * 0.3,
            height: height * 0.4
        ))
    }

    /// 큰 구름 모양 생성
    private func createLargeCloud(path: inout Path, width: CGFloat, height: CGFloat, centerY: CGFloat) {
        // 맨 왼쪽 작은 원
        path.addEllipse(in: CGRect(
            x: 0,
            y: centerY - height * 0.2,
            width: width * 0.25,
            height: height * 0.4
        ))

        // 왼쪽 중간 원
        path.addEllipse(in: CGRect(
            x: width * 0.15,
            y: centerY - height * 0.35,
            width: width * 0.35,
            height: height * 0.7
        ))

        // 가운데 큰 원 (메인)
        path.addEllipse(in: CGRect(
            x: width * 0.35,
            y: centerY - height * 0.45,
            width: width * 0.4,
            height: height * 0.9
        ))

        // 오른쪽 중간 원
        path.addEllipse(in: CGRect(
            x: width * 0.55,
            y: centerY - height * 0.3,
            width: width * 0.3,
            height: height * 0.6
        ))

        // 맨 오른쪽 작은 원
        path.addEllipse(in: CGRect(
            x: width * 0.75,
            y: centerY - height * 0.15,
            width: width * 0.25,
            height: height * 0.3
        ))
    }
}
