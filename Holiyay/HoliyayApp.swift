//
//  HoliyayApp.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

@main
struct HoliyayApp: App {
    @StateObject private var destinationDataModel = DestinationDataModel()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(destinationDataModel)
        }
    }
}
