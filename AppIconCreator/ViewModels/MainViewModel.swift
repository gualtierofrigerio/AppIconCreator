//
//  MainViewModel.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 08/01/22.
//

import AppKit
import Foundation

class MainViewModel: ObservableObject {
    @Published var destinationPath = "click here to set destination"
    @Published var enableButton = false
    @Published var image: NSImage?
    @Published var warningText = ""
    
    init() {
        if let url = try? FileUtils.getUserDownloadsURL() {
            destinationPath = url.absoluteString
        }
    }
    
    func createIcons() {
        do {
            
        }
    }
    
    func setImage(atURL url: URL) {
        guard let data = try? Data(contentsOf: url),
            let nsImage = NSImage(data: data) else {
                showWarning("Cannot load image from the file you dropped")
                return
            }
        if checkImage(nsImage) {
            DispatchQueue.main.async {
                self.warningText = ""
                self.image = nsImage
                self.enableButton = true
            }
        }
        else {
            showWarning("The image is in an invalid format")
        }
    }
    
    // MARK: - Private
    
    private func checkImage(_ image: NSImage) -> Bool {
        !image.isSquare
    }
    
    private func destinationString(fromURL: URL) -> String {
        fromURL.absoluteString.replacingOccurrences(of: "file://", with: "")
    }
    
    private func showWarning(_ warning: String) {
        DispatchQueue.main.async {
            self.warningText = warning
        }
    }
}
