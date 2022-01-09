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
    @Published var resultText = ""
    @Published var warningText = ""
    
    init() {
        if let url = try? FileUtils.getUserDownloadsURL() {
            destinationPath = url.absoluteString
        }
    }
    
    func createIcons() {
        guard let destinationURL = destinationURL,
              let originalImageURL = originalImageURL else {
                  resultText = "Error while creating icons"
                  return
              }
        do {
            try IconCreator.createIcons(fromImageAtURL: originalImageURL,
                                        destinationURL: destinationURL)
        }
        catch (IconCreatorError.loadImage) {
            showResult("Error loading original image")
        }
        catch (IconCreatorError.resize) {
            showResult("Error resizing images")
        }
        catch (IconCreatorError.save) {
            showResult("Error saving icons")
        }
        catch (let error) {
            showResult("Error \(error.localizedDescription)")
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
    
    private var destinationURL: URL?
    private var originalImageURL: URL?
    
    private func checkImage(_ image: NSImage) -> Bool {
        !image.isSquare
    }
    
    private func destinationString(fromURL: URL) -> String {
        fromURL.absoluteString.replacingOccurrences(of: "file://", with: "")
    }
    
    private func showResult(_ result: String) {
        DispatchQueue.main.async {
            self.resultText = result
        }
    }
    
    private func showWarning(_ warning: String) {
        DispatchQueue.main.async {
            self.warningText = warning
        }
    }
}
