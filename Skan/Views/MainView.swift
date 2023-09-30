//
//  MainView.swift
//  Skan
//
//  Created by Marco Margarucci on 30/09/23.
//

import SwiftUI

struct MainView: View {
    // MARK: - Properties
    @StateObject var cameraViewModel: CameraViewModel
    
    var body: some View {
        VStack {
            DataScannerView(recognizedItems: $cameraViewModel.recognizedItems,
                            recognizedDataTypes: cameraViewModel.recognizedDataType,
                            recognizesMultipleItems: cameraViewModel.recognizeMultipleItems)
            .background(Color.gray.opacity(0.2))
            .ignoresSafeArea()
            .id(cameraViewModel.dataScannerViewId)
            
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
        .onChange(of: cameraViewModel.scanType) { [] in cameraViewModel.recognizedItems = [] }
        .onChange(of: cameraViewModel.textContentType) { [] in cameraViewModel.recognizedItems = [] }
        .onChange(of: cameraViewModel.recognizeMultipleItems) { [] in cameraViewModel.recognizedItems = [] }
    }
}
