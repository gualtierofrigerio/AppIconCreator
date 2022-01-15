//
//  IconCreator.swift
//  AppIconCreator
//
//  Created by Gualtiero Frigerio on 09/01/22.
//

import Foundation

class IconCreator {
    class func createIcons(fromImageAtURL imageURL: URL,
                           destinationURL: URL) throws {
        guard let cgImage = ImageUtils.loadCGImage(fromUrl: imageURL) else {
            throw IconCreatorError.loadImage
        }
        try createIcons(defaultIconConfiguration,
                    fromImage: cgImage,
                    prefix: "AppIcon",
                    destinationURL: destinationURL)
    }
    
    class func createIcons(_ icons: [Icon],
                           fromImage originalImage: CGImage,
                           prefix: String,
                           destinationURL: URL) throws {
        var url: URL
        for icon in icons {
            url = destinationURL
            url.appendPathComponent(prefix + icon.suffix)
            url.appendPathExtension("png")
            guard let resizedImage = ImageUtils.resizeImage(originalImage, size: icon.size) else {
                throw IconCreatorError.resize
            }
            let result = ImageUtils.savePNGImage(image: resizedImage, toUrl: url)
            if result == false {
                throw IconCreatorError.save
            }
        }
    }
}
