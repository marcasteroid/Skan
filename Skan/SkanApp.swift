//
//  SkanApp.swift
//  Skan
//
//  Created by Marco Margarucci on 30/09/23.
//

import SwiftUI

@main
struct SkanApp: App {
    @StateObject private var cameraViewModel = CameraViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cameraViewModel)
                .task {
                    await cameraViewModel.requestDataScannerAccessStatus()
                }
        }
    }
}
