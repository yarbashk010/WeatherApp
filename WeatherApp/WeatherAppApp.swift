//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by admin on 22/11/24.
//

import SwiftUI

@main
struct WeatherApp: App {
    @AppStorage("isFreshUser") private var isFreshUser: Bool = true

    var body: some Scene {
        WindowGroup {
            if isFreshUser {
                InitialView()
            } else {
                LandingPageView()
            }
        }
    }
}
