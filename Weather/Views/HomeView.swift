//
//  HomeView.swift
//  netflix
//
//  Created by 김건혜 on 7/27/25.
//

import SwiftUI

struct HomeView: View {
    // @StateObject를 사용해 LocationManager 인스턴스를 뷰 라이프사이클에 맞게 관리합니다.
    @ObservedObject var locationManager: LocationManager

    var body: some View {
        ScrollView {
            // 상단 위치, 시간
            HStack {
                Spacer()
                // 위치, 시간 정보
                switch locationManager.authorizationStatus {
                case .notDetermined:
                    Text("위치 권한을 요청해주세요.")
                case .denied:
                    Text("설정에서 위치 권한을 허용해주세요.")
                case .authorizedWhenInUse:
                    VStack {
                        Text(locationManager.cityName ?? "")
                            .font(.system(size: 20))
                        Text(locationManager.currentTime ?? "")
                    }
                default:
                    Text("위치 권한 상태를 알 수 없습니다.")
                }
                Spacer()
            }
            .padding()

            // 메인컨텐츠
            HStack {
                // 왼쪽: 아바타
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)

                // 오른쪽: 날씨 정보
                VStack(alignment: .leading, spacing: 15) {
                    // 상단: 날씨 아이콘과 상태
                    HStack(spacing: 5) {
                        Image(systemName: "cloud.rain")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)

                        Text("Light Rain")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    }

                    // 중간: 온도
                    Text("26°")
                        .font(.system(size: 50, weight: .thin))

                    // 하단: 설명과 최고/최저 온도
                    VStack(alignment: .leading, spacing: 5) {
                        Text("어제와 비슷해요")
                            .font(.body)
                        HStack {
                            Text("최고 34°")
                                .font(.body)
                            Text("최저 20°")
                                .font(.body)
                        }
                    }
                }
            }
            .padding(.bottom, 20)
            .padding(.trailing, 20)

            // 데일리 날씨 코멘트
            Text("Perfect weather for cozy day!")
                .font(.system(size: 18, weight: .medium))
                .padding(.horizontal, 30)
                .padding(.vertical, 11)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)

            // 데일리 날씨 부가정보
            HStack(spacing: 16) {
                // 미세먼지
                VStack {
                    // 웃는 얼굴 아이콘
                    Image(systemName: "face.smiling")
                        .font(.system(size: 26))
                        .foregroundColor(.green.opacity(0.5))

                    // 좋음 텍스트
                    Text("좋음")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)

                    // 미세먼지 텍스트
                    Text("미세먼지")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.black.opacity(0.03))
                .clipShape(RoundedRectangle(cornerRadius: 10))

                // 체감온도
                VStack {
                    // 웃는 얼굴 아이콘
                    Image(systemName: "thermometer.variable")
                        .font(.system(size: 26))
                        .foregroundColor(.red.opacity(0.5))

                    // 좋음 텍스트
                    Text("33°")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)

                    // 미세먼지 텍스트
                    Text("체감온도")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.black.opacity(0.03))
                .clipShape(RoundedRectangle(cornerRadius: 10))

                // 강수확률
                VStack {
                    // 웃는 얼굴 아이콘
                    Image(systemName: "umbrella")
                        .font(.system(size: 26))
                        .foregroundColor(.gray.opacity(0.5))

                    // 좋음 텍스트
                    Text("50%")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)

                    // 미세먼지 텍스트
                    Text("강수확률")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.black.opacity(0.03))
                .clipShape(RoundedRectangle(cornerRadius: 10))

                // 습도
                VStack {
                    // 웃는 얼굴 아이콘
                    Image(systemName: "humidity")
                        .font(.system(size: 26))
                        .foregroundColor(.blue.opacity(0.5))

                    // 좋음 텍스트
                    Text("40%")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)

                    // 미세먼지 텍스트
                    Text("습도")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.black.opacity(0.03))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.vertical, 16)

            // 시간대별 날씨 변화 그래프
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: .infinity, minHeight: 230)
                .padding()
        }
    }
}

#Preview {
    HomeView(locationManager: LocationManager())
}
