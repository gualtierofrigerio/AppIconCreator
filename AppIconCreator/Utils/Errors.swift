//
//  Errors.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 11/01/22.
//

import Foundation

enum IconCreatorError: Error {
    case loadImage
    case resize
    case save
    case writeJSON
}

extension IconCreatorError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .loadImage:
            return NSLocalizedString("Error loading original image", comment: "")
        case .resize:
            return NSLocalizedString("Error resizing images", comment: "")
        case .save:
            return NSLocalizedString("Error saving icons", comment: "")
        case .writeJSON:
            return NSLocalizedString("Error writing Contents.json", comment: "")
        }
    }
}

enum Warnings: String {
    case cannotLoadImage = "Cannot load image from the file you dropped"
    case imageInvalidFormat = "The image is in an invalid format"
}


