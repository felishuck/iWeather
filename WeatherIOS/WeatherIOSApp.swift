//
//  WeatherIOSApp.swift
//  WeatherIOS
//
//  Created by Félix Tineo Ortega on 22/5/22.
//

import SwiftUI

@main
struct WeatherIOSApp: App {
    var body: some Scene {
        WindowGroup {
            TabWeatherView(WeatherManager())
        }
    }
}
