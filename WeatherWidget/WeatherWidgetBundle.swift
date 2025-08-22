//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by 김건혜 on 8/4/25.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetControl()
        WeatherWidgetLiveActivity()
    }
}
