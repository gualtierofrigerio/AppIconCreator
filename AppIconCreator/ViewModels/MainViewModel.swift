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
    @Published var showResultAlert = false
    @Published var warningText = ""
    
    func changeDestination() {
        FileUtils.changeDestination { url in
            if let url = url {
                self.destinationURL = url
                DispatchQueue.main.async {
                    self.destinationPath = self.destinationString(fromURL: url)
                }
            }
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
            showResult("Icons created!")
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
            originalImageURL = url
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
        image.isSquare
    }
    
    private func destinationString(fromURL: URL) -> String {
        fromURL.absoluteString.replacingOccurrences(of: "file://", with: "")
    }
    
    private func showResult(_ result: String) {
        DispatchQueue.main.async {
            self.showResultAlert = true
            self.resultText = result
        }
    }
    
    private func showWarning(_ warning: String) {
        DispatchQueue.main.async {
            self.warningText = warning
        }
    }
}
