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
        DataScannerView(recognizedItems: $cameraViewModel.recognizedItems,
                        recognizedDataTypes: cameraViewModel.recognizedDataType,
                        recognizesMultipleItems: cameraViewModel.recognizeMultipleItems)
        .background(Color.gray.opacity(0.2))
        .ignoresSafeArea()
        .id(cameraViewModel.dataScannerViewId)
        .sheet(isPresented: .constant(true), content: {
            VStack {
                BottomView(cameraViewModel: cameraViewModel)
                    .presentationDetents([.medium, .fraction(0.20)])
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled()
            }
        })
        .onChange(of: cameraViewModel.scanType) { [] in cameraViewModel.recognizedItems = [] }
        .onChange(of: cameraViewModel.textContentType) { [] in cameraViewModel.recognizedItems = [] }
        .onChange(of: cameraViewModel.recognizeMultipleItems) { [] in cameraViewModel.recognizedItems = [] }
    }
}
