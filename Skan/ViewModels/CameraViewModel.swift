//
//  CameraViewModel.swift
//  Skan
//
//  Created by Marco Margarucci on 30/09/23.
//

import Foundation
import SwiftUI
import VisionKit
import AVKit

enum ScanType {
    case barcode, text
}

enum DataScannerAccessStatusType {
    case notDetermined
    case cameraAccessNotGranted
    case cameraNotAvailable
    case scannerAvailable
    case scannerNotAvailable
}

@MainActor
class CameraViewModel: ObservableObject {
    // MARK: - Properties
    @Published private(set) var dataScannerAccessStatus: DataScannerAccessStatusType = .notDetermined
    @Published private(set) var recognizedItems: [RecognizedItem] = []
    @Published private(set) var scanType: ScanType = .barcode
    @Published private(set) var textContentType: DataScannerViewController.TextContentType?
    @Published private(set) var recognizeMultipleItems: Bool = true
    
    private var isScannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    private var recognizedDataType: DataScannerViewController.RecognizedDataType {
        scanType == .barcode ? .barcode() : .text(textContentType: textContentType)
    }
    
    // Data camera access
    func requestDataScannerAccessStatus() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            dataScannerAccessStatus = .cameraNotAvailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            } else {
                dataScannerAccessStatus = .cameraAccessNotGranted
            }
        case .restricted, .denied:
            dataScannerAccessStatus = .cameraAccessNotGranted
        @unknown default:
            break
        }
    }
}
