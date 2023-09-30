//
//  BottomView.swift
//  Skan
//
//  Created by Marco Margarucci on 30/09/23.
//

import SwiftUI

struct BottomView: View {
    // MARK: - Properties
    @StateObject var cameraViewModel: CameraViewModel
    
    var body: some View {
        VStack {
            HeaderView(cameraViewModel: cameraViewModel)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(cameraViewModel.recognizedItems) { item in
                        switch item {
                        case .barcode(let barcode):
                            Text(barcode.payloadStringValue ?? "Unknown barcode")
                        case .text(let text):
                            Text(text.transcript)
                        @unknown default:
                            Text("Unknown")
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
