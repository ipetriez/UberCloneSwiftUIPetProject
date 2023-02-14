//
//  UberCloneSwiftUIPetProjectApp.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 10.02.23.
//

import SwiftUI

@main
struct UberCloneSwiftUIPetProjectApp: App {
    
    // MARK: — Public properties
    
    @StateObject var locationSearchViewModel = LocationSearchViewModel()
    @StateObject var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationSearchViewModel)
                .environmentObject(locationManager)
        }
    }
}
