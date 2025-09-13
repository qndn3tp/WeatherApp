//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by 김건혜 on 9/13/25.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetLiveActivity()
    }
}
