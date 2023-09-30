//
//  ContentView.swift
//  Skan
//
//  Created by Marco Margarucci on 30/09/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    var body: some View {
        switch cameraViewModel.dataScannerAccessStatus {
        case .notDetermined:
            Text("Requesting camera access")
        case .cameraAccessNotGranted:
            Text("Access not granted")
        case .cameraNotAvailable:
            Text("Camera not available")
        case .scannerAvailable:
            Text("Scanner is available")
        case .scannerNotAvailable:
            Text("Scanner not available")
        }
    }
}

#Preview {
    ContentView()
}
