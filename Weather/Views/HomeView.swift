//
//  HomeView.swift
//  netflix
//
//  Created by 김건혜 on 7/27/25.
//

import SwiftUI

// MARK: HomeView
struct HomeView: View {
    // MARK: - Properties
    /// 위치 관리자 (외부에서 주입받는 의존성)
    @ObservedObject var locationManager: LocationManager
    
    /// 위치 관련 비즈니스 로직을 처리하는 ViewModel
    @StateObject private var locationViewModel: LocationViewModel
    
    // MARK: - Initialization
    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self._locationViewModel = StateObject(wrappedValue: LocationViewModel(locationManager: locationManager))
    }

    // MARK: - Body
    var body: some View {
        ScrollView {
            // MARK: - Header Section (위치 및 시간 정보)
            HStack {
                Spacer()
                // 조건부 렌더링: 위치 권한 상태에 따라 다른 UI 표시
                if locationViewModel.shouldShowLocationInfo {
                    VStack {
                        Text(locationViewModel.cityName ?? "")
                            .font(.system(size: 20))
                        Text(locationViewModel.currentTime ?? "")
                    }
                } else {
                    Text(locationViewModel.statusMessage)
                }
                Spacer()
            }
            .padding()

            // MARK: - Main Content Section (날씨 정보)
            HStack {
                // 왼쪽: 아바타
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)

                // 오른쪽: 현재 날씨 정보
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

                    // 중간: 현재 온도
                    Text("26°")
                        .font(.system(size: 50, weight: .thin))

                    // 하단: 부가 정보 (어제 비교, 최고/최저 온도)
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

            // MARK: - Daily Comment Section (오늘의 날씨에 대한 한줄 코멘트)
            Text("Perfect weather for cozy day!")
                .font(.system(size: 18, weight: .medium))
                .padding(.horizontal, 30)
                .padding(.vertical, 11)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.05), radius: 1, x: 0, y: 1)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)

            // MARK: - Weather Info Cards Section (데일리 날씨 부가정보)
            HStack(spacing: 16) {
                // 미세먼지
                WeatherInfoCard(icon: "face.smiling", value: "좋음", label: "미세먼지", iconColor: .green.opacity(0.5))
                // 체감온도
                WeatherInfoCard(icon: "thermometer.variable", value: "33°", label: "체감온도", iconColor: .red.opacity(0.5))
                // 강수확률
                WeatherInfoCard(icon: "umbrella", value: "50%", label: "강수확률", iconColor: Color.gray.opacity(0.5))
                // 습도
                WeatherInfoCard(icon: "humidity", value: "40%", label: "습도", iconColor: Color.blue.opacity(0.5))
            }
//            .padding(.vertical, 16)
            
            // MARK: - Chart Section (시간대별 날씨 변화 그래프)
            // TODO
            Rectangle()
                .fill(Color.white)
                .frame(maxWidth: .infinity, minHeight: 230)
                .padding()
        }
    }
}

// MARK: - WeatherInfoCard Component ( 날씨 정보 카드 뷰)
struct WeatherInfoCard: View {
    let icon: String
    let value: String
    let label: String
    let iconColor: Color
    
    var body: some View {
        VStack {
            // 상단: 카테고리를 나타내는 아이콘
            Image(systemName: icon)
                .font(.system(size: 26))
                .foregroundColor(iconColor)
            
            // 중간: 실제 값 (메인 정보)
            Text(value)
                .font(.system(size: 14, weight: .medium))
            
            // 하단: 라벨 (부가 설명)
            Text(label)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.black.opacity(0.03))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Preview
#Preview {
    HomeView(locationManager: LocationManager())
}
