//
//  HeaderView.swift
//  Skan
//
//  Created by Marco Margarucci on 30/09/23.
//

import SwiftUI
import VisionKit

struct HeaderView: View {    // MARK: - Properties
    @StateObject var cameraViewModel: CameraViewModel
    
    private let textContentType: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
        ("All", .none),
        ("URL", .URL),
        ("Phone", .telephoneNumber),
        ("Email", .emailAddress),
        ("Address", .fullStreetAddress)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Picker("Scan type", selection: $cameraViewModel.scanType) {
                    Text("Barcode").tag(ScanType.barcode)
                    Text("Text").tag(ScanType.text)
                }
                .pickerStyle(.segmented)
                Toggle("Scan multiple", isOn: $cameraViewModel.recognizeMultipleItems)
            }
            .padding(.top)
            if cameraViewModel.scanType == .text {
                Picker("Text content type", selection: $cameraViewModel.textContentType) {
                    ForEach(textContentType, id: \.self.textContentType) { option in
                        Text(option.title).tag(option.textContentType)
                    }
                }
                .pickerStyle(.segmented)
            }
            Text(cameraViewModel.headerText)
                .padding(.top)
        }
        .padding()
    }
}
